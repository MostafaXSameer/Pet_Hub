class LostPostData {
  String? id;
  String? fullName;
  String? profileImage;
  String? postImage;
  String? petName;
  String? petAge;
  String? petAgeType;
  String? petType;
  String? petFamily;
  String? prize;
  String? state;
  String? city;
  String? petGander;
  String? moreDetails;
  String? postDescription;
  DateTime? postDate;

  LostPostData({
    this.id,
    this.fullName,
    this.profileImage,
    this.postImage,
    this.petName,
    this.petAge,
    this.petAgeType,
    this.petType,
    this.petFamily,
    this.prize,
    this.state,
    this.city,
    this.petGander,
    this.moreDetails,
    this.postDescription,
    this.postDate,
  });
  LostPostData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    profileImage = json['profileImage'];
    postImage = json['postImage'];
    petName = json['petName'];
    petAge = json['petAge'];
    petAgeType = json['petAgeType'];
    petType = json['petType'];
    petFamily = json['petFamily'];
    prize=json['prize'];
    state = json['state'];
    city = json['city'];
    petGander = json['petGander'];
    moreDetails=json['moreDetails'];
    postDescription = json['postDescription'];
    postDate = json['postDate'].toDate();


  }

  factory LostPostData.fromMap(map) {
    return LostPostData(
      id: map['id'],
      fullName: map['fullName'],
      profileImage: map['profileImage'],
      postImage: map['postImage'],
      petName: map['petName'],
      petAge: map['petAge'],
      petAgeType: map['petAgeType'],
      petType: map['petType'],
      petFamily: map['petFamily'],
      prize:map['prize'],
      state: map['state'],
      city: map['city'],
      petGander: map['petGander'],
      moreDetails:map['moreDetails'],
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
      'prize':prize,
      'state': state,
      'city': city,
      'petGander': petGander,
      'moreDetails':moreDetails,
      'postDescription': postDescription,
      'postDate': postDate,
    };
  }
}
