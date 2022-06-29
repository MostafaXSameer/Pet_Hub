
class PetsOwned{
  String? petId;
  String? ownerId;
  String? ownerName;
  String? petImage;
  String? petName;
  String? petAge;
  String? petAgeType;
  String? petType;
  String? petFamily;
  String? country;
  String? state;
  String? city;
  String? petGander;
  String? ownerContact;
 PetsOwned({this.petId,this.ownerId,this.ownerName,this.ownerContact,this.petName,this.petType,this.petAge,this.country,this.state,this.city,this.petAgeType,this.petFamily,this.petGander,this.petImage});

 PetsOwned.fromJson(Map<String, dynamic> json) {
    petId=json['petId'];
    ownerId = json['ownerId'];
    ownerName = json['ownerName'];
    petImage = json['petImage'];
    petName = json['petName'];
    petAge = json['petAge'];
    petAgeType = json['petAgeType'];
    petType = json['petType'];
    petFamily = json['petFamily'];
    country=json['country'];
    state = json['state'];
    city = json['city'];
    petGander = json['petGander'];
    ownerContact = json['ownerContact'];
  }

  Map<String, dynamic> toMap() {
    return {
      'petId':petId,
      'ownerId': ownerId,
      'ownerName': ownerName,
      'petImage': petImage,
      'petName': petName,
      'petAge': petAge,
      'petAgeType': petAgeType,
      'petType': petType,
      'petFamily': petFamily,
      'country':country,
      'state': state,
      'city': city,
      'petGander': petGander,
      'ownerContact': ownerContact,
    };
  }
}