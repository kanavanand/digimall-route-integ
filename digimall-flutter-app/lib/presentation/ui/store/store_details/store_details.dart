import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/constants/configs.dart';
import 'package:prachar/domain/auth/store.dart';
import 'package:prachar/domain/home/product/product.dart';
import 'package:prachar/presentation/core/pages/app_widget.dart';
import 'package:prachar/presentation/core/strings.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/core/widgets/search_widget.dart';
import 'package:prachar/presentation/routes/router.gr.dart';
import 'package:prachar/presentation/ui/products/products_search.dart';
import 'package:prachar/presentation/ui/store/store_details/store_bottom_sheat_cart.dart';
import 'package:prachar/presentation/ui/store/widgets/store_product_tile.dart';
import 'package:prachar/infrastructure/core/firebase_helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';
import 'package:truncate/truncate.dart';

class StoreDetailsPage extends StatefulWidget {
  final Store store;
  const StoreDetailsPage({
    Key key,
    @required this.store,
  }) : super(key: key);

  @override
  _StoreDetailsPageState createState() => _StoreDetailsPageState();
}

class _StoreDetailsPageState extends State<StoreDetailsPage> {
  @override
  void initState() {
    super.initState();
    increaseViewCount();
  }

  Widget productsList(String category, List categoriesList) {
    final auth = FirebaseAuth.instance;

    final query = category == 'All'
        ? FirebaseFirestore.instance.storesCollection
            .doc(widget.store.id)
            .productsCollection
            .where('availability', isEqualTo: true)
            .orderBy('timestamp', descending: true)
            .snapshots()
        : FirebaseFirestore.instance.storesCollection
            .doc(widget.store.id)
            .productsCollection
            .where('availability', isEqualTo: true)
            .where('category', isEqualTo: category)
            .orderBy('timestamp', descending: true)
            .snapshots();
    return StreamBuilder(
      stream: query,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length as int,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc =
                      snapshot.data.docs[index] as DocumentSnapshot;
                  final Product product = Product.fromJson(doc.data());
                  return StoreProductTile(
                    store: widget.store,
                    product: product,
                    storeId: widget.store.id,
                    storeName: widget.store.name,
                    storePhoneNumber: widget.store.number,
                    onAddChangeState: () {
                      setState(() {});
                    },
                  );
                },
              )
            : Container();
      },
    );
  }

  void _select(
    String choice,
    BuildContext context,
  ) async {
    if (choice == "Share") {
      await Share.share(
          'Hi, Check out DigiMall Mobile App, a simple way to sell your store products to anyone,anywhere. \nHere, use my store link to checkout the catlogue of my store \n Link : ${widget.store.dynamicLinkUrl} \n Link to download the app : \n https://play.google.com/store/apps/details?id=com.business.prachar');
    } else if (choice == "Add to favourite") {
      addTofavouriteStore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final choices = ["Share", "Add to favourite"];
    var text = widget.store.name;
    var truncated =
        truncate(text, 24, omission: "...", position: TruncatePosition.end);
    final productTEC = TextEditingController();
    final List categoriesList = List.from(getCategoriesList() ?? []);
    if (!categoriesList.contains("All")) {
      categoriesList?.insert(0, "All");
    }
    return DefaultTabController(
      length: categoriesList?.length ?? 0,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          iconTheme: const IconThemeData(
            color: Colors.grey, //change your color here
          ),
          backgroundColor: Colors.white,
          title: Center(
              child: Text(
            truncated,
            style: TextStyle(color: Colors.grey, fontSize: 20),
          )),
          actions: [
            PopupMenuButton(
              onSelected: (val) {
                _select(val as String, context);
              },
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
              // initialValue: choices[_selection],
              itemBuilder: (BuildContext context) {
                return choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(10),
                  child: Container(
                    height: 30,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    alignment: Alignment.bottomLeft,
                    child: TabBar(
                      isScrollable: true,
                      labelColor: const Color(0xff525c6e),
                      unselectedLabelColor: const Color(0xffacb3bf),
                      indicatorWeight: 2.0,
                      indicatorColor: Kolors.primaryColor,
                      // unselectedLabelColor: Kolors.primaryBackgroundColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: const ShapeDecoration(
                        shape: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                                style: BorderStyle.solid)),
                        color: Kolors.primaryColor,
                      ),
                      tabs: categoriesList
                              ?.map(
                                (val) => Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  color: Colors.white,
                                  child: Tab(child: Text('  $val  ')),
                                ),
                              )
                              ?.toList() ??
                          [],
                    ),
                  ),
                ),
                expandedHeight: 220,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.none,
                  background: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(6),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.network(widget.store.image,
                                height: 100, width: 100),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.store.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 145,
                                    child: Text(
                                      widget.store.address,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          145,
                                      child: Text(
                                        "Delivery Charges:  ₹${widget.store.deliveryCharges.toString()}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          color: Kolors.PrimaryColorDark,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          145,
                                      child: Text(
                                        "Minimum Order Amount:  ₹${widget.store.minimumOrderAmount.toString()}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          color: Kolors.PrimaryColorDark,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SearchWidget(
                          hint: "Search Products",
                          text: "",
                          onPressed: () {
                            ExtendedNavigator.of(context).push(
                                Routes.productsSearchStorePage,
                                arguments: ProductsSearchStorePageArguments(
                                  store: widget.store,
                                  productsSearchType: ProductsSearchType.buyer,
                                ));
                          },
                        ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        // productsList(),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Container(
            margin: const EdgeInsets.only(
              bottom: 30,
            ),
            child: TabBarView(
              children: categoriesList
                      ?.map(
                        (val) => ProductListView(
                          store: widget.store,
                          category: val.toString(),
                          storeId: widget.store.id,
                          storePhoneNumber: widget.store.number,
                          storeName: widget.store.name,
                          onAddChangeState: () {
                            setState(() {});
                          },
                        ),
                      )
                      ?.toList() ??
                  [],
            ),
          ),
        ),
        bottomSheet: StoreBottomSheatCart(
          store: widget.store,
          updateCartFn: () {
            setState(() {});
          },
        ),
      ),
    );
  }

  List getCategoriesList() {
    return widget.store.productCategories;
    // Map<String, dynamic> map = navigatorKey.currentState.context
    //     .read<AuthenticationBloc>()
    //     .state
    //     .categoriesMap;
    // return map[widget.store.category] as List;
  }

  void addTofavouriteStore() {
    final uid = FirebaseAuth.instance.currentUser.uid;
    final List<String> list = [
      uid,
    ];
    FirebaseFirestore.instance.storesCollection.doc(widget.store.id).update({
      'savedBy': FieldValue.arrayUnion(list),
    });
  }

  void increaseViewCount() {
    final user = navigatorKey.currentState.context
        .read<AuthenticationBloc>()
        .state
        .storeUser;
    String views = 'views';
    FirebaseFirestore.instance.storesCollection
        .doc(widget.store.id)
        .update({'analytics.$views': FieldValue.increment(1)});
    if (user.isStore) {
      user.store.homeAnalytics.views += 1;
      navigatorKey.currentState.context
          .read<AuthenticationBloc>()
          .add(AuthenticationEvent.userModified(user: user));
    }
  }
}

// GridView.builder(
//                 itemCount: snapshot.data.docs.length as int,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 0.85,
//                 ),
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   DocumentSnapshot doc =
//                       snapshot.data.docs[index] as DocumentSnapshot;
//                   final Product product = Product.fromJson(doc.data());
//                   return StoreProductTile(
//                     product: product,
//                   );
//                 },
//               )
class ProductListView extends StatefulWidget {
  final String category;
  final String storeId;
  final String storeName;
  final String storePhoneNumber;
  final Function onAddChangeState;
  final Store store;
  const ProductListView({
    Key key,
    @required this.category,
    @required this.storeId,
    @required this.store,
    this.storePhoneNumber,
    this.storeName,
    this.onAddChangeState,
  }) : super(key: key);
  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final int limit = Configs.kPerPageViewLimitForSeller;
  bool isLoading = false;
  final List<QueryDocumentSnapshot> _products = [];
  final ScrollController _controller = ScrollController();

  Future<void> fetchFirstList() async {
    final Query query = widget.category == 'All'
        ? FirebaseFirestore.instance.storesCollection
            .doc(widget.storeId)
            .productsCollection
            .where('availability', isEqualTo: true)
            .orderBy('timestamp', descending: true)
            .limit(limit)
        : FirebaseFirestore.instance.storesCollection
            .doc(widget.storeId)
            .productsCollection
            .where('availability', isEqualTo: true)
            .where('category', isEqualTo: widget.category)
            .orderBy('timestamp', descending: true)
            .limit(limit);
    final QuerySnapshot snapshot = await query.get();
    setState(() {
      _products.addAll(snapshot.docs);
    });
  }

  Future fetchMore() async {
    setState(() {
      isLoading = true;
    });
    final Query query = widget.category == 'All'
        ? FirebaseFirestore.instance.storesCollection
            .doc(widget.storeId)
            .productsCollection
            .where('availability', isEqualTo: true)
            .orderBy('timestamp', descending: true)
            .startAfterDocument(_products.last)
            .limit(limit)
        : FirebaseFirestore.instance.storesCollection
            .doc(widget.storeId)
            .productsCollection
            .where('availability', isEqualTo: true)
            .where('category', isEqualTo: widget.category)
            .orderBy('timestamp', descending: true)
            .startAfterDocument(_products.last)
            .limit(limit);
    final QuerySnapshot snapshot = await query.get();
    setState(() {
      _products.addAll(snapshot.docs);
    });
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _scrollListener() async {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      await fetchMore();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFirstList();
    _controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          controller: _controller,
          itemCount: _products.length,
          itemBuilder: (BuildContext context, int index) {
            final _product = Product.fromJson(_products[index].data());
            return StoreProductTile(
              store: widget.store,
              product: _product,
              storeId: widget.storeId,
              storeName: widget.storeName,
              onAddChangeState: widget.onAddChangeState,
              storePhoneNumber: widget.storePhoneNumber,
            );
          },
        ),
        if (isLoading)
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: CircularProgressIndicator(),
            ),
          )
        else
          Container()
      ],
    );
  }
}
