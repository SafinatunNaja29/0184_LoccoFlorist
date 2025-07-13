import 'package:bloc/bloc.dart';
import 'package:loccoproject/data/model/kategori_model.dart';
import 'package:loccoproject/data/repository/kategori_repository.dart';

part 'kategori_event.dart';
part 'kategori_state.dart';

class KategoriBloc extends Bloc<KategoriEvent, KategoriState> {
  final KategoriRepository kategoriRepository;

  KategoriBloc({required this.kategoriRepository}) : super(KategoriInitial()) {
    on<LoadKategoriEvent>(_onLoadKategori);
    on<CreateKategoriEvent>(_onCreateKategori);
    on<UpdateKategoriEvent>(_onUpdateKategori);
    on<DeleteKategoriEvent>(_onDeleteKategori);
  }

  Future<void> _onLoadKategori(
      LoadKategoriEvent event, Emitter<KategoriState> emit) async {
    emit(KategoriLoading());
    final result = await kategoriRepository.getAllKategori();
    result.fold(
      (error) => emit(KategoriFailure(error: error)),
      (data) => emit(KategoriLoaded(listKategori: data)),
    );
  }

  Future<void> _onCreateKategori(
      CreateKategoriEvent event, Emitter<KategoriState> emit) async {
    emit(KategoriLoading());
    final result = await kategoriRepository.createKategori(event.namaKategori);
    result.fold(
      (error) => emit(KategoriFailure(error: error)),
      (success) => emit(KategoriSuccess(message: success)),
    );
    add(LoadKategoriEvent()); 
  }

  Future<void> _onUpdateKategori(
      UpdateKategoriEvent event, Emitter<KategoriState> emit) async {
    emit(KategoriLoading());
    final result = await kategoriRepository.updateKategori(event.id, event.namaKategori);
    result.fold(
      (error) => emit(KategoriFailure(error: error)),
      (success) => emit(KategoriSuccess(message: success)),
    );
    add(LoadKategoriEvent());
  }

  Future<void> _onDeleteKategori(
      DeleteKategoriEvent event, Emitter<KategoriState> emit) async {
    emit(KategoriLoading());
    final result = await kategoriRepository.deleteKategori(event.id);
    result.fold(
      (error) => emit(KategoriFailure(error: error)),
      (success) => emit(KategoriSuccess(message: success)),
    );
    add(LoadKategoriEvent());
  }
}
