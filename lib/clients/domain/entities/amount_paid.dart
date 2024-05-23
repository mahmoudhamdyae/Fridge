import 'package:equatable/equatable.dart';

class AmountPaid extends Equatable {
  final List<AllAmount>? allAmount;

  const AmountPaid({this.allAmount});

  @override
  List<Object?> get props => [allAmount];
}

class AllAmount extends Equatable {
  final int? amountPaid;
  final String? date;
  final int? amountRemain;

  const AllAmount({this.amountPaid, this.date, this.amountRemain});

  @override
  List<Object?> get props => [amountPaid, date, amountRemain];
}