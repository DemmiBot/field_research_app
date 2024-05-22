import 'package:app_repositories/app_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<ISignInBlocEvent, ISignInState> {
  final IUserRepository _userRepository;

  final IStorageRepository _storage;

  final IBiometricRepository _biometric;

  //state inital in constructor
  SignInBloc(
      {required IStorageRepository storage,
      required biometric,
      required IUserRepository userRepository})
      : _userRepository = userRepository,
        _biometric = biometric,
        _storage = storage,
        super(SignInInitial()) {
    //trigger signIn event
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess());

      final response = await _userRepository.signIn(
          login: event.email, password: event.password);

      response.fold(
        (failure) => emit(
          SignInFailure(message: failure.message),
        ),
        (success) => emit(
          SignInSuccess(
              currentUser: success, typeUser: getTypeUser(success.adm!)),
        ),
      );
    });

    //trigger logOut event
    on<SignOutRequired>((event, emit) async {
      await _userRepository.logOut();
    });

    on<SignInBiometricRequired>(
      (event, emit) async {
        final List<String?> login = await _storage.login;

        _biometric.authenticate(
          () async {
            emit(SignInProcess());
            final response = await _userRepository.signIn(
              login: login[0]!,
              password: login[1]!,
            );

            response.fold(
              (failure) => emit(
                SignInFailure(message: failure.message),
              ),
              (success) => emit(
                SignInSuccess(
                    currentUser: success, typeUser: getTypeUser(success.adm!)),
              ),
            );
          },
        );
      },
    );
  }

  TypeUser getTypeUser(String response) {
    switch (response) {
      case 'USER':
        return TypeUser.user;
      case 'ADMIN':
        return TypeUser.admin;
      default:
        return TypeUser.user;
    }
  }
}
