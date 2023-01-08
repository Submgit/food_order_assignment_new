
import '../../business_logic/models/product.dart';
import '../../business_logic/models/product_cat.dart';

class AppData{
  AppData._();

  static List<Product> products = [
    Product(
       name: "Dal Makhani",
      inStock: true,
      isBestSeller: false,
      price: 299,
      qty: 0,
      type: ProductType.veg,
      orderCount: 0
    ),
    Product(
        name: "Dal Fry",
        inStock: true,
        isBestSeller: false,
        price: 139,
        qty: 0,
        type: ProductType.veg,
        orderCount: 0
    ),
    Product(
        name: "Dilux Thali",
        inStock: true,
        isBestSeller: false,
        price: 349,
        qty: 0,
        type: ProductType.veg,
        orderCount: 0
    ),
    Product(
        name: "Zingy Parcel",
        inStock: true,
        isBestSeller: false,
        price: 129,
        qty: 0,
        type: ProductType.salad,
        orderCount: 0
    ),
    Product(
        name: "Veg Crunch Salad",
        inStock: true,
        isBestSeller: false,
        price: 99,
        qty: 0,
        type: ProductType.salad,
        orderCount: 0
    ),
    Product(
        name: "Peach Iced Tea",
        inStock: true,
        isBestSeller: false,
        price: 75,
        qty: 0,
        type: ProductType.beverage,
        orderCount: 0
    ),
    Product(
        name: "Masala Cola",
        inStock: true,
        isBestSeller: false,
        price: 65,
        qty: 0,
        type: ProductType.beverage,
        orderCount: 0
    ),
    Product(
        name: "Green Apple Mojito",
        inStock: true,
        isBestSeller: false,
        price: 99,
        qty: 0,
        type: ProductType.beverage,
        orderCount: 0
    ),
    Product(
        name: "Murgh Afghani",
        inStock: true,
        isBestSeller: false,
        price: 319,
        qty: 0,
        type: ProductType.chicken,
        orderCount: 0
    ),
    Product(
        name: "Chicken Biryani",
        inStock: true,
        isBestSeller: false,
        price: 299,
        qty: 0,
        type: ProductType.chicken,
        orderCount: 0
    ),
    Product(
        name: "Boneless Chilli Chicken",
        inStock: true,
        isBestSeller: false,
        price: 299,
        qty: 0,
        type: ProductType.chicken,
        orderCount: 0
    ),
    Product(
        name: "Chicken Soup",
        inStock: true,
        isBestSeller: false,
        price: 59,
        qty: 0,
        type: ProductType.soup,
        orderCount: 0
    ),
    Product(
        name: "Tomato Soup",
        inStock: true,
        isBestSeller: false,
        price: 49,
        qty: 0,
        type: ProductType.soup,
        orderCount: 0
    )
  ];

  static List<ProductCat> catProduct = [
    ProductCat(
      isSelected: false,
      name: "Veg",
      products: AppData.products.where((element) => element.type==ProductType.veg).toList()
    ),
    ProductCat(
        isSelected: false,
        name: "Chicken",
        products: AppData.products.where((element) => element.type==ProductType.chicken).toList()
    ),
    ProductCat(
        isSelected: false,
        name: "Salads",
        products: AppData.products.where((element) => element.type==ProductType.salad).toList()
    ),
    ProductCat(
        isSelected: false,
        name: "Soups",
        products: AppData.products.where((element) => element.type==ProductType.soup).toList()
    ),
    ProductCat(
        isSelected: true,
        name: "Beverage",
        products: AppData.products.where((element) => element.type==ProductType.beverage).toList()
    ),
  ];
}