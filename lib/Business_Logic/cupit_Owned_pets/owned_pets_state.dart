
import 'package:flutter/material.dart';

@immutable
abstract class OwnedPetsState {}

class OwnedPetsInitial extends OwnedPetsState {}

class OwnedPetsCreateLoadingState extends OwnedPetsState {}
class OwnedPetsCreateSuccessState extends OwnedPetsState {}
class OwnedPetsCreateErrorState extends OwnedPetsState {}

class GetOwnedPetsLoadingState extends OwnedPetsState {}
class GetOwnedPetsSuccessState extends OwnedPetsState {}
class GetOwnedPetsErrorState extends OwnedPetsState {}


class OwnedPetsImagePickedSuccessState extends OwnedPetsState {}
class OwnedPetsImagePickedErrorState extends OwnedPetsState {}

class OwnedPetsImageUploadSuccessState extends OwnedPetsState {}
class OwnedPetsImageUploadErrorState extends OwnedPetsState {}
class OwnedPetsImageUploadLoadingState extends OwnedPetsState {}



