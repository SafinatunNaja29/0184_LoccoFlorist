part of 'kategori_bloc.dart';

abstract class KategoriEvent {}

class LoadKategoriEvent extends KategoriEvent {}

class CreateKategoriEvent extends KategoriEvent {
  final String namaKategori;

  CreateKategoriEvent({required this.namaKategori});
}

class UpdateKategoriEvent extends KategoriEvent {
  final int id;
  final String namaKategori;

  UpdateKategoriEvent({required this.id, required this.namaKategori});
}

class DeleteKategoriEvent extends KategoriEvent {
  final int id;

  DeleteKategoriEvent({required this.id});
}