import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/enum/enum_action_method.dart';
import 'package:ipqaia/core/enum/enum_campus.dart';
import 'package:ipqaia/core/shared/app_containers/app_body_container.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';
import 'package:ipqaia/core/shared/app_dialog.dart';
import 'package:ipqaia/core/shared/app_drop_down_field.dart';
import 'package:ipqaia/features/main/academic_offerings/domain/academic_offerings/academic_offerings_cubit.dart';
import 'package:ipqaia/features/main/academic_offerings/presentation/programs/program_form.dart';
import 'package:ipqaia/features/main/academic_offerings/repository/program_model/program_vm.dart';
import 'package:ipqaia/talker_service.dart';

@RoutePage()
class ProgramsExternalScreen extends StatefulWidget {
  const ProgramsExternalScreen({super.key});

  @override
  State<ProgramsExternalScreen> createState() => _ProgramsExternalScreenState();
}

class _ProgramsExternalScreenState extends State<ProgramsExternalScreen> {
  final List<String> _columnTitles = [
    'Program',
    'Major',
    'Actions',
  ];

  final TextEditingController program = TextEditingController();
  final TextEditingController major = TextEditingController();
  final TextEditingController cluster = TextEditingController();
  final TextEditingController sdg = TextEditingController();

  void _showDialog({Method? method, ProgramVm? programs}) {
    final acadCubit = context.read<AcademicOfferingsCubit>();

    final program = TextEditingController(text: programs?.program ?? '');
    final major = TextEditingController(text: programs?.major ?? '');
    final cluster = TextEditingController(text: programs?.cluster ?? '');

    final formKey = GlobalKey<FormState>();

    AppDialog.showCustomFormDialog(
      context: context,
      onClose: () {},
      formFields: [
        ProgramsForm(
          key: formKey,
          major: major,
          program: program,
          cluster: cluster,
          campus: Campus.external,
        ),
      ],
      isLoading: acadCubit.state.isLoading,
      onSubmit: () {
        if (method == Method.add) {
          acadCubit.addProgramMain(ProgramVm(
              major: major.text,
              program: program.text,
              campus: '',
              cluster: cluster.text));
        }

        TalkerService.talker.debug(program.toString());
        context.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AcademicOfferingsCubit, AcademicOfferingsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.backgroundSecondary,
            title: Row(
              children: [
                SizedBox(
                  width: 200,
                  child: AppDropdownField<String>(
                    title: "Select program here",
                    options: ['All'] +
                        state.program
                            .map((p) => p.program)
                            .whereType<String>()
                            .toList(),
                    value: state.selectedProgram,
                    onChanged: (value) {
                      context
                          .read<AcademicOfferingsCubit>()
                          .updateSelectedProgram(value!);

                      // TODO: Add search using program
                    },
                    optionLabel: (option) => option,
                  ),
                ),
                Gap(20),
                // SizedBox(
                //   width: 200,
                //   child: AppDropdownField<String>(
                //     title: "Select year here",
                //     options: ['All'] +
                //         state.program
                //             .map((p) => p.perYear)
                //             .whereType<String>()
                //             .toList(),
                //     value: state.selectedYear,
                //     onChanged: (value) {
                //       context
                //           .read<AcademicOfferingsCubit>()
                //           .updateSelectedYear(value!);

                //       // TODO: Add search using year
                //     },
                //     optionLabel: (option) => option,
                //   ),
                // ),
                Spacer(),
                AppCustomButton(
                    text: 'Add Program to External Campus',
                    ontab: () => _showDialog(method: Method.add)),
              ],
            ),
          ),
          body: AppBodyContainer(
            child: Column(
              children: [
                DataTable(
                    headingRowColor: WidgetStateProperty.all(AppColors.primary),
                    columns: [
                      for (var title in _columnTitles)
                        DataColumn(
                            label: Expanded(
                                child: Center(
                                    child: Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: AppColors.textSecondary),
                        ))))
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('Program')),
                        DataCell(Text('Major')),
                        DataCell(
                          Row(
                            children: [
                              AppCustomButton(
                                text: 'Edit',
                                ontab: () {
                                  //TODO: Add edit program
                                },
                              ),
                              Gap(10),
                              AppCustomButton(
                                text: 'Delete',
                                backgroundColor: AppColors.delete,
                                ontab: () {
                                  //TODO: Add delete program
                                },
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ]),
              ],
            ),
          ),
        );
      },
    );
  }
}
