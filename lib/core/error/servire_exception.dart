import 'error_handle.dart';

class ServierException implements Exception {
  final ErrorHandleApi errorHandle;
  const ServierException(this.errorHandle);
}
