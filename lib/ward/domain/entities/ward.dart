import 'package:equatable/equatable.dart';

class Ward extends Equatable {
  final int? id;
  final String? name;
  final int? width;
  final int? height;
  final int? floorNum;
  final int? fridgeId;

  const Ward({
    this.id,
    this.name,
    this.width,
    this.height,
    this.floorNum,
    this.fridgeId
  });

  @override
  List<Object?> get props => [id, name, width, height, floorNum, fridgeId];
}