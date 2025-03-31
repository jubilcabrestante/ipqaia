import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/extensions/theme_extensions.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';
import 'package:ipqaia/core/shared/app_custom_textfield.dart';
import 'package:ipqaia/core/shared/app_dialog.dart';
import 'package:ipqaia/core/shared/app_drop_down_field.dart';
import 'package:ipqaia/core/shared/search_bar.dart';
import 'package:ipqaia/features/main/sdg/domain/cubit/sdg_cubit.dart';

@RoutePage()
class ListArticlesScreen extends StatefulWidget {
  const ListArticlesScreen({super.key});

  @override
  State<ListArticlesScreen> createState() => _ListArticlesScreenState();
}

class _ListArticlesScreenState extends State<ListArticlesScreen> {
  TextEditingController searchController = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _link = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _title.dispose();
    _link.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sdgCubit = context.read<SdgCubit>();
    return BlocBuilder<SdgCubit, SdgState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundSecondary,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.backgroundSecondary,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20),
                  width: 350,
                  child: CustomSearchBar(
                    controller: searchController,
                    onSearchPressed: () {
                      //TODO: Handle this case
                      // Add your search logic here if needed
                    },
                  ),
                ),
                Row(
                  children: [
                    AppDropdownField<String>(
                      title: "Category",
                      options: state.articles
                          .map((article) => article.title)
                          .toList(),
                      value: state.selectedArticle,
                      onChanged: (value) {
                        sdgCubit.getArticles();
                      },
                      optionLabel: (option) => option,
                    ),
                    Gap(20),
                    AppCustomButton(
                      ontab: () {
                        AppDialog.showCustomFormDialog(
                            context: context,
                            formFields: [
                              AppCustomTextfield(
                                controller: _title,
                                label: "Title",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Title cannot be empty";
                                  }
                                  return null;
                                },
                              ),
                              Gap(20),
                              AppCustomTextfield(
                                controller: _link,
                                label: "Link",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Link cannot be empty";
                                  }
                                  return null;
                                },
                              ),
                              Gap(20),
                              AppDropdownField(
                                title: "SDG",
                                options: sdgCubit.state.sdg
                                    .map((sdg) => sdg.sdgTitle)
                                    .toList(),
                                value: sdgCubit.state.selectedSdg,
                                onChanged: (value) {
                                  setState(() {
                                    value;
                                  });
                                },
                                optionLabel: (option) => 'Select Sdg here',
                              )
                            ],
                            onSubmit: () {});
                      },
                      backgroundColor: AppColors.primary,
                      text: "Add New Category",
                    )
                  ],
                )
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Expanded(
                        child: state.articles.isNotEmpty
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      minWidth: constraints.maxWidth),
                                  child: DataTable(
                                    headingRowColor: WidgetStateProperty.all(
                                        AppColors.primary),
                                    headingTextStyle:
                                        context.textTheme.titleSmall!.copyWith(
                                            color: AppColors.textSecondary),
                                    columns: [
                                      DataColumn(
                                          label: SizedBox(
                                              child: Center(
                                        child: Text(
                                          "SDG",
                                          textAlign: TextAlign.center,
                                        ),
                                      ))),
                                      DataColumn(
                                          label: SizedBox(
                                              child: Center(
                                        child: Text(
                                          "Title",
                                          textAlign: TextAlign.center,
                                        ),
                                      ))),
                                      DataColumn(
                                          label: SizedBox(
                                              child: Center(
                                        child: Text(
                                          "Link",
                                          textAlign: TextAlign.center,
                                        ),
                                      ))),
                                      DataColumn(
                                          label: SizedBox(
                                              child: Center(
                                        child: Text(
                                          "Action",
                                          textAlign: TextAlign.center,
                                        ),
                                      ))),
                                    ],
                                    rows: state.articles
                                        .map(
                                          (article) => DataRow(
                                            cells: [
                                              DataCell(
                                                Center(
                                                  child: Text(article.sdg),
                                                ),
                                              ),
                                              DataCell(
                                                Center(
                                                  child: Text(article.title),
                                                ),
                                              ),
                                              DataCell(
                                                Center(
                                                  child: InkWell(
                                                    child: Text(
                                                      article.link,
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      log("Opening link: ${article.link}");
                                                    },
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5,
                                                      horizontal: 0),
                                                  child: Center(
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      AppCustomButton(
                                                        ontab: () {
                                                          sdgCubit.updateArticle(
                                                              article.articleId,
                                                              article);
                                                        },
                                                        backgroundColor:
                                                            AppColors.secondary,
                                                        text: "edit",
                                                      ),
                                                      AppCustomButton(
                                                        ontab: () {
                                                          // articles
                                                          //     .remove(article);
                                                        },
                                                        backgroundColor:
                                                            AppColors.delete,
                                                        text: "delete",
                                                      ),
                                                    ],
                                                  )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              )
                            : Center(child: Text("No SDG Available"))),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
