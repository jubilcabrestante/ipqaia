import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/core/domain/cubit/auth_cubit.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';
import 'package:ipqaia/core/shared/app_custom_loading_indicator.dart';
import 'package:ipqaia/core/shared/app_custom_textfield.dart';
import 'package:ipqaia/core/shared/app_dialog.dart';
import 'package:ipqaia/core/shared/app_drop_down_field.dart';
import 'package:ipqaia/features/main/accounts/models/account_creation_vm.dart';

@RoutePage()
class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  CreateAccountScreenState createState() => CreateAccountScreenState();
}

class CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? selectedGender;
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 2,
                  child: AppCustomTextfield(
                    controller: fullNameController,
                    label: "Full Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Full name is required';
                      }
                      return null;
                    },
                  ),
                ),
                const Gap(20),
                Expanded(
                  flex: 2,
                  child: AppCustomTextfield(
                    controller: emailController,
                    label: "Email",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                const Gap(20),
                Expanded(
                  flex: 1,
                  child: AppCustomTextfield(
                    controller: ageController,
                    label: "Age",
                    type: "email",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Age is required';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const Gap(20),
            Row(
              children: [
                Expanded(
                  child: AppDropdownField(
                    title: "Role",
                    value: selectedRole,
                    options: const ["Staff", "Admin"],
                    onChanged: (value) => setState(() => selectedRole = value),
                    optionLabel: (value) => value,
                    validator: (value) {
                      if (value == null) return "Please select a role";
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: AppDropdownField(
                    title: "Gender",
                    value: selectedGender,
                    options: const ["Male", "Female"],
                    onChanged: (value) =>
                        setState(() => selectedGender = value),
                    optionLabel: (value) => value,
                    validator: (value) {
                      if (value == null) return "Please select a gender";
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const Gap(20),
            Row(
              children: [
                Expanded(
                  child: AppCustomTextfield(
                    controller: passwordController,
                    label: "Password",
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: AppCustomTextfield(
                    controller: confirmPasswordController,
                    label: "Confirm Password",
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm password';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const Gap(20),
            Center(
              child: SizedBox(
                  width: 150,
                  height: 45,
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state.isSuccess) {
                        AppDialog.showCustomAlertDialog(
                          context,
                          buttonText: 'OK',
                          'Success',
                          'Account has been added successfully',
                        );
                        fullNameController.clear();
                        emailController.clear();
                        ageController.clear();
                        passwordController.clear();
                        confirmPasswordController.clear();
                        selectedGender = null;
                        selectedRole = null;
                      }
                      if (state.errorMessage != null) {
                        AppDialog.showCustomAlertDialog(
                          context,
                          buttonText: 'OK',
                          'Error',
                          state.errorMessage!,
                        );
                      }
                    },
                    builder: (context, state) {
                      return AppCustomButton(
                        text: "add account",
                        backgroundColor: Theme.of(context).primaryColor,
                        ontab: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().createAccount(
                                  AccountVm(
                                    age: int.parse(ageController.text),
                                    gender: selectedGender!,
                                    name: fullNameController.text,
                                    email: emailController.text,
                                    role: selectedRole!,
                                  ),
                                  passwordController.text,
                                );
                          }
                        },
                        child: state.isLoading
                            ? AppCustomLoadingIndicator()
                            : null,
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
