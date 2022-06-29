part of 'lost_postes_cubit.dart';

@immutable
abstract class LostPostesState {}

class LostPostesInitial extends LostPostesState {}
class CreateLostPostLoadingState extends LostPostesState {}

class CreateLostPostSuccessState extends LostPostesState {}

class CreateLostPostErrorState extends LostPostesState {}

class LostPostImagePickedSuccessState extends LostPostesState {}

class LostPostImagePickedErrorState extends LostPostesState {}

class LostPostImageUploadSuccessState extends LostPostesState {}

class LostPostImageUploadErrorState extends LostPostesState {}

class GetLostPostLoadingState extends LostPostesState {}

class GetLostPostSuccessState extends LostPostesState {}

class GetLostPostErrorState extends LostPostesState {}
class GetLostLikesState extends LostPostesState {}
class CreateLikePostSuccessState extends LostPostesState {}
class CreateLikePostErrorState extends LostPostesState {}
class CreateDisLikePostSuccessState extends LostPostesState {}
class CreateHostCommentLoadingState extends LostPostesState {}
class CreateHostCommentSuccessState extends LostPostesState {}
class CreateHostCommentErrorState extends LostPostesState {}
class GetHostCommentLoadingState extends LostPostesState {}
class GetHostCommentSuccessState extends LostPostesState {}
class GetHostCommentErrorState extends LostPostesState {}