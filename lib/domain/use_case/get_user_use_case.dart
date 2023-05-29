import 'package:equatable/equatable.dart';

import '../entities/user_enitites.dart';
import '../repository/base_repository.dart';
import 'base_use_case.dart';

class getUserDataUseCase extends BaseUseCase<UserEntities, setToken> {
  final BaseRepository baseRepository;
  getUserDataUseCase(this.baseRepository);
  @override
  Future<UserEntities> call(setToken parameter) async {
    return await baseRepository.getUserData(parameter);
  }
}
 class setToken extends Equatable{
  final String token;
  setToken({required this.token});

  @override
  List<Object?> get props => [token];
 }