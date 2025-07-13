part of 'kategori_bloc.dart';

sealed class KategoriState {}

final class KategoriInitial extends KategoriState {}

final class KategoriLoading extends KategoriState {}

final class KategoriLoaded extends KategoriState {
  final List<Kategori> listKategori;

  KategoriLoaded({required this.listKategori});
}

final class KategoriSuccess extends KategoriState {
  final String message;

  KategoriSuccess({required this.message});
}

final class KategoriFailure extends KategoriState {
  final String error;

  KategoriFailure({required this.error});
}
