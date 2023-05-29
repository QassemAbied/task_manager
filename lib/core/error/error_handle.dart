import 'package:equatable/equatable.dart';

class ErrorHandleApi extends Equatable {
  final String statusMessage;
  final int statusCode;
  bool success;

  ErrorHandleApi(
      {required this.statusMessage,
        required this.statusCode,
        required this.success});

  factory ErrorHandleApi.fromJson(Map<String, dynamic> json) => ErrorHandleApi(
    statusMessage: json['status_message'],
    statusCode: json['status_code'],
    success: json['success'],
  );

  @override
  List<Object?> get props => [statusMessage, success, statusCode];
}
