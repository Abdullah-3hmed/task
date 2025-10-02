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
          // 'Connection to API server failed due to internet connection',
          "No Internet Connection",
          isConnected: false,
        );
      case DioExceptionType.cancel:
        return const ServerFailure(
          'Request to API server was cancelled',
          isConnected: false,
        );
      case DioExceptionType.connectionTimeout:
        return const ServerFailure(
          'Connection timeout with API server',
          isConnected: false,
        );
      case DioExceptionType.sendTimeout:
        return const ServerFailure(
          'Send timeout in connection with API server',
          isConnected: false,
        );

      case DioExceptionType.receiveTimeout:
        return const ServerFailure(
          'Receive timeout in connection with API server',
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
            'No internet connection',
            isConnected: false,
          );
        }
        return const ServerFailure(
          'Unexpected Error , Please try again',
          isConnected: false,
        );
      default:
        return ServerFailure(
          dioError.message ?? 'There was an error, please try again',
          isConnected: false,
        );
    }
  }

  factory ServerFailure.fromBadResponse(int statusCode, dynamic response) {
    String message = "There was an error , please try again";

    if (response is Map && response.containsKey("message")) {
      message = response["message"].toString();
    } else if (response is String) {
      message = response;
    }
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(message);
    } else if (statusCode == 404) {
      return const ServerFailure('Your request not found , please try later');
    } else if (statusCode == 500) {
      return const ServerFailure('Internal server error , please try later');
    }
    return const ServerFailure('there was an error , please try again');
  }
}

