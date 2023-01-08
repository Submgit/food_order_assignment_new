import 'package:flutter/material.dart';
import 'package:food_order_assignment/business_logic/models/product_cat.dart';
import 'package:food_order_assignment/presentation/views/cart_items.dart';
import 'package:get/get.dart';

import '../../business_logic/controllers/product_controller.dart';
import '../../business_logic/models/product.dart';
import '../widgets/animation_switch_wrapper.dart';

final ProductController controller = Get.put(ProductController());

class ProductView extends StatelessWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Savera Restaurants"),
      ),
      body: cartListView(),
      bottomNavigationBar: GetBuilder<ProductController>(
        builder: (ProductController controller) {
          return controller.totalPrice.value>0?SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEC6813) // Background color
              ),
              onPressed: () {
                controller.GetCartItems();
                Get.to(CartView());
              },
              child: Row(
                children: [
                  Expanded(child: Center(child: Text("Place Order",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),)),
                  Text("₹${controller.totalPrice.value}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),)
                ],
              ),
            ),
          ):SizedBox(height: 0,);
        },
      ),
    );
  }

  Widget cartListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      itemCount: controller.catProducts.length,
      reverse: true,
      itemBuilder: (_, index) {
        ProductCat cat = controller.catProducts[index];
        return Card(
          child: ExpansionTile(
            title: Text(
              cat.name!,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            initiallyExpanded: cat.isSelected!,
            onExpansionChanged: (val) {
              cat.isSelected = val;
            },
            children: cat.products!.map((e) => productView(e, index)).toList(),
          ),
        );
      },
    );
  }

  Widget productView(Product product, int cIndex) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      height: 120,
      decoration: BoxDecoration(
          color: Colors.grey[200]?.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  product.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 15),
                ),
                Text(
                  controller.getPrice(product),
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w400),
                ),
                Visibility(
                  visible: product.isBestSeller!,
                  child: Text(
                   "Bestseller",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          GetBuilder<ProductController>(
            builder: (ProductController controller) {
              return product.qty! > 0
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          IconButton(
                            splashRadius: 10.0,
                            onPressed: () => controller.decreaseItemP(product),
                            icon: const Icon(
                              Icons.remove,
                              color: Color(0xFFEC6813),
                            ),
                          ),
                          GetBuilder<ProductController>(
                            builder: (ProductController controller) {
                              return AnimatedSwitcherWrapper(
                                child: Text(
                                  '${product.qty}',
                                  key: ValueKey<int>(product.qty!),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            splashRadius: 10.0,
                            onPressed: () => controller.increaseItemP(product),
                            icon: const Icon(
                              Icons.add,
                              color: Color(0xFFEC6813),
                            ),
                          ),
                        ],
                      ),
                    )
                  : InkWell(
                      onTap: () => controller.addToCart(product),
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              "Add",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFEC6813),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
