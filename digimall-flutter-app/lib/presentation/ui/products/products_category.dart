import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:prachar/constants/configs.dart';
import 'package:prachar/domain/home/product/product.dart';
import 'package:prachar/presentation/ui/products/widgets/product_tile.dart';
import 'package:prachar/infrastructure/core/firebase_helpers.dart';

class ProductsCategory extends StatelessWidget {
  final String category;
  const ProductsCategory({
    Key key,
    @required this.category,
  }) : super(key: key);

  Widget productsList() {
    final auth = FirebaseAuth.instance;
    final query = category == 'All'
        ? FirebaseFirestore.instance.storesCollection
            .doc(auth.currentUser.uid)
            .productsCollection
            .orderBy('timestamp', descending: true)
        : FirebaseFirestore.instance.storesCollection
            .doc(auth.currentUser.uid)
            .productsCollection
            .where('category', isEqualTo: category)
            .orderBy('timestamp', descending: true);
    return PaginateFirestore(
      bottomLoader: const Center(child: CircularProgressIndicator()),
      itemsPerPage: Configs.kPerPageViewLimitForSeller,
      query: query,
      itemBuilderType: PaginateBuilderType.listView,
      isLive: true,
      emptyDisplay: const Center(child: Text("No Products Added")),
      itemBuilder: (index, context, snapshot) {
        final Product product = Product.fromJson(snapshot.data());
        return ProductTile(
          product: product,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return productsList();
  }
}
