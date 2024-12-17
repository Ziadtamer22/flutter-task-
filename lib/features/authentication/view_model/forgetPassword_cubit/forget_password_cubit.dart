import 'package:eco/features/authentication/data/repo/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  Future<void> forgetPassword(String email) async {
    AuthRepository authRepository = AuthRepository();
    emit(ForgetPasswordLoading());
    final result = await authRepository.resetPassword(email);
    result.fold(
      (l) => emit(ForgetPasswordError(error: l)),
      (r) => emit(ForgetPasswordSuccess()),
    );
  }
}
