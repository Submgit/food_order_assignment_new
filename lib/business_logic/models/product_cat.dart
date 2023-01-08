import 'package:food_order_assignment/business_logic/models/product.dart';

class ProductCat{
  bool? isSelected = false;
  String? name;
  List<Product>? products;
  ProductCat({this.isSelected, this.name,this.products});
}