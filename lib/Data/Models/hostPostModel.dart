class HostPostData {
  String? id;
  String? fullName;
  String? profileImage;
  String? postImage;
  String? petName;
  String? petAge;
  String? petAgeType;
  String? petType;
  String? petFamily;
  String? reward;
  String? state;
  String? city;
  String? moreDetails;
  DateTime? startDate;
  DateTime? endDate;
  String? petGander;
  String? postDescription;
  DateTime? postDate;

  HostPostData({
    this.id,
    this.fullName,
    this.profileImage,
    this.postImage,
    this.petName,
    this.petAge,
    this.petAgeType,
    this.petType,
    this.petFamily,
    this.reward,
    this.state,
    this.city,
    this.moreDetails,
    this.startDate,
    this.endDate,
    this.petGander,
    this.postDescription,
    this.postDate,
  });
  HostPostData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    profileImage = json['profileImage'];
    postImage = json['postImage'];
    petName = json['petName'];
    petAge = json['petAge'];
    petAgeType = json['petAgeType'];
    petType = json['petType'];
    petFamily = json['petFamily'];
    reward=json['reward'];
    state = json['state'];
    city = json['city'];
    moreDetails=json['moreDetails'];
    startDate=json['startDate'].toDate();
    endDate=json['endDate'].toDate();
    petGander = json['petGander'];
    postDescription = json['postDescription'];
    postDate = json['postDate'].toDate();

  }

  factory HostPostData.fromMap(map) {
    return HostPostData(
      id: map['id'],
      fullName: map['fullName'],
      profileImage: map['profileImage'],
      postImage: map['postImage'],
      petName: map['petName'],
      petAge: map['petAge'],
      petAgeType: map['petAgeType'],
      petType: map['petType'],
      petFamily: map['petFamily'],
      reward:map['reward'],
      state: map['state'],
      city: map['city'],
      moreDetails:map['moreDetails'],
      startDate:map['startDate'].toDate(),
      endDate:map['endDate'].toDate(),
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
      'reward':reward,
      'state': state,
      'city': city,
      'moreDetails':moreDetails,
      'startDate':startDate,
      'endDate':endDate,
      'petGander': petGander,
      'postDescription': postDescription,
      'postDate': postDate,
    };
  }
}
