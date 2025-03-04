import 'package:flutter/material.dart';
// import 'package:practice/product_controller.dart';
// import 'package:practice/widgets/product_card.dart';
import 'package:product_app/product_controller.dart';
import 'package:product_app/widgets/product_card.dart';

class Module13Class1 extends StatefulWidget {
  const Module13Class1({super.key});

  @override
  State<Module13Class1> createState() => _Module13Class1State();
}

class _Module13Class1State extends State<Module13Class1> {
  final ProductController productController = ProductController();

  void productDialog({
    String? id,
    String? name,
    int? qty,
    String? img,
    int? unitPrice,
    int? totalPrice,
  }) {
    TextEditingController productNameController =
    TextEditingController(text: name ?? '');
    TextEditingController productQtyController =
    TextEditingController(text: qty?.toString() ?? '0');
    TextEditingController productImageController =
    TextEditingController(text: img ?? '');
    TextEditingController productUnitPriceController =
    TextEditingController(text: unitPrice?.toString() ?? '0');
    TextEditingController productTotalPriceController =
    TextEditingController(text: totalPrice?.toString() ?? '0');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(id == null ? 'Add Product' : 'Update Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: productNameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: productImageController,
              decoration: const InputDecoration(labelText: 'Product Image'),
            ),
            TextField(
              controller: productQtyController,
              decoration: const InputDecoration(labelText: 'Product Qty'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: productUnitPriceController,
              decoration: const InputDecoration(labelText: 'Product Unit Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: productTotalPriceController,
              decoration: const InputDecoration(labelText: 'Total Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
                ElevatedButton(
                  onPressed: () {
                    int? qty = int.tryParse(productQtyController.text);
                    int? unitPrice = int.tryParse(productUnitPriceController.text);
                    int? totalPrice = int.tryParse(productTotalPriceController.text);

                    if (qty == null || unitPrice == null || totalPrice == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter valid numbers"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    if (id == null) {
                      productController.createProduct(
                        productNameController.text,
                        productImageController.text,
                        qty,
                        unitPrice,
                        totalPrice,
                      );
                    } else {
                      productController.UpdateProduct(
                        id,
                        productNameController.text,
                        productImageController.text,
                        qty,
                        unitPrice,
                        totalPrice,
                      );
                    }

                    fetchData();
                    Navigator.pop(context);
                  },
                  child: Text(id == null ? 'Add Product' : 'Update Product'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    await productController.fetchProducts();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: const Text('Products')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: productController.products.length,
        itemBuilder: (context, index) {
          var product = productController.products[index];
          return ProductCard(
            product: product,
            onEdit: () => productDialog(
              id: product.sId,
              name: product.productName,
              img: product.img,
              qty: product.qty,
              unitPrice: product.unitPrice,
              totalPrice: product.totalPrice,
            ),
            onDelete: () {
              productController.deleteProducts(product.sId.toString()).then((value) {
                if (value) {
                  fetchData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Product deleted"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Something went wrong, try again"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => productDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
