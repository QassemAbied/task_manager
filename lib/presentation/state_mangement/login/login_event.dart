import 'package:equatable/equatable.dart';
import 'package:firebase_app/domain/entities/add_task_entities.dart';
import 'package:firebase_app/domain/entities/user_enitites.dart';

abstract class LoginEvent extends Equatable{

  @override
  List<Object> get props =>[];
}

class getLoginEvent extends LoginEvent{
  final String email ;
  final String password;
  getLoginEvent({required this.email , required this.password});
  @override
  List<Object> get props =>[email , password];
}

class getRegisterEvent extends LoginEvent{
  final String email ;
  final String password;
  getRegisterEvent({required this.email , required this.password});
  @override
  List<Object> get props =>[email , password];
}

class setUserDataEvent extends LoginEvent{
  final UserEntities userEntities ;
  //final String password;
  setUserDataEvent({required this.userEntities ,});
  @override
  List<Object> get props =>[userEntities ,];
}

class getUserDataEvent extends LoginEvent{
  final String token ;
  getUserDataEvent({required this.token ,});
  @override
  List<Object> get props =>[token ,];
}

class setAddTaskUserEvent extends LoginEvent{
  final AddTskEntities addTskEntities ;
  //final String password;
  setAddTaskUserEvent({required this.addTskEntities ,});
  @override
  List<Object> get props =>[addTskEntities ,];
}