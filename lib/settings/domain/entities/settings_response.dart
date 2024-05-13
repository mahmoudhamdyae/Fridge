import 'package:equatable/equatable.dart';

class SettingsResponse extends Equatable {
  final bool? status;
  final Data? data;

  const SettingsResponse({this.status, this.data});

  @override
  List<Object?> get props => [status, data];
}

class Data extends Equatable {
  final List<dynamic>? products;
  final String? units;
  final List<dynamic>? boxing;
  final String? price;
  final int? partsCount;
  final double? smallBags;
  final double? largeBags;

  const Data({this.products, this.units, this.boxing, this.price, this.partsCount, this.smallBags, this.largeBags});

  @override
  List<Object?> get props => [products, units, boxing, price, partsCount, smallBags, largeBags];
}