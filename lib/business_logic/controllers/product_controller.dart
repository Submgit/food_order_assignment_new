import 'package:food_order_assignment/business_logic/models/product.dart';
import 'package:food_order_assignment/business_logic/models/product_cat.dart';
import 'package:food_order_assignment/presentation/utils/app_data.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  RxList<Product> products = AppData.products.obs;
  RxList<Product> cartProducts = <Product>[].obs;
  RxList<ProductCat> catProducts = AppData.catProduct.obs;
  RxInt totalPrice = 0.obs;


  void resetProducts(){
    List<Product>? list;
    for(var cat in catProducts){
      list =[];
      for(var p in cat.products!){

        if(p.qty! >0){
          Product product = p;
          product.type = ProductType.popular;
          product.orderCount = product.orderCount! + p.qty!;
          list.add(product);
          p.qty = 0;
        }
      }

      if(AppData.catProduct.where((element) => element.name=="Popular").toList().isEmpty){
        if(list.isNotEmpty){
          AppData.catProduct.add(ProductCat(
              products: list,
              isSelected: false,
              name: "Popular"
          ));
        }
      }
      else{
        for(var c in AppData.catProduct.where((element) => element.name=="Popular").toList()){
          if(list.isNotEmpty){
            c.products!.addAll(list);
          }
        }
      }
    }

    getBestseller();
    catProducts = AppData.catProduct.obs;
    totalPrice = 0.obs;
    update();
  }
  bool isEmptyCart(Product p) {
    if (p.qty! >0) {
      return true;
    } else {
      return false;
    }

  }

  String getPrice(Product product){
    return "Price: ₹${product.price}";
  }
  String getQty(Product product){
    return "Quantity: ${product.qty}";
  }
  void addToCart(Product item) {
    Product product = item;
    product.qty =  product.qty! + 1;
    //cartProducts.add(product);
    calculateTotalPrice();
    update();
  }

  void GetCartItems(){
   cartProducts.clear();

    for(var element in catProducts){

      for(var c in element.products!.where((e) => e.qty! > 0).toList()){
        if(cartProducts.where((e) => e.name! == c.name).toList().isEmpty){
          cartProducts.addAll(element.products!.where((e) => e.qty! >0).toList());
        }
      }
    }



  }

  void getBestseller(){
  Product? maxProduct;
  if(products.where((e) => e.orderCount! >0).toList().isNotEmpty){
    maxProduct = products.where((e) => e.orderCount! >0).toList()[0];
    for(var p in products){

      if(p.orderCount! > maxProduct!.orderCount!){
        maxProduct = p;
      }
    }
    for(var p in products){
      if(p.name==maxProduct!.name){
        p.isBestSeller = true;
      }
    }
  }
  products.sort((i, b) => i.orderCount!.compareTo(b.orderCount!));
}
  void decreaseItemP(Product item) {
    Product product = item;
    if (product.qty! > 0) {
      product.qty =  product.qty! - 1;
     // isEmptyCart(product);
    }

    calculateTotalPrice();
    update();
  }

  void increaseItemP(Product item) {
    Product product = item;
    product.qty =  product.qty! + 1;
    calculateTotalPrice();
    update();
  }

  void calculateTotalPrice() {
    totalPrice.value = 0;
    for(var p in catProducts){
      for (var element in p.products!) {
        totalPrice.value += element.qty! * element.price!;
      }
    }

  }
}