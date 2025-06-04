import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/enum/enum_action_method.dart';
import 'package:ipqaia/core/shared/app_containers/app_body_container.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';
import 'package:ipqaia/core/shared/app_dialog.dart';
import 'package:ipqaia/core/shared/app_drop_down_field.dart';
import 'package:ipqaia/features/main/academic_offerings/domain/academic_offerings/academic_offerings_cubit.dart';
import 'package:ipqaia/features/main/academic_offerings/repository/program_model/program_vm.dart';
import 'package:ipqaia/core/enum/enum_academics_action.dart';
import 'package:ipqaia/core/shared/app_custom_textfield.dart';

@RoutePage()
class ProgramsScreen extends StatefulWidget {
  const ProgramsScreen({super.key});

  @override
  State<ProgramsScreen> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen> {
  final List<String> _columnTitle = [
    'Cluster',
    'Campus',
    'College',
    'Program',
    'Major',
    'Actions',
  ];

  void _showDialog({Method? method}) {
    final acadCubit = context.read<AcademicOfferingsCubit>();
    final formKey = GlobalKey<_ProgramsFormState>();

    AppDialog.showCustomFormDialog(
      width: 500,
      context: context,
      onClose: () {},
      formFields: [
        ProgramsForm(
          key: formKey,
          programs: acadCubit.state.program,
        ),
      ],
      isLoading: acadCubit.state.isLoading,
      onSubmit: () {
        if (method == Method.add) {
          final program = formKey.currentState?.getFormData();
          if (program != null) {
            acadCubit.addProgramMain(program);
          }
        }
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final acadCubit = context.read<AcademicOfferingsCubit>();
    return BlocConsumer<AcademicOfferingsCubit, AcademicOfferingsState>(
      listener: (context, state) {},
      builder: (context, state) {
        final academicData = acadCubit.getFlattenedAcademicStructure();

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.backgroundSecondary,
            title: Row(
              children: [
                const Gap(20),
                SizedBox(
                  width: 300,
                  child: AppDropdownField<String>(
                    title: "Cluster",
                    options: ['All'] +
                        state.program.map((p) => p.cluster).toSet().toList(),
                    value: state.selectedCluster.isEmpty
                        ? null
                        : state.selectedCluster,
                    onChanged: (value) {
                      if (value == 'All') {
                        acadCubit.getPrograms();
                      } else {
                        // TODO: Add search data using cluster
                        acadCubit.updateSelectedCluster(value!);
                      }
                    },
                    optionLabel: (option) => option,
                  ),
                ),
                const Gap(20),
                SizedBox(
                  width: 300,
                  child: BlocBuilder<AcademicOfferingsCubit,
                      AcademicOfferingsState>(
                    builder: (context, state) {
                      final selectedCluster = state.selectedCluster.isEmpty
                          ? null
                          : state.selectedCluster;

                      List<String> campuses = ['All'];
                      if (selectedCluster != null) {
                        final cluster = state.program.firstWhere(
                          (c) => c.cluster == selectedCluster,
                          orElse: () => ProgramVm(cluster: ''),
                        );
                        campuses
                            .addAll(cluster.campuses.map((c) => c.campusName));
                      }

                      return AppDropdownField<String>(
                        title: "Campus",
                        options: campuses,
                        value: state.selectedCampus.isEmpty
                            ? null
                            : state.selectedCampus,
                        onChanged: (value) {
                          if (value == 'All') {
                            acadCubit.updateSelectedCampus('');
                          } else {
                            // TODO: Add search data using campus
                            acadCubit.updateSelectedCampus(value!);
                          }
                        },
                        optionLabel: (option) => option,
                      );
                    },
                  ),
                ),
                const Spacer(),
                AppCustomButton(
                  text: 'Add',
                  ontab: () => _showDialog(method: Method.add),
                  backgroundColor: AppColors.primary,
                ),
                const Gap(20),
              ],
            ),
          ),
          body: AppBodyContainer(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                      minHeight: constraints.maxHeight,
                    ),
                    child: DataTable(
                      headingRowColor:
                          WidgetStateProperty.all(AppColors.primary),
                      headingTextStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: AppColors.textSecondary,
                              ),
                      columns: _columnTitle.map((name) {
                        return DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      rows: academicData.map((entry) {
                        return DataRow(
                          cells: [
                            DataCell(
                                Center(child: Text(entry['cluster'] ?? ''))),
                            DataCell(
                                Center(child: Text(entry['campus'] ?? ''))),
                            DataCell(
                                Center(child: Text(entry['college'] ?? ''))),
                            DataCell(
                                Center(child: Text(entry['program'] ?? ''))),
                            DataCell(Center(child: Text(entry['major'] ?? ''))),
                            DataCell(
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // TODO: Fix delete program or major here
                                    AppCustomButton(
                                      ontab: () =>
                                          AppDialog.showCustomAlertDialog(
                                        context,
                                        'Delete Major',
                                        'Are you sure you want to delete this major?',
                                        buttonText: "Delete",
                                        showCancelButton: true,
                                        onPressed: () {
                                          // acadCubit.deleteMajor(
                                          //   programId: entry['programId'] ?? '',
                                          //   campusName: entry['campus'] ?? '',
                                          //   collegeName: entry['college'] ?? '',
                                          //   programName: entry['program'] ?? '',
                                          //   majorName: entry['major'] ?? '',
                                          // );
                                          // Navigator.of(context).pop();
                                        },
                                      ),
                                      backgroundColor: AppColors.delete,
                                      text: "Delete",
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
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class ProgramsForm extends StatefulWidget {
  final List<ProgramVm> programs;

  const ProgramsForm({
    super.key,
    required this.programs,
  });

  @override
  State<ProgramsForm> createState() => _ProgramsFormState();
}

class _ProgramsFormState extends State<ProgramsForm> {
  final _formKey = GlobalKey<FormState>();
  EnumAcademicsAction? selectedAction;

  // Selected values for dropdowns
  ProgramVm? selectedCluster;
  Campus? selectedCampus;
  College? selectedCollege;
  Program? selectedProgram;
  Major? selectedMajor;

  final clusterController = TextEditingController();
  final campusController = TextEditingController();
  final collegeController = TextEditingController();
  final programController = TextEditingController();
  final majorController = TextEditingController();

  ProgramVm? getFormData() {
    if (_formKey.currentState?.validate() ?? false) {
      switch (selectedAction) {
        case EnumAcademicsAction.cluster:
          return ProgramVm(
            cluster: clusterController.text,
            campuses: [],
          );

        case EnumAcademicsAction.campus:
          return ProgramVm(
            id: selectedCluster?.id, // Preserve existing ID
            cluster: selectedCluster?.cluster ?? clusterController.text,
            campuses: [
              ...selectedCluster?.campuses ?? [],
              Campus(
                campusName: campusController.text,
                colleges: [],
              ),
            ],
          );

        case EnumAcademicsAction.college:
          return ProgramVm(
            id: selectedCluster?.id, // Preserve existing ID
            cluster: selectedCluster?.cluster ?? '',
            campuses: [
              Campus(
                campusName: selectedCampus?.campusName ?? '',
                colleges: [
                  ...selectedCampus?.colleges ?? [],
                  College(
                    collegeName: collegeController.text,
                    programs: [],
                  ),
                ],
              ),
            ],
          );

        case EnumAcademicsAction.program:
          return ProgramVm(
            id: selectedCluster?.id, // Preserve existing ID
            cluster: selectedCluster?.cluster ?? '',
            campuses: [
              Campus(
                campusName: selectedCampus?.campusName ?? '',
                colleges: [
                  College(
                    collegeName: selectedCollege?.collegeName ?? '',
                    programs: [
                      ...selectedCollege?.programs ?? [],
                      Program(
                        programName: programController.text,
                        majors: [],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );

        case EnumAcademicsAction.major:
          return ProgramVm(
            id: selectedCluster?.id, // Preserve existing ID
            cluster: selectedCluster?.cluster ?? '',
            campuses: [
              Campus(
                campusName: selectedCampus?.campusName ?? '',
                colleges: [
                  College(
                    collegeName: selectedCollege?.collegeName ?? '',
                    programs: [
                      Program(
                        programName: selectedProgram?.programName ?? '',
                        majors: [
                          Major(majorName: majorController.text),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );

        default:
          return null;
      }
    }
    return null;
  }

  @override
  void dispose() {
    clusterController.dispose();
    campusController.dispose();
    collegeController.dispose();
    programController.dispose();
    majorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'ADD ACADEMIC STRUCTURE',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Gap(20),
          AppDropdownField<EnumAcademicsAction>(
            title: 'Select here to add',
            options: EnumAcademicsAction.values,
            value: selectedAction,
            onChanged: (value) => setState(() {
              selectedAction = value;
              // Reset selections when action changes
              selectedCluster = null;
              selectedCampus = null;
              selectedCollege = null;
              selectedProgram = null;
              selectedMajor = null;
            }),
            optionLabel: (value) => value.value,
          ),
          if (selectedAction != null) ...[
            const Gap(20),
            ..._buildActionFields(),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildActionFields() {
    final action = selectedAction!;
    final fields = <Widget>[];

    switch (action) {
      case EnumAcademicsAction.cluster:
        fields.add(
          AppCustomTextfield(
            controller: clusterController,
            label: 'New Cluster Name',
            validator: (value) => value == null || value.isEmpty
                ? 'Cluster name is required'
                : null,
          ),
        );
        break;

      case EnumAcademicsAction.campus:
        fields.addAll([
          _buildClusterDropdown(),
          const Gap(10),
          AppCustomTextfield(
            controller: campusController,
            label: 'New Campus Name',
            validator: (value) => value == null || value.isEmpty
                ? 'Campus name is required'
                : null,
          ),
        ]);
        break;

      case EnumAcademicsAction.college:
        fields.addAll([
          _buildClusterDropdown(),
          const Gap(10),
          if (selectedCluster != null) ...[
            _buildCampusDropdown(),
            const Gap(10),
          ],
          AppCustomTextfield(
            controller: collegeController,
            label: 'New College Name',
            validator: (value) => value == null || value.isEmpty
                ? 'College name is required'
                : null,
          ),
        ]);
        break;

      case EnumAcademicsAction.program:
        fields.addAll([
          _buildClusterDropdown(),
          const Gap(10),
          if (selectedCluster != null) ...[
            _buildCampusDropdown(),
            const Gap(10),
          ],
          if (selectedCampus != null) ...[
            _buildCollegeDropdown(),
            const Gap(10),
          ],
          AppCustomTextfield(
            controller: programController,
            label: 'New Program Name',
            validator: (value) => value == null || value.isEmpty
                ? 'Program name is required'
                : null,
          ),
        ]);
        break;

      case EnumAcademicsAction.major:
        fields.addAll([
          _buildClusterDropdown(),
          const Gap(10),
          if (selectedCluster != null) ...[
            _buildCampusDropdown(),
            const Gap(10),
          ],
          if (selectedCampus != null) ...[
            _buildCollegeDropdown(),
            const Gap(10),
          ],
          // Show Program dropdown ONLY if College dropdown is set to 'None' (null)
          if (selectedCollege == null || selectedCollege != null) ...[
            _buildProgramDropdown(),
            const Gap(10),
          ],
          AppCustomTextfield(
            controller: majorController,
            label: 'New Major Name',
            validator: (value) {
              if (!(selectedCollege == null && selectedProgram != null)) {
                return 'Please select "None" for College and a Program first';
              }
              if (value == null || value.isEmpty) {
                return 'Major name is required';
              }
              return null;
            },
          ),
        ]);
        break;
    }

    return fields;
  }

  Widget _buildClusterDropdown() {
    return AppDropdownField<ProgramVm>(
      title: 'Select Cluster',
      options: widget.programs,
      value: selectedCluster,
      onChanged: (value) => setState(() {
        selectedCluster = value;
        // Reset dependent dropdowns
        selectedCampus = null;
        selectedCollege = null;
        selectedProgram = null;
        selectedMajor = null;
      }),
      optionLabel: (value) => value.cluster,
    );
  }

  Widget _buildCampusDropdown() {
    return AppDropdownField<Campus>(
      title: 'Select Campus',
      options: selectedCluster?.campuses ?? [],
      value: selectedCampus,
      onChanged: (value) => setState(() {
        selectedCampus = value;
        // Reset dependent dropdowns
        selectedCollege = null;
        selectedProgram = null;
        selectedMajor = null;
      }),
      optionLabel: (value) => value.campusName,
    );
  }

  Widget _buildCollegeDropdown() {
    final colleges = selectedCampus?.colleges ?? [];

    // Filter out colleges where collegeName is null or empty or just whitespace
    final filteredColleges =
        colleges.where((c) => c.collegeName.trim().isNotEmpty).toList();

    return AppDropdownField<College?>(
      title: 'Select College',
      options: [
        null,
        ...filteredColleges
      ], // keep the null option if you want 'None'
      value: selectedCollege,
      onChanged: (value) => setState(() {
        selectedCollege = value;
        selectedProgram = null;
        selectedMajor = null;
      }),
      optionLabel: (value) => value?.collegeName ?? 'None',
    );
  }

  Widget _buildProgramDropdown() {
    List<Program> programsToShow = [];

    if (selectedCampus != null) {
      if (selectedCollege == null) {
        // Show all programs across all colleges under this campus
        for (var college in selectedCampus!.colleges) {
          programsToShow.addAll(college.programs!);
        }
      } else {
        // Show programs inside the selected college only
        programsToShow = selectedCollege!.programs!;
      }
    }

    return AppDropdownField<Program>(
      title: 'Select Program',
      options: programsToShow,
      value: selectedProgram,
      onChanged: (value) => setState(() {
        selectedProgram = value;
        selectedMajor = null;
      }),
      optionLabel: (value) => value.programName,
    );
  }
}
