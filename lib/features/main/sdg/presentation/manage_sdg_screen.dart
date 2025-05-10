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
import 'package:ipqaia/features/main/sdg/domain/cubit/sdg_cubit.dart';
import 'package:ipqaia/features/main/sdg/repository/sdg_model/sdg_vm.dart';

@RoutePage()
class ManageSdgScreen extends StatefulWidget {
  const ManageSdgScreen({super.key});

  @override
  State<ManageSdgScreen> createState() => _ManageSdgScreenState();
}

class _ManageSdgScreenState extends State<ManageSdgScreen> {
  final TextEditingController numberController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController wordController = TextEditingController();
  final List<String> words = [];
  final List<String> sdgColumnTitle = ['SDG', 'Title', 'Words', 'Action'];

  @override
  void initState() {
    super.initState();
    numberController;
    titleController;
    wordController;
    words;
  }

  void _showSdgForms({
    required Method method,
    SdgVm? sdg,
  }) {
    final sdgCubit = context.read<SdgCubit>();
    final numberController =
        TextEditingController(text: sdg?.sdgNumber.toString() ?? '');
    final titleController = TextEditingController(text: sdg?.sdgTitle ?? '');
    final wordController = TextEditingController();
    List<String> words = List.from(sdg?.words ?? []);

    AppDialog.showCustomFormDialog(
      width: 700,
      context: context,
      onClose: () {
        sdgCubit.clearWords();
        Navigator.of(context, rootNavigator: true).pop();
      },
      formFields: [
        StatefulBuilder(
          builder: (context, setState) => SdgForms(
            numberController: numberController,
            titleController: titleController,
            wordController: wordController,
            initialWords: words,
            onWordsUpdated: (updatedWords) => words = updatedWords,
          ),
        ),
      ],
      onSubmit: () {
        final number = int.tryParse(numberController.text) ?? 0;
        final title = titleController.text;

        if (method == Method.add) {
          sdgCubit.addSdg(number, title, words);
        } else if (method == Method.update && sdg != null) {
          sdgCubit.updateSdg(
            SdgVm(
              sdgId: sdg.sdgId,
              sdgNumber: number,
              sdgTitle: title,
              words: words,
            ),
          );
        }
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
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
            title: Align(
              alignment: Alignment.topRight,
              child: AppCustomButton(
                ontab: () => _showSdgForms(method: Method.add),
                backgroundColor: AppColors.primary,
                text: "Add SDG",
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Expanded(
                      child: BlocBuilder<SdgCubit, SdgState>(
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
                          if (state.sdg.isEmpty) {
                            return const Center(
                              child: Text("No SDG data available"),
                            );
                          }
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minWidth: constraints.maxWidth),
                              child: BlocBuilder<SdgCubit, SdgState>(
                                builder: (context, state) {
                                  return state.isSuccess
                                      ? DataTable(
                                          headingRowColor:
                                              WidgetStateProperty.all(
                                                  AppColors.primary),
                                          headingTextStyle: context
                                              .textTheme.titleSmall!
                                              .copyWith(
                                            color: AppColors.textSecondary,
                                          ),
                                          sortColumnIndex: 0,
                                          sortAscending: true,
                                          columnSpacing: 12,
                                          horizontalMargin: 12,
                                          dataRowMinHeight: 50,
                                          dataRowMaxHeight: double.infinity,
                                          columns: [
                                            for (var title in sdgColumnTitle)
                                              DataColumn(
                                                label: Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      title,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                          rows: state.sdg
                                              .map((sdg) => DataRow(
                                                    cells: [
                                                      DataCell(Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                            sdg.sdgNumber
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center),
                                                      )),
                                                      DataCell(Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                            sdg.sdgTitle!,
                                                            textAlign: TextAlign
                                                                .center),
                                                      )),
                                                      DataCell(
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Wrap(
                                                            alignment:
                                                                WrapAlignment
                                                                    .center,
                                                            spacing: 8,
                                                            runSpacing: 8,
                                                            children: sdg.words
                                                                    ?.map((word) =>
                                                                        Container(
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: 10,
                                                                              vertical: 5),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                AppColors.secondary,
                                                                            borderRadius:
                                                                                BorderRadius.circular(25),
                                                                          ),
                                                                          child:
                                                                              Text(word),
                                                                        ))
                                                                    .toList() ??
                                                                [],
                                                          ),
                                                        ),
                                                      ),
                                                      DataCell(
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              AppCustomButton(
                                                                ontab: () =>
                                                                    _showSdgForms(
                                                                  method: Method
                                                                      .update,
                                                                  sdg: sdg,
                                                                ),
                                                                backgroundColor:
                                                                    AppColors
                                                                        .secondary,
                                                                text: "Update",
                                                              ),
                                                              const Gap(20),
                                                              AppCustomButton(
                                                                ontab: () => AppDialog
                                                                    .showCustomAlertDialog(
                                                                        context,
                                                                        'Delete SDG',
                                                                        'Are you sure you want to delete this SDG?',
                                                                        onPressed:
                                                                            () {
                                                                  sdgCubit.deleteSdg(
                                                                      sdg.sdgId!);
                                                                }),
                                                                backgroundColor:
                                                                    AppColors
                                                                        .delete,
                                                                text: "Delete",
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ))
                                              .toList(),
                                        )
                                      : const Center(
                                          child: Text("No SDG Added"));
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
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

// Modified SdgForms widget
class SdgForms extends StatefulWidget {
  final TextEditingController numberController;
  final TextEditingController titleController;
  final TextEditingController wordController;
  final List<String> initialWords;
  final ValueChanged<List<String>> onWordsUpdated;

  const SdgForms({
    super.key,
    required this.numberController,
    required this.titleController,
    required this.wordController,
    required this.initialWords,
    required this.onWordsUpdated,
  });

  @override
  State<SdgForms> createState() => _SdgFormsState();
}

class _SdgFormsState extends State<SdgForms> {
  late List<String> _words;

  @override
  void initState() {
    super.initState();
    _words = List.from(widget.initialWords);
  }

  void _addWord() {
    if (widget.wordController.text.trim().isNotEmpty) {
      setState(() {
        _words.add(widget.wordController.text.trim());
        widget.onWordsUpdated(_words);
      });
      widget.wordController.clear();
    }
  }

  void _removeWord(String word) {
    setState(() {
      _words.remove(word);
      widget.onWordsUpdated(_words);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppCustomTextfield(
            controller: widget.numberController,
            label: "SDG Number",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter SDG number';
              }
              if (int.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          const Gap(10),
          AppCustomTextfield(
            controller: widget.titleController,
            label: "Title",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter SDG title';
              }
              return null;
            },
          ),
          const Gap(10),
          Row(
            children: [
              Expanded(
                child: AppCustomTextfield(
                  controller: widget.wordController,
                  label: "Input word here...",
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: _addWord,
              ),
            ],
          ),
          const Gap(10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _words
                .map((word) => Chip(
                      label: Text(word),
                      deleteIcon: const Icon(Icons.close),
                      onDeleted: () => _removeWord(word),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
