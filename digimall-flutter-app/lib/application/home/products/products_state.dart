part of 'products_bloc.dart';

@freezed
abstract class ProductsState with _$ProductsState {
  const factory ProductsState({
    @required Option<Either<FirebaseFailure, Unit>> addProductFailure,
    @required Option<Either<FirebaseFailure, Unit>> deleteProductFailure,
    @required bool isLoadingToAddProduct,
  }) = _ProductsState;

  factory ProductsState.initial() => ProductsState(
        addProductFailure: none(),
        isLoadingToAddProduct: false,
        deleteProductFailure: none(),
      );
}
