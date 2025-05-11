import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/domain/cubit/auth_cubit.dart';
import 'package:ipqaia/core/extensions/theme_extensions.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';
import 'package:ipqaia/core/shared/app_custom_loading_indicator.dart';
import 'package:ipqaia/core/shared/app_dialog.dart';
import 'package:ipqaia/core/shared/search_bar.dart';

@RoutePage()
class ListOfAccountsScreen extends StatefulWidget {
  const ListOfAccountsScreen({super.key});

  @override
  State<ListOfAccountsScreen> createState() => _ListOfAccountsScreenState();
}

class _ListOfAccountsScreenState extends State<ListOfAccountsScreen> {
  final TextEditingController searchController = TextEditingController();
  final List<String> columnTitles = [
    'Full Name',
    'Email',
    'Age',
    'Role',
    'Gender',
    'Actions'
  ];

  @override
  Widget build(BuildContext context) {
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
                  controller: searchController,
                  onSearchPressed: () {
                    // TODO: Implement search functionality
                    // authCubit.searchAccounts(searchController.text);
                  },
                ),
              ),
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
            return AppCustomLoadingIndicator();
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
                    headingTextStyle: context.textTheme.titleSmall!.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    columns: [
                      for (var title in columnTitles)
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                title,
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
                                    ontab: () {
                                      // TODO: Implement edit functionality
                                    },
                                    backgroundColor: AppColors.secondary,
                                    text: "edit",
                                  ),
                                  const Gap(15),
                                  AppCustomButton(
                                    ontab: () {
                                      // TODO: Implement delete functionality
                                      AppDialog.showCustomAlertDialog(
                                        context,
                                        'Delete Account',
                                        'Are you sure you want to delete this account?',
                                        buttonText: "delete",
                                        onPressed: () {
                                          // authCubit.deleteAccount(account.id);
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    },
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
