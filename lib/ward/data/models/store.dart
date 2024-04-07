class StoreResponse {
  bool? status;
  List<Store>? data;

  StoreResponse({this.status, this.data});

  StoreResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Store>[];
      json['data'].forEach((v) {
        data!.add(Store.fromJson(v));
      });
    }
  }
}

class Store {
  int? id;
  int? fridgeId;
  int? fridgePartId;
  int? customerId;
  String? product;
  String? boxing;
  int? quantity;
  int? totalWeight;
  int? price;
  int? xAxies;
  int? yAxies;
  Customer? customer;

  Store(
      {this.id,
        this.fridgeId,
        this.fridgePartId,
        this.customerId,
        this.product,
        this.boxing,
        this.quantity,
        this.totalWeight,
        this.price,
        this.xAxies,
        this.yAxies,
        this.customer});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fridgeId = json['fridge_id'];
    fridgePartId = json['fridge_part_id'];
    customerId = json['customer_id'];
    product = json['product'];
    boxing = json['boxing'];
    quantity = json['quantity'];
    totalWeight = json['total_weight'];
    price = json['price'];
    xAxies = json['x_axies'];
    yAxies = json['y_axies'];
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
  }
}

class Customer {
  int? id;
  String? name;
  String? phone;
  String? address;
  int? type;
  int? fridgeId;

  Customer(
      {this.id,
        this.name,
        this.phone,
        this.address,
        this.type,
        this.fridgeId});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    type = json['type'];
    fridgeId = json['fridge_id'];
  }
}