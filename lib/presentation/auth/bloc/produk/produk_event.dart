part of 'produk_bloc.dart';

sealed class ProdukEvent {}

class GetAllProduk extends ProdukEvent {}

class CreateProduk extends ProdukEvent {
  final ProdukRequestModel produk;
  CreateProduk({required this.produk});
}

class UpdateProduk extends ProdukEvent {
  final int id;
  final ProdukRequestModel produk;
  UpdateProduk({required this.id, required this.produk});
}

class DeleteProduk extends ProdukEvent {
  final int id;
  DeleteProduk({required this.id});
}
