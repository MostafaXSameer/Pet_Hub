
import 'package:cloud_firestore/cloud_firestore.dart';

class Likes {
  String? isLiked;
  String? userId;
  String? postId;
  Likes({
    this.isLiked,
    this.userId,
    this.postId
  });

  Likes.fromJson(Map<String, dynamic> json) {
    isLiked = json['isLiked'];
    userId=json['userId'];
    postId=json['postId'];

  }
  factory Likes.fromMap(map) {
    return Likes(
      isLiked: map['isLiked'],
        userId:map['userId'],
      postId:map['postId']

    );
  }
  factory Likes.fromDocument(DocumentSnapshot doc) {
    return Likes(
      isLiked: doc['isLiked'],
        userId:doc['userId'],
      postId:doc['postId']
    );
  }

// sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'isLiked': isLiked,
         'userId':userId,
       'postId':postId
    };
  }
}
