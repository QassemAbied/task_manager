import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:firebase_app/domain/entities/user_enitites.dart';

class UserModels extends UserEntities{
  UserModels({required String name, required String email, required String? userImageUrl,
    required String phoneNuber, required Timestamp createdAt, required String positionCompany,
    required String id}) : super(name: name, email: email, userImageUrl: userImageUrl,
      phoneNuber: phoneNuber, createdAt: createdAt, positionCompany: positionCompany, id: id);

  factory UserModels.fromJson(Map<String , dynamic> json)=>
  UserModels(
      name: json['name'],
      email: json['email'],
      userImageUrl: json['userImageUrl'],
      phoneNuber: json['phoneNuber'],
      createdAt: json['createdAt'],
      positionCompany: json['positionCompany'],
      id: json['id']
  );

}