part of 'lens_cubit.dart';

@immutable
 class LensState {
  
  final bool isLoggedIn;
  final String? accesToken;
  const LensState({required this.isLoggedIn, this.accesToken});
 }

final class LensInitial extends LensState {
  
  const LensInitial() : super(isLoggedIn: true, accesToken: "");
}
