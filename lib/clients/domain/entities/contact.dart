import 'package:equatable/equatable.dart';

class CustomContact extends Equatable {
  final String name;
  final String phone;
  
  const CustomContact({
    required this.name,
    required this.phone,
  });
  
  @override
  List<Object?> get props => [name, phone];
}