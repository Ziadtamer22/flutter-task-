import 'package:bloc/bloc.dart';
import 'package:eco/features/authentication/data/repo/auth_repo.dart';
import 'package:equatable/equatable.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit() : super(LogOutInitial());
  Future<void> logout() async {
    AuthRepository authRepository = AuthRepository();
    emit(LogOutLoading());
    final result = await authRepository.signOut();

    result.fold(
      (failure) => emit(LogOutFailure(message: failure)),
      (_) => emit(LogOutSuccess()),
    );
  }
}
