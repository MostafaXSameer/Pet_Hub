import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_hub/Business_Logic/cubit_log_in/log_in_cubit.dart';
import 'Sign_in.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = 'ForgotPassword_Page';
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var emUser = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => LogInCubit(),
        child: BlocConsumer <LogInCubit, LogInState>(
          listener:(context, state){} ,
          builder: (context, state){
            return  Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
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
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emUser,
                                onSaved: (String? value) {
                                  emUser.text = value!;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email is Required';
                                  }
                                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
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
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 220,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Color(0xff23424A),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MaterialButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        // ignore: unnecessary_statements
                                        if (LogInCubit.get(context).canResendEmail) {
                                          LogInCubit.get(context).resetPassword(emUser,context);
                                        } else {
                                          return null;
                                        }
                                      }
                                    },
                                    child: Text(
                                      "Reset Password",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(SignIn.routeName);
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color(0xff23424A),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )

    );
  }
}
