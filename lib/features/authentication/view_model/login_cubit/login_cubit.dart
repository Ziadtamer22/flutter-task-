import 'package:eco/features/authentication/data/repo/auth_repo.dart';
import 'package:eco/features/authentication/data/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final AuthRepository _authRepo = AuthRepository();

  Future<void> loginWithEmail(String email, String password) async {
    emit(LoginLoading());

    ///<---- Login user with email ---->
    final result = await _authRepo.loginWithEmail(email, password);
    result.fold(
      ///<---- Login error ---->
      (l) => emit(LoginError(error: l)),

      ///<---- Login success ---->
      (user) async {
        ///<---- Get current user ---->
        await _getCurrentUser(user.uid);
      },
    );
  }

  Future<void> loginWithGoogle() async {
    emit(LoginLoading());

    ///<---- Login user with email ---->
    final result = await _authRepo.loginWithGoogle();
    result.fold(
      ///<---- Login error ---->
      (l) => emit(LoginError(error: l)),
      (user) async {
        await _getCurrentUser(user.uid);
      },
    );
  }

  Future<void> _getCurrentUser(String uid) async {
    ///<---- Login success ---->
    ///<---- Get current user ---->
    print("Get current user: $uid");
    final currentUser = await _authRepo.getCurrentUser(uid);
    currentUser.fold(
      ///<---- Get current user error ---->
      (l) => emit(LoginError(error: l)),

      ///<---- Get current user success ---->
      (currentUser) => emit(LoginSuccess(user: currentUser)),
    );
  }
}
