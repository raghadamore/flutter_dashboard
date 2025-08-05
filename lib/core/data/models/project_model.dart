class ProjectModel {
  int? id;
  String? category;
  String? statusDisplay;
  String? aidTypeDisplay;
  String? requestDate;
  String? reviewer;
  Beneficiary? beneficiary;

  ProjectModel(
      {this.id,
      this.category,
      this.statusDisplay,
      this.aidTypeDisplay,
      this.requestDate,
     this.reviewer,
      this.beneficiary});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    statusDisplay = json['status_display'];
    aidTypeDisplay = json['aid_type_display'];
    requestDate = json['request_date'];
    reviewer = json['reviewer'];
    beneficiary = json['beneficiary'] != null
        ? new Beneficiary.fromJson(json['beneficiary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['status_display'] = this.statusDisplay;
    data['aid_type_display'] = this.aidTypeDisplay;
    data['request_date'] = this.requestDate;
   data['reviewer'] = this.reviewer;
    if (this.beneficiary != null) {
      data['beneficiary'] = this.beneficiary!.toJson();
    }
    return data;
  }
}

class Beneficiary {
  String? fullName;
  String? phoneNumber;
  String? gender;
  String? currentAddress;

  Beneficiary(
      {this.fullName, this.phoneNumber, this.gender, this.currentAddress});

  Beneficiary.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
    gender = json['gender'];
    currentAddress = json['current_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['phone_number'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['current_address'] = this.currentAddress;
    return data;
  }
}
