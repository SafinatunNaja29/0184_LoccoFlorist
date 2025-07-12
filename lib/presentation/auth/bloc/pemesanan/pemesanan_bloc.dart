import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loccoproject/data/model/response/pemesanan_response_model.dart';
import 'package:loccoproject/data/repository/pemesanan_repository.dart';

part 'pemesanan_event.dart';
part 'pemesanan_state.dart';

class PemesananBloc extends Bloc<PemesananEvent, PemesananState> {
  final PemesananRepository pemesananRepository;

  PemesananBloc({required this.pemesananRepository}) : super(PemesananInitial()) {
    on<GetAllPemesanan>(_onGetAllPemesanan);
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


}
