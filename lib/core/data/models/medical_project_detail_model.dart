class MedicalProjectDetailModel {
  int? id;
  Beneficiary? beneficiary;
  String? aidTypeDisplay;
  String? statusDisplay;
  String? reviewer;
  String? deliveryDate;
  String? reviewDate;
  String? aidType;
  String? status;
  String? requestDate;
  String? notes;
  String? medicalReport;

  MedicalProjectDetailModel(
      {this.id,
      this.beneficiary,
      this.aidTypeDisplay,
      this.statusDisplay,
      this.reviewer,
      this.deliveryDate,
      this.reviewDate,
      this.aidType,
      this.status,
      this.requestDate,
      this.notes,
      this.medicalReport});

  MedicalProjectDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    beneficiary = json['beneficiary'] != null
        ? new Beneficiary.fromJson(json['beneficiary'])
        : null;
    aidTypeDisplay = json['aid_type_display'];
    statusDisplay = json['status_display'];
    reviewer = json['reviewer'];
    deliveryDate = json['delivery_date'];
    reviewDate = json['review_date'];
    aidType = json['aid_type'];
    status = json['status'];
    requestDate = json['request_date'];
    notes = json['notes'];
    medicalReport = json['medical_report'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.beneficiary != null) {
      data['beneficiary'] = this.beneficiary!.toJson();
    }
    data['aid_type_display'] = this.aidTypeDisplay;
    data['status_display'] = this.statusDisplay;
    data['reviewer'] = this.reviewer;
    data['delivery_date'] = this.deliveryDate;
    data['review_date'] = this.reviewDate;
    data['aid_type'] = this.aidType;
    data['status'] = this.status;
    data['request_date'] = this.requestDate;
    data['notes'] = this.notes;
    data['medical_report'] = this.medicalReport;
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
