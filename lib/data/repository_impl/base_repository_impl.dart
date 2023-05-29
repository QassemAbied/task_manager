
import 'package:firebase_app/data/data_sourece/remote_data_source.dart';
import 'package:firebase_app/domain/entities/add_task_entities.dart';
import 'package:firebase_app/domain/entities/login_entities.dart';
import 'package:firebase_app/domain/entities/user_enitites.dart';
import 'package:firebase_app/domain/repository/base_repository.dart';
import 'package:firebase_app/domain/use_case/get_user_use_case.dart';
import 'package:flutter/cupertino.dart';

class BaseRepositoryImpl implements BaseRepository{
  final RemoteDataSource remoteDataSource;
  BaseRepositoryImpl(this.remoteDataSource);
  @override
  Future<void> getLogin(LoginEntities parameter) async{
  return await remoteDataSource.getLogin(parameter);

  }

  @override
  Future<void> getRegister(LoginEntities parameter)async {
    return await remoteDataSource.getRegister(parameter);

  }

  @override
  Future<void> setUserData(UserEntities parameter) async{
    return await remoteDataSource.setUserData(parameter);

  }

  @override
  Future<UserEntities> getUserData(setToken parameter)async {
    return await remoteDataSource.getUserData(parameter);
  }

  @override
  Future<void> setAddTaskUser(AddTskEntities parameter)async {
   await remoteDataSource.setAddTaskUser(parameter);
  }



}