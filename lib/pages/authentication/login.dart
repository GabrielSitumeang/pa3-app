// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:pa3/constant.dart';
// import 'package:pa3/models/api_response.dart';
// import 'package:pa3/models/user.dart';
// import 'package:pa3/pages/authentication/register.dart';
// import 'package:pa3/pages/home_page.dart';
// import 'package:pa3/service/user_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final GlobalKey<FormState> formkey = GlobalKey<FormState>();
//   TextEditingController txtEmail = TextEditingController();
//   TextEditingController txtPassword = TextEditingController();
//   bool _isLoading = false;

//   void _loginUser() async {
//     ApiResponse response = await login(txtEmail.text, txtPassword.text);
//     if (response.error == null) {
//       _saveAndRedirectToHome(response.data as User);
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('${response.error!}')));
//     }
//   }

//   void _saveAndRedirectToHome(User user) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     await pref.setString('token', user.token ?? '');
//     await pref.setInt('userId', user.id ?? 0);
//     Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//         centerTitle: true,
//       ),
//       body: Form(
//         key: formkey,
//         child: ListView(
//           padding: EdgeInsets.all(32),
//           children: [
//             TextFormField(
//               keyboardType: TextInputType.emailAddress,
//               controller: txtEmail,
//               validator: (val) => val!.isEmpty ? 'Invalid email address' : null,
//               decoration: kinputDecoration('Email'),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             TextFormField(
//               controller: txtPassword,
//               obscureText: true,
//               validator: (val) =>
//                   val!.length < 6 ? 'Required at least 6 chars' : null,
//               decoration: kinputDecoration('Password'),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             _isLoading
//                 ? Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : kTextButton('Login', () {
//                     if (formkey.currentState!.validate()) {
//                       _loginUser();
//                     }
//                   }),
//             SizedBox(
//               height: 10,
//             ),
//             kLoginRegisterHint('Dont have an acount?', 'Register', () {
//               Navigator.of(context).pushAndRemoveUntil(
//                   MaterialPageRoute(builder: (context) => Register()),
//                   (route) => false);
//             })
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pa3/constant.dart';
import 'package:pa3/models/api_response.dart';
import 'package:pa3/models/user.dart';
import 'package:pa3/pages/authentication/register.dart';
import 'package:pa3/pages/home_page.dart';
import 'package:pa3/service/user_service.dart';
import 'package:pa3/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  FocusNode _focusEmail = FocusNode();
  FocusNode _focusPassword = FocusNode();
  bool _isProcessing = false;

  void _loginUser() async {
    setState(() {
      _isProcessing = true;
    });

    ApiResponse response =
        await login(_emailTextController.text, _passwordTextController.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        _isProcessing = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error!}')));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundWhite,
        body: Container(
          margin: EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login',
                style: primaryTextStyle.copyWith(
                  fontSize: 34,
                  fontWeight: semiBold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 50),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Email Address",
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Icon(Icons.email, size: 17, color: Colors.black54),
                            SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                style: buttonTextStyle,
                                controller: _emailTextController,
                                focusNode: _focusEmail,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Your Email',
                                  hintStyle: subtitleTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 22),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Password",
                        style: primaryTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: medium,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Icon(Icons.lock, size: 17, color: Colors.black54),
                            SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                style: buttonTextStyle,
                                controller: _passwordTextController,
                                focusNode: _focusPassword,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Your Password',
                                  hintStyle: subtitleTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 54.0),
                    _isProcessing
                        ? CircularProgressIndicator()
                        : Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _focusEmail.unfocus();
                                        _focusPassword.unfocus();

                                        if (_formKey.currentState!.validate()) {
                                          _loginUser();
                                        }
                                      },
                                      child: Text(
                                        'Sign In',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.green),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 24.0),
                                ],
                              ),
                              SizedBox(height: 12.0),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Register(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Belum memiliki akun?',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
