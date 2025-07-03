import 'package:bloc/bloc.dart';
import 'package:loccoproject/data/model/request/register_request_model.dart';
import 'package:loccoproject/data/repository/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc({required this.authRepository}) : super(RegisterInitial()) {
    on<RegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());

    final result = await authRepository.register(event.requestModel);

    result.fold(
      (failure) => emit(RegisterFailure(error: failure)),
      (message) => emit(RegisterSuccess(message: message)),
    );
  }
}
