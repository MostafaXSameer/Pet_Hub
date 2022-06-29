import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:intl/intl.dart';
import 'package:pet_hub/Business_Logic/cupit_app/cubit/app_cubit.dart';
import 'package:pet_hub/Data/Models/lostPostsModel.dart';

import '../../Data/Models/Likes.dart';
import '../../Data/Models/comments.dart';

part 'lost_postes_state.dart';

class LostPostesCubit extends Cubit<LostPostesState> {
  LostPostesCubit() : super(LostPostesInitial());
  String? birthDate;

  static LostPostesCubit get(context) => BlocProvider.of(context);
  File? lostPosteImage;
  var lostPostImagePicker = ImagePicker();
  List<LostPostData> lostPosts = [];
  List<String> postsId = [];
  List<String> likesId = [];
  List<Likes> likesState = [];
  List<Comments> comments = [];
  var map_name = new Map();

  Future<void> getLostPosteImage() async {
    final pickedFile =
    await lostPostImagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      lostPosteImage = File(pickedFile.path);
      print(lostPosteImage);
      emit(LostPostImagePickedSuccessState());
    } else {
      print(lostPosteImage);
      print("no image selected");
      emit(LostPostImagePickedErrorState());
    }
  }

  void uploadlostpostWithImage(
      String petName,
      String petAge,
      String petAgeType,
      String petType,
      String petFamily,
      String prize,
      String state,
      String city,
      String petGander,
      String moreDetails,
      String postDescription,
      DateTime postDate,
      BuildContext context,
      ) {
    emit(CreateLostPostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
        'LostPosts/${Uri.file(lostPosteImage!.path).pathSegments.last}')
        .putFile(lostPosteImage!)
        .then((value) {
      emit(LostPostImageUploadSuccessState());
      value.ref.getDownloadURL().then((value) {
        LostPostData postData = LostPostData(
          fullName:  AppCubit.get(context).loggedInUser.fullName,
          id:  AppCubit.get(context).loggedInUser.id,
          profileImage:  AppCubit.get(context).loggedInUser.profileImage,
          postImage: value,
          petName: petName,
          petAge: petAge,
          petAgeType: petAgeType,
          petType: petType,
          petFamily: petFamily,
          prize: prize,
          state: state,
          city: city,
          petGander: petGander,
          moreDetails: moreDetails,
          postDescription: postDescription,
          postDate: postDate,
        );
        FirebaseFirestore.instance
            .collection("LostPosts")
            .add(postData.toMap())
            .then((value) {
          emit(CreateLostPostSuccessState());
        }).catchError((error) {
          emit(CreateLostPostErrorState());
        });
      }).catchError((error) {
        emit(CreateLostPostErrorState());
      });
    }).catchError((error) {
      emit(LostPostImageUploadErrorState());
    });
  }
  var myFormat = DateFormat('yyyy-MM-dd');
  String? postDate;
  void getlostPosts(BuildContext context )  {


    FirebaseFirestore.instance
        .collection('LostPosts')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        lostPosts.add(LostPostData.fromJson(element.data()));
        postsId.add(element.id);

      });
      getLostLikes(context);
      emit(GetLostPostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetLostPostErrorState());
    });

  }
  void getLostLikes(BuildContext context){
    likesState.clear();
    for(int i=0;i<postsId.length;i++){
      FirebaseFirestore
          .instance
          .collection('LostLikes')
          .doc(postsId[i])
          .collection('LostLikes')
          .get()
          .then((value){
        map_name[postsId[i]]= value.docs.length.toString();
        likesId.add(postsId[i]);
        value.docs.forEach((element) {
          likesState.add(Likes.fromJson(element.data()));


        });
        emit(GetLostLikesState());

      })
          .catchError((error){

      });
    }}

  void likeLostPosts( String? postId, BuildContext context){
    Likes likeData=Likes(
        isLiked: "true",
        userId: AppCubit.get(context).loggedInUser.id,
        postId: postId
    );
    FirebaseFirestore
        .instance
        .collection('LostLikes')
        .doc(postId)
        .collection('LostLikes')
        .doc(AppCubit.get(context).loggedInUser.id)
        .set(likeData.toMap())
        .then((value){

      emit(CreateLikePostSuccessState());

    } )
        .catchError((error){
      emit(CreateLikePostErrorState());
    });

  }
  void dislikeLostPosts( String? postId, BuildContext context){
    FirebaseFirestore
        .instance
        .collection('LostLikes')
        .doc(postId)
        .collection('LostLikes')
        .doc(AppCubit.get(context).loggedInUser.id)
        .delete().then((value){

      emit(CreateDisLikePostSuccessState());
    });

  }
  void addComment(String postId,String description,  DateTime commentDate, BuildContext context){
    emit(CreateHostCommentLoadingState());
    Comments commentData=Comments(
      id: AppCubit.get(context).loggedInUser.id,
      fullName:AppCubit.get(context).loggedInUser.fullName ,
      ProfileImage:AppCubit.get(context).loggedInUser.profileImage ,
      commentDescription:description ,
      commentDate: commentDate,
    );
    FirebaseFirestore
        .instance
        .collection('comments')
        .doc(postId)
        .collection('Comments')
        .add(commentData.toMap()).then((value) {
      emit(CreateHostCommentSuccessState());
    }).catchError((error){
      emit(CreateHostCommentErrorState());
    });
  }
  getComments(String postId){
    emit(GetHostCommentLoadingState());
    FirebaseFirestore
        .instance
        .collection('comments')
        .doc(postId)
        .collection('Comments')
        .get()
        .then((value){
      value.docs.forEach((element) {
        comments.add(Comments.fromJson(element.data()));
      });
      emit(GetHostCommentSuccessState());
    }).catchError((error){
      emit(GetHostCommentErrorState());
    });

  }
}
