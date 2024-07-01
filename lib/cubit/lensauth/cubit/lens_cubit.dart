// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'lens_state.dart';

class LensCubit extends Cubit<LensState> {
  LensCubit() : super(const LensInitial());
  
  void login(String accesToken) {
    emit(LensState(isLoggedIn: true, accesToken: accesToken));
  }

  void logout() {
    emit(const LensState(isLoggedIn: false, accesToken: ""));
  }
}
