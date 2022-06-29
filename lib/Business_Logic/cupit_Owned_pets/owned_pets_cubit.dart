import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


import '../../Data/Models/pets_data.dart';
import '../cupit_app/cubit/app_cubit.dart';
import 'owned_pets_state.dart';

class OwnedPetsCubit extends Cubit<OwnedPetsState> {
  OwnedPetsCubit() : super(OwnedPetsInitial());
  static OwnedPetsCubit get(context) => BlocProvider.of(context);
  List<PetsOwned> petsOwned = [];
  List<String>petsOwnedIds=[];
  File? ownedPetImage;
  var ownedPetImagePicker = ImagePicker();

  Future<void> getOwnedPetImage() async {
    final pickedFile =
    await ownedPetImagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      ownedPetImage = File(pickedFile.path);
      print(ownedPetImage);
      emit(OwnedPetsImagePickedSuccessState());
    } else {
      print(ownedPetImage);
      print("no image selected");
      emit(OwnedPetsImagePickedErrorState());
    }
  }

  void uploadOwnedPetData(
      String petName,
      String petAge,
      String petAgeType,
      String petType,
      String petFamily,
      String country,
      String state,
      String city,
      String petGander,
      BuildContext context,
      ) {
    emit(OwnedPetsImageUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
        'Owned Pets Images/${Uri.file(ownedPetImage!.path).pathSegments.last}')
        .putFile(ownedPetImage!)
        .then((value) {
      emit(OwnedPetsCreateLoadingState());
      value.ref.getDownloadURL().then((value) {
        PetsOwned petOwned = PetsOwned(
          petId: petsOwned.length.toString(),
          ownerName: AppCubit.get(context).loggedInUser.fullName,
          ownerId: AppCubit.get(context).loggedInUser.id,
          petImage: value,
          petName: petName,
          petAge: petAge,
          petAgeType: petAgeType,
          petType: petType,
          petFamily: petFamily,
          country: country,
          state: state,
          city: city,
          petGander: petGander,
          ownerContact: AppCubit.get(context).loggedInUser.phoneNumber,
        );
        FirebaseFirestore.instance
            .collection("Users").doc(AppCubit.get(context).loggedInUser.id).collection("PetsOwned")
            .add(petOwned.toMap())
            .then((value) {
          emit(OwnedPetsCreateSuccessState());
        }).catchError((error) {
          emit(OwnedPetsCreateErrorState());
        });
      }).catchError((error) {
        emit(OwnedPetsCreateErrorState());
      });
    }).catchError((error) {
      emit(OwnedPetsCreateErrorState());
    });
  }

  void getOwnedPets(BuildContext ctx,String userId)  {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection("PetsOwned")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        petsOwned.add(PetsOwned.fromJson(element.data()));
        petsOwnedIds.add(element.id);
      });
      emit(GetOwnedPetsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetOwnedPetsErrorState());
    });

  }

}