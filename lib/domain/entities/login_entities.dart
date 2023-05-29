import 'package:equatable/equatable.dart';

class LoginEntities extends Equatable{
  final String email;
  final String password;
  LoginEntities({
    required this.email , required this.password,
});

  @override
  List<Object?> get props => [email , password];
}