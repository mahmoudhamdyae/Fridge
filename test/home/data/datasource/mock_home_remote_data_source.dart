import 'package:fridge/home/data/datasource/home_remote_data_source.dart';
import 'package:fridge/home/data/models/responses/product_model.dart';

class MockHomeRemoteDataSource extends HomeRemoteDataSource {

  List<ProductModel> products = [
    ProductModel(id: 1, name: 'name1', description: 'description1', fridgeId: 0),
  ];

  MockHomeRemoteDataSource(super.dioManager);

  @override
  Future<List<ProductModel>> getProducts() async {
    return await Future(() => products);
  }

  @override
  Future<void> storeProduct(String name, String description) async {
    products.add(ProductModel(id: 1, name: name, description: description, fridgeId: 0));
  }

  @override
  Future<void> updateProduct(int id, String name, String description) async {
  }

  @override
  Future<void> delProduct(int productId) async {
  }
}