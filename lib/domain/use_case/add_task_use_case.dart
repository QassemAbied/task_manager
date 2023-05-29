import 'package:firebase_app/domain/entities/add_task_entities.dart';

import '../repository/base_repository.dart';
import 'base_use_case.dart';

class SetAddTaskUserUseCase extends BaseUseCase<void, AddTskEntities> {
  final BaseRepository baseRepository;
  SetAddTaskUserUseCase(this.baseRepository);
  @override
  Future<void> call(AddTskEntities parameter) async {
    return await baseRepository.setAddTaskUser(parameter);
  }
}
