import 'package:bloc/bloc.dart';
import 'package:loccoproject/data/model/request/login_request_model.dart';
import 'package:loccoproject/data/model/response/auth_response_model.dart';
import 'package:loccoproject/data/repository/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    final result = await authRepository.login(event.requestModel);

    result.fold(
      (failure) => emit(LoginFailure(error: failure)),
      (response) => emit(LoginSuccess(responseModel: response)),
    );
  }
}
