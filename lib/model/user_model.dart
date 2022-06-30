import 'package:flutter/foundation.dart';

class AppUser{
 final int? id;
 final int? nationalID;
 final String? name;
 final String? email;
 final String? phone;
 final String? anotherPhone;
 final String? position;
 final String? token;

  AppUser({@required this.token, @required this.id,@required this.nationalID,@required this.name,@required this.email,
    @required this.phone,@required this.anotherPhone,@required this.position});

  const AppUser.dummy(this.id, this.nationalID, this.name, this.email, this.phone, this.anotherPhone, this.position, this.token);

 factory AppUser.fromJson(Map<String, dynamic> json) {
   return AppUser(
     id: json['id'] as int,
     nationalID: json['civilID'] as int,
     name: json['name'] as String,
     email: json['email'] as String,
     phone: json['phone'] as String,
     anotherPhone: json['anotherPhone'] == null ? '' : json['anotherPhone'] as String,
     position: json['position'] as String,
     token: json['token'] == null ? '' : json['token'] as String,

   );
 }

 Map<String,dynamic> toMap()=>
     {
       'id': id, 'civilID': nationalID, 'name': name, 'email': email,
       'phone': phone, 'anotherPhone': anotherPhone, 'position': position,
     };

}
