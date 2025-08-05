class BeneficiaryModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? userType;
  String? gender;
  Null? profilePicture;

  BeneficiaryModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.userType,
      this.gender,
      this.profilePicture});

  BeneficiaryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    userType = json['user_type'];
    gender = json['gender'];
    profilePicture = json['profile_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['user_type'] = this.userType;
    data['gender'] = this.gender;
    data['profile_picture'] = this.profilePicture;
    return data;
  }
}
