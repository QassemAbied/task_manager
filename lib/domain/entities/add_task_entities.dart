import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AddTskEntities extends Equatable{
  final String taskCategory;
  final String taskTitle;
  final String taskDescription;
  final String deadlineData;
  final String taskID;
  final String upLoaded;
  final List Comment;
  final bool isDone;
  final Timestamp CreatedAt;
  final Timestamp? deadlineDatatimeStamp;
  AddTskEntities({required this.deadlineDatatimeStamp,required this.taskID,required this.upLoaded,required this.Comment,required this.isDone,required this.CreatedAt, required this.taskCategory , required this.taskTitle , required this.taskDescription,
  required this.deadlineData
  });

  @override
  List<Object?> get props => [taskCategory ,taskTitle , taskDescription , deadlineData];
}