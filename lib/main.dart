import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lens_lend/components/auth_wrapper.dart';
import 'package:lens_lend/cubit/cubit/auth_cubit.dart';
import 'package:lens_lend/cubit/lensauth/cubit/lens_cubit.dart';
import 'package:lens_lend/endpoints/endpoints_lens.dart';
import 'package:lens_lend/screens/home_screen.dart';
import 'package:lens_lend/screens/ip.dart';
import 'package:lens_lend/screens/login_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize URLs before running the app
  try {
    await LensEndpoints.initializeURLs();
  } catch (e) {
    // Handle initialization error if necessary
    // ignore: avoid_print
    print('Failed to initialize URLs: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LensCubit>(create: (context) => LensCubit()),
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
      ],
      child: MaterialApp(
        title: 'LensLend',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,  
        initialRoute: "/intro-screen",
        routes: {
          '/home-screen': (context) => const AuthWrapper(child: HomeScreen()),
          '/intro-screen': (context) => const LoginScreen(),
          '/ip':(context) => const InputIp()
        },
      ),
    );
  }
}
