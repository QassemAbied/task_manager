import 'package:equatable/equatable.dart';

abstract class BaseUseCase<T, Parameter> {
  Future< T> call(Parameter parameter);
}

class NoParameter extends Equatable {
  const NoParameter();

  @override
  List<Object?> get props => [];
}
