import 'package:pa3/models/user.dart';

class Ajukan {
  int? id;
  String? namaTanaman;
  String? isi;
  String? image;
  User? user;

  Ajukan({
    this.id,
    this.namaTanaman,
    this.isi,
    this.image,
    this.user,
  });

  factory Ajukan.fromJson(Map<String, dynamic> json) {
    return Ajukan(
        id: json['id'],
        namaTanaman: json['namaTanaman'],
        isi: json['isi'],
        image: json['image'],
        user: User(
            id: json['user']['id'],
            name: json['user']['name'],
            image: json['user']['image']));
  }
}
