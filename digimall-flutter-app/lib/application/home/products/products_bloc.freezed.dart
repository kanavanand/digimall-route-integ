// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'products_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ProductsEventTearOff {
  const _$ProductsEventTearOff();

// ignore: unused_element
  _AddProduct addProduct({@required Product product, File file}) {
    return _AddProduct(
      product: product,
      file: file,
    );
  }

// ignore: unused_element
  _EditProduct editProduct({@required Product product, File file}) {
    return _EditProduct(
      product: product,
      file: file,
    );
  }

// ignore: unused_element
  _DeleteProduct deleteProduct({@required String productId}) {
    return _DeleteProduct(
      productId: productId,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ProductsEvent = _$ProductsEventTearOff();

/// @nodoc
mixin _$ProductsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult addProduct(Product product, File file),
    @required TResult editProduct(Product product, File file),
    @required TResult deleteProduct(String productId),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult addProduct(Product product, File file),
    TResult editProduct(Product product, File file),
    TResult deleteProduct(String productId),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult addProduct(_AddProduct value),
    @required TResult editProduct(_EditProduct value),
    @required TResult deleteProduct(_DeleteProduct value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult addProduct(_AddProduct value),
    TResult editProduct(_EditProduct value),
    TResult deleteProduct(_DeleteProduct value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $ProductsEventCopyWith<$Res> {
  factory $ProductsEventCopyWith(
          ProductsEvent value, $Res Function(ProductsEvent) then) =
      _$ProductsEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ProductsEventCopyWithImpl<$Res>
    implements $ProductsEventCopyWith<$Res> {
  _$ProductsEventCopyWithImpl(this._value, this._then);

  final ProductsEvent _value;
  // ignore: unused_field
  final $Res Function(ProductsEvent) _then;
}

/// @nodoc
abstract class _$AddProductCopyWith<$Res> {
  factory _$AddProductCopyWith(
          _AddProduct value, $Res Function(_AddProduct) then) =
      __$AddProductCopyWithImpl<$Res>;
  $Res call({Product product, File file});
}

/// @nodoc
class __$AddProductCopyWithImpl<$Res> extends _$ProductsEventCopyWithImpl<$Res>
    implements _$AddProductCopyWith<$Res> {
  __$AddProductCopyWithImpl(
      _AddProduct _value, $Res Function(_AddProduct) _then)
      : super(_value, (v) => _then(v as _AddProduct));

  @override
  _AddProduct get _value => super._value as _AddProduct;

  @override
  $Res call({
    Object product = freezed,
    Object file = freezed,
  }) {
    return _then(_AddProduct(
      product: product == freezed ? _value.product : product as Product,
      file: file == freezed ? _value.file : file as File,
    ));
  }
}

/// @nodoc
class _$_AddProduct implements _AddProduct {
  const _$_AddProduct({@required this.product, this.file})
      : assert(product != null);

  @override
  final Product product;
  @override
  final File file;

  @override
  String toString() {
    return 'ProductsEvent.addProduct(product: $product, file: $file)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AddProduct &&
            (identical(other.product, product) ||
                const DeepCollectionEquality()
                    .equals(other.product, product)) &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(product) ^
      const DeepCollectionEquality().hash(file);

  @JsonKey(ignore: true)
  @override
  _$AddProductCopyWith<_AddProduct> get copyWith =>
      __$AddProductCopyWithImpl<_AddProduct>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult addProduct(Product product, File file),
    @required TResult editProduct(Product product, File file),
    @required TResult deleteProduct(String productId),
  }) {
    assert(addProduct != null);
    assert(editProduct != null);
    assert(deleteProduct != null);
    return addProduct(product, file);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult addProduct(Product product, File file),
    TResult editProduct(Product product, File file),
    TResult deleteProduct(String productId),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (addProduct != null) {
      return addProduct(product, file);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult addProduct(_AddProduct value),
    @required TResult editProduct(_EditProduct value),
    @required TResult deleteProduct(_DeleteProduct value),
  }) {
    assert(addProduct != null);
    assert(editProduct != null);
    assert(deleteProduct != null);
    return addProduct(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult addProduct(_AddProduct value),
    TResult editProduct(_EditProduct value),
    TResult deleteProduct(_DeleteProduct value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (addProduct != null) {
      return addProduct(this);
    }
    return orElse();
  }
}

abstract class _AddProduct implements ProductsEvent {
  const factory _AddProduct({@required Product product, File file}) =
      _$_AddProduct;

  Product get product;
  File get file;
  @JsonKey(ignore: true)
  _$AddProductCopyWith<_AddProduct> get copyWith;
}

/// @nodoc
abstract class _$EditProductCopyWith<$Res> {
  factory _$EditProductCopyWith(
          _EditProduct value, $Res Function(_EditProduct) then) =
      __$EditProductCopyWithImpl<$Res>;
  $Res call({Product product, File file});
}

/// @nodoc
class __$EditProductCopyWithImpl<$Res> extends _$ProductsEventCopyWithImpl<$Res>
    implements _$EditProductCopyWith<$Res> {
  __$EditProductCopyWithImpl(
      _EditProduct _value, $Res Function(_EditProduct) _then)
      : super(_value, (v) => _then(v as _EditProduct));

  @override
  _EditProduct get _value => super._value as _EditProduct;

  @override
  $Res call({
    Object product = freezed,
    Object file = freezed,
  }) {
    return _then(_EditProduct(
      product: product == freezed ? _value.product : product as Product,
      file: file == freezed ? _value.file : file as File,
    ));
  }
}

/// @nodoc
class _$_EditProduct implements _EditProduct {
  const _$_EditProduct({@required this.product, this.file})
      : assert(product != null);

  @override
  final Product product;
  @override
  final File file;

  @override
  String toString() {
    return 'ProductsEvent.editProduct(product: $product, file: $file)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EditProduct &&
            (identical(other.product, product) ||
                const DeepCollectionEquality()
                    .equals(other.product, product)) &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(product) ^
      const DeepCollectionEquality().hash(file);

  @JsonKey(ignore: true)
  @override
  _$EditProductCopyWith<_EditProduct> get copyWith =>
      __$EditProductCopyWithImpl<_EditProduct>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult addProduct(Product product, File file),
    @required TResult editProduct(Product product, File file),
    @required TResult deleteProduct(String productId),
  }) {
    assert(addProduct != null);
    assert(editProduct != null);
    assert(deleteProduct != null);
    return editProduct(product, file);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult addProduct(Product product, File file),
    TResult editProduct(Product product, File file),
    TResult deleteProduct(String productId),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (editProduct != null) {
      return editProduct(product, file);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult addProduct(_AddProduct value),
    @required TResult editProduct(_EditProduct value),
    @required TResult deleteProduct(_DeleteProduct value),
  }) {
    assert(addProduct != null);
    assert(editProduct != null);
    assert(deleteProduct != null);
    return editProduct(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult addProduct(_AddProduct value),
    TResult editProduct(_EditProduct value),
    TResult deleteProduct(_DeleteProduct value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (editProduct != null) {
      return editProduct(this);
    }
    return orElse();
  }
}

abstract class _EditProduct implements ProductsEvent {
  const factory _EditProduct({@required Product product, File file}) =
      _$_EditProduct;

  Product get product;
  File get file;
  @JsonKey(ignore: true)
  _$EditProductCopyWith<_EditProduct> get copyWith;
}

/// @nodoc
abstract class _$DeleteProductCopyWith<$Res> {
  factory _$DeleteProductCopyWith(
          _DeleteProduct value, $Res Function(_DeleteProduct) then) =
      __$DeleteProductCopyWithImpl<$Res>;
  $Res call({String productId});
}

/// @nodoc
class __$DeleteProductCopyWithImpl<$Res>
    extends _$ProductsEventCopyWithImpl<$Res>
    implements _$DeleteProductCopyWith<$Res> {
  __$DeleteProductCopyWithImpl(
      _DeleteProduct _value, $Res Function(_DeleteProduct) _then)
      : super(_value, (v) => _then(v as _DeleteProduct));

  @override
  _DeleteProduct get _value => super._value as _DeleteProduct;

  @override
  $Res call({
    Object productId = freezed,
  }) {
    return _then(_DeleteProduct(
      productId: productId == freezed ? _value.productId : productId as String,
    ));
  }
}

/// @nodoc
class _$_DeleteProduct implements _DeleteProduct {
  const _$_DeleteProduct({@required this.productId})
      : assert(productId != null);

  @override
  final String productId;

  @override
  String toString() {
    return 'ProductsEvent.deleteProduct(productId: $productId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DeleteProduct &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality()
                    .equals(other.productId, productId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(productId);

  @JsonKey(ignore: true)
  @override
  _$DeleteProductCopyWith<_DeleteProduct> get copyWith =>
      __$DeleteProductCopyWithImpl<_DeleteProduct>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult addProduct(Product product, File file),
    @required TResult editProduct(Product product, File file),
    @required TResult deleteProduct(String productId),
  }) {
    assert(addProduct != null);
    assert(editProduct != null);
    assert(deleteProduct != null);
    return deleteProduct(productId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult addProduct(Product product, File file),
    TResult editProduct(Product product, File file),
    TResult deleteProduct(String productId),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (deleteProduct != null) {
      return deleteProduct(productId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult addProduct(_AddProduct value),
    @required TResult editProduct(_EditProduct value),
    @required TResult deleteProduct(_DeleteProduct value),
  }) {
    assert(addProduct != null);
    assert(editProduct != null);
    assert(deleteProduct != null);
    return deleteProduct(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult addProduct(_AddProduct value),
    TResult editProduct(_EditProduct value),
    TResult deleteProduct(_DeleteProduct value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (deleteProduct != null) {
      return deleteProduct(this);
    }
    return orElse();
  }
}

abstract class _DeleteProduct implements ProductsEvent {
  const factory _DeleteProduct({@required String productId}) = _$_DeleteProduct;

  String get productId;
  @JsonKey(ignore: true)
  _$DeleteProductCopyWith<_DeleteProduct> get copyWith;
}

/// @nodoc
class _$ProductsStateTearOff {
  const _$ProductsStateTearOff();

// ignore: unused_element
  _ProductsState call(
      {@required Option<Either<FirebaseFailure, Unit>> addProductFailure,
      @required Option<Either<FirebaseFailure, Unit>> deleteProductFailure,
      @required bool isLoadingToAddProduct}) {
    return _ProductsState(
      addProductFailure: addProductFailure,
      deleteProductFailure: deleteProductFailure,
      isLoadingToAddProduct: isLoadingToAddProduct,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ProductsState = _$ProductsStateTearOff();

/// @nodoc
mixin _$ProductsState {
  Option<Either<FirebaseFailure, Unit>> get addProductFailure;
  Option<Either<FirebaseFailure, Unit>> get deleteProductFailure;
  bool get isLoadingToAddProduct;

  @JsonKey(ignore: true)
  $ProductsStateCopyWith<ProductsState> get copyWith;
}

/// @nodoc
abstract class $ProductsStateCopyWith<$Res> {
  factory $ProductsStateCopyWith(
          ProductsState value, $Res Function(ProductsState) then) =
      _$ProductsStateCopyWithImpl<$Res>;
  $Res call(
      {Option<Either<FirebaseFailure, Unit>> addProductFailure,
      Option<Either<FirebaseFailure, Unit>> deleteProductFailure,
      bool isLoadingToAddProduct});
}

/// @nodoc
class _$ProductsStateCopyWithImpl<$Res>
    implements $ProductsStateCopyWith<$Res> {
  _$ProductsStateCopyWithImpl(this._value, this._then);

  final ProductsState _value;
  // ignore: unused_field
  final $Res Function(ProductsState) _then;

  @override
  $Res call({
    Object addProductFailure = freezed,
    Object deleteProductFailure = freezed,
    Object isLoadingToAddProduct = freezed,
  }) {
    return _then(_value.copyWith(
      addProductFailure: addProductFailure == freezed
          ? _value.addProductFailure
          : addProductFailure as Option<Either<FirebaseFailure, Unit>>,
      deleteProductFailure: deleteProductFailure == freezed
          ? _value.deleteProductFailure
          : deleteProductFailure as Option<Either<FirebaseFailure, Unit>>,
      isLoadingToAddProduct: isLoadingToAddProduct == freezed
          ? _value.isLoadingToAddProduct
          : isLoadingToAddProduct as bool,
    ));
  }
}

/// @nodoc
abstract class _$ProductsStateCopyWith<$Res>
    implements $ProductsStateCopyWith<$Res> {
  factory _$ProductsStateCopyWith(
          _ProductsState value, $Res Function(_ProductsState) then) =
      __$ProductsStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {Option<Either<FirebaseFailure, Unit>> addProductFailure,
      Option<Either<FirebaseFailure, Unit>> deleteProductFailure,
      bool isLoadingToAddProduct});
}

/// @nodoc
class __$ProductsStateCopyWithImpl<$Res>
    extends _$ProductsStateCopyWithImpl<$Res>
    implements _$ProductsStateCopyWith<$Res> {
  __$ProductsStateCopyWithImpl(
      _ProductsState _value, $Res Function(_ProductsState) _then)
      : super(_value, (v) => _then(v as _ProductsState));

  @override
  _ProductsState get _value => super._value as _ProductsState;

  @override
  $Res call({
    Object addProductFailure = freezed,
    Object deleteProductFailure = freezed,
    Object isLoadingToAddProduct = freezed,
  }) {
    return _then(_ProductsState(
      addProductFailure: addProductFailure == freezed
          ? _value.addProductFailure
          : addProductFailure as Option<Either<FirebaseFailure, Unit>>,
      deleteProductFailure: deleteProductFailure == freezed
          ? _value.deleteProductFailure
          : deleteProductFailure as Option<Either<FirebaseFailure, Unit>>,
      isLoadingToAddProduct: isLoadingToAddProduct == freezed
          ? _value.isLoadingToAddProduct
          : isLoadingToAddProduct as bool,
    ));
  }
}

/// @nodoc
class _$_ProductsState implements _ProductsState {
  const _$_ProductsState(
      {@required this.addProductFailure,
      @required this.deleteProductFailure,
      @required this.isLoadingToAddProduct})
      : assert(addProductFailure != null),
        assert(deleteProductFailure != null),
        assert(isLoadingToAddProduct != null);

  @override
  final Option<Either<FirebaseFailure, Unit>> addProductFailure;
  @override
  final Option<Either<FirebaseFailure, Unit>> deleteProductFailure;
  @override
  final bool isLoadingToAddProduct;

  @override
  String toString() {
    return 'ProductsState(addProductFailure: $addProductFailure, deleteProductFailure: $deleteProductFailure, isLoadingToAddProduct: $isLoadingToAddProduct)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ProductsState &&
            (identical(other.addProductFailure, addProductFailure) ||
                const DeepCollectionEquality()
                    .equals(other.addProductFailure, addProductFailure)) &&
            (identical(other.deleteProductFailure, deleteProductFailure) ||
                const DeepCollectionEquality().equals(
                    other.deleteProductFailure, deleteProductFailure)) &&
            (identical(other.isLoadingToAddProduct, isLoadingToAddProduct) ||
                const DeepCollectionEquality().equals(
                    other.isLoadingToAddProduct, isLoadingToAddProduct)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(addProductFailure) ^
      const DeepCollectionEquality().hash(deleteProductFailure) ^
      const DeepCollectionEquality().hash(isLoadingToAddProduct);

  @JsonKey(ignore: true)
  @override
  _$ProductsStateCopyWith<_ProductsState> get copyWith =>
      __$ProductsStateCopyWithImpl<_ProductsState>(this, _$identity);
}

abstract class _ProductsState implements ProductsState {
  const factory _ProductsState(
      {@required Option<Either<FirebaseFailure, Unit>> addProductFailure,
      @required Option<Either<FirebaseFailure, Unit>> deleteProductFailure,
      @required bool isLoadingToAddProduct}) = _$_ProductsState;

  @override
  Option<Either<FirebaseFailure, Unit>> get addProductFailure;
  @override
  Option<Either<FirebaseFailure, Unit>> get deleteProductFailure;
  @override
  bool get isLoadingToAddProduct;
  @override
  @JsonKey(ignore: true)
  _$ProductsStateCopyWith<_ProductsState> get copyWith;
}
