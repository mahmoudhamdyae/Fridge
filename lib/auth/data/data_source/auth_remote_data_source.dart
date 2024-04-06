import 'package:dio/dio.dart';
import 'package:fridge/auth/domain/entities/register_request.dart';
import 'package:fridge/core/error/error_message_model.dart';
import 'package:fridge/core/error/exceptions.dart';
import 'package:fridge/core/network/api_constants.dart';

import '../../../core/network/dio_manager.dart';
import '../../domain/entities/auth_response.dart';
import '../../domain/entities/login_request.dart';

abstract class AuthRemoteDataSource {
  final DioManager dioManager;

  AuthRemoteDataSource(this.dioManager);

  Future<String?> login({
    required String phone,
    required String password,
  });

  Future<String?> register({
    required String name,
    required String phone,
    required String password,
    required String address,
    required String fridgeName,
  });
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(super.dioManager);

  @override
  Future<String?> login({
    required String phone,
    required String password,
  }) async {
    ApiConstants.isAuth = true;
    try {
      var response = await dioManager.dio.post(
        ApiConstants.loginPath,
        data: LoginRequest(
          phone: phone,
          password: password,
        ).toJson(),
      );
      ApiConstants.isAuth = false;
      return AuthResponse.fromJson(response.data).token;
    } on DioException catch (error) {
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
  Future<String?> register({
    required String name,
    required String phone,
    required String password,
    required String address,
    required String fridgeName,
  }) async {
    ApiConstants.isAuth = true;
    try {
      var response = await dioManager.dio.post(
        ApiConstants.registerPath,
        data: RegisterRequest(
          name: name,
          phone: phone,
          password: password,
          address: address,
          fridgeName: fridgeName
        ).toJson(),
      );
      ApiConstants.isAuth = true;
      return AuthResponse.fromJson(response.data).token;
    } on DioException catch (error) {
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