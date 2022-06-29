import 'package:cloud_firestore/cloud_firestore.dart';

class Comments {
  String? id;
  String? fullName;
  String? ProfileImage;
  String? commentDescription;
  DateTime? commentDate;
  Comments({
    this.fullName,
    this.id,
    this.ProfileImage,
    this.commentDescription,
    this.commentDate,
  });

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    ProfileImage = json['ProfileImage'];
    commentDescription = json['commentDescription'];
    commentDate = json['commentDate'].toDate();

  }
  factory Comments.fromMap(map) {
    return Comments(
      id: map['id'],
      fullName: map['fullName'],
      ProfileImage: map['ProfileImage'],
      commentDescription: map['commentDescription'],
      commentDate: map['commentDate'].toDate(),

    );
  }
  factory Comments.fromDocument(DocumentSnapshot doc) {
    return Comments(
      id: doc['id'],
      fullName: doc['fullName'],
      ProfileImage: doc['ProfileImage'],
      commentDescription: doc['commentDescription'],
      commentDate: doc['commentDate'].toDate(),

    );
  }

// sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'ProfileImage': ProfileImage,
      'commentDescription': commentDescription,
      'commentDate': commentDate,

    };
  }
}
