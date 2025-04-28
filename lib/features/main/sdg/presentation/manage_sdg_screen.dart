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
  final TextEditingController sdgNumber = TextEditingController();
  final TextEditingController sdgTitle = TextEditingController();
  final TextEditingController wordInputController = TextEditingController();
  final List<String> sdgColumnTitle = ['SDG', 'Title', 'Words', 'Action'];

  void _showSdgForms({
    required Method method,
    String? sdgId,
    String? initialNumber,
    String? initialTitle,
    List<String>? initialWords,
  }) {
    final sdgCubit = context.read<SdgCubit>();

    AppDialog.showCustomFormDialog(
      width: 700,
      context: context,
      onClose: () {
        sdgCubit.clearWords();
        sdgNumber.clear();
        sdgTitle.clear();
        Navigator.of(context, rootNavigator: true).pop();
      },
      formFields: [
        SdgForms(
          method: method,
          sdgId: sdgId,
          initialNumber: initialNumber,
          initialTitle: initialTitle,
          initialWords: initialWords,
        ),
      ],
      onSubmit: () {
        if (method == Method.add) {
          sdgCubit.addSdg(int.parse(sdgNumber.text), sdgTitle.text);
        } else if (method == Method.update && sdgId != null) {
          sdgCubit.updateSdg(
            SdgVm(
              sdgId: sdgId,
              sdgNumber: int.parse(sdgNumber.text),
              sdgTitle: sdgTitle.text,
              words: initialWords,
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
                                        for (var title in sdgColumnTitle)
                                          DataColumn(
                                            label: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.darkGreen,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(width: 2),
                                              ),
                                              child: Text(title,
                                                  textAlign: TextAlign.center),
                                            ),
                                          ),
                                      ],
                                      rows: state.sdg
                                          .map((sdg) => DataRow(
                                                cells: [
                                                  DataCell(Text(
                                                      sdg.sdgNumber.toString(),
                                                      textAlign:
                                                          TextAlign.center)),
                                                  DataCell(Text(sdg.sdgTitle!,
                                                      textAlign:
                                                          TextAlign.center)),
                                                  DataCell(
                                                    Wrap(
                                                      alignment:
                                                          WrapAlignment.center,
                                                      spacing: 8,
                                                      runSpacing: 8,
                                                      children: sdg.words
                                                              ?.map(
                                                                  (word) =>
                                                                      Container(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                5),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              AppColors.secondary,
                                                                          borderRadius:
                                                                              BorderRadius.circular(25),
                                                                        ),
                                                                        child: Text(
                                                                            word),
                                                                      ))
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
                                                            ontab: () =>
                                                                _showSdgForms(
                                                              method:
                                                                  Method.update,
                                                              sdgId: sdg.sdgId,
                                                              initialNumber: sdg
                                                                  .sdgNumber
                                                                  .toString(),
                                                              initialTitle:
                                                                  sdg.sdgTitle,
                                                              initialWords:
                                                                  sdg.words,
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
                                                              sdgCubit
                                                                  .deleteSdg();
                                                              Navigator.of(
                                                                      context,
                                                                      rootNavigator:
                                                                          true)
                                                                  .pop();
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
                                  : const Center(child: Text("No SDG Added"));
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

class SdgForms extends StatefulWidget {
  final Method method;
  final String? sdgId;
  final String? initialNumber;
  final String? initialTitle;
  final List<String>? initialWords;
  final VoidCallback? onDelete;

  const SdgForms({
    super.key,
    required this.method,
    this.sdgId,
    this.initialNumber,
    this.initialTitle,
    this.initialWords,
    this.onDelete,
  });

  @override
  State<SdgForms> createState() => _SdgFormsState();
}

class _SdgFormsState extends State<SdgForms> {
  late final TextEditingController _numberController;
  late final TextEditingController _titleController;
  late final TextEditingController _wordController;
  final List<String> _words = [];

  @override
  void initState() {
    super.initState();
    _numberController = TextEditingController(text: widget.initialNumber);
    _titleController = TextEditingController(text: widget.initialTitle);
    _wordController = TextEditingController();
    _words.addAll(widget.initialWords ?? []);
  }

  void _addWord() {
    if (_wordController.text.trim().isNotEmpty) {
      setState(() => _words.add(_wordController.text.trim()));
      _wordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppCustomTextfield(
          controller: _numberController,
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
        AppCustomTextfield(controller: _titleController, label: "Title"),
        const Gap(10),
        Row(
          children: [
            Expanded(
              child: AppCustomTextfield(
                controller: _wordController,
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
                    onDeleted: () => setState(() => _words.remove(word)),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
