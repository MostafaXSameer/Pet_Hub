class UserData {
  String? id;
  String? fullName;
  String? profileImage;
  String? phoneNumber;
  String? email;
  DateTime? birthDay;
  String? state;
  String? city;
  String? gender;
  UserData({
    this.fullName,
    this.email,
    this.id,
    this.profileImage,
    this.phoneNumber,
    this.birthDay,
    this.state,
    this.city,
    this.gender,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    profileImage = json['profileImage'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    birthDay = json['birthDay'];
    state = json['state'];
    city = json['city'];
    gender = json['gender'];
  }

  factory UserData.fromMap(map) {
    return UserData(
      id: map['id'],
      email: map['email'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
      profileImage: map['ProfileImage'],
      birthDay: map['birthDay'].toDate(),
      state: map['state'],
      city: map['city'],
      gender: map['gender'],
    );
  }

// sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'ProfileImage': profileImage,
      'birthDay': birthDay,
      'state': state,
      'city': city,
      'gender': gender,
    };
  }
}
