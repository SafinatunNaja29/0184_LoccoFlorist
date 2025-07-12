import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loccoproject/data/model/response/pemesanan_response_model.dart';
import 'package:loccoproject/data/repository/pemesanan_repository.dart';

part 'pemesanan_event.dart';
part 'pemesanan_state.dart';

class PemesananBloc extends Bloc<PemesananEvent, PemesananState> {
  final PemesananRepository pemesananRepository;

  PemesananBloc({required this.pemesananRepository}) : super(PemesananInitial()) {
    on<GetAllPemesanan>(_onGetAllPemesanan);
    on<UpdateStatusPemesanan>(_onUpdateStatusPemesanan);
  }

  Future<void> _onGetAllPemesanan(GetAllPemesanan event, Emitter<PemesananState> emit) async {
    emit(PemesananLoading());
    try {
      final pemesananList = await pemesananRepository.fetchAllPemesanan();
      emit(PemesananLoaded(data: pemesananList));
    } catch (e) {
      emit(PemesananError(error: e.toString()));
    }
  }

  Future<void> _onUpdateStatusPemesanan(UpdateStatusPemesanan event, Emitter<PemesananState> emit) async {
  emit(PemesananLoading());
  try {
    await pemesananRepository.updateStatus(
      idPemesanan: event.id,
      status: event.status,
      buktiFoto: event.buktiFoto,
    );
    add(GetAllPemesanan());
  } catch (e) {
    emit(PemesananError(error: e.toString()));
  }
}
}
