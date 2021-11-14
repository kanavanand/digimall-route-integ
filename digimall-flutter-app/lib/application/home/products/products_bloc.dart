import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:prachar/domain/core/failure/firebase_failure.dart';
import 'package:prachar/domain/home/product/i_product_repo.dart';
import 'package:prachar/domain/home/product/product.dart';

part 'products_event.dart';
part 'products_state.dart';
part 'products_bloc.freezed.dart';

@injectable
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final IProductRepo iProductRepo;
  ProductsBloc(this.iProductRepo) : super(ProductsState.initial());

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    // TODO: implement mapEventToState
    yield* event.map(
      addProduct: (e) async* {
        yield state.copyWith(
          addProductFailure: none(),
          isLoadingToAddProduct: true,
          deleteProductFailure: none(),
        );

        final opt = await iProductRepo.addProduct(
          product: e.product,
          file: e.file,
        );

        yield state.copyWith(
          addProductFailure: optionOf(opt),
          isLoadingToAddProduct: false,
          deleteProductFailure: none(),
        );
      },
      deleteProduct: (e) async* {
        final opt = await iProductRepo.deleteProduct(productId: e.productId);
        yield state.copyWith(
          addProductFailure: none(),
          deleteProductFailure: optionOf(opt),
        );
      },
      editProduct: (e) async* {
        yield state.copyWith(
          isLoadingToAddProduct: true,
          addProductFailure: none(),
          deleteProductFailure: none(),
        );

        final opt = await iProductRepo.editProduct(
          product: e.product,
          file: e.file,
        );

        yield state.copyWith(
          addProductFailure: optionOf(opt),
          isLoadingToAddProduct: false,
        );
      },
    );
  }
}
