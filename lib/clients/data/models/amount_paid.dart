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
  final int? fridgePartId;
  final String? product;
  final int? xAxies;
  final int? yAxies;
  final String? partName;

  const TrashedStore({
    this.fridgePartId,
    this.product,
    this.xAxies,
    this.yAxies,
    this.partName,
  });

  factory TrashedStore.fromJson(Map<String, dynamic> json) => TrashedStore(
    fridgePartId: json['fridge_part_id'],
    product: json['product'],
    xAxies: json['x_axies'],
    yAxies: json['y_axies'],
    partName: json['part_name'],
  );

  @override
  List<Object?> get props => [
    fridgePartId,
    product,
    xAxies,
    yAxies,
    partName
  ];
}