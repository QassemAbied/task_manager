import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

 class UserEntities extends Equatable{
   final  String name;
  final String email;
  final String? userImageUrl;
  final String phoneNuber;
  final String positionCompany;
  final Timestamp createdAt;
  final String id;
  UserEntities({required this.name , required this.email , required this.userImageUrl,
  required this.phoneNuber , required this.createdAt , required this.positionCompany , required this.id});

  @override
  List<Object?> get props => [name , email , userImageUrl , phoneNuber , positionCompany , createdAt , id];

}