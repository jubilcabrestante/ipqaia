import 'dart:developer';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/domain/cubit/auth_cubit.dart';
import 'package:ipqaia/core/enum/enum_action_method.dart' show Method;
import 'package:ipqaia/core/extensions/theme_extensions.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';
import 'package:ipqaia/core/shared/app_custom_loading_indicator.dart';
import 'package:ipqaia/core/shared/app_custom_textfield.dart';
import 'package:ipqaia/core/shared/app_dialog.dart';
import 'package:ipqaia/core/shared/app_drop_down_field.dart';
import 'package:ipqaia/core/shared/search_bar.dart';
import 'package:ipqaia/features/main/accounts/models/account_creation_vm.dart';
import 'package:ipqaia/talker_service.dart';

@RoutePage()
class ListOfAccountsScreen extends StatefulWidget {
  const ListOfAccountsScreen({super.key});

  @override
  State<ListOfAccountsScreen> createState() => _ListOfAccountsScreenState();
}

class _ListOfAccountsScreenState extends State<ListOfAccountsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _columnnames = [
    'Full Name',
    'Email',
    'Age',
    'Role',
    'Gender',
    'Actions'
  ];

  void _showAccountForm({Method? method, AccountVm? account}) {
    final authCubit = context.read<AuthCubit>();

    final TextEditingController nameController =
        TextEditingController(text: account?.name ?? '');
    final TextEditingController emailController =
        TextEditingController(text: account?.email ?? '');
    final TextEditingController ageController =
        TextEditingController(text: account?.age.toString() ?? '');
    AppDialog.showCustomFormDialog(
      width: 600,
      context: context,
      onClose: () => Navigator.of(context, rootNavigator: true).pop(),
      isLoading: authCubit.state.isLoading,
      formFields: [
        BlocProvider.value(
          value: authCubit,
          child: AccountForms(
            method: method!,
            account: account,
            password: _passwordController,
            nameController: nameController,
            emailController: emailController,
            ageController: ageController,
            confirmPasswordController: _confirmPasswordController,
            formKey: _formKey,
          ),
        )
      ],
      onSubmit: () {
        if (_formKey.currentState!.validate()) {
          // Validate form
          if (method == Method.add) {
            final newAccount = AccountVm(
              name: nameController.text,
              email: emailController.text,
              role: authCubit.state.selectedRole,
              gender: authCubit.state.selectedGender,
              age: int.parse(ageController.text),
            );
            TalkerService.talker
                .debug(newAccount.toJson(), _passwordController.text);

            context
                .read<AuthCubit>()
                .createAccount(newAccount, _passwordController.text);
          } else {
            // context.read<AuthCubit>().updateAccount(account);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundSecondary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: CustomSearchBar(
                  controller: _searchController,
                  onSearchPressed: () {
                    // TODO: Implement search functionality
                    // authCubit.searchAccounts(_searchController.text);
                  }, onChanged: (String query) { 
                  
                   },
                ),
              ),
            ),
            AppCustomButton(
              ontab: () => _showAccountForm(method: Method.add),
              backgroundColor: AppColors.primary,
              text: "Add Account",
            ),
          ],
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoadingAccounts) {
            return const AppCustomLoadingIndicator();
          }

          if (state.accounts.isEmpty) {
            return const Center(child: Text("No accounts found"));
          }

          return LayoutBuilder(builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight,
                  ),
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(AppColors.primary),
                    headingTextStyle: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    columns: [
                      for (var name in _columnnames)
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                    ],
                    rows: state.accounts.map((account) {
                      return DataRow(
                        cells: [
                          DataCell(Center(child: Text(account.name))),
                          DataCell(Center(child: Text(account.email))),
                          DataCell(Center(child: Text(account.age.toString()))),
                          DataCell(Center(child: Text(account.role))),
                          DataCell(Center(child: Text(account.gender))),
                          DataCell(
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppCustomButton(
                                    ontab: () => _showAccountForm(
                                      method: Method.update,
                                      account: account,
                                    ),
                                    backgroundColor: AppColors.secondary,
                                    text: "edit",
                                  ),
                                  const Gap(15),
                                  AppCustomButton(
                                    ontab: () =>
                                        AppDialog.showCustomAlertDialog(
                                      context,
                                      'Delete Account',
                                      'Are you sure you want to delete this account?',
                                      buttonText: "delete",
                                      showCancelButton: true,
                                      onPressed: () {
                                        authCubit.deleteUser(account.uid!);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    backgroundColor: AppColors.delete,
                                    text: "delete",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}

class AccountForms extends StatefulWidget {
  final Method method;
  final AccountVm? account;
  final GlobalKey<FormState> formKey;
  final TextEditingController? nameController;
  final TextEditingController? emailController;
  final TextEditingController? ageController;
  final TextEditingController? confirmPasswordController;
  final TextEditingController? password;

  const AccountForms({
    super.key,
    required this.method,
    this.account,
    this.password,
    required this.formKey,
    this.nameController,
    this.emailController,
    this.ageController,
    this.confirmPasswordController,
  });

  @override
  State<AccountForms> createState() => _AccountFormsState();
}

class _AccountFormsState extends State<AccountForms> {
  String? _selectedGender;
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
        }
      },
      builder: (context, state) {
        final authCubit = context.read<AuthCubit>();
        return Form(
          key: widget.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AppCustomTextfield(
                        controller: widget.nameController!,
                        label: "Full Name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Full name is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      flex: 2,
                      child: AppCustomTextfield(
                        controller: widget.emailController!,
                        label: "Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Enter valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      flex: 1,
                      child: AppCustomTextfield(
                        controller: widget.ageController!,
                        label: "Age",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Age is required';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Enter valid number';
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
                        value: _selectedRole,
                        options: const ["Staff", "Admin"],
                        optionLabel: (value) => value,
                        onChanged: (value) =>
                            authCubit.updateSelectedRole(value!),
                        validator: (value) =>
                            value == null ? "Select role" : null,
                      ),
                    ),
                    const Gap(20),
                    Expanded(
                      child: AppDropdownField(
                        title: "Gender",
                        value: _selectedGender,
                        options: const ["Male", "Female"],
                        optionLabel: (value) => value,
                        onChanged: (value) =>
                            authCubit.updateSelectedGender(value!),
                        validator: (value) =>
                            value == null ? "Select gender" : null,
                      ),
                    ),
                    const Gap(20),
                  ],
                ),
                const Gap(20),
                if (widget.method == Method.add) ...[
                  Row(
                    children: [
                      Expanded(
                        child: AppCustomTextfield(
                          controller: widget.password!,
                          label: "Password",
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password required';
                            }
                            if (value.length < 8) {
                              return 'Minimum 8 characters';
                            }
                            return null;
                          },
                        ),
                      ),
                      const Gap(20),
                      Expanded(
                        child: AppCustomTextfield(
                          controller: widget.confirmPasswordController!,
                          label: "Confirm Password",
                          isPassword: true,
                          validator: (value) {
                            if (value != widget.password?.text) {
                              return 'Passwords mismatch';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
