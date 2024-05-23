import 'package:fridge/clients/domain/entities/amount_paid.dart';

class AmountPaidModel extends AmountPaid {

  const AmountPaidModel({super.allAmount});

  factory AmountPaidModel.fromJson(Map<String, dynamic> json) {
    List<AllAmountModel> allAmount = [];
    if (json['all_amount'] != null) {
      json['all_amount'].forEach((v) {
        allAmount.add(AllAmountModel.fromJson(v));
      });
    }
    return AmountPaidModel(allAmount: allAmount);
  }
}

class AllAmountModel extends AllAmount {

  const AllAmountModel({super.amountPaid, super.date});

  factory AllAmountModel.fromJson(Map<String, dynamic> json) => AllAmountModel(
    amountPaid: json['amount_paid'],
    date: json['date'],
  );
}