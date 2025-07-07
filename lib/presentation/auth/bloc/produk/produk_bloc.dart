import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loccoproject/data/model/request/produk_request_model.dart';
import 'package:loccoproject/data/model/response/produk_response_model.dart';
import 'package:loccoproject/data/repository/produk_repository.dart';

part 'produk_event.dart';
part 'produk_state.dart';

class ProdukBloc extends Bloc<ProdukEvent, ProdukState> {
  final ProdukRepository produkRepository;

  ProdukBloc({required this.produkRepository}) : super(ProdukInitial()) {
    on<GetAllProduk>(_onGetAllProduk);
    on<CreateProduk>(_onCreateProduk);
    on<UpdateProduk>(_onUpdateProduk);
    on<DeleteProduk>(_onDeleteProduk);
  }

  Future<void> _onGetAllProduk(
    GetAllProduk event,
    Emitter<ProdukState> emit,
  ) async {
    emit(ProdukLoading());

    final result = await produkRepository.getAllProduk();

    result.fold(
      (error) => emit(ProdukFailure(error: error)),
      (produkList) {
        final responseList = produkList
            .map((produk) => ProdukResponseModel.fromProduk(produk))
            .toList();
        emit(ProdukLoaded(products: responseList));
      },
    );
  }

  Future<void> _onCreateProduk(
    CreateProduk event,
    Emitter<ProdukState> emit,
  ) async {
    emit(ProdukLoading());

    final result = await produkRepository.createProduk(event.produk);

    result.fold(
      (error) => emit(ProdukFailure(error: error)),
      (message) => emit(ProdukSuccess(message: message)),
    );
  }

  Future<void> _onUpdateProduk(
    UpdateProduk event,
    Emitter<ProdukState> emit,
  ) async {
    emit(ProdukLoading());

    final result =
        await produkRepository.updateProduk(event.id, event.produk);

    result.fold(
      (error) => emit(ProdukFailure(error: error)),
      (message) => emit(ProdukSuccess(message: message)),
    );
  }

  Future<void> _onDeleteProduk(
    DeleteProduk event,
    Emitter<ProdukState> emit,
  ) async {
    emit(ProdukLoading());

    final result = await produkRepository.deleteProduk(event.id);

    result.fold(
      (error) => emit(ProdukFailure(error: error)),
      (message) => emit(ProdukSuccess(message: message)),
    );
  }
}
