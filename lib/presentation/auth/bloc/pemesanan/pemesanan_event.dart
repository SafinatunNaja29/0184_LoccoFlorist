part of 'pemesanan_bloc.dart';

sealed class PemesananEvent {}

class GetAllPemesanan extends PemesananEvent {}

class GetRiwayatPemesanan extends PemesananEvent {}

class UpdateStatusPemesanan extends PemesananEvent {
  final int id;
  final String status;
  final String? buktiFoto;

  UpdateStatusPemesanan({
    required this.id,
    required this.status,
    this.buktiFoto,
  });
}
