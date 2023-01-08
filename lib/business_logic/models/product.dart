
enum ProductType {popular,salad,chicken,soup,veg,beverage}

class Product{
  String? name;
  int? price;
  bool? inStock;
  ProductType? type;
  int? qty = 0;
  bool? isBestSeller = false;
  int? orderCount;

  Product(
      {this.name,
      this.price,
      this.inStock,
      this.type,
      this.qty,
      this.isBestSeller,
      this.orderCount});

}