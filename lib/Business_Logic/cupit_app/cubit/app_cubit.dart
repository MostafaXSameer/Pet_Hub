import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pet_hub/Constants/strings.dart';
import 'package:pet_hub/Data/Models/MessageModel.dart';
import 'package:pet_hub/Data/Models/pets_data.dart';
import 'package:pet_hub/Data/Models/userModel.dart';
import 'package:pet_hub/Presentation/Screens/OwnedPetDetails.dart';
import 'package:pet_hub/Presentation/Screens/Sign_in.dart';
import 'package:pet_hub/Presentation/Screens/homePage.dart';
import 'package:pet_hub/Presentation/Screens/placesPage.dart';
import 'package:pet_hub/Presentation/Screens/profilePage.dart';
import 'package:pet_hub/Presentation/Screens/qrCodePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:url_launcher/url_launcher.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  var myFormat = DateFormat('yyyy-MM-dd');
  UserData loggedInUser = UserData();
  UserData? strangeUser;
  UserData? chatUser;

  String? birthDate;
  bool linkOpened = false;


  Future<void> getUserData() async {
    if (uId != null) {
      print(uId);
      emit(AppGetUserLoadingState());
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(uId)
          .get()
          .then((value) {
        this.loggedInUser = UserData.fromMap(value.data());
        birthDate = "${myFormat.format(loggedInUser.birthDay!).toString()}";
        print("ana keda tmam");
        print(loggedInUser.fullName);
        emit(AppGetUserSuccessState());
      }).catchError((e) {
        emit(AppGetUserErrorState());
      });
    }
  }

  Future<void> getStrangeUserData(String? userId) async {
    strangeUser = new UserData();
    emit(AppGetUserLoadingState());
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .get()
        .then((value) {
      this.strangeUser = UserData.fromMap(value.data());
      birthDate = "${myFormat.format(strangeUser!.birthDay!).toString()}";
      print("-----------------------------------------------------------ana keda tmam");
      print(strangeUser!.fullName);
      emit(AppGetUserSuccessState());
    }).catchError((e) {
      emit(AppGetUserErrorState());
    });
  }


  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('uId');
    loggedInUser = UserData();
    currentIndex = 0;
    Navigator.of(context).pushReplacementNamed(SignIn.routeName);
  }


  int currentIndex = 0;
  List<Widget>screens = [HomePage(), PlacesPage(), QrCode(), Profile()];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }


  File? profileImage;
  var profileImagePicker = ImagePicker();
  String? profileImageUrl;

  Future<void> getProfileImage() async {
    final pickedFile = await profileImagePicker.pickImage(
        source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(AppImagePickedSuccessState());
      //isPicUploaded=true;
    } else {
      emit(AppImagePickedErrorState());
    }
  }


  void uploadProfileImage(
      {@required String? fullName, @required String? phoneNumber}) {
    emit(AppUploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('uers/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        updateUser(fullName: fullName, phoneNumber: phoneNumber);
      }).catchError((error) {
        emit(AppUploadProfileImageErrorState());
      });
    }).catchError((erorr) {
      emit(AppUploadProfileImageErrorState());
    });
  }


  void updateUser({@required String? fullName, @required String? phoneNumber}) {
    UserData userData = UserData();
    // writing all the values
    userData.email = loggedInUser.email;
    userData.id = loggedInUser.id;
    userData.fullName = fullName == "" ? loggedInUser.fullName : fullName;
    userData.phoneNumber =
    phoneNumber == "" ? loggedInUser.phoneNumber : phoneNumber;
    userData.birthDay = loggedInUser.birthDay;
    userData.city = loggedInUser.city;
    userData.state = loggedInUser.state;
    userData.gender = loggedInUser.gender;
    userData.profileImage =
    profileImage == null ? loggedInUser.profileImage : profileImageUrl;
    FirebaseFirestore.instance.collection("Users").doc(loggedInUser.id).update(
        userData.toMap()).then((value) {
      getUserData();
      profileImage = null;
    }).catchError((error) {});
  }


  openWhatsUp(BuildContext context) async {
    var whatsApp = "+2${loggedInUser.phoneNumber}";
    var whatsAppUrlAndroid = "whatsapp://send?phone=" + whatsApp;
    if (Platform.isAndroid) {
      if (await canLaunch(whatsAppUrlAndroid)) {
        await launch(whatsAppUrlAndroid);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("WhatsApp Not Installed")));
      }
    } else {}
  }

  void handleLinkRunning(BuildContext context) async
  {
    emit(AppRunningOpenWithLinkInitialState());

    if (!linkOpened) {
      linkOpened = true;
      FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
        if (uId != null) {
          print("I love U");
          String link = dynamicLinkData.link.toString();
          var arr = link.split('/');
          String userId = arr[arr.length - 3];
          String petOwnedId = arr[arr.length - 2];
          navigateToPetScreen(context, userId, petOwnedId, link);
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text(
              "Please Sign in or Sign up to Reach the required page"),
            backgroundColor: Colors.lightGreen,
            duration: Duration(seconds: 3),));
        }
      }).onError((error) {
        emit(AppRunningOpenWithLinkErrorState());
        print(error.toString());
      });
    }
  }

  void navigateToPetScreen(BuildContext context, String userId,
      String petOwnedId, String link) async
  {
    PetsOwned petsOwned = new PetsOwned();
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection("PetsOwned")
        .doc(petOwnedId)
        .get()
        .then((value) {
      petsOwned = PetsOwned.fromJson(value.data()!);
      emit(AppRunningOpenWithLinkOpenedState());
    }
    ).catchError((e) {
      emit(AppRunningOpenWithLinkErrorState());
      print(e.toString());
    });

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => OwnedPetDetails(petsOwned, link),));
  }

  Future <void> handleLink(PendingDynamicLinkData? initialLink,
      BuildContext context) async
  {
    print("I Hate U");
    String link = initialLink!.link.toString();
    print(link);
    var arr = link.split('/');
    String userId = arr[arr.length - 3];
    String petOwnedId = arr[arr.length - 2];
    PetsOwned petsOwned = new PetsOwned();
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection("PetsOwned")
        .doc(petOwnedId)
        .get()
        .then((value) {
      petsOwned = PetsOwned.fromJson(value.data()!);
    }
    ).catchError((e) {
      print(e.toString());
    });

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => OwnedPetDetails(petsOwned, link),));
  }


  Future<String> createDynamicLink(PetsOwned petOwned, String? petId) async {
    String _linkMessage;
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      link: Uri.parse(
          'https://www.pethub.page.link.com/${petOwned.ownerId}/${petId!}/'),
      uriPrefix: 'https://pethub.page.link',
      androidParameters: const AndroidParameters(
          packageName: "com.example.pet_hub"),
    );
    Uri url;
    url = await FirebaseDynamicLinks.instance.buildLink(parameters);
    _linkMessage = url.toString();
    return _linkMessage;
  }


  // CHAT

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,}) {
    MessageModel model = MessageModel(
      senderId: loggedInUser.id,
      receiverId: receiverId,
      dateTime: dateTime,
      text: text,
    );

    FirebaseFirestore.instance
        .collection('Users')
        .doc(loggedInUser.id)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(AppSendMessageSuccessState());
    })
        .catchError((error) {
      emit(AppSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(receiverId)
        .collection('chats')
        .doc(loggedInUser.id)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(AppSendMessageSuccessState());
    })
        .catchError((error) {
      emit(AppSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(loggedInUser.id)
        .collection('chats')
        .doc(receiverId)
        .set({
      'ID': 'test'
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(receiverId)
        .collection('chats')
        .doc(loggedInUser.id)
        .set({
      'ID': 'test'
    });
  }


  List <MessageModel> messages = [];
  void getMessages({required String receiverId,}) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(loggedInUser.id)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(AppGetMessagesSuccessState());
    });
  }


  List <String> chatUsersId=[];
  void getallchatsid(){
    FirebaseFirestore.instance
        .collection('Users/${loggedInUser.id}/chats')
        .get()
        .then((value)
    {
      chatUsersId=[];
       value.docs.forEach((element)
       {
         chatUsersId.add(element.reference.id);
       });
      getchatuserdata();
       emit(AppGetAllChatUsersSuccessState());
    }).catchError((error){
      emit(AppGetAllChatUsersErrorState());
    });
  }
  List<UserData> chatUsersData=[];
  Future<void> getchatuserdata() async {
    chatUsersData=[];
    for (int i = 0; i < chatUsersId.length; i++)
    {
      UserData chatUser = new UserData();
      emit(AppGetUserLoadingState());
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(chatUsersId[i])
          .get()
          .then((value) {
        chatUser = UserData.fromMap(value.data());
        chatUsersData.add(chatUser);
        //print("ana ${chatUser.fullName}");
        emit(AppGetUserSuccessState());
      }).catchError((e) {
        emit(AppGetUserErrorState());
      });
    }
  }
}