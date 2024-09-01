import 'package:dio/dio.dart';

const String baseUrl = "https://testys-snapfeast.hf.space";

final Dio dio = Dio(
  BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(minutes: 1),
    sendTimeout: const Duration(minutes: 1),
    receiveTimeout: const Duration(minutes: 1),
  ),
);

class SnapfeastResponse<T> {
  final String message;
  final T data;
  final bool success;

  const SnapfeastResponse({
    required this.message,
    required this.data,
    required this.success,
  });
}
