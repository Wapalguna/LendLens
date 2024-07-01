part of 'auth_cubit.dart';

@immutable
class AuthState {
  final bool isLoggedIn;
  final String accessToken;
  final int idPengguna;
  final String role;
  final List<String> isCrt;

  const AuthState({
    required this.isLoggedIn,
    required this.accessToken,
    required this.idPengguna,
    required this.role,
    required this.isCrt
  });

  AuthState copyWith({
    bool? isLoggeIn,
    String? accessToken,
    int? idPengguna,
    String? role,
    List<String>? isCrt,
  }) {
    return AuthState(
      isLoggedIn: isLoggeIn ?? isLoggedIn,
      accessToken: accessToken ?? this.accessToken,
      idPengguna: idPengguna ?? this.idPengguna,
      role: role ?? this.role,
      isCrt: isCrt ?? this.isCrt,
    );
  }
}

class AuthInitialState extends AuthState {
  const AuthInitialState()
      : super(isLoggedIn: false, accessToken: '', idPengguna: -1, role: 'biasa', isCrt: const []);
      
}