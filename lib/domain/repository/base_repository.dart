import 'package:firebase_app/domain/entities/add_task_entities.dart';
import 'package:firebase_app/domain/entities/login_entities.dart';
import 'package:firebase_app/domain/entities/user_enitites.dart';

import '../use_case/get_user_use_case.dart';

abstract class BaseRepository{
  Future<void> getLogin(LoginEntities parameter);
  Future<void> getRegister(LoginEntities parameter);
  Future<void> setUserData(UserEntities parameter);
  Future<UserEntities> getUserData(setToken parameter);
  Future<void> setAddTaskUser(AddTskEntities parameter);



}