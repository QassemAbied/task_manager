import 'package:firebase_app/data/models/login_model.dart';
import 'package:firebase_app/data/models/user_models.dart';
import 'package:firebase_app/domain/entities/login_entities.dart';

import '../../domain/entities/add_task_entities.dart';
import '../../domain/entities/user_enitites.dart';
import '../../domain/use_case/get_user_use_case.dart';

abstract class RemoteDataSource{
  Future<void> getLogin(LoginEntities parameter);
  Future<void> getRegister(LoginEntities parameter);
  Future<void> setUserData(UserEntities parameter);
  Future<UserModels> getUserData(setToken parameter);
  Future<void> setAddTaskUser(AddTskEntities parameter);

}