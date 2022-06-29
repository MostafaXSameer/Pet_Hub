part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitialState extends AppState {}

class AppGetUserLoadingState extends AppState {}

class AppGetUserSuccessState extends AppState {}

class AppGetUserErrorState extends AppState {}


class AppGetAllUserLoadingState extends AppState {}

class AppGetAllUserSuccessState extends AppState {}

class AppGetAllUserErrorState extends AppState {}


class AppChangeBottomNavState extends AppState {}

class AppImagePickedSuccessState extends AppState {}

class AppImagePickedErrorState extends AppState {}

class AppEditingProfileState extends AppState {}

class AppUploadProfileImageLoadingState extends AppState {}

class AppUploadProfileImageSuccessState extends AppState {}

class AppUploadProfileImageErrorState extends AppState {}

class AppUserUpdateErrorState extends AppState {}

class AppUserUpdateLoadingState extends AppState {}

class AppUserUpdateSuccessState extends AppState {}

class AppRunningOpenWithLinkInitialState extends AppState{}

class AppRunningOpenWithLinkOpenedState extends AppState{}

class AppRunningOpenWithLinkErrorState extends AppState{}

//chat

class AppSendMessageSuccessState extends AppState{}

class AppSendMessageErrorState extends AppState{}

class AppGetMessagesSuccessState extends AppState{}

class AppGetAllChatUsersSuccessState extends AppState{}

class AppGetAllChatUsersErrorState extends AppState{}











