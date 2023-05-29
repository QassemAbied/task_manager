import 'package:equatable/equatable.dart';
import 'package:firebase_app/core/enum.dart';
import 'package:firebase_app/domain/entities/login_entities.dart';

import '../../../domain/entities/user_enitites.dart';

class LoginStates extends Equatable{
  final void login;
  final EnumRequest loginEnumRequest;
  final String loginString;

  final void register;
  final EnumRequest registerEnumRequest;
  final String registerString;

  final void userData;
  final EnumRequest userDataEnumRequest;
  final String userDataString;

  final UserEntities? userEntities;
  final EnumRequest userEntitiesEnumRequest;
  final String userEntitiesString;
  LoginStates({
    this.login,
    this.loginEnumRequest = EnumRequest.loding,
    this.loginString = '',

    this.register,
    this.registerEnumRequest  = EnumRequest.loding,
    this.registerString ='',

    this.userData,
    this.userDataEnumRequest = EnumRequest.loding,
    this.userDataString = '',

    this.userEntities,
    this.userEntitiesEnumRequest = EnumRequest.loding,
    this.userEntitiesString='',
});
  LoginStates copyWith({
    final void login,
    final EnumRequest? loginEnumRequest,
    final String? loginString,

    final void register,
    final EnumRequest? registerEnumRequest,
    final String? registerString ,

    final void userData ,
    final EnumRequest? userDataEnumRequest ,
    final String? userDataString ,

    final UserEntities? userEntities,
    final EnumRequest? userEntitiesEnumRequest,
    final String? userEntitiesString,
})
  {
    return LoginStates(
   // login: login??this.login,
  loginEnumRequest: loginEnumRequest ??this.loginEnumRequest,
  loginString: loginString ??this.loginString,

      registerEnumRequest: registerEnumRequest ??this.registerEnumRequest,
      registerString: registerString ??this.registerString,

      userDataEnumRequest: userDataEnumRequest??this.userDataEnumRequest,
      userDataString: userDataString??this.userDataString,

      userEntities: userEntities??this.userEntities,
      userEntitiesEnumRequest: userEntitiesEnumRequest??this.userEntitiesEnumRequest,
      userEntitiesString: userEntitiesString??this.userEntitiesString,
    );
  }

  @override
  List<Object?> get props => [
    loginEnumRequest , loginString,
    registerEnumRequest , registerString,
    userDataEnumRequest , userDataString,

    userEntities, userEntitiesEnumRequest,userDataString
  ];
}