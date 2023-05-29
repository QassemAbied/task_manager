import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  const Failure(
      this.message,
      );

  @override
  List<Object?> get props => [message];
}

class ServiceFailure extends Failure {
  ServiceFailure(String message) : super(message);
}
