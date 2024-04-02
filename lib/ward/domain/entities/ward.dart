import 'package:equatable/equatable.dart';

class Ward extends Equatable {
  final int? id;
  final String? name;
  final int? width;
  final int? height;
  final int? floorNum;
  final int? fridgeId;

  const Ward({
    required this.id,
    required this.name,
    required this.width,
    required this.height,
    required this.floorNum,
    required this.fridgeId
  });

  @override
  List<Object?> get props => [id, name, width, height, floorNum, fridgeId];
}