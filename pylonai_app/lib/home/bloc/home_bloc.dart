import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:pylonai_app/sign-up/sign_up.dart';
import 'package:user_repository/user_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const HomeState()) {
    on<HomeNameChanged>(_onNameChanged);
    on<HomeEmailChanged>(_onEmailChanged);
    on<HomePasswordChanged>(_onPasswordChanged);
    on<HomeSelectedUserChanged>(_onSelectedUserChanged);
    on<HomeSubmitted>(_onSubmitted);
  }

  final UserRepository _userRepository;

  void _onNameChanged(
    HomeNameChanged event,
    Emitter<HomeState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([state.password, state.email, name]),
      ),
    );
  }

  void _onEmailChanged(
    HomeEmailChanged event,
    Emitter<HomeState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.name, state.password]),
      ),
    );
  }

  void _onPasswordChanged(
    HomePasswordChanged event,
    Emitter<HomeState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.name, state.email]),
      ),
    );
  }

  void _onSelectedUserChanged(
    HomeSelectedUserChanged event,
    Emitter<HomeState> emit,
  ) {
    emit(
      state.copyWith(selectedUser: event.selectedUser),
    );
  }

  Future<void> _onSubmitted(
    HomeSubmitted event,
    Emitter<HomeState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        Map<String, dynamic> body = {
          'name': state.name.value,
          'email': state.email.value,
          'password': state.password.value
        };
        var userId = state.selectedUser?.id ?? 0;
        var response = await _userRepository.updateUser(userId, body);
        if (response.statusCode == 201) {
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        } else {
          emit(state.copyWith(status: FormzSubmissionStatus.failure));
        }
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
