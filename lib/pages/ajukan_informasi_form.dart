import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pa3/constant.dart';
import 'package:pa3/models/ajukan.dart';
import 'package:pa3/models/api_response.dart';
import 'package:pa3/pages/authentication/login.dart';
import 'package:pa3/service/ajukan_service.dart';
import 'package:pa3/service/user_service.dart';

class AjukanInformasiForm extends StatefulWidget {
  final Ajukan? ajukan;
  final String? title;

  AjukanInformasiForm({this.ajukan, this.title});

  @override
  _AjukanInformasiFormState createState() => _AjukanInformasiFormState();
}

class _AjukanInformasiFormState extends State<AjukanInformasiForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtControllerNamaTanaman =
      TextEditingController();
  final TextEditingController _txtControllerJudul = TextEditingController();
  final TextEditingController _txtControllerIsi = TextEditingController();
  bool _loading = false;
  File? _imageFile;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _createAjukan() async {
    String? image = _imageFile == null ? null : getStringImage(_imageFile);
    ApiResponse response = await createAjukan(
      _txtControllerNamaTanaman.text,
      _txtControllerJudul.text,
      _txtControllerIsi.text,
      image,
    );

    if (response.error == null) {
      Navigator.of(context).pop();
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Login()),
              (route) => false,
            )
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      setState(() {
        _loading = !_loading;
      });
    }
  }

  void _editAjukan(int ajukanId) async {
    ApiResponse response = await editAjukan(
      ajukanId,
      _txtControllerNamaTanaman.text,
      _txtControllerJudul.text,
      _txtControllerIsi.text,
      _imageFile == null ? null : getStringImage(_imageFile),
    );
    if (response.error == null) {
      Navigator.of(context).pop();
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Login()),
              (route) => false,
            )
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      setState(() {
        _loading = !_loading;
      });
    }
  }

  @override
  void initState() {
    if (widget.ajukan != null) {
      _txtControllerNamaTanaman.text = widget.ajukan!.namaTanaman ?? '';
      _txtControllerIsi.text = widget.ajukan!.isi ?? '';
      _imageFile =
          widget.ajukan!.image != null ? File(widget.ajukan!.image!) : null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}'),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                widget.ajukan != null
                    ? SizedBox()
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                            image: _imageFile == null
                                ? null
                                : DecorationImage(
                                    image: FileImage(_imageFile ?? File('')),
                                    fit: BoxFit.cover)),
                        child: Center(
                          child: IconButton(
                            icon: Icon(Icons.image,
                                size: 50, color: Colors.black38),
                            onPressed: () {
                              getImage();
                            },
                          ),
                        ),
                      ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _txtControllerNamaTanaman,
                          validator: (val) =>
                              val!.isEmpty ? 'Nama tanaman is required' : null,
                          decoration: InputDecoration(
                              hintText: "Nama tanaman...",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black38))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _txtControllerJudul,
                          validator: (val) =>
                              val!.isEmpty ? 'Judul is required' : null,
                          decoration: InputDecoration(
                              hintText: "Judul...",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black38))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _txtControllerIsi,
                          keyboardType: TextInputType.multiline,
                          maxLines: 9,
                          validator: (val) =>
                              val!.isEmpty ? 'Isi is required' : null,
                          decoration: InputDecoration(
                              hintText: "Isi...",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black38))),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: kTextButton('Ajukan', () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _loading = !_loading;
                      });
                      if (widget.ajukan == null) {
                        _createAjukan();
                      } else {
                        _editAjukan(widget.ajukan!.id ?? 0);
                      }
                    }
                  }),
                )
              ],
            ),
    );
  }
}
