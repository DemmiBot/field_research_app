import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
part 'sign_in_bloc_event.dart';
part 'sign_in_bloc_state.dart';

class SignInBloc extends Bloc<ISignInBlocEvent, ISignInState> {
  final IUserRepository _userRepository;

  //state inital in constructor
  SignInBloc({required IUserRepository userRepository})
      : _userRepository = userRepository,
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
              typeUser: getTypeUser(success['typeUser']),
              userId: success['userId']),
        ),
      );
    });
    //trigger logOut event
    on<SignOutRequired>((event, emit) async {
      await _userRepository.logOut();
    });
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
