import 'package:equatable/equatable.dart';
import 'package:task/core/enums/request_status.dart';

class AppState extends Equatable {
  final RequestStatus requestEditDeleteState;
  final String requestEditDeleteMessage;
  final String errorMessage;

  const AppState({
    this.requestEditDeleteState = RequestStatus.initial,
    this.requestEditDeleteMessage = "",
    this.errorMessage = "",
  });

  AppState copyWith({
    RequestStatus? requestEditDeleteState,
    String? requestEditDeleteMessage,
    String? errorMessage,
  }) {
    return AppState(
      requestEditDeleteState:
          requestEditDeleteState ?? this.requestEditDeleteState,
      requestEditDeleteMessage:
          requestEditDeleteMessage ?? this.requestEditDeleteMessage,
      errorMessage: requestEditDeleteMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
    requestEditDeleteState,
    requestEditDeleteMessage,
    errorMessage,
  ];
}
