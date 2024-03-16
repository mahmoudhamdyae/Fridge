import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:fridge/auth/domain/usecases/login_usecase.dart';
import 'package:fridge/auth/domain/usecases/sign_out_usecase.dart';
import '../../../core/enums/auth_enums.dart';
import '../../domain/usecases/is_first_entry_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final SignOutUsecase signOutUsecase;
  final IsLoggedInUsecase isLoggedInUsecase;
  final IsFirstEntryUsecase isFirstEntryUsecase;

  AuthBloc(
      this.loginUsecase,
      this.registerUsecase,
      this.signOutUsecase,
      this.isLoggedInUsecase,
      this.isFirstEntryUsecase,
      )
      : super( AuthState.unKnown()) {
    print('============= hahahahahahah');
    on<AppStarted>((event, emit) async {
      await _init(emit);
    });

    on<LoginRequested>((event, emit) async {
        await _login(event, emit);
      },
    );

    on<RegisterRequested>((event, emit) async {
      await _register(event, emit);
    },
    );

    on<SignOutRequested>((event, emit) async {
      await _signOut(emit);
    });
  }

  Future<void> _init(Emitter<AuthState> emit) async {
    try {
      final isFirstEntryResult = isFirstEntryUsecase.call();
      isFirstEntryResult.fold((l) {
        emit( AuthState.error(),);
      }, (bool firstEntry) {
        if (firstEntry) {
          emit( AuthState.firstEntry());
        } else {
          final isLoggedInResult = isLoggedInUsecase.call();
          isLoggedInResult.fold((l) {
            emit( AuthState.error(),);
          }, (bool isUserLoggedIn) {
            if (isUserLoggedIn) {
              emit( AuthState.authenticated());
            } else {
              emit( AuthState.unAuthenticated());
            }
          });
        }
      });
    } on Exception {
      emit( AuthState.error());
    }
  }

  Future<void> _login(LoginRequested event, Emitter<AuthState> emit) async {
    final result = await loginUsecase.call(
        event.phone,
        event.password,
    );
    result.fold((l) {
      emit( AuthState.error(error: AuthError.wrongData));
      print('================ee2 ${state.error}');
    }, (r) {
      emit( AuthState.authenticated());
    });
  }

  Future<void> _register(RegisterRequested event, Emitter<AuthState> emit) async {
    final result = await registerUsecase.call(
        event.name,
        event.phone,
        event.password,
        event.confirmPassword
    );
    result.fold((l) {
      emit( AuthState.error(error: AuthError.wrongData));
    }, (r) {
      emit( AuthState.authenticated());
    });
  }

  Future<void> _signOut(Emitter<AuthState> emit) async {
    try {
      final result = await signOutUsecase.call();
      result.fold((l) {
        emit( AuthState.error());
      }, (r) {
        emit( AuthState.unAuthenticated());
      });
    } catch (_) {
      emit( AuthState.error());
    }
  }
}