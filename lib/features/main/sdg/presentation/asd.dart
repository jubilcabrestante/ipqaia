import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/extensions/theme_extensions.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';
import 'package:ipqaia/core/shared/app_custom_loading_indicator.dart';
import 'package:ipqaia/core/shared/app_custom_textfield.dart';
import 'package:ipqaia/core/shared/app_dialog.dart';
import 'package:ipqaia/features/main/sdg/domain/cubit/sdg_cubit.dart';

@RoutePage()
class ManageSdgScreen extends StatefulWidget {
  const ManageSdgScreen({super.key});

  @override
  State<ManageSdgScreen> createState() => _ManageSdgScreenState();
}

class _ManageSdgScreenState extends State<ManageSdgScreen> {
  final TextEditingController sdgNumber = TextEditingController();
  final TextEditingController sdgTitle = TextEditingController();
  final TextEditingController wordInputController = TextEditingController();

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
                  ontab: () {
                    AppDialog.showCustomFormDialog(
                      width: 700,
                      context: context,
                      formFields: [
                        AppCustomTextfield(
                            controller: sdgNumber, label: "SDG Number"),
                        Gap(10),
                        AppCustomTextfield(
                            controller: sdgTitle, label: "Title"),
                        Gap(10),
                        AppCustomTextfield(
                          controller: wordInputController,
                          label: "Word",
                        ),
                        Gap(10),
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 8,
                            runSpacing: 8,
                            children: state.newWords
                                .map(
                                  (word) => Chip(label: Text(word)),
                                )
                                .toList(),
                          ),
                        ),
                        Gap(20),
                        AppCustomButton(
                          ontab: () {
                            final word = wordInputController.text.trim();
                            if (word.isNotEmpty) {
                              context.read<SdgCubit>().addNewWord(word);
                              wordInputController.clear();
                            }
                          },
                          child: state.isLoading
                              ? AppCustomLoadingIndicator()
                              : Center(child: Text("Add SDG")),
                        ),
                      ],
                      onSubmit: () {
                        context.read<SdgCubit>().addSdg(
                              sdgNumber.text,
                              sdgTitle.text,
                            );
                        sdgNumber.clear();
                        sdgTitle.clear();
                      },
                    );
                  },
                  backgroundColor: AppColors.primary,
                  text: "Add SDG",
                ),
              )),
          body: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minWidth: constraints.maxWidth),
                          child: BlocBuilder<SdgCubit, SdgState>(
                            builder: (context, state) {
                              return state.isSuccess
                                  ? DataTable(
                                      headingRowColor: WidgetStateProperty.all(
                                          AppColors.primary),
                                      dataRowMinHeight: 100,
                                      dataRowMaxHeight: 300,
                                      headingTextStyle: context
                                          .textTheme.titleSmall!
                                          .copyWith(
                                              color: AppColors.textSecondary),
                                      columns: [
                                        DataColumn(
                                            label: Text(
                                          "SDG",
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "Title",
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "Words",
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "Action",
                                        )),
                                      ],
                                      rows: state.sdg
                                          .map(
                                            (sdg) => DataRow(
                                              cells: [
                                                DataCell(
                                                  Text(
                                                    sdg.sdgNumber.toString(),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                DataCell(
                                                  Text(
                                                    sdg.sdgTitle!,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                DataCell(
                                                  Wrap(
                                                    alignment:
                                                        WrapAlignment.center,
                                                    spacing: 8,
                                                    runSpacing: 8,
                                                    children: sdg.words
                                                            ?.map((word) => Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            5),
                                                                decoration: BoxDecoration(
                                                                    color: AppColors
                                                                        .secondary,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            25)),
                                                                child:
                                                                    Text(word)))
                                                            .toList() ??
                                                        [],
                                                  ),
                                                ),
                                                DataCell(
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 5,
                                                        horizontal: 0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        AppCustomButton(
                                                          ontab: () {
                                                            AppDialog
                                                                .showCustomFormDialog(
                                                              width: 700,
                                                              context: context,
                                                              formFields: [
                                                                AppCustomTextfield(
                                                                    controller: TextEditingController(
                                                                        text: sdg
                                                                            .sdgNumber
                                                                            .toString()),
                                                                    label:
                                                                        "SDG Number"),
                                                                Gap(10),
                                                                AppCustomTextfield(
                                                                    controller: TextEditingController(
                                                                        text: sdg.sdgTitle ??
                                                                            ''),
                                                                    label:
                                                                        "Title"),
                                                                Gap(10),
                                                                AppCustomTextfield(
                                                                    controller: TextEditingController(
                                                                        text: sdg.words !=
                                                                                null
                                                                            ? sdg.words!.join(
                                                                                ', ')
                                                                            : ''),
                                                                    label:
                                                                        "Word"),
                                                                Center(
                                                                  child: Wrap(
                                                                    alignment:
                                                                        WrapAlignment
                                                                            .center,
                                                                    spacing: 8,
                                                                    runSpacing:
                                                                        8,
                                                                    children: state
                                                                        .newWords
                                                                        .map((word) =>
                                                                            Container(
                                                                              child: ListTile(
                                                                                leading: Text(word),
                                                                                trailing: GestureDetector(
                                                                                  onTap: () {
                                                                                    final updatedWords = List<String>.from(sdg.words ?? []);
                                                                                    updatedWords.add(word);
                                                                                    sdgCubit.updateWord(word, updatedWords.join(', '));
                                                                                  },
                                                                                  child: Icon(
                                                                                    Icons.edit,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ))
                                                                        .toList(),
                                                                  ),
                                                                ),
                                                                Gap(20),
                                                                AppCustomButton(
                                                                  ontab: () {
                                                                    final word =
                                                                        wordInputController
                                                                            .text
                                                                            .trim();
                                                                    if (word
                                                                        .isNotEmpty) {
                                                                      context
                                                                          .read<
                                                                              SdgCubit>()
                                                                          .addNewWord(
                                                                              word);
                                                                      wordInputController
                                                                          .clear();
                                                                    }
                                                                  },
                                                                  child: state
                                                                          .isLoading
                                                                      ? AppCustomLoadingIndicator()
                                                                      : Center(
                                                                          child:
                                                                              Text("Add Word")),
                                                                ),
                                                              ],
                                                              onSubmit: () {
                                                                context
                                                                    .read<
                                                                        SdgCubit>()
                                                                    .addSdg(
                                                                      sdgNumber
                                                                          .text,
                                                                      sdgTitle
                                                                          .text,
                                                                    );
                                                                sdgNumber
                                                                    .clear();
                                                                sdgTitle
                                                                    .clear();
                                                              },
                                                            );
                                                          },
                                                          backgroundColor:
                                                              AppColors
                                                                  .secondary,
                                                          text: "Update",
                                                        ),
                                                        Gap(20),
                                                        AppCustomButton(
                                                          ontab: () {
                                                            sdgCubit
                                                                .deleteSdg();
                                                          },
                                                          backgroundColor:
                                                              AppColors.delete,
                                                          text: "delete",
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    )
                                  : Center(child: Text("No SDG Added"));
                            },
                          ),
                        ),
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
