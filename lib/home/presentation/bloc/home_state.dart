part of 'home_bloc.dart';

class HomeState extends Equatable {

  final List<Product> products;
  final RequestState productsState;
  final String productsErrorMessage;
  // Store Product
  final RequestState storeProductState;
  final String storeProductErrorMessage;
  // Update Product
  final RequestState updateProductState;
  final String updateProductErrorMessage;
  // Del Product
  final RequestState delProductState;
  final String delProductErrorMessage;

  const HomeState({
    this.products = const[],
    this.productsState = RequestState.loading,
    this.productsErrorMessage = '',
    this.storeProductState = RequestState.loaded,
    this.storeProductErrorMessage = '',
    this.updateProductState = RequestState.loaded,
    this.updateProductErrorMessage = '',
    this.delProductState = RequestState.loaded,
    this.delProductErrorMessage = '',
  });

  HomeState copyWith({
    List<Product>? products,
    RequestState? productsState,
    String? productsErrorMessage,
    RequestState? storeProductState,
    String? storeProductErrorMessage,
    RequestState? updateProductState,
    String? updateProductErrorMessage,
    RequestState? delProductState,
    String? delProductErrorMessage,
  }) {
    return HomeState(
      products: products ?? this.products,
      productsState: productsState ?? this.productsState,
      productsErrorMessage: productsErrorMessage ?? this.productsErrorMessage,
      storeProductState: storeProductState ?? this.storeProductState,
      storeProductErrorMessage: storeProductErrorMessage ?? this.storeProductErrorMessage,
      updateProductState: updateProductState ?? this.updateProductState,
      updateProductErrorMessage: updateProductErrorMessage ?? this.updateProductErrorMessage,
      delProductState: delProductState ?? this.delProductState,
      delProductErrorMessage: delProductErrorMessage ?? this.delProductErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    products, productsState, productsErrorMessage,
    storeProductState, storeProductErrorMessage,
    updateProductState, updateProductErrorMessage,
    delProductState, delProductErrorMessage
  ];
}