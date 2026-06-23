import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:session_3/features/ecomerce/domain/entities/product.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';


@freezed
abstract class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String id,
    required String name,
    required double price,
    required String description,
    required String category,
    required String image,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

extension ProductModelX on ProductModel {
  Product toEntity() => Product(
    id: id,
    name: name,
    price: price,
    description: description,
    category: category,
    image: image,
  );
}

extension ProductModelListEx on List<ProductModel> {
  List<Product> toEntityList() => map((model) => model.toEntity()).toList();

  int total() => length;
  ProductModel modellHighestPrice() => reduce((value, element) => value.price > element.price ? value : element);
  ProductModel modellLowestPrice() => reduce((value, element) => value.price < element.price ? value : element);
  String imageNameStartsWithZ() => firstWhere((element) => element.image.startsWith('z')).image;
  
}




