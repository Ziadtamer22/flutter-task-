import 'package:eco/features/authentication/data/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final AuthRepository _authService = AuthRepository();

  Future<void> registerWithEmail(String email, String password) async {
    emit(RegisterLoading());
    final result = await _authService.registerWithEmail(email, password);
    result.fold(
      (l) => emit(RegisterFailure(message: l)),
      (r) async {
        ///<--- add user data to firestore --->///
        final result = await _authService.setUser(r);
        result.fold(
          (l) => emit(RegisterFailure(message: l)),
          (r) => emit(RegisterSuccess()),
        );
      },
    );
  }

  Future<void> registerWithGoogle() async {
    emit(RegisterLoading());
    final result = await _authService.loginWithGoogle();
    result.fold(
      (l) => emit(RegisterFailure(message: l)),
      (r) => emit(RegisterSuccess()),
    );
  }
}
