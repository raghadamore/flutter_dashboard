class PatchProjectModel {
  String? status;
  String? reviewer;
  String? reviewDate;
  String? deliveryDate;

  PatchProjectModel(
      {this.status, this.reviewer, this.reviewDate, this.deliveryDate});

  PatchProjectModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    reviewer = json['reviewer'];
    reviewDate = json['review_date'];
    deliveryDate = json['delivery_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['reviewer'] = this.reviewer;
    data['review_date'] = this.reviewDate;
    data['delivery_date'] = this.deliveryDate;
    return data;
  }
}
