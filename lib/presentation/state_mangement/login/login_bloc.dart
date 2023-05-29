import 'package:firebase_app/domain/entities/add_task_entities.dart';
import 'package:firebase_app/domain/entities/login_entities.dart';
import 'package:firebase_app/domain/entities/user_enitites.dart';
import 'package:firebase_app/domain/use_case/add_task_use_case.dart';
import 'package:firebase_app/domain/use_case/login_use_case.dart';
import 'package:firebase_app/domain/use_case/register_use_case.dart';
import 'package:firebase_app/presentation/state_mangement/login/login_event.dart';
import 'package:firebase_app/presentation/state_mangement/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enum.dart';
import '../../../domain/use_case/base_use_case.dart';
import '../../../domain/use_case/get_user_use_case.dart';
import '../../../domain/use_case/set_user_use_case.dart';

class LoginBloc extends Bloc<LoginEvent , LoginStates>{
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase ;
  final SetUserDataUseCase setUserDataUseCase;
  final getUserDataUseCase  userDataUseCase;
  final SetAddTaskUserUseCase setAddTaskUserUseCase;
  LoginBloc(
      this.loginUseCase,
      this.registerUseCase,
      this.setUserDataUseCase,
      this.userDataUseCase,
      this.setAddTaskUserUseCase,
      ) : super(LoginStates()){

    on<getLoginEvent>((event, emit) async {
      final result = await loginUseCase.call(LoginEntities(email: event.email, password: event.password));

      return result;
      // result.fold((l) {
      //   emit(state.copyWith(
      //       loginEnumRequest: EnumRequest.error, loginString: l.message));
      // }, (r) {
      //   emit(state.copyWith(
      //       login: r, loginEnumRequest: EnumRequest.loded));
      // });
    });

    on<getRegisterEvent>((event, emit) async {
      final result = await registerUseCase.call(LoginEntities(email: event.email, password: event.password));

      return result;
      // result.fold((l) {
      //   emit(state.copyWith(
      //       loginEnumRequest: EnumRequest.error, loginString: l.message));
      // }, (r) {
      //   emit(state.copyWith(
      //       login: r, loginEnumRequest: EnumRequest.loded));
      // });
    });


    on<setUserDataEvent>((event, emit) async {
      final result = await setUserDataUseCase.call(
          UserEntities(
              name: event.userEntities.name,
              email: event.userEntities.email,
              userImageUrl: event.userEntities.userImageUrl,
              phoneNuber: event.userEntities.phoneNuber,
              createdAt: event.userEntities.createdAt,
              positionCompany: event.userEntities.positionCompany,
              id: event.userEntities.id,
          ),
      );

      return result;

    });


    on<getUserDataEvent>((event, emit) async {
       await userDataUseCase.call(setToken(token: event.token));


      // result.fold((l) {
      //   emit(state.copyWith(
      //       loginEnumRequest: EnumRequest.error, loginString: l.message));
      // }, (r) {
      //   emit(state.copyWith(
      //       login: r, loginEnumRequest: EnumRequest.loded));
      // });
    });

    on<setAddTaskUserEvent>((event, emit) async {
      final result = await setAddTaskUserUseCase.call(
        AddTskEntities(
            taskCategory: event.addTskEntities.taskCategory,
            taskTitle:  event.addTskEntities.taskTitle,
            taskDescription:  event.addTskEntities.taskDescription,
            deadlineData:  event.addTskEntities.deadlineData,
          taskID: event.addTskEntities.taskID,
          upLoaded: event.addTskEntities.upLoaded,
          Comment:event.addTskEntities.Comment,
          isDone: event.addTskEntities.isDone,
          CreatedAt: event.addTskEntities.CreatedAt,
          deadlineDatatimeStamp: event.addTskEntities.deadlineDatatimeStamp,
        ),
      );

      return result;

    });
  }

}