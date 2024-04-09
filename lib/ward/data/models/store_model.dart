import 'package:fridge/ward/domain/entities/store.dart';

class StoreResponse {
  bool? status;
  List<StoreModel>? data;

  StoreResponse({this.status, this.data});

  StoreResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <StoreModel>[];
      json['data'].forEach((v) {
        data!.add(StoreModel.fromJson(v));
      });
    }
  }
}

class StoreModel extends Store {
  const StoreModel({
    super.id,
    super.fridgeId,
    super.fridgePartId,
    super.customerId,
    super.product,
    super.boxing,
    super.unit,
    super.quantity,
    super.totalWeight,
    super.price,
    super.x,
    super.y,
    super.customer,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
    id: json['id'],
    fridgeId: json['fridge_id'],
    fridgePartId: json['fridge_part_id'],
    customerId: json['customer_id'],
    product: json['product'],
    boxing: json['boxing'],
    unit: json['unit'],
    quantity: json['quantity'],
    totalWeight: json['total_weight'],
    price: json['price'],
    x: json['x_axies'],
    y: json['y_axies'],
    customer: json['customer'] != null
        ? StoreCustomerModel.fromJson(json['customer'])
        : null,
  );
}

class StoreCustomerModel extends StoreCustomer {

  const StoreCustomerModel({
    super.id,
    super.name,
    super.phone,
    super.address,
    super.type,
    super.fridgeId
  });

  factory StoreCustomerModel.fromJson(Map<String, dynamic> json) => StoreCustomerModel(
    id: json['id'],
    name: json['name'],
    phone: json['phone'],
    address: json['address'],
    type: json['type'],
    fridgeId: json['fridge_id'],
  );
}