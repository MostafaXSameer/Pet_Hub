import 'package:flutter/material.dart';
import 'package:pet_hub/Business_Logic/cupit_app/cubit/app_cubit.dart';
import 'package:pet_hub/Data/Models/userModel.dart';
class ProfileImage extends StatelessWidget {
  final UserData? userData;
  ProfileImage({required this.userData});
  @override
  Widget build(BuildContext context) {
    UserData user =userData! ;
    return  Container(
      width: 130,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            width: 4,
            color: Theme.of(context).scaffoldBackgroundColor),
        boxShadow: [
          BoxShadow(
              spreadRadius: 2,
              blurRadius: 10,
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 10))
        ],
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        backgroundImage: user.profileImage == null
            ? AssetImage('Images/Group 2.png') as ImageProvider
            : NetworkImage("${user.profileImage}"),
        backgroundColor: Colors.white,
        radius: 70,
      ),
    );
  }
}
