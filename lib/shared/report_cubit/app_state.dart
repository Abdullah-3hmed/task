import 'package:equatable/equatable.dart';
import 'package:task/core/enums/request_status.dart';

class ReportState extends Equatable {
  final RequestStatus requestEditDeleteState;
  final String message;
  final String errorMessage;

  const ReportState({
    this.requestEditDeleteState = RequestStatus.initial,
    this.message = "",
    this.errorMessage = "",
  });

  ReportState copyWith({
    RequestStatus? requestEditDeleteState,
    String? message,
    String? errorMessage,
  }) {
    return ReportState(
      requestEditDeleteState:
          requestEditDeleteState ?? this.requestEditDeleteState,
      message: message ?? this.message,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [requestEditDeleteState, message, errorMessage];
}
