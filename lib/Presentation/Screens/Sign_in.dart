import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pet_hub/Business_Logic/cubit_log_in/log_in_cubit.dart';
import 'package:pet_hub/Business_Logic/cupit_app/cubit/app_cubit.dart';
import 'package:pet_hub/Constants/strings.dart';
import 'package:pet_hub/Presentation/Screens/verficationPage.dart';
import 'package:pet_hub/Presentation/Widgets/CustomButton.dart';
import 'Sign_Up.dart';
import 'forgotPassword.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignIn extends StatelessWidget {
  static const routeName = 'sign_in';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emUser = TextEditingController();
  final TextEditingController passUser = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return BlocProvider(
        create: (BuildContext context) => LogInCubit(),
        child: BlocConsumer <LogInCubit, LogInState>(
            listener: (context, state) async{
              if (state is LogInSuccess ) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('uId',state.uId);
                uId = prefs.getString('uId');
                await AppCubit.get(context).getUserData();
                Navigator.of(context).pushNamedAndRemoveUntil(Verification.routeName, (route) => false);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("Log in Success"),backgroundColor: Colors.lightGreen,));

              }
        }, builder: (context, state) {
          return Scaffold(
            body: Container(
              width: screenwidth,
              height: screenheight,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Image(
                          image: AssetImage('Images/Group 2.png'),
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'PetHub',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                            color: Color(0xff23424A),
                            fontFamily: 'Doggies Silhouette Font',
                          ),
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        //email field
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emUser,
                          onSaved: (value) {
                            emUser.text = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email is Required';
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please Enter a valid email");
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Email Address',
                              labelStyle: TextStyle(
                                color: Color(0xff23424A),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Color(0xff23424A),
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Color(0xff23424A),
                                  width: 3.0,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color(0xff23424A),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //password field
                        TextFormField(
                          obscureText: true,
                          controller: passUser,
                          onSaved: (String? value) {
                            passUser.text = value!;
                          },
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return 'Password is Required';
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Enter Valid Password(Min. 6 Character)");
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Color(0xff23424A),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Color(0xff23424A),
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Color(0xff23424A),
                                width: 3.0,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xff23424A),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color(0xff23424A),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: state is LogInLoading||state is LogInSuccess
                                ? loadingButton()
                                : buildMaterialButton(context),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(
                                  ForgotPassword.routeName);
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff23424A),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'don\'t have account ?',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed(SignUp.routeName);
                                  },
                                  child: Text(
                                    'SignUp',
                                    style: TextStyle(
                                        fontSize: 15, color: Color(0xff23424A)),
                                  )),
                            ])
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }

  CustomButton buildMaterialButton(BuildContext context) {
   return CustomButton(inputText: 'Log In', fontSize: 30, Navigation: () {LogInCubit.get(context).loading();
    if (formKey.currentState!.validate()) {
      LogInCubit.get(context)
          .signInUser(emUser.text, passUser.text, context, _auth);
    } else {
      LogInCubit.get(context).error();
    }}, padd: 0, width: 200,);

  }

  SpinKitWave loadingButton() {
    return SpinKitWave(
      color: Colors.white,
      size: 30.0,
    );
  }

  // login function

}
