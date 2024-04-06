import 'package:dio/dio.dart';
import 'package:fridge/core/network/api_constants.dart';
import 'package:fridge/home/data/models/requests/store_product_request.dart';
import 'package:fridge/home/data/models/requests/update_product_request.dart';
import 'package:fridge/home/data/models/responses/product_model.dart';

import '../../../core/error/error_message_model.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/network/dio_manager.dart';

abstract class HomeRemoteDataSource {

  final DioManager dioManager;
  HomeRemoteDataSource(this.dioManager);

  Future<List<ProductModel>> getProducts();
  Future<void> storeProduct(String name, String description);
  Future<void> updateProduct(int id, String name, String description);
  Future<void> delProduct(int productId);
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {

  HomeRemoteDataSourceImpl(super.dioManager);

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      var response = await dioManager.dio.get(ApiConstants.getProductsPath);
      return List<ProductModel>.from((response.data).map(
            (e) => ProductModel.fromJson(e),
      ));
    }  on DioException catch (error) {
      if (error.response != null) {
        throw ServerException(
            errorMessageModel: ErrorMessageModel.fromJson(error.response?.data)
        );
      } else {
        // Error due to setting up or sending the request
        throw ServerException(
            errorMessageModel: ErrorMessageModel(status: false, message: error.message ?? '')
        );
      }
    }
  }

  @override
  Future<void> storeProduct(String name, String description) async {
    try {
      var response = await dioManager.dio.post(
        ApiConstants.loginPath,
        data: StoreProductRequest(
          name: name,
          description: description
        ).toJson(),
      );
      if (!response.data['status']) {
        throw ServerException(
            errorMessageModel: ErrorMessageModel.fromJson(response.data)
        );
      }
    }  on DioException catch (error) {
      if (error.response != null) {
        throw ServerException(
            errorMessageModel: ErrorMessageModel.fromJson(error.response?.data)
        );
      } else {
        // Error due to setting up or sending the request
        throw ServerException(
            errorMessageModel: ErrorMessageModel(status: false, message: error.message ?? '')
        );
      }
    }
  }

  @override
  Future<void> updateProduct(int id, String name, String description) async {
    try {
      var response = await dioManager.dio.post(
        ApiConstants.updateProductPath,
        data: UpdateProductRequest(
            id: id,
            name: name,
            description: description
        ).toJson(),
      );
      if (!response.data['status']) {
        throw ServerException(
            errorMessageModel: ErrorMessageModel.fromJson(response.data)
        );
      }
    }  on DioException catch (error) {
      if (error.response != null) {
        throw ServerException(
            errorMessageModel: ErrorMessageModel.fromJson(error.response?.data)
        );
      } else {
        // Error due to setting up or sending the request
        throw ServerException(
            errorMessageModel: ErrorMessageModel(status: false, message: error.message ?? '')
        );
      }
    }
  }

  @override
  Future<void> delProduct(int productId) async {
    try {
      var response = await dioManager.dio.get(
        ApiConstants.delProductPath(productId),
      );
      if (!response.data['status']) {
        throw ServerException(
            errorMessageModel: ErrorMessageModel.fromJson(response.data)
        );
      }
    }  on DioException catch (error) {
      if (error.response != null) {
        throw ServerException(
            errorMessageModel: ErrorMessageModel.fromJson(error.response?.data)
        );
      } else {
        // Error due to setting up or sending the request
        throw ServerException(
            errorMessageModel: ErrorMessageModel(status: false, message: error.message ?? '')
        );
      }
    }
  }
}