import 'package:cloud_firestore/cloud_firestore.dart';

class EcomerceRemoteDatasource {
  final FirebaseFirestore _firestore;
  EcomerceRemoteDatasource({required FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<ProductModel>> getProducts() async {
    final productsResult = await _firestore.collection('products').get();

    return productsResult.docs
        .map((doc) => ProductModel.fromJson(doc.data()))
        .toList();
  }
}
