import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/app/routes/router.gr.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/domain/cubit/auth_cubit.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';
import 'package:ipqaia/core/shared/app_custom_loading_indicator.dart';
import 'package:ipqaia/core/shared/app_custom_textfield.dart';
import 'package:ipqaia/core/shared/app_dialog.dart';
import 'package:ipqaia/gen/assets.gen.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isHovered = false;
  final _formKey = GlobalKey<FormState>();
  bool _validateForm = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.1;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          AppDialog.showCustomAlertDialog(
            context,
            'Error',
            state.errorMessage!,
          );
        } else if (state.isSuccess) {
          context.router.replaceAll([const MainAppRoute()]);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(width),
                  child: MouseRegion(
                    onEnter: (_) => setState(() => _isHovered = true),
                    onExit: (_) => setState(() => _isHovered = false),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      transform: _isHovered
                          ? Matrix4.translationValues(0, 5, 0)
                          : Matrix4.identity(),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColors.secondary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                            spreadRadius: _isHovered ? 0.5 : 0,
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        autovalidateMode: _validateForm
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sign in",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const Gap(20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              child: AppCustomTextfield(
                                controller: emailController,
                                label: 'Email',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  } else if (!RegExp(
                                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                      .hasMatch(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const Gap(10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              child: AppCustomTextfield(
                                controller: passwordController,
                                label: 'Password',
                                isPassword: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: TextButton(
                                  onPressed: () {
                                    context.router
                                        .push(const ForgotPasswordRoute());
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 0, 131, 202)),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(10),
                            AppCustomButton(
                              ontab: () {
                                setState(() => _validateForm = true);
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().login(
                                        emailController.text,
                                        passwordController.text,
                                      );
                                }
                              },
                              backgroundColor: AppColors.primary,
                              child: state.isLoading
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: width * 0.9),
                                      child: const AppCustomLoadingIndicator(),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: width * 0.9),
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Assets.images.background.path),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withValues(alpha: 0.6),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(Assets.images.logo.path, height: 300),
                          const Gap(20),
                          const Text(
                            "IPQAIA",
                            style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
