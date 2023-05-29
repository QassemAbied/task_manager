import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/data/data_sourece/remote_data_source.dart';
import 'package:firebase_app/data/models/user_models.dart';
import 'package:firebase_app/domain/entities/add_task_entities.dart';
import 'package:firebase_app/domain/entities/login_entities.dart';
import 'package:firebase_app/domain/entities/user_enitites.dart';
import 'package:firebase_app/domain/use_case/get_user_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
class RemoteDataSourceImpl implements RemoteDataSource{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> getLogin(LoginEntities parameter)async {


      // final dfgg= await auth.createUserWithEmailAndPassword(
      //     email: parameter.email,
      //     password: parameter.password
      // );



  }

  @override
  Future<void> getRegister(LoginEntities parameter) async{
   // await auth.signInWithEmailAndPassword(
   //     email: parameter.email,
   //     password: parameter.password,
   // );
  }

  @override
  Future<void> setUserData(UserEntities parameter) async{
    final User? user = auth.currentUser;
    final _uid= user!.uid;
    await firestore.collection('User').doc(_uid).set({
      'name' : parameter.name,
      'email' : parameter.email,
      'userImageUrl' : parameter.userImageUrl,
      'phoneNuber' : parameter.phoneNuber,
      'positionCompany' : parameter.positionCompany,
      'createdAt' : parameter.createdAt,
      'id' : parameter.id,
    });
  }

  @override
  Future<UserModels> getUserData(setToken parameter)async {

    final DocumentSnapshot userDoc = await firestore.collection('User').doc(parameter.token).get();

    if(userDoc==null){
      return null!;
    }else{
      return await UserModels.fromJson(userDoc.get(UserModels));
    }
  }

  @override
  Future<void> setAddTaskUser(AddTskEntities parameter)async {
    final User? user = auth.currentUser;
    final _uid= user!.uid;
    final taskID= Uuid().v4();
    await firestore.collection('Tasks').doc(taskID).set(
        {
          'taskCategory' : parameter.taskCategory,
          'taskTitle' : parameter.taskTitle,
          'taskDescription' : parameter.taskDescription,
          'deadlineData'  : parameter.deadlineData,
          'taskID':taskID,
        'upLoaded':parameter.upLoaded,
        'Comment':parameter.Comment,
        'isDone':parameter.isDone,
        'CreatedAt':parameter.CreatedAt,
        'deadlineDatatimeStamp':parameter.deadlineDatatimeStamp,
        }
    );
  }


}