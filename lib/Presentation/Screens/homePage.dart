import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_hub/Presentation/Screens/ChatMenu.dart';

import 'package:pet_hub/Presentation/Screens/CreateLostPost.dart';

import 'package:pet_hub/Presentation/Widgets/adaption_post_item.dart';
import 'package:pet_hub/Presentation/Widgets/lost_post_item.dart';

import 'package:pet_hub/pets_icons_icons.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../Widgets/host_post_item.dart';
import 'CreateAdoptionPost.dart';
import 'CreateHostPost.dart';
import 'Notifications.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'homePage';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var adaptionHeart = true;
  var lostHeart = true;
  var hostHeart = true;


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'PetHub',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.white,
                fontFamily: 'Doggies Silhouette Font',
              ),
            ),
            backgroundColor: Color(0xff23424A),
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            actions: [
              IconButton(icon:Icon(PetsIcons.comment),onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatMenu(),
                    )); },
              ),
               IconButton(icon:Icon(PetsIcons.notify_),onPressed: (){
                 Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => NotificationScreen(),
                     )); },),
              SizedBox(width: 10,),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(PetsIcons.icons8_care_96),
                  text: ("Adaption"),
                ),
                Tab(
                  icon: Icon(PetsIcons.location),
                  text: ("Lost"),
                ),
                Tab(
                  icon: Icon(PetsIcons.host),
                  text: ("Host"),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AdaptionPostItem(),
              LostPostItem(),
              HostPostItem(),
            ],
          ),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.add_event,
            //child: Icon(Icons.add),
            backgroundColor: Color(0xff23424A),
            overlayColor: Color(0xff23424A),
            overlayOpacity: 0.4,
            spacing: 10,
            spaceBetweenChildren: 10,
            elevation: 12,
            children: [
              SpeedDialChild(
                child: const Icon(PetsIcons.icons8_care_96),
                label: 'Adoption',
                backgroundColor: Colors.white,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateAdaptionPost(),
                    )),
              ),
              SpeedDialChild(
                child: const Icon(PetsIcons.location),
                label: 'Lost',
                backgroundColor: Colors.white,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateLostPost(),
                    )),
              ),
              SpeedDialChild(
                child: const Icon(PetsIcons.host),
                label: 'Host',
                backgroundColor: Colors.white,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateHostPost(),
                    )),
              ),
            ],
          )),
    );
  }
}
