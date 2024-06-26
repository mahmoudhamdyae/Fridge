import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/ward/data/data_source/wards_remote_data_source.dart';
import 'package:fridge/ward/domain/entities/ward.dart';

import '../entities/invoice.dart';
import '../entities/store.dart';

abstract class WardsRepository {

  final WardsRemoteDataSource remoteDataSource;
  WardsRepository(this.remoteDataSource);

  Future<Either<Failure, List<Ward>>> getWards();
  Future<Either<Failure, void>> updateWardSettings(int wardId, int wardWidth, int wardHeight);
  Future<Either<Failure, List<Store>>> getAllStore(int wardId);
  Future<Either<Failure, Invoice>> getInvoice(int storeId);
}