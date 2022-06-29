import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitial());
  static LogInCubit get(context) => BlocProvider.of(context);

  void loading() {
    emit(LogInLoading());
  }

  void error() {
    emit(LogInError());
  }

  void signInUser(String email, String password, BuildContext context,
      FirebaseAuth _auth) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value)async => {
        print(value.user!.uid),
        emit(LogInSuccess(value.user!.uid)),
              });
    } on FirebaseAuthException catch (error) {
      LogInCubit.get(context).error();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text(error.toString()),backgroundColor: Colors.red));
      print(error.code);
    }
  }


  bool canResendEmail = true;
  Future resetPassword(TextEditingController emUser,BuildContext context) async {
    emit(ResetPasswordLoading());
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emUser.text.trim());

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text('Password Reset Email has been sent to ' + emUser.text.trim())));
      emit(ResetPasswordChangeState());
        canResendEmail = false;
      await Future.delayed(Duration(seconds: 5));
        canResendEmail = true;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text(e.toString())));
    }
  }

}
