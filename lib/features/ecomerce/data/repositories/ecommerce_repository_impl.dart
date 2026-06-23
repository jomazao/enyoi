import 'package:session_3/features/ecomerce/data/datasources/ecommerce_remote_datasource.dart';
import 'package:session_3/features/ecomerce/data/models/product_model.dart';
import 'package:session_3/features/ecomerce/domain/entities/product.dart';
import 'package:session_3/features/ecomerce/domain/repositories/ecommerce_repository.dart';

class EcommerceRepositoryImpl extends EcommerceRepository {
  final EcommerceRemoteDatasource _remoteDatasource;

  EcommerceRepositoryImpl({EcommerceRemoteDatasource? remoteDatasource})
    : _remoteDatasource = remoteDatasource ?? EcommerceRemoteDatasource();

  @override
  Future<List<String>> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductDetail({required String id}) {
    // TODO: implement getProductDetail
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProducts() async {
    final productsModels = await _remoteDatasource.getProducts();
    //return productModelsToEntities(productsModels);
    return productsModels.toEntityList();
  }
}

List<Product> productModelsToEntities(List<ProductModel> productModels) {
  return productModels.map((model) => model.toEntity()).toList();
}
