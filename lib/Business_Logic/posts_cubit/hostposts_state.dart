part of 'hostposts_cubit.dart';

@immutable
abstract class HostpostsState {}

class HostpostsInitial extends HostpostsState {}

class CreateHostPostLoadingState extends HostpostsState {}

class CreateHostPostSuccessState extends HostpostsState {}

class CreateHostPostErrorState extends HostpostsState {}

class HostPostImagePickedSuccessState extends HostpostsState {}

class HostPostImagePickedErrorState extends HostpostsState {}

class HostPostImageUploadSuccessState extends HostpostsState {}

class HostPostImageUploadErrorState extends HostpostsState {}

class GetHostPostLoadingState extends HostpostsState {}

class GetHostPostSuccessState extends HostpostsState {}

class GetHostPostErrorState extends HostpostsState {}

class GetHostLikesState extends HostpostsState {}

class GetHostLikes2State extends HostpostsState {}

class CreateLikePostSuccessState extends HostpostsState {}

class CreateLikePostErrorState extends HostpostsState {}

class CreateDisLikePostSuccessState extends HostpostsState {}

class CreateHostCommentLoadingState extends HostpostsState {}

class CreateHostCommentSuccessState extends HostpostsState {}

class CreateHostCommentErrorState extends HostpostsState {}

class GetHostCommentLoadingState extends HostpostsState {}

class GetHostCommentSuccessState extends HostpostsState {}

class GetHostCommentErrorState extends HostpostsState {}