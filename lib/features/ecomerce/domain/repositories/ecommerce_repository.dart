import 'package:session_3/features/ecomerce/domain/entities/product.dart';

abstract class EcommerceRepository {
  Future<List<Product>> getProducts();
  Future<List<String>> getCategories();
  Future<Product> getProductDetail({required String id});
}
