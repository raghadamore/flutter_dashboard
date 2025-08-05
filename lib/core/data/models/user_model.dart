class UserModel {
  String? firstName;
  String? lastName;
  String? userType;
  String? profilePicture;
  String? access;
  String? refresh;

  UserModel(
      {this.firstName,
      this.lastName,
      this.userType,
      this.profilePicture,
      this.access,
      this.refresh});

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    userType = json['user_type'];
    profilePicture = json['profile_picture'];
    access = json['access'];
    refresh = json['refresh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['user_type'] = this.userType;
    data['profile_picture'] = this.profilePicture;
    data['access'] = this.access;
    data['refresh'] = this.refresh;
    return data;
  }
}
