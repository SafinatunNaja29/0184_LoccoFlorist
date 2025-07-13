import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/gestures.dart';

import 'package:loccoproject/core/extentions/build_context_ext.dart';
import 'package:loccoproject/core/components/custom_text_field.dart';
import 'package:loccoproject/core/components/buttons.dart';
import 'package:loccoproject/core/components/spaces.dart';
import 'package:loccoproject/core/constants/colors.dart';
import 'package:loccoproject/data/model/request/login_request_model.dart';
import 'package:loccoproject/presentation/auth/bloc/login/login_bloc.dart';
import 'package:loccoproject/presentation/admin/admin_home_screen.dart';
import 'package:loccoproject/presentation/customer/customer_home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> _formKey;
  bool isShowPassword = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                  'Tentukan bunga untuk moment terindahmu',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.deviceWidth * 0.03,
                    fontWeight: FontWeight.w500,
                    color: AppColors.tosca,
                    fontStyle: FontStyle.italic,  
                    letterSpacing: 1.2,                   
                    height: 1.4,                          
                    fontFamily: 'Montserrat',           
                  ),
                ),
                const SpaceHeight(16),
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
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    } else if (state is LoginSuccess) {
                      final role = state.responseModel.user?.role?.toLowerCase();
                      if (role == 'admin') {
                        context.pushAndRemoveUntil(
                          const AdminHomeScreen(),
                          (route) => false,
                        );
                      } else if (role == 'customer') {
                        context.pushAndRemoveUntil(
                          const CustomerHomeScreen(),
                          (route) => false,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Role tidak dikenali')),
                        );
                      }
                    }
                  },
                  builder: (context, state) {
                    return AppButton.filled(
                      onPressed: state is LoginLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                final request = LoginRequestModel(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                context.read<LoginBloc>().add(
                                  LoginRequested(requestModel: request),
                                );
                              }
                            },
                      label: state is LoginLoading ? 'Memuat...' : 'Masuk',
                      color: AppColors.purple,
                    );
                  },
                ),
                const SpaceHeight(20),
                Text.rich(
                  TextSpan(
                    text: 'Belum punya akun? ',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: context.deviceWidth * 0.035,
                    ),
                    children: [
                      TextSpan(
                        text: 'Daftar di sini!',
                        style: TextStyle(
                          color: AppColors.pinkFanta,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.push(const RegisterScreen());
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
