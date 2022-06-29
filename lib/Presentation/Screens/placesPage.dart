import 'package:flutter/material.dart';
import 'package:pet_hub/Presentation/Widgets/Txt.dart';

import 'package:pet_hub/pets_icons_icons.dart';

import 'Notifications.dart';

class PlacesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title:  Txt(txt: 'PetHub',size: 28,color: Colors.white,
            family: 'Doggies Silhouette Font' , weight: FontWeight.bold,),
          backgroundColor: Color(0xff23424A),
          actions: [
            IconButton(icon:Icon(PetsIcons.notify_),onPressed: (){
              Navigator.pushNamed(context,NotificationScreen.routeName);
            },),
            SizedBox(width: 10,),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(PetsIcons.vets___copy),
                text: ("Clinics"),
              ),
              Tab(
                icon: Icon(PetsIcons.shelters_copy),
                text: ("Shelters"),
              ),
              Tab(
                icon: Icon(PetsIcons.pet_shop_2___copy),
                text: ("Shops"),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Icon(PetsIcons.heart),
            Icon(PetsIcons.heart),
            Icon(PetsIcons.heart),
          ],
        ),
      ),
    );
  }
}
