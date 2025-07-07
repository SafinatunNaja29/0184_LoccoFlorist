part of 'produk_bloc.dart';

sealed class ProdukState {}

final class ProdukInitial extends ProdukState {}

final class ProdukLoading extends ProdukState {}

final class ProdukLoaded extends ProdukState {
  final List<ProdukResponseModel> products;

  ProdukLoaded({required this.products});
}

final class ProdukSuccess extends ProdukState {
  final String message;

  ProdukSuccess({required this.message});
}

final class ProdukFailure extends ProdukState {
  final String error;

  ProdukFailure({required this.error});
}
