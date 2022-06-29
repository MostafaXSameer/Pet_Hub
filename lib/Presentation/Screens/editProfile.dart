import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pet_hub/Data/Models/userModel.dart';

import '../../Business_Logic/cupit_app/cubit/app_cubit.dart';


class EditProfilePage extends StatefulWidget {
  static const routeName = 'Edit_Profile';
  final UserData? loggedInUser;
  EditProfilePage({@required this.loggedInUser});
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> formKey2=GlobalKey<FormState>();
  final TextEditingController fullNameController= TextEditingController();
  final TextEditingController phoneNumberController =TextEditingController();
  File? profileImage ;
  UserData currentUser =UserData();
  final pattern=r'^01[0125][0-9]{8}$';

  @override
  void initState() {
    super.initState();
    fullNameController.text=widget.loggedInUser!.fullName!;
    phoneNumberController.text =widget.loggedInUser!.phoneNumber!;
    fullNameController.selection = TextSelection.fromPosition(TextPosition(offset: fullNameController.text.length));
    phoneNumberController.selection = TextSelection.fromPosition(TextPosition(offset: phoneNumberController.text.length));
  }
  @override
  Widget build(BuildContext context) {
    double screenwidth= MediaQuery.of(context).size.width;
    double screenheight= MediaQuery.of(context).size.height;
    profileImage= AppCubit.get(context).profileImage;
    currentUser=AppCubit.get(context).loggedInUser;

      return BlocConsumer<AppCubit,AppState>(
        listener: (context,state){
          if(state is AppGetUserSuccessState)
            {
              Navigator.pop(context);
            }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff23424A),
              elevation: 5,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            body: Container(
              width: screenwidth,
              height: screenheight,
              padding: EdgeInsets.only(left: 16, top: 25, right: 16),
              child: Form(
                key: formKey2,
                child: ListView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    children: [
                      if(state is AppUserUpdateLoadingState||state is AppUploadProfileImageLoadingState)
                        LinearProgressIndicator(color: Color(0xff23424A),),
                      if(state is AppUserUpdateLoadingState||state is AppUploadProfileImageLoadingState)
                        SizedBox(height: 5,),
                      Text(
                        "Edit Profile",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500,color: Color(0xff23424A)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      //Profile Image Edit
                      Center(
                        child: Stack(
                          children: [
                            if(currentUser.profileImage!=null)
                              Container(
                                width: 130,
                                height: 140,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 4,
                                        color: Theme
                                            .of(context)
                                            .scaffoldBackgroundColor),
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          color: Colors.black.withOpacity(0.1),
                                          offset: Offset(0, 10))
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: profileImage==null? NetworkImage(
                                          "${currentUser.profileImage}",
                                        ):FileImage(profileImage!)as ImageProvider)),
                              ),
                            if(currentUser.profileImage==null)// no profile image
                              Container(
                                width: 130,
                                height: 140,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 4,
                                        color: Theme
                                            .of(context)
                                            .scaffoldBackgroundColor),
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          color: Colors.black.withOpacity(0.1),
                                          offset: Offset(0, 10))
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: profileImage==null? AssetImage('Images/Group 2.png'):FileImage(profileImage!)as ImageProvider)),
                              ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                left: 80 ,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 4,
                                      color: Theme
                                          .of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    color: Colors.green,
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.edit,),
                                    color: Colors.white,
                                    onPressed: (){
                                      AppCubit.get(context).getProfileImage();
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
                      // Full Name Edit
                      TextFormField(
                        controller:fullNameController,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'FullName is Required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            labelText: 'Full Name',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:  Color(0xff23424A),
                            )),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      //Phone Number Edit
                      TextFormField(
                        controller:phoneNumberController ,
                        keyboardType: TextInputType.phone,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Phone Number is Required';
                          }
                          if (!RegExp(pattern)
                              .hasMatch(value)) {
                            return ("Please Enter a valid Phone number starts with 01");
                          }
                          return null;
                        },
                        //initialValue: widget.currentUser.phoneNumber,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            labelText: 'phone Number',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:  Color(0xff23424A),
                            )),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Cancel Button
                          OutlinedButton (
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("CANCEL",
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 2,
                                    color: Colors.black)),
                          ),
                          //.....
                          SizedBox(
                            width: 20,
                          ),
                          //Save Button
                          ElevatedButton(
                            onPressed: () {
                              if (formKey2.currentState!.validate())
                              {
                                if(AppCubit.get(context).profileImage==null)
                                  AppCubit.get(context).updateUser(fullName: fullNameController.text,phoneNumber: phoneNumberController.text);
                                else
                                  AppCubit.get(context).uploadProfileImage(fullName: fullNameController.text,phoneNumber: phoneNumberController.text);
                              }
                            },
                            child: Text(
                              "SAVE",
                              textAlign:TextAlign.center ,
                              style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.white,),
                            ),
                          ),
                        ],
                      ),]
                ),
              ),
            ),
          );
        },
      );
      }
}


