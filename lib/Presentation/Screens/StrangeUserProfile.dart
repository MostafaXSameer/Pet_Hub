import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../Business_Logic/cupit_app/cubit/app_cubit.dart';
import '../../Constants/strings.dart';
import '../../Data/Models/userModel.dart';
import '../Widgets/Txt.dart';
import '../Widgets/owned_pets_tab.dart';
import '../Widgets/profile_image.dart';
import 'ChatInside.dart';

class UserProfile extends StatefulWidget {
  final String? userId;
  UserProfile({this.userId});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> with SingleTickerProviderStateMixin{
  TabController? _tabController;
  UserData strangeUser = UserData();
  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getStrangeUserData(widget.userId);
    _tabController = new TabController(length: 3, vsync:this);
  }

  List<BoxShadow> shadowList = [
    BoxShadow(color: Colors.grey, blurRadius: 30, offset: Offset(0, 10))
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener: (context, state) {},
        builder: (context,state){
          strangeUser=AppCubit.get(context).strangeUser!;
          return  Scaffold(
            appBar: AppBar(
              elevation: 10,
              backgroundColor: Color(0xff23424A),
            ),
            body: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //profile image
                    ProfileImage(userData: strangeUser),
                    SizedBox(
                      height: 20,
                    ),
                    //profile Name
                    Text(
                      "${strangeUser.fullName}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xff23424A),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Container(
                              width: double.maxFinite,
                              height: 100,
                              child: Align(
                                alignment: Alignment.center,
                                child: TabBar(
                                  isScrollable: true,
                                  labelColor: Color(0xff23424A),
                                  indicatorColor: Color(0xff23424A),
                                  labelPadding:
                                  EdgeInsets.only(left: 35, right: 35),
                                  controller: _tabController,
                                  tabs: [
                                    Tab(text: "About"),
                                    Tab(text: "Animal Owned"),
                                    Tab(text: "Posts"),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Expanded(
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          //country city state
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, bottom: 20),
                                            child: Text(
                                              "${strangeUser.state} , ${strangeUser.city} , Egypt",
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 17,
                                                color: Color(0xff23424A),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          //Gender
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, bottom: 20),
                                              child: Txt(txt: "Gender : ${strangeUser.gender}",size: 17,weight: FontWeight.normal,color: Color(0xff23424A),)
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          // BirthDate
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, bottom: 20),
                                              child: Txt(txt: AppCubit.get(context).birthDate!,size: 17,weight: FontWeight.normal,color: Color(0xff23424A),)
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(30),
                                                  child: IconButton(
                                                      onPressed: () {
                                                        AppCubit.get(context).openWhatsUp(context);
                                                      },
                                                      icon: Icon(
                                                        Icons.phone,
                                                        color: Colors.green,
                                                        size: 50.0,
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: 120,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(30),
                                                  child: IconButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => ChatInside(strangeuser:strangeUser),
                                                            ));
                                                      },
                                                      icon: Icon(
                                                        Icons.mail,
                                                        color: Colors.redAccent,
                                                        size: 50.0,
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    OwnedPetsTab(user: strangeUser),
                                    Icon(Icons.location_on_outlined),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });

  }
  Padding loadingText() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 20),
      child: SkeletonAnimation(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          height: 20,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey[200]),
        ),
      ),
    );
  }



}
