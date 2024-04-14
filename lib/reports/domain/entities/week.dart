import 'package:equatable/equatable.dart';

class Week extends Equatable {
  final String? date;
  final String? day;
  final int? count;

  const Week({
    required this.date,
    required this.day,
    required this.count
  });

  @override
  List<Object?> get props => [date, day, count];
}