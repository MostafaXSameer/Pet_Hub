import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_hub/Business_Logic/cupit_app/cubit/app_cubit.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';


import 'package:pet_hub/pets_icons_icons.dart';


class TabScreen extends StatelessWidget {
  static const routeName = 'tab_screen';
  final PendingDynamicLinkData? initialLink;
  TabScreen({this.initialLink});
  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).handleLinkRunning(context);
    if(initialLink!=null)
    AppCubit.get(context).handleLink(initialLink,context);
    return BlocConsumer<AppCubit,AppState>(
   listener: (context, state) {},
     builder:(context,state){
       var cubit=AppCubit.get(context);
       return Scaffold(
         body: cubit.screens[cubit.currentIndex],
         bottomNavigationBar: BottomNavigationBar(
           onTap: (index){cubit.changeBottomNav(index);},
           selectedItemColor: Color(0xffF3F3F3),
           unselectedItemColor: Color(0xffF3F3F3),
           currentIndex:cubit.currentIndex,
           items: [
             BottomNavigationBarItem(
               icon: Icon(PetsIcons.home),
               label: "Home",
               backgroundColor: Color(0xff23424A),
             ),
             BottomNavigationBarItem(
               icon: Icon(PetsIcons.care__places_),
               label: "Places",
               backgroundColor: Color(0xff23424A),
             ),
             BottomNavigationBarItem(
               icon: Icon(PetsIcons.icons8_qr_code_90),
               label: "QR Code",
               backgroundColor: Color(0xff23424A),
             ),
             BottomNavigationBarItem(
               icon: Icon(Icons.person),
               label: "Profile",
               backgroundColor: Color(0xff23424A),
             ),
           ],
         ),
       );
     } ,
    );
  }

}



