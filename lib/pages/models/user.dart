import 'package:flutter/foundation.dart';

class UserObject {
  String? get id => uid;

  String? uid;

  String?   username;
  String?   photoUrl;

  bool? newUser;

  UserObject({
    this.uid,
    this.username,
    this.photoUrl,
    this.newUser,
  });

  /*toJson() => {
    'username'  : username,
    'photo_url' : photoUrl
  };

  factory UserObject.fromJson(Map<String, dynamic> json){
    final user = UserObject(
      username: json['username'],
      photoUrl: json['photo_url']
    );
    user.uid = json['id'];
    return user;
  }*/

}