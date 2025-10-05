import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMessage;
  final bool isConnected;
  const Failure(this.errorMessage, {this.isConnected = true});

  @override
  List<Object> get props => [errorMessage, isConnected];
}

class ServerFailure extends Failure {
  const ServerFailure(super.errorMessage, {super.isConnected = true});

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionError:
        return const ServerFailure(
          "لا يوجد اتصال بالإنترنت",
          isConnected: false,
        );
      case DioExceptionType.cancel:
        return const ServerFailure(
          'تم إلغاء الطلب إلى الخادم',
          isConnected: false,
        );
      case DioExceptionType.connectionTimeout:
        return const ServerFailure(
          'انتهت مهلة الاتصال بالخادم',
          isConnected: false,
        );
      case DioExceptionType.sendTimeout:
        return const ServerFailure(
          'انتهت مهلة إرسال البيانات إلى الخادم',
          isConnected: false,
        );

      case DioExceptionType.receiveTimeout:
        return const ServerFailure(
          'انتهت مهلة استلام البيانات من الخادم',
          isConnected: false,
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromBadResponse(
          dioError.response!.statusCode!,
          dioError.response!.data,
        );
      case DioExceptionType.unknown:
        if (dioError.error is SocketException) {
          return const ServerFailure(
            'لا يوجد اتصال بالإنترنت',
            isConnected: false,
          );
        }
        return const ServerFailure(
          'خطأ غير متوقع، يرجى المحاولة مرة أخرى',
          isConnected: false,
        );
      default:
        return ServerFailure(
          dioError.message ?? 'حدث خطأ، يرجى المحاولة مرة أخرى',
          isConnected: false,
        );
    }
  }

  factory ServerFailure.fromBadResponse(int statusCode, dynamic response) {
    String message = "حدث خطأ، يرجى المحاولة مرة أخرى";

    if (response is Map && response.containsKey("message")) {
      message = response["message"].toString();
    } else if (response is String) {
      message = response;
    }
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(message);
    } else if (statusCode == 404) {
      return const ServerFailure('الطلب غير موجود، يرجى المحاولة لاحقًا');
    } else if (statusCode == 500) {
      return const ServerFailure('خطأ داخلي في الخادم، يرجى المحاولة لاحقًا');
    }
    return const ServerFailure('حدث خطأ، يرجى المحاولة مرة أخرى');
  }
}
