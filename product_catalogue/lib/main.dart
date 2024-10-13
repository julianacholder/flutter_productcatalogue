import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'theme.dart';
import 'product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Store',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: CatalogPage(),
    );
  }
}

class CatalogPage extends StatelessWidget {
  final List<Product> products = [
    Product(
        name: 'Product 1',
        imagePath: 'assets/images/bluenike.jpg',
        price: 19.99),
    Product(
        name: 'Product 2',
        imagePath: 'assets/images/bluenike.jpg',
        price: 29.99),
    Product(
        name: 'Product 3',
        imagePath: 'assets/images/bluenike.jpg',
        price: 39.99),
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Store'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              Get.changeThemeMode(
                Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.snackbar(
          'Product Tapped',
          'You selected ${product.name}',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.asset(
                  product.imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
