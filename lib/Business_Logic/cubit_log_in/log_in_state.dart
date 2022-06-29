part of 'log_in_cubit.dart';

@immutable
abstract class LogInState {}

class LogInInitial extends LogInState {}

class LogInError extends LogInState {}

class LogInSuccess extends LogInState {
  final String uId;
  LogInSuccess(this.uId);
}

class LogInLoading extends LogInState {}

class ResetPasswordLoading extends LogInState {}

class ResetPasswordSuccess extends LogInState {}

class ResetPasswordChangeState extends LogInState {}



