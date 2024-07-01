// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// part 'auth_state.dart';

// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(AuthInitialState());

//   void login(String accessToken, int idUser) {
//     emit(AuthState(isLoggedIn: true, accessToken: accessToken));
//   }

//   void logout() {
//     emit(const AuthState(isLoggedIn: false, accessToken: ""));
//   }
// }


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitialState());

  void login(String accessToken, int idUser, String role) {
    emit(AuthState(
        isLoggedIn: true, accessToken: accessToken, idPengguna: idUser,role:role, isCrt: const []));
  }

  void toggleCrt(String idBarang) {
    final isFavorite = state.isCrt.contains(idBarang);
    final updatedFavorites = List<String>.from(state.isCrt);
    if (isFavorite) {
      updatedFavorites.remove(idBarang);
    } else {
      updatedFavorites.add(idBarang);
    }
    emit(state.copyWith(isCrt: updatedFavorites));
  }

  void logout() {
    emit(const AuthState(isLoggedIn: false, accessToken: "", idPengguna: -1, role: 'biasa', isCrt:[]));
 }
}
