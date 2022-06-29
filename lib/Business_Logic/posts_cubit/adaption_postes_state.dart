part of 'adaption_postes_cubit.dart';

@immutable
abstract class AdaptionPostesState {}

class PostesInitial extends AdaptionPostesState {}

class CreateAdaptionPostLoadingState extends AdaptionPostesState {}

class CreateAdaptionPostSuccessState extends AdaptionPostesState {}

class CreateAdaptionPostErrorState extends AdaptionPostesState {}

class AdaptionPostImagePickedSuccessState extends AdaptionPostesState {}

class AdaptionPostImagePickedErrorState extends AdaptionPostesState {}

class AdaptionPostImageUploadSuccessState extends AdaptionPostesState {}

class AdaptionPostImageUploadErrorState extends AdaptionPostesState {}

class GetAdaptionPostLoadingState extends AdaptionPostesState {}

class GetAdaptionPostSuccessState extends AdaptionPostesState {}

class GetAdaptionPostErrorState extends AdaptionPostesState {}
class CreateLikePostSuccessState extends AdaptionPostesState {}
class GetAdaptionLikesState extends AdaptionPostesState {}
class GetAdaptionLikes2State extends AdaptionPostesState {}
class CreateLikePostErrorState extends AdaptionPostesState {}
class CreateDisLikePostSuccessState extends AdaptionPostesState {}

class CreateDisLikePostErrorState extends AdaptionPostesState {}
class CreateAdaptionCommentLoadingState extends AdaptionPostesState {}

class CreateAdaptionCommentSuccessState extends AdaptionPostesState {}

class CreateAdaptionCommentErrorState extends AdaptionPostesState {}
class GetAdaptionCommentLoadingState extends AdaptionPostesState {}

class GetAdaptionCommentSuccessState extends AdaptionPostesState {}

class GetAdaptionCommentErrorState extends AdaptionPostesState {}

class CreateDisLike2PostSuccessState extends AdaptionPostesState {}