import 'package:session_3/features/ecomerce/data/repositories/ecommerce_repository_impl.dart';
import 'package:session_3/features/ecomerce/domain/entities/product.dart';
import 'package:session_3/features/ecomerce/domain/repositories/ecommerce_repository.dart';

class GetProductsUseCase {
  final EcommerceRepository _ecommerceRepository;

  GetProductsUseCase({EcommerceRepository? ecommerceRepository})
    : _ecommerceRepository = ecommerceRepository ?? EcommerceRepositoryImpl();

  Future<List<Product>> call() => _ecommerceRepository.getProducts();
}
