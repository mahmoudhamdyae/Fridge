import 'package:equatable/equatable.dart';

class AmountPaid extends Equatable{
  final List<AllAmount>? allAmount;
  final List<AllTrashed>? allTrashed;

  const AmountPaid({this.allAmount, this.allTrashed});

  factory AmountPaid.fromJson(Map<String, dynamic> json) {
    List<AllAmount> allAmount = [];
    List<AllTrashed> allTrashed = [];
    if (json['all_amount'] != null) {
      json['all_amount'].forEach((v) {
        allAmount.add(AllAmount.fromJson(v));
      });
    }
    if (json['all_trashed'] != null) {
      json['all_trashed'].forEach((v) {
        allTrashed.add(AllTrashed.fromJson(v));
      });
    }
    return AmountPaid(
      allAmount: allAmount.reversed.toList(),
      allTrashed: allTrashed.reversed.toList(),
    );
  }

  @override
  List<Object?> get props => [allAmount, allTrashed];
}

class AllAmount extends Equatable {
  final int? amountPaid;
  final String? date;

  const AllAmount({this.amountPaid, this.date});

  factory AllAmount.fromJson(Map<String, dynamic> json) => AllAmount(
    amountPaid: json['amount_paid'],
    date: json['date'],
  );

  @override
  List<Object?> get props => [amountPaid, date];
}

class AllTrashed extends Equatable {
  final TrashedStore? trashedStore;
  final String? date;

  const AllTrashed({this.trashedStore, this.date});

  factory AllTrashed.fromJson(Map<String, dynamic> json) => AllTrashed(
    trashedStore: json['trashed_store'] != null
        ? TrashedStore.fromJson(json['trashed_store'])
        : null,
    date: json['date'],
  );

  @override
  List<Object?> get props => [trashedStore, date];
}

class TrashedStore extends Equatable {
  final int? id;
  final int? fridgeId;
  final int? fridgePartId;
  final int? customerId;
  final String? product;
  final String? boxing;
  final String? unit;
  final int? quantity;
  final dynamic totalWeight;
  final int? price;
  final int? xAxies;
  final int? yAxies;
  final String? createdAt;
  final String? updatedAt;
  final int? amountPaid;
  final dynamic bagType;
  final dynamic totalBagPrice;
  final String? deletedAt;

  const TrashedStore(
      {this.id,
        this.fridgeId,
        this.fridgePartId,
        this.customerId,
        this.product,
        this.boxing,
        this.unit,
        this.quantity,
        this.totalWeight,
        this.price,
        this.xAxies,
        this.yAxies,
        this.createdAt,
        this.updatedAt,
        this.amountPaid,
        this.bagType,
        this.totalBagPrice,
        this.deletedAt});

  factory TrashedStore.fromJson(Map<String, dynamic> json) => TrashedStore(
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
    xAxies: json['x_axies'],
    yAxies: json['y_axies'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    amountPaid: json['amount_paid'],
    bagType: json['bag_type'],
    totalBagPrice: json['total_bag_price'],
    deletedAt: json['deleted_at'],
  );

  @override
  List<Object?> get props => [
    id,
    fridgeId,
    fridgePartId,
    customerId,
    product,
    boxing,
    unit,
    quantity,
    totalWeight,
    price,
    xAxies,
    yAxies,
    createdAt,
    updatedAt,
    amountPaid,
    bagType,
    totalBagPrice,
    deletedAt
  ];
}