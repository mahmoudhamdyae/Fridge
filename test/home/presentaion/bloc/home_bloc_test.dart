import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fridge/core/enums/request_state.dart';
import 'package:fridge/core/network/dio_manager.dart';
import 'package:fridge/home/data/datasource/home_remote_data_source.dart';
import 'package:fridge/home/domain/usecases/del_product_usecase.dart';
import 'package:fridge/home/domain/usecases/get_products_usecase.dart';
import 'package:fridge/home/domain/usecases/store_product_usecase.dart';
import 'package:fridge/home/domain/usecases/update_product_usecase.dart';
import 'package:fridge/home/presentation/bloc/home_bloc.dart';

import '../../data/datasource/mock_home_remote_data_source.dart';
import '../../data/repository/mock_home_repository.dart';

void main() {
  HomeRemoteDataSource remoteDataSource;
  late MockHomeRepository repository;
  late HomeBloc bloc;
  group('HomeBloc', () {
    setUp(() {
      remoteDataSource = MockHomeRemoteDataSource(DioManager.instance);
      repository = MockHomeRepository(remoteDataSource);
      bloc = HomeBloc(
          GetProductsUsecase(repository),
          StoreProductUsecase(repository),
          UpdateProductUsecase(repository),
          DelProductUsecase(repository)
      );
    });
    tearDown(() {
      bloc.close();
    });

    blocTest(
      'emits [] when nothing is added',
      build: () => bloc,
      expect: () => [],
    );

    blocTest(
      'store product test - return success',
      build: () => bloc,
      act: (bloc) => bloc.add(StoreProduct('name', 'description')),
      expect: () => [
        const HomeState(storeProductState: RequestState.loading, storeProductErrorMessage: ''),
        const HomeState(storeProductState: RequestState.loaded, storeProductErrorMessage: ''),
      ],
    );

    blocTest(
      'store product test - return failure',
      build: () => bloc,
      setUp: () {
        repository.returnError(true);
      },
      act: (bloc) => bloc.add(StoreProduct('name', 'description')),
      expect: () => [
        const HomeState(storeProductState: RequestState.loading, storeProductErrorMessage: ''),
        const HomeState(storeProductState: RequestState.error, storeProductErrorMessage: 'ERROR'),
      ],
    );

    blocTest(
      'update product test - return success',
      build: () => bloc,
      act: (bloc) => bloc.add(UpdateProduct(0, 'name', 'description')),
      expect: () => [
        const HomeState(updateProductState: RequestState.loading, updateProductErrorMessage: ''),
        const HomeState(updateProductState: RequestState.loaded, updateProductErrorMessage: ''),
      ],
    );

    blocTest(
      'del product test - return success',
      build: () => bloc,
      act: (bloc) => bloc.add(DelProduct(0)),
      expect: () => [
        const HomeState(delProductState: RequestState.loading, delProductErrorMessage: ''),
        const HomeState(delProductState: RequestState.loaded, delProductErrorMessage: ''),
      ],
    );
  });
}