import 'package:firebase_app/domain/entities/login_entities.dart';

class LoginModel extends LoginEntities{
  LoginModel({required String email, required String password}) :
        super(email: email, password: password);

  factory LoginModel.fromJson(Map<String , dynamic> json)=>LoginModel(
      email: json['email'],
      password: json['password']
  );

}