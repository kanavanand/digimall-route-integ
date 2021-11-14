import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prachar/domain/auth/store.dart';
import 'package:prachar/domain/home/product/product.dart';
import 'package:prachar/infrastructure/core/firebase_helpers.dart';
import 'package:prachar/presentation/ui/products/widgets/product_tile.dart';
import 'package:prachar/presentation/ui/store/widgets/store_product_tile.dart';

enum ProductsSearchType {
  buyer,
  seller,
}

class ProductsSearchStorePage extends StatefulWidget {
  final Store store;
  final ProductsSearchType productsSearchType;
  const ProductsSearchStorePage({
    Key key,
    this.store,
    @required this.productsSearchType,
  }) : super(key: key);

  @override
  _ProductsSearchStorePageState createState() =>
      _ProductsSearchStorePageState();
}

class _ProductsSearchStorePageState extends State<ProductsSearchStorePage> {
  String searchQuery = "";
  bool _isSearching = false;
  final _searchQueryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: _buildSearchField(),
        //  _isSearching
        //     ? _buildSearchField()
        //     : const Text(
        //         'Search products',
        //         style: TextStyle(
        //           color: Colors.black,
        //           fontWeight: FontWeight.w500,
        //         ),
        //       ),
        actions: _buildActions(),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xff252733)),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: productsList(),
      ),
    );
  }

  Widget productsList() {
    final auth = FirebaseAuth.instance;
    final String id =
        widget.store != null ? widget.store.id : auth.currentUser.uid;
    final CollectionReference query =
        FirebaseFirestore.instance.storesCollection.doc(id).productsCollection;

    return StreamBuilder(
      stream: query
          .where('keywords', arrayContainsAny: [
            ...searchQuery.split(' ').map((e) => e.trim()).toList()
          ])
          .where('availability', isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length as int,
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final DocumentSnapshot doc =
                      snapshot.data.docs[index] as DocumentSnapshot;
                  final Product product = Product.fromJson(doc.data());
                  return widget.productsSearchType == ProductsSearchType.buyer
                      ? StoreProductTile(
                          store: widget.store,
                          product: product,
                          storeId: widget.store.id,
                          storeName: widget.store.name,
                          storePhoneNumber: widget.store.number,
                        )
                      : ProductTile(
                          product: product,
                        );
                })
            : Container();
      },
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search products...",
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.black38),
      ),
      style: const TextStyle(color: Colors.black38, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(_searchQueryController.text),
    );
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }
}
