import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import 'package:pet_hub/Presentation/Screens/bottomTabScreen.dart';
import 'package:pet_hub/Presentation/Widgets/Txt.dart';

import 'Sign_in.dart';

class Verification extends StatefulWidget {
  static const routeName = 'Verification_Page';
  final PendingDynamicLinkData? initialLink;
  Verification({this.initialLink});
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  bool isEmailVerfied = false;
  bool canResendEmail = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    isEmailVerfied = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerfied) {
      sendVerficationEmail();
      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerfied(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerfied() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerfied = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerfied) {
      timer?.cancel();
    }
  }

  Future sendVerficationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text(e.toString()),backgroundColor: Colors.red,));
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerfied
      ? TabScreen(initialLink:widget.initialLink)
      : Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Image(
                      image: AssetImage('Images/Group 2.png'),
                      width: 200,
                      height: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      color: Colors.amber.withOpacity(0.6),
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Icon(Icons.info_outline),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(child: Txt(txt: 'A Verification email has been '
                              'sent to your Email, please check your Email', size: 15,)
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                      onPressed: canResendEmail ? sendVerficationEmail : null,
                      icon: Icon(
                        Icons.email,
                        size: 32,
                      ),
                      label: Txt(txt: 'Resend Email Verfication', color: Colors.white,
                        weight: FontWeight.bold,size: 15,),
                  ),
                  TextButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context)
                          .pushReplacementNamed(SignIn.routeName);
                    },
                    child: Txt(txt: 'Sign In', color: Colors.blueAccent,
                      weight: FontWeight.bold,size: 15,),
                  )
                ],
              ),
            ),
          ),
        );
}
