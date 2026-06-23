import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:session_3/features/ecomerce/data/models/product_model.dart';

class EcommerceRemoteDatasource {
  final FirebaseFirestore _firestore;
  EcommerceRemoteDatasource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<ProductModel>> getProducts() async {
    final productsResult = await _firestore.collection('products').get();

    return productsResult.docs
        .map((doc) => ProductModel.fromJson(doc.data()))
        .toList();
  }
}
