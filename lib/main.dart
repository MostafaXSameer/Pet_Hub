import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_hub/Business_Logic/cupit_app/cubit/app_cubit.dart';
import 'package:pet_hub/Presentation/Screens/ChatInside.dart';
import 'package:pet_hub/Presentation/Screens/ChatMenu.dart';
import 'package:pet_hub/Presentation/Screens/CreateHostPost.dart';
import 'package:pet_hub/Presentation/Screens/CreateLostPost.dart';
import 'package:pet_hub/Presentation/Screens/Notifications.dart';

import 'package:pet_hub/Presentation/Screens/Sign_Up.dart';
import 'package:pet_hub/Presentation/Screens/Sign_in.dart';
import 'package:pet_hub/Presentation/Screens/Sign_in_out.dart';
import 'package:pet_hub/Presentation/Screens/bottomTabScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pet_hub/Presentation/Screens/homePage.dart';
import 'package:pet_hub/Presentation/Screens/profilePage.dart';

import 'Constants/strings.dart';
import 'Presentation/Screens/CreateAdoptionPost.dart';
import 'Presentation/Screens/forgotPassword.dart';
import 'Presentation/Screens/verficationPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
  Widget? widget;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  uId = prefs.getString('uId');
  print(uId);
  if (uId == null) {
    widget = SignInOut(initialLink: initialLink,);
  } else {
    widget = Verification(initialLink:initialLink);
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  MyApp(this.startWidget);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getUserData(),
      child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'PetHup',
              theme: ThemeData(
                primarySwatch: Colors.teal,
                //primaryColor: Color(0xff23424A),
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              routes: {
                '/': (context) => startWidget!,
                HomePage.routeName: (context) => HomePage(),
                SignInOut.routeName: (context) => SignInOut(),
                SignIn.routeName: (context) => SignIn(),
                SignUp.routeName: (context) => SignUp(),
                TabScreen.routeName: (context) => TabScreen(),
                Profile.routeName: (context) => Profile(),
                Verification.routeName: (context) => Verification(),
                ForgotPassword.routeName: (context) => ForgotPassword(),
                CreateAdaptionPost.routeName: (context) => CreateAdaptionPost(),
                CreateLostPost.routeName: (context) => CreateLostPost(),
                CreateHostPost.routeName: (context) => CreateHostPost(),
                NotificationScreen.routeName:(context)=>NotificationScreen(),
                ChatMenu.routeName: (context) => ChatMenu(),
                // ChatInside.routeName: (context) => ChatInside(),
              },
            );
          }),
    );
  }
}