import 'package:task_P2/core/enums/order_status_enum.dart';
import 'package:task_P2/core/enums/order_type_enum.dart';
import 'package:task_P2/ui/shared/utlis.dart';

class OrderModel {
  OrderStatus? status;
  DateTime? orderDate;
  int? id;
  String? type;
  

  OrderModel(
      {
        this.type,
      this.orderDate,
      this.status,
     this.id});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderDate = json['orderDate'];
    status = json['status'];
    id = json['id'];
    type=json["type"];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderDate'] = this.orderDate;
    data['refreshToken'] = this.status;
    data['id'] = this.id;
    data['type'] = this.type;
    
    return data;
  }
  String get formatedOrderDate=>getFormattedDate(orderDate!);

  get beneficiariesCount => null;
}
