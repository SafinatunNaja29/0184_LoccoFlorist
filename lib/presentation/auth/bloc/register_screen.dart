import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:loccoproject/core/constants/colors.dart';
import 'package:loccoproject/core/components/custom_text_field.dart';
import 'package:loccoproject/core/components/buttons.dart';
import 'package:loccoproject/core/components/spaces.dart';
import 'package:loccoproject/core/extentions/build_context_ext.dart';
import 'package:loccoproject/data/model/request/register_request_model.dart';
import 'package:loccoproject/presentation/auth/bloc/register/register_bloc.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController namaController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> _key;
  bool isShowPassword = false;

  @override
  void initState() {
    namaController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _key = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SpaceHeight(80),
                Image.asset(
                  'assets/images/logo.png',
                  height: 100,
                ),
                const SpaceHeight(10),
                Text(
                  'Daftar Akun Baru',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.deviceWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: AppColors.tosca,
                    letterSpacing: 1.2,
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SpaceHeight(16),
                CustomTextField(
                  validator: 'Nama tidak boleh kosong',
                  controller: namaController,
                  label: 'Nama',
                  hintText: 'Masukkan nama Anda',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.person),
                  ),
                ),
                const SpaceHeight(25),
                CustomTextField(
                  validator: 'Email tidak boleh kosong',
                  controller: emailController,
                  label: 'Email',
                  hintText: 'Masukkan email Anda',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.email),
                  ),
                ),
                const SpaceHeight(25),
                CustomTextField(
                  validator: 'Password tidak boleh kosong',
                  controller: passwordController,
                  label: 'Password',
                  hintText: 'Masukkan password Anda',
                  obscureText: !isShowPassword,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.lock),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    icon: Icon(
                      isShowPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.grey,
                    ),
                  ),
                ),
                const SpaceHeight(30),
                BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
                      context.pushAndRemoveUntil(
                        const LoginScreen(),
                        (route) => false,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: AppColors.white,
                        ),
                      );
                    } else if (state is RegisterFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                          backgroundColor: AppColors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return AppButton.filled(
                      onPressed: state is RegisterLoading
                          ? null
                          : () {
                              if (_key.currentState!.validate()) {
                                final request = RegisterRequestModel(
                                  namaUser: namaController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  idRole: 2,
                                );
                                context.read<RegisterBloc>().add(
                                  RegisterRequested(requestModel: request),
                                );
                              }
                            },
                      label: state is RegisterLoading ? 'Memuat...' : 'Daftar',
                      color: AppColors.purple,
                    );
                  },
                ),
                const SpaceHeight(20),
                Text.rich(
                  TextSpan(
                    text: 'Sudah punya akun? ',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: context.deviceWidth * 0.035,
                    ),
                    children: [
                      TextSpan(
                        text: 'Login di sini!',
                        style: TextStyle(color: AppColors.pinkFanta),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.pushAndRemoveUntil(
                              const LoginScreen(),
                              (route) => false,
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
