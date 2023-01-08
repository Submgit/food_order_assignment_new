import 'package:flutter/material.dart';
import 'package:food_order_assignment/business_logic/models/product_cat.dart';
import 'package:food_order_assignment/presentation/views/product_view.dart';
import 'package:get/get.dart';

import '../../business_logic/controllers/product_controller.dart';
import '../../business_logic/models/product.dart';
import '../widgets/animation_switch_wrapper.dart';

final ProductController controller = Get.put(ProductController());

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: cartListView(),
      bottomNavigationBar:SizedBox(
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFEC6813) // Background color
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("Order Placed"),
                content: const Text("Your order successfully placed at your location."),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      controller.resetProducts();
                      Get.offAll(ProductView());
                    },
                    child:Text("Go to Home"),
                  ),
                ],
              ),
            );
          },
          child: Row(
            children: [
              Expanded(child: Center(child: Text("Pay Now >>",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),)),
              Text("₹${controller.totalPrice.value}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),)
            ],
          ),
        ),
      ),
    );
  }

  Widget cartListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      itemCount: controller.cartProducts.length,
      itemBuilder: (_, index) {
        Product e = controller.cartProducts[index];
        return productView(e, index);
      },
    );
  }

  Widget productView(Product product, int cIndex) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.grey[200]?.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
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
              controller.getQty(product),
              style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w400),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                controller.getPrice(product),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
