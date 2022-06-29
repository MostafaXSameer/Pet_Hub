import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Data/models/userModel.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  static SignUpCubit get(context) => BlocProvider.of(context);
  final _auth = FirebaseAuth.instance;
  void loading() {
    emit(SignUpLoading());
  }

  void error() {
    emit(SignUpError());
  }

  void signUp(
    String email,
    String password,
    BuildContext context,
    String fullName,
    String phoneNumber,
    DateTime birthDay,
    String city,
    String state,
    String gender,
  ) async {
    emit(SignUpLoading());
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
           emit(SignUpSuccess()),

        postDetailsToFirestore(
                  fullName,
                  phoneNumber,
                  birthDay,
                  city,
                  state,
                  gender,
                  context,
                )
              })
          .catchError((e) {
        error();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text(e.toString())));
      });
    } catch (errorAuth) {
      error();
      print(errorAuth.toString());
    }
  }

  postDetailsToFirestore(
    String fullName,
    String phoneNumber,
    DateTime birthDay,
    String city,
    String state,
    String gender,
    BuildContext context,
  ) async {
    emit(CreateUserLoading());
    // calling our firestore
    // calling our user model
    // sedning these values
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User user = _auth.currentUser!;
      UserData userData = UserData();
      // writing all the values
      userData.email = user.email;
      userData.id = user.uid;
      userData.fullName = fullName;
      userData.phoneNumber = phoneNumber;
      userData.birthDay = birthDay;
      userData.city = city;
      userData.state = state;
      userData.gender = gender;
      await firebaseFirestore
          .collection("Users")
          .doc(user.uid)
          .set(userData.toMap());
      emit(CreateUserSuccess(user.uid));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("Account created Successfully")));

    } catch (errorData) {
      error();
    }
  }
}
