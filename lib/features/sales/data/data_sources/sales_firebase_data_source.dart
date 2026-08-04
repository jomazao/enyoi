import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:session_3/features/sales/data/models/sale_model.dart';

class SalesFirebaseDataSource {
  final FirebaseFirestore _firestore;

  SalesFirebaseDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<SaleModel>> getSalesModelsStream() {
    return _firestore
        .collection('sales')
        .orderBy('total', descending: false)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => SaleModel.fromJson(doc.data()))
              .toList(),
        );
  }

  Future<List<SaleModel>> getSalesModels({double? lastTotal}) async {
    final docs = await _firestore
        .collection('sales')
        .orderBy('total', descending: false)
        .startAfter([lastTotal])
        .limit(2)
        .get();
    return docs.docs.map((doc) => SaleModel.fromJson(doc.data())).toList();
  }
}
