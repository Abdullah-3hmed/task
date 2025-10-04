import 'package:equatable/equatable.dart';
import 'package:task/core/enums/request_status.dart';

class AppState extends Equatable {
  final RequestStatus requestEditDeleteState;
  final String message;
  final String errorMessage;

  const AppState({
    this.requestEditDeleteState = RequestStatus.initial,
    this.message = "",
    this.errorMessage = "",
  });

  AppState copyWith({
    RequestStatus? requestEditDeleteState,
    String? message,
    String? errorMessage,
  }) {
    return AppState(
      requestEditDeleteState:
          requestEditDeleteState ?? this.requestEditDeleteState,
      message: message ?? this.message,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [requestEditDeleteState, message, errorMessage];
}
