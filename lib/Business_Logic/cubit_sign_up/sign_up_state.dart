part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpError extends SignUpState {}

class SignUpSuccess extends SignUpState {

}
class CreateUserLoading extends SignUpState {}
class CreateUserError extends SignUpState {}
class CreateUserSuccess extends SignUpState {
  final String uId;
  CreateUserSuccess(this.uId);
}

