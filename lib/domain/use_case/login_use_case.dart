import 'package:firebase_app/domain/entities/login_entities.dart';
import 'package:firebase_app/domain/repository/base_repository.dart';
import 'package:firebase_app/domain/use_case/base_use_case.dart';

class LoginUseCase extends BaseUseCase<void , LoginEntities>{
  final BaseRepository baseRepository;
  LoginUseCase(this.baseRepository);
  @override
  Future<void> call(LoginEntities parameter) async{
   return await baseRepository.getLogin(parameter);
  }

}