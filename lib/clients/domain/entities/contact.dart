import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class CustomContact extends Equatable {
  final String name;
  final String phone;
  final Uint8List? thumbnail;

  const CustomContact({
    required this.name,
    required this.phone,
    required this.thumbnail,
  });
  
  @override
  List<Object?> get props => [name, phone, thumbnail];
}