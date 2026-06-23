import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:session_3/features/sales/data/models/sale_model.dart';

class SalesFirebaseDataSource {
  final FirebaseFirestore _firestore;

  SalesFirebaseDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<SaleModel>> getSalesModelsStream() {
    return _firestore
        .collection('sales')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((e) => SaleModel.fromJson(e.data())).toList(),
        );
  }
}
