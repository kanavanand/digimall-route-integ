part of 'products_bloc.dart';

@freezed
abstract class ProductsEvent with _$ProductsEvent {
  const factory ProductsEvent.addProduct({
    @required Product product,
    File file,
  }) = _AddProduct;

  const factory ProductsEvent.editProduct({
    @required Product product,
    File file,
  }) = _EditProduct;

  const factory ProductsEvent.deleteProduct({
    @required String productId,
  }) = _DeleteProduct;
}
