part of 'pemesanan_bloc.dart';

sealed class PemesananState {}

class PemesananInitial extends PemesananState {}

class PemesananLoading extends PemesananState {}

class PemesananLoaded extends PemesananState {
  final List<PemesananResponseModel> data;

  PemesananLoaded({required this.data});
}

class PemesananFailure extends PemesananState {
  final String error;

  PemesananFailure({required this.error});
}

class PemesananStatusUpdated extends PemesananState {
  final String message;

  PemesananStatusUpdated({required this.message});
}

class PemesananError extends PemesananState {
  final String error;
  PemesananError({required this.error});
}
