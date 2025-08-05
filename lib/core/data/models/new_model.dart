class NewsModel {
  String newsDetails;
  DateTime publishingDate;
  String status;

  NewsModel({
    required this.newsDetails,
    required this.publishingDate,
    required this.status,
  });

  /// نموذج افتراضي
  factory NewsModel.defaultModel() {
    return NewsModel(
      newsDetails: "لا يوجد تفاصيل",
      publishingDate: DateTime.now(),
      status: "غير منشور",
    );
  }

  /// تحويل من JSON
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      newsDetails: json['newsDetails'] ?? 'لا يوجد تفاصيل',
      publishingDate: DateTime.tryParse(json['publishingDate'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? 'غير منشور',
    );
  }

  /// تحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'newsDetails': newsDetails,
      'publishingDate': publishingDate.toIso8601String(),
      'status': status,
    };
  }

  /// تاريخ منسق بشكل جاهز للعرض
  String get formattedDate =>
      "${publishingDate.day}/${publishingDate.month}/${publishingDate.year}";
}
