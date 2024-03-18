import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/enums/request_state.dart';
import 'package:fridge/home/domain/usecases/del_product_usecase.dart';
import 'package:fridge/home/domain/usecases/get_products_usecase.dart';
import 'package:fridge/home/domain/usecases/store_product_usecase.dart';
import 'package:fridge/home/domain/usecases/update_product_usecase.dart';

import '../../domain/entities/product.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final GetProductsUsecase getProductsUsecase;
  final StoreProductUsecase storeProductUsecase;
  final UpdateProductUsecase updateProductUsecase;
  final DelProductUsecase delProductUsecase;

  HomeBloc(
      this.getProductsUsecase,
      this.storeProductUsecase,
      this.updateProductUsecase,
      this.delProductUsecase,
      ) : super(const HomeState()) {
    on<GetProducts>((event, emit) {
      _getProducts(event, emit);
    });
    on<StoreProduct>((event, emit) {
      _storeProduct(event, emit);
    });
    on<UpdateProduct>((event, emit) {
      _updateProduct(event, emit);
    });
    on<DelProduct>((event, emit) {
      _delProduct(event, emit);
    });
  }

  void _getProducts(GetProducts event, Emitter<HomeState> emit) async {
    final result = await getProductsUsecase.call();
    result.fold((l) {
      emit(state.copyWith(
        productsState: RequestState.error,
        productsErrorMessage: l.message,
      ));
    }, (products) {
      emit(state.copyWith(
        products: products,
        productsState: RequestState.loaded,
      ));
    });
  }

  void _storeProduct(StoreProduct event, Emitter<HomeState> emit) async {
    emit(state.copyWith(storeProductState: RequestState.loading));
    final result = await storeProductUsecase.call(
      event.name,
      event.description
    );
    result.fold((l) {
      emit(state.copyWith(
        storeProductState: RequestState.error,
        storeProductErrorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(storeProductState: RequestState.loaded));
    });
  }

  void _updateProduct(UpdateProduct event, Emitter<HomeState> emit) async {
    emit(state.copyWith(updateProductState: RequestState.loading));
    final result = await updateProductUsecase.call(
        event.id,
        event.name,
        event.description
    );
    result.fold((l) {
      emit(state.copyWith(
        updateProductState: RequestState.error,
        updateProductErrorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(updateProductState: RequestState.loaded));
    });
  }

  void _delProduct(DelProduct event, Emitter<HomeState> emit) async {
    emit(state.copyWith(delProductState: RequestState.loading));
    final result = await delProductUsecase.call(event.productId);
    result.fold((l) {
      emit(state.copyWith(
        delProductState: RequestState.error,
        delProductErrorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(delProductState: RequestState.loaded));
    });
  }
}
