import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lens_lend/cubit/cubit/auth_cubit.dart';
import 'package:lens_lend/screens/constants.dart';
import 'package:lens_lend/screens/login_screen.dart';
import 'package:lens_lend/screens/secure_storage_util.dart';

class AuthWrapper extends StatelessWidget {
  final Widget child;
  const AuthWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return FutureBuilder<String?>(
      future: _getAccessTokenFromSecureStorage(),
      builder: (context, snapshot) {
        final storedAccessToken = snapshot.data;

        if (snapshot.connectionState == ConnectionState.done) {
          if (storedAccessToken != null &&
              storedAccessToken == authCubit.state.accessToken) {
            return child; 
          } else {
            return const LoginScreen(); 
          }
        } else {
          
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<String?> _getAccessTokenFromSecureStorage() async {
    try {
      final accessToken =
          await SecureStorageUtil.storage.read(key: tokenStoreName);
      return accessToken;
    } catch (e) {
      
      debugPrint('Error while retrieving access token: $e');
      return null;
    }
  }
}
