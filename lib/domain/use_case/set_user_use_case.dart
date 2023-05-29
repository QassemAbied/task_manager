import 'package:firebase_app/domain/entities/user_enitites.dart';

import '../repository/base_repository.dart';
import 'base_use_case.dart';

class SetUserDataUseCase extends BaseUseCase<void, UserEntities> {
  final BaseRepository baseRepository;
  SetUserDataUseCase(this.baseRepository);
  @override
  Future<void> call(UserEntities parameter) async {
    return await baseRepository.setUserData(parameter);
  }
}
