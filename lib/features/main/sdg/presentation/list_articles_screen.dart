import 'dart:developer';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/enum/enum_action_method.dart';
import 'package:ipqaia/core/extensions/theme_extensions.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';
import 'package:ipqaia/core/shared/app_custom_textfield.dart';
import 'package:ipqaia/core/shared/app_dialog.dart';
import 'package:ipqaia/core/shared/app_drop_down_field.dart';
import 'package:ipqaia/core/shared/search_bar.dart';
import 'package:ipqaia/features/main/sdg/domain/cubit/sdg_cubit.dart';
import 'package:ipqaia/features/main/sdg/repository/article_model/article_vm.dart';
import 'package:ipqaia/talker_service.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class ListArticlesScreen extends StatefulWidget {
  const ListArticlesScreen({super.key});

  @override
  State<ListArticlesScreen> createState() => _ListArticlesScreenState();
}

class _ListArticlesScreenState extends State<ListArticlesScreen> {
  TextEditingController searchController = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController link = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController sdg = TextEditingController();
  final List<String> columnTitle = ['SDG', 'Title', 'Link', 'Action'];

  @override
  void initState() {
    super.initState();
    final sdgCubit = context.read<SdgCubit>();
    sdgCubit.getArticles();
  }

  void _showDialog({Method? method, ArticleVm? article}) {
    final sdgCubit = context.read<SdgCubit>();

    final title = TextEditingController(text: article?.title ?? '');
    final link = TextEditingController(text: article?.link ?? '');
    final description = TextEditingController(text: article?.description ?? '');
    final year = article?.year ?? DateTime.now();

    final formKey = GlobalKey<_ArticleFormState>();

    AppDialog.showCustomFormDialog(
      context: context,
      onClose: () {},
      formFields: [
        ArticleForm(
          key: formKey,
          title: title,
          description: description,
          link: link,
          year: sdgCubit.state.selectedDate ?? year,
        ),
      ],
      isLoading: sdgCubit.state.isLoading,
      onSubmit: () {
        if (method == Method.add) {
          sdgCubit.addArticle(ArticleVm(
            title: title.text,
            description: description.text,
            link: link.text,
            year: sdgCubit.state.selectedDate ?? year,
            sdg: sdgCubit.state.selectedSdg,
          ));
        } else if (method == Method.update && article != null) {
          sdgCubit.updateArticle(
            ArticleVm(
              articleId: article.articleId,
              title: title.text,
              link: link.text,
              description: description.text,
              year: sdgCubit.state.selectedDate ?? year,
              sdg: sdgCubit.state.selectedSdg,
            ),
          );
        }

        TalkerService.talker.debug(article?.toJson());
        context.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sdgCubit = context.read<SdgCubit>();
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
                  // TODO: Implement search
                },
              ),
            ),
            Row(
              children: [
                // AppDropdownField<String>(
                //   title: "Category",
                //   options: state.sdg
                //       .map((sdg) => sdg.sdgTitle)
                //       .whereType<String>()
                //       .toList(),
                //   value: state.selectedArticle,
                //   onChanged: (value) {
                //     sdgCubit.getArticles();
                //   },
                //   optionLabel: (option) => option,
                // ),
                // Gap(20),
                AppCustomButton(
                  ontab: () => _showDialog(method: Method.add),
                  backgroundColor: AppColors.primary,
                  text: "Add New Article",
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
            return BlocBuilder<SdgCubit, SdgState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // Error State
                if (state.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                // Success State with empty data
                if (state.articles.isEmpty) {
                  return const Center(
                    child: Text("No SDG data available"),
                  );
                }
                return Column(
                  children: [
                    Expanded(
                      child: state.articles.isNotEmpty
                          ? SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    minWidth: constraints.maxWidth),
                                child: DataTable(
                                  headingRowColor: WidgetStateProperty.all(
                                      AppColors.primary),
                                  headingTextStyle:
                                      context.textTheme.titleSmall!.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                  columns: [
                                    for (var title in columnTitle)
                                      DataColumn(
                                        label: Expanded(
                                            child: Center(child: Text(title))),
                                      )
                                  ],
                                  rows: state.articles.map((article) {
                                    return DataRow(cells: [
                                      DataCell(Center(
                                          child: Text(article.sdg ?? ""))),
                                      DataCell(
                                          Center(child: Text(article.title))),
                                      DataCell(
                                        Center(
                                          child: InkWell(
                                            onTap: () async {
                                              final url =
                                                  Uri.parse(article.link);
                                              if (await canLaunchUrl(url)) {
                                                await launchUrl(url);
                                              }
                                            },
                                            child: Text(
                                              article.link,
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              AppCustomButton(
                                                ontab: () {
                                                  _showDialog(
                                                    method: Method.update,
                                                    article: article,
                                                  );
                                                  log("article: ${article.articleId}");
                                                },
                                                backgroundColor:
                                                    AppColors.secondary,
                                                text: "Edit",
                                              ),
                                              AppCustomButton(
                                                ontab: () => AppDialog
                                                    .showCustomAlertDialog(
                                                  context,
                                                  'Delete Article',
                                                  'Are you sure you want to delete this article?',
                                                  onPressed: () {
                                                    sdgCubit.deleteArticle(
                                                        article.articleId!);
                                                  },
                                                ),
                                                backgroundColor:
                                                    AppColors.delete,
                                                text: "Delete",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]);
                                  }).toList(),
                                ),
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ArticleForm extends StatefulWidget {
  final TextEditingController? title;
  final TextEditingController? link;
  final TextEditingController? description;
  final DateTime? year;

  const ArticleForm({
    super.key,
    this.title,
    this.link,
    this.description,
    required this.year,
  });

  @override
  State<ArticleForm> createState() => _ArticleFormState();
}

class _ArticleFormState extends State<ArticleForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedYear;

  @override
  void initState() {
    super.initState();
    selectedYear = widget.year;
  }

  // Validator for URL (simple pattern, you can make it more strict)
  String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return "Link cannot be empty";
    }

    // Accept URLs starting with http:// or https:// or without any protocol (like www.google.com)
    final urlPattern =
        r"^(https?|ftp)://[^\s/$.?#].[^\s]*$|^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}(/S*)?$";
    final result = RegExp(urlPattern).hasMatch(value);

    if (!result) {
      return "Please enter a valid URL";
    }

    return null;
  }

  String? validateSdg(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select an SDG";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final sdgCubit = context.read<SdgCubit>();
    return BlocBuilder<SdgCubit, SdgState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppCustomTextfield(
                    controller: widget.title!,
                    label: "Title",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Title is required";
                      }
                      return null;
                    },
                  ),
                  Gap(20),
                  AppCustomTextfield(
                    controller: widget.link!,
                    label: "Link",
                    validator: validateUrl,
                  ),
                  Gap(20),
                  AppCustomTextfield(
                    controller: widget.description!,
                    label: "Description",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Description is required";
                      }
                      return null;
                    },
                  ),
                  Gap(20),
                  AppDropdownField<String>(
                    title: "Sdg",
                    options: state.sdg
                        .map((sdg) => sdg.sdgTitle)
                        .whereType<String>()
                        .toList(),
                    value: state.selectedSdg,
                    onChanged: (value) {
                      sdgCubit.updateSelectedSdg(value!);
                    },
                    optionLabel: (option) => option,
                    validator: validateSdg,
                  ),
                  Gap(20),
                  AppCustomButton(
                    ontab: () {
                      //TODO: Implement the prediction button here
                    },
                    backgroundColor: AppColors.primary,
                    text: "Predict SDG",
                  ),
                  SizedBox(
                    height: 200,
                    child: YearPicker(
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                      selectedDate: selectedYear,
                      onChanged: (newDate) {
                        setState(() {
                          selectedYear = newDate;
                        });
                        sdgCubit.updateSelectedDate(newDate);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
