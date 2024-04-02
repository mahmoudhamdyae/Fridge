import 'dart:io';

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
    try {
      var response = await dioManager.dio.post(
        ApiConstants.loginPath,
        data: LoginRequest(
          phone: phone,
          password: password,
        ).toJson(),
      );
      if (response.statusCode == HttpStatus.ok) {
        return AuthResponse.fromJson(response.data).token;
      } else {
        return throw ServerException(
            errorMessageModel: ErrorMessageModel.fromJson(response.data)
        );
      }
    } on Exception {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(status: false, message: 'بيانات الدخول غير صحيحة')
      );
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

      if (response.statusCode == HttpStatus.ok) {
        return AuthResponse.fromJson(response.data).token;
      } else {
        return throw ServerException(
            errorMessageModel: ErrorMessageModel.fromJson(response.data)
        );
      }
    } on Exception catch (error) {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              status: false, message: error.toString())
      );
    }
  }
}