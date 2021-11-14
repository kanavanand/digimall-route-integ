import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/application/home/products/products_bloc.dart';
import 'package:prachar/domain/home/product/product.dart';
import 'package:prachar/presentation/core/data.dart';
import 'package:prachar/presentation/core/pages/app_widget.dart';
import 'package:prachar/presentation/core/pages/styles.dart';
import 'package:prachar/presentation/core/widgets/add_image.dart';
import 'package:prachar/presentation/core/widgets/button.dart';
import 'package:prachar/presentation/core/widgets/pick_image_dialog.dart';
import 'package:prachar/presentation/core/widgets/text_form_with_toplabel.dart';

class AddProductPage extends StatefulWidget {
  final Product product;
  final Function updateProductsFn;
  const AddProductPage({
    Key key,
    this.product,
    this.updateProductsFn,
  }) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final formKey = GlobalKey<FormState>();
  String category;
  TextEditingController nameTEC;
  TextEditingController quantityTEC;
  TextEditingController mrpTEC;
  TextEditingController descTEC;
  TextEditingController sellingTEC;
  TextEditingController codeTEC;
  File file;
  bool isEdit;

  @override
  void initState() {
    super.initState();
    isEdit = widget.product != null;
    nameTEC = TextEditingController(text: widget.product?.name ?? '');
    quantityTEC = TextEditingController(text: widget.product?.quantity ?? '');
    mrpTEC = TextEditingController(
        text: widget.product != null ? '${widget.product?.mrp}' : '');

    sellingTEC = TextEditingController(
        text: widget.product != null ? '${widget.product?.sellingPrice}' : '');
    descTEC = TextEditingController(text: widget.product?.desc ?? '');
    codeTEC = TextEditingController(text: widget.product?.code ?? '');
    if (widget.product != null) {
      category = widget.product.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List categoriesList = getCategoriesList() ?? [];
    if (categoriesList.contains("All")) {
      categoriesList.remove("All");
    }

    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {
        state.addProductFailure.fold(
            () => null,
            (either) => either.fold(
                    (failure) =>
                        FlushbarHelper.createError(message: failure.error)
                            .show(context), (_) {
                  if (widget.product == null) {
                    Fluttertoast.showToast(msg: "Product added successfully");
                  } else {
                    Fluttertoast.showToast(
                        msg: "Product details changes successfully");
                  }
                  ExtendedNavigator.of(context).pop();
                }));
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(isEdit ? "Edit Product" : "Add Product"),
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () {
                      chooseImage(
                          context: context,
                          fn: (val) {
                            setState(() {
                              file = val as File;
                            });
                          });
                    },
                    child: Container(
                      child: file != null
                          ? Image.file(
                              file,
                              height: 100,
                              width: 150,
                            )
                          : widget.product?.image != null
                              ? Image.network(
                                  widget.product.image,
                                  height: 100,
                                  width: 150,
                                )
                              : AddImage(
                                  onPressed: () async {
                                    chooseImage(
                                        context: context,
                                        fn: (val) {
                                          setState(() {
                                            file = val as File;
                                          });
                                        });
                                  },
                                ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormFieldWithTopText(
                          tec: nameTEC,
                          hint: "Enter name",
                          error: "Please enter name",
                          text: "Name",
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormFieldWithTopText(
                          tec: codeTEC,
                          hint: "Enter code",
                          error: "Please enter code",
                          text: "Code",
                          isOptional: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormFieldWithTopText(
                          tec: quantityTEC,
                          hint: "Enter quantity",
                          error: "Please enter quantity",
                          text: "Quantity",
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Category",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.grey[100],
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: category,
                                items: categoriesList?.map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value as String,
                                        child: Text(value as String),
                                      );
                                    })?.toList() ??
                                    [],
                                onChanged: (val) {
                                  setState(() {
                                    category = val;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormFieldWithTopText(
                          tec: mrpTEC,
                          hint: "Enter MRP",
                          error: "Please enter MRP",
                          text: "MRP",
                          isOnlyInt: true,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormFieldWithTopText(
                          tec: sellingTEC,
                          hint: "Enter Selling Price",
                          error: "Please enter selling price",
                          text: "Selling Price",
                          isOnlyInt: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 100,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: descTEC,
                      decoration: Styles.inputDecoration(
                          "Please enter something in detail about product"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonFW(
                    isLoading: state.isLoadingToAddProduct,
                    onPressed: () {
                      saveProduct();
                    },
                    text: isEdit ? "Save" : "Add product",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List getCategoriesList() {
    Map<String, dynamic> map = navigatorKey.currentState.context
        .read<AuthenticationBloc>()
        .state
        .categoriesMap;
    return map[getStoreCategory()] as List;
  }

  void saveProduct() {
    if (formKey.currentState.validate() && category != null) {
      if (widget.product != null) {
        context.read<ProductsBloc>().add(
              ProductsEvent.editProduct(
                product: Product(
                    name: nameTEC.text,
                    code: codeTEC.text,
                    quantity: quantityTEC.text,
                    category: category,
                    mrp: int.parse(mrpTEC.text),
                    sellingPrice: int.parse(sellingTEC.text),
                    desc: descTEC.text,
                    productId: widget.product.productId),
                file: file,
              ),
            );
      } else {
        context.read<ProductsBloc>().add(
              ProductsEvent.addProduct(
                product: Product(
                  name: nameTEC.text,
                  code: codeTEC.text,
                  quantity: quantityTEC.text,
                  category: category,
                  mrp: int.parse(mrpTEC.text),
                  sellingPrice: int.parse(sellingTEC.text),
                  desc: descTEC.text,
                ),
                file: file,
              ),
            );
        widget.updateProductsFn();
        updateUserProductcount(context);
      }
    } else if (category == null) {
      FlushbarHelper.createError(message: "Please select product category")
          .show(context);
    } else {
      FlushbarHelper.createError(message: "Please add product image")
          .show(context);
    }
  }

  void updateUserProductcount(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.storeUser;
    user.store.homeAnalytics.products += 1;
    context.read<AuthenticationBloc>().add(
          AuthenticationEvent.userModified(user: user),
        );
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
