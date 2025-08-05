class MedicalPeriodModel {
  int? total;
  int? approved;
  int? rejected;

  MedicalPeriodModel({this.total, this.approved, this.rejected});

  MedicalPeriodModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    approved = json['approved'];
    rejected = json['rejected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['approved'] = this.approved;
    data['rejected'] = this.rejected;
    return data;
  }
}
