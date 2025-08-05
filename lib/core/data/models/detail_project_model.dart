class DetailProjectModel {
  int? id;
  Beneficiary? beneficiary;
  String? projectTypeDisplay;
  String? statusDisplay;
  String? reviewer;
  String? projectType;
  String? ownership;
  String? area;
  String? experience;
  String? tools;
  String? notes;
  String? status;
  String? deliveryDate;
  String? reviewDate;
  String? requestDate;

  DetailProjectModel(
      {this.id,
      this.beneficiary,
      this.projectTypeDisplay,
      this.statusDisplay,
      this.reviewer,
      this.projectType,
      this.ownership,
      this.area,
      this.experience,
      this.tools,
      this.notes,
      this.status,
      this.deliveryDate,
      this.reviewDate,
      this.requestDate});

  DetailProjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    beneficiary = json['beneficiary'] != null
        ? new Beneficiary.fromJson(json['beneficiary'])
        : null;
    projectTypeDisplay = json['project_type_display'];
    statusDisplay = json['status_display'];
    reviewer = json['reviewer'];
    projectType = json['project_type'];
    ownership = json['ownership'];
    area = json['area'];
    experience = json['experience'];
    tools = json['tools'];
    notes = json['notes'];
    status = json['status'];
    deliveryDate = json['delivery_date'];
    reviewDate = json['review_date'];
    requestDate = json['request_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.beneficiary != null) {
      data['beneficiary'] = this.beneficiary!.toJson();
    }
    data['project_type_display'] = this.projectTypeDisplay;
    data['status_display'] = this.statusDisplay;
    data['reviewer'] = this.reviewer;
    data['project_type'] = this.projectType;
    data['ownership'] = this.ownership;
    data['area'] = this.area;
    data['experience'] = this.experience;
    data['tools'] = this.tools;
    data['notes'] = this.notes;
    data['status'] = this.status;
    data['delivery_date'] = this.deliveryDate;
    data['review_date'] = this.reviewDate;
    data['request_date'] = this.requestDate;
    return data;
  }
}

class Beneficiary {
  int? id;
  String? fullName;
  String? gender;
  String? birthDate;
  String? email;
  String? phoneNumber;
  String? residenceType;
  String? currentAddress;
  String? previousAddress;
  String? livingStatus;
  String? maritalStatus;
  int? familyMembers;
  String? education;
  String? job;
  String? weaknessesDisabilities;
  String? notes;

  Beneficiary(
      {this.id,
      this.fullName,
      this.gender,
      this.birthDate,
      this.email,
      this.phoneNumber,
      this.residenceType,
      this.currentAddress,
      this.previousAddress,
      this.livingStatus,
      this.maritalStatus,
      this.familyMembers,
      this.education,
      this.job,
      this.weaknessesDisabilities,
      this.notes});

  Beneficiary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    gender = json['gender'];
    birthDate = json['birth_date'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    residenceType = json['residence_type'];
    currentAddress = json['current_address'];
    previousAddress = json['previous_address'];
    livingStatus = json['living_status'];
    maritalStatus = json['marital_status'];
    familyMembers = json['family_members'];
    education = json['education'];
    job = json['job'];
    weaknessesDisabilities = json['weaknesses_disabilities'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['gender'] = this.gender;
    data['birth_date'] = this.birthDate;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['residence_type'] = this.residenceType;
    data['current_address'] = this.currentAddress;
    data['previous_address'] = this.previousAddress;
    data['living_status'] = this.livingStatus;
    data['marital_status'] = this.maritalStatus;
    data['family_members'] = this.familyMembers;
    data['education'] = this.education;
    data['job'] = this.job;
    data['weaknesses_disabilities'] = this.weaknessesDisabilities;
    data['notes'] = this.notes;
    return data;
  }
}
