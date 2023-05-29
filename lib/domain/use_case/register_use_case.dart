import '../entities/login_entities.dart';
import '../repository/base_repository.dart';
import 'base_use_case.dart';

class RegisterUseCase extends BaseUseCase<void, LoginEntities> {
  final BaseRepository baseRepository;
  RegisterUseCase(this.baseRepository);
  @override
  Future<void> call(LoginEntities parameter) async {
    return await baseRepository.getRegister(parameter);
  }
}
