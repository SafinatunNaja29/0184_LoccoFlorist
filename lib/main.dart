import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loccoproject/data/repository/auth_repository.dart';
import 'package:loccoproject/presentation/auth/bloc/login/login_bloc.dart';
import 'package:loccoproject/presentation/auth/bloc/register/register_bloc.dart';
import 'package:loccoproject/presentation/auth/bloc/login_screen.dart';
import 'package:loccoproject/service/service_http_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceHttpClient = ServiceHttpClient();
    final authRepository = AuthRepository(serviceHttpClient);

    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(authRepository: authRepository),
        ),
        BlocProvider<RegisterBloc>(
          create: (_) => RegisterBloc(authRepository: authRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Locco Project',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
