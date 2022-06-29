import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_hub/Business_Logic/cupit_app/cubit/app_cubit.dart';
import 'package:pet_hub/Presentation/Widgets/CustomButton.dart';
import 'package:pet_hub/Presentation/Widgets/Txt.dart';
import 'Sign_in.dart';
import 'Sign_Up.dart';

class SignInOut extends StatelessWidget {
  static const routeName = 'sign_in_out';
  final PendingDynamicLinkData? initialLink;
  SignInOut({this.initialLink});
  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).handleLinkRunning(context);
    return BlocConsumer<AppCubit, AppState>( listener:(context,state){},
        builder:(context,state){
          double screenwidth= MediaQuery.of(context).size.width;
          double screenheight= MediaQuery.of(context).size.height;
          return Scaffold(
            body: Container(
              width: screenwidth,
              height: screenheight,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      const Image(
                        image: AssetImage('Images/Group 2.png'),
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(child: const Txt(txt: 'PetHub', color: Color(0xff23424A),weight: FontWeight.bold,size: 50,family:'Doggies Silhouette Font' ,)),
                      const SizedBox(
                        height: 40.0,
                      ),
                      if(initialLink!=null)
                        const Txt(txt: 'You Need to SignUp or SignIn to Reach the required Page', color: Colors.red,weight: FontWeight.bold,size: 20,),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(inputText: 'Sign In', fontSize: 30, Navigation:(){Navigator.of(context).pushNamed(SignIn.routeName);}, padd: 16, width: double.infinity,),
                      CustomButton(inputText: 'SignUp', fontSize: 30, Navigation:(){Navigator.of(context).pushNamed(SignUp.routeName);},padd: 16,width: 400,),
                    ],
                  ),
                ),
              ),
            ),
          );

        } );
  }
}




