class AdaptionPostData {
  String? id;

  String? fullName;
  String? profileImage;
  String? postImage;
  String? petName;
  String? petAge;
  String? petAgeType;
  String? petType;
  String? petFamily;
  String? state;
  String? city;
  String? petGander;
  String? postDescription;
  DateTime? postDate;

  AdaptionPostData({
    this.id,

    this.fullName,
    this.profileImage,
    this.postImage,
    this.petName,
    this.petAge,
    this.petAgeType,
    this.petType,
    this.petFamily,
    this.state,
    this.city,
    this.petGander,
    this.postDescription,
    this.postDate,
  });
  AdaptionPostData.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    fullName = json['fullName'];
    profileImage = json['profileImage'];
    postImage = json['postImage'];
    petName = json['petName'];
    petAge = json['petAge'];
    petAgeType = json['petAgeType'];
    petType = json['petType'];
    petFamily = json['petFamily'];
    state = json['state'];
    city = json['city'];
    petGander = json['petGander'];
    postDescription = json['postDescription'];
    postDate = json['postDate'].toDate();


  }

  factory AdaptionPostData.fromMap(map) {
    return AdaptionPostData(
      id: map['id'],

      fullName: map['fullName'],
      profileImage: map['profileImage'],
      postImage: map['postImage'],
      petName: map['petName'],
      petAge: map['petAge'],
      petAgeType: map['petAgeType'],
      petType: map['petType'],
      petFamily: map['petFamily'],
      state: map['state'],
      city: map['city'],
      petGander: map['petGander'],
      postDescription: map['postDescription'],
      postDate: map['postDate'].toDate(),
    );
  }

// sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'fullName': fullName,
      'profileImage': profileImage,
      'postImage': postImage,
      'petName': petName,
      'petAge': petAge,
      'petAgeType': petAgeType,
      'petType': petType,
      'petFamily': petFamily,
      'state': state,
      'city': city,
      'petGander': petGander,
      'postDescription': postDescription,
      'postDate': postDate,
    };
  }
}
