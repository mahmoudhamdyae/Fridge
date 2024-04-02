import '../../domain/entities/ward.dart';

class Wards {
  bool? status;
  List<WardModel>? data;

  Wards({this.status, this.data});

  Wards.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <WardModel>[];
      json['data'].forEach((v) {
        data!.add(WardModel.fromJson(v));
      });
    }
  }
}

class WardModel extends Ward {

  const WardModel({
    super.id,
    super.name,
    super.width,
    super.height,
    super.floorNum,
    super.fridgeId
  });

  factory WardModel.fromJson(Map<String, dynamic> json) => WardModel(
    id: json['id'],
    name: json['name'],
    width: json['width'],
    height: json['height'],
    floorNum: json['floorNum'],
    fridgeId: json['fridgeId']
  );
}