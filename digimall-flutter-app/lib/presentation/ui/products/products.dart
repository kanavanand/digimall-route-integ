import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:prachar/presentation/core/data.dart';
import 'package:prachar/presentation/core/pages/app_widget.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/core/widgets/search_widget.dart';
import 'package:prachar/presentation/core/widgets/text_form_with_toplabel.dart';
import 'package:prachar/presentation/routes/router.gr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prachar/presentation/ui/products/products_category.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/presentation/ui/products/products_search.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    final List categoriesList = getCategoriesList() ?? [];
    if (!categoriesList.contains("All")) {
      categoriesList?.insert(0, "All");
    }

    return DefaultTabController(
      length: categoriesList?.length ?? 0,
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              SearchWidget(
                hint: "Search Products",
                text: "Products",
                onPressed: () {
                  ExtendedNavigator.of(context)
                      .push(Routes.productsSearchStorePage,
                          arguments: ProductsSearchStorePageArguments(
                            productsSearchType: ProductsSearchType.seller,
                          ));
                },
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                height: 30,
                alignment: Alignment.bottomLeft,
                child: TabBar(
                  isScrollable: true,
                  unselectedLabelColor: Colors.grey,
                  labelPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Kolors.primaryColor,
                  ),
                  tabs: categoriesList
                          ?.map(
                            (val) => Tab(
                              child: Text(val as String),
                            ),
                          )
                          ?.toList() ??
                      [],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: TabBarView(
                  children: categoriesList
                          ?.map(
                            (val) => ProductsCategory(
                              category: val as String,
                            ),
                          )
                          ?.toList() ??
                      [],
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Kolors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          onPressed: () {
            ExtendedNavigator.of(context).push(Routes.addProductPage,
                arguments: AddProductPageArguments(updateProductsFn: () {
              setState(() {});
            })).then((_) {
              setState(() {});
            });
          },
          label: const Text(
            "Add new product",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  List getCategoriesList() {
    return navigatorKey.currentState.context
        .read<AuthenticationBloc>()
        .state
        .storeUser
        .store
        .productCategories;
    // .categoriesMap;
    // return map[getStoreCategory()] as List;
  }

  String getStoreCategory() {
    return navigatorKey.currentState.context
        .read<AuthenticationBloc>()
        .state
        .storeUser
        .store
        .category;
  }
}
