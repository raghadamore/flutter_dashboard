class RefreshTokenModel {
  String? access;

  RefreshTokenModel({this.access});

  RefreshTokenModel.fromJson(Map<String, dynamic> json) {
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access'] = this.access;
    return data;
  }
}
