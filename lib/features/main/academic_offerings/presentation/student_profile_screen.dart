import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/shared/app_containers/app_body_container.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';
import 'package:ipqaia/core/shared/app_dialog.dart';
import 'package:ipqaia/core/shared/app_drop_down_field.dart';
import 'package:ipqaia/features/main/academic_offerings/domain/academic_offerings/academic_offerings_cubit.dart';
import 'package:ipqaia/features/main/academic_offerings/repository/program_model/program_vm.dart';
import 'package:ipqaia/core/shared/app_custom_textfield.dart';
import 'package:ipqaia/features/main/academic_offerings/repository/student_profile_model/student_profile_vm.dart';

@RoutePage()
class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  final List<String> _columnTitle = [
    'Cluster',
    'Campus',
    'College',
    'Program',
    'Major',
    'Gender',
    'Year Enrolled',
    'Year Graduate',
    'Citizenship',
    'Indigenous People',
    'Financial Assistance',
    'PWD',
    'Actions',
  ];

  void _showAddStudentDialog() {
    final acadCubit = context.read<AcademicOfferingsCubit>();
    final formKey = GlobalKey<_StudentProfileFormState>();

    AppDialog.showCustomFormDialog(
      width: 800,
      context: context,
      onClose: () {},
      formFields: [
        StudentProfileForm(
          key: formKey,
          programs: acadCubit.state.program,
        ),
      ],
      isLoading: acadCubit.state.isLoading,
      onSubmit: () {
        final student = formKey.currentState?.getFormData();
        if (student != null) {
          acadCubit.addStudentProfile(student);
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
                  text: 'Add Student',
                  ontab: _showAddStudentDialog,
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
                      rows: state.studentProfile.map((student) {
                        return DataRow(
                          cells: [
                            DataCell(Center(child: Text(student.cluster))),
                            DataCell(Center(child: Text(student.campus))),
                            DataCell(Center(child: Text(student.program))),
                            DataCell(Center(child: Text(student.major ?? ''))),
                            DataCell(Center(child: Text(student.yearEnrolled))),
                            DataCell(
                                Center(child: Text(student.ethnicGroup ?? ''))),
                            DataCell(Center(
                                child: Text(student.financialAssistance != null
                                    ? 'Yes'
                                    : 'No'))),
                            DataCell(Center(
                                child:
                                    Text(student.pwd != null ? 'Yes' : 'No'))),
                            DataCell(
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppCustomButton(
                                      ontab: () =>
                                          AppDialog.showCustomAlertDialog(
                                        context,
                                        'Delete Student',
                                        'Are you sure you want to delete this student profile?',
                                        buttonText: "Delete",
                                        showCancelButton: true,
                                        onPressed: () {
                                          // acadCubit.deleteStudentProfileMain(
                                          //     student.id);
                                          Navigator.of(context).pop();
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

class StudentProfileForm extends StatefulWidget {
  final List<ProgramVm> programs;

  const StudentProfileForm({
    super.key,
    required this.programs,
  });

  @override
  State<StudentProfileForm> createState() => _StudentProfileFormState();
}

class _StudentProfileFormState extends State<StudentProfileForm> {
  final _formKey = GlobalKey<FormState>();

  // Academic structure
  ProgramVm? selectedCluster;
  Campus? selectedCampus;
  College? selectedCollege;
  Program? selectedProgram;
  Major? selectedMajor;

  // Student details
  final genderController = TextEditingController();
  final yearEnrolledController = TextEditingController();
  final yearGraduateController = TextEditingController();
  final citizenshipController = TextEditingController();
  bool indigenousPeople = false;
  final financialAssistance = TextEditingController();

  final studentId = TextEditingController();
  bool pwd = false;

  StudentProfileVm? getFormData() {
    if (_formKey.currentState?.validate() ?? false) {
      return StudentProfileVm(
        studentId: '',
        cluster: selectedCluster?.cluster ?? '',
        campus: selectedCampus?.campusName ?? '',
        program: selectedProgram?.programName ?? '',
        major: selectedMajor?.majorName ?? '',
        yearEnrolled: yearEnrolledController.text,
        ethnicGroup: '',
        financialAssistance: financialAssistance.text,
        pwd: pwd ? 'Yes' : 'No',
      );
    }
    return null;
  }

  @override
  void dispose() {
    genderController.dispose();
    yearEnrolledController.dispose();
    yearGraduateController.dispose();
    citizenshipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'ADD STUDENT PROFILE',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Gap(20),
            _buildAcademicStructureFields(),
            const Gap(20),
            _buildStudentDetailsFields(),
          ],
        ),
      ),
    );
  }

  Widget _buildAcademicStructureFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Academic Information',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const Gap(10),
        Row(
          children: [
            Expanded(
              child: _buildClusterDropdown(),
            ),
            const Gap(10),
            Expanded(
              child: _buildCampusDropdown(),
            ),
          ],
        ),
        const Gap(10),
        Row(
          children: [
            Expanded(
              child: _buildCollegeDropdown(),
            ),
            const Gap(10),
            Expanded(
              child: _buildProgramDropdown(),
            ),
          ],
        ),
        const Gap(10),
        Row(
          children: [
            Expanded(
              child: _buildMajorDropdown(),
            ),
            const Gap(10),
            Expanded(child: Container()), // Spacer
          ],
        ),
      ],
    );
  }

  Widget _buildStudentDetailsFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Student Details',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const Gap(10),

        // Row 1: Student ID, Gender, Year Enrolled
        Row(
          children: [
            Expanded(
              child: AppCustomTextfield(
                controller: studentId,
                label: 'Student ID',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
            ),
            const Gap(10),
            Expanded(
              child: AppDropdownField<String>(
                title: 'Gender',
                options: ['Male', 'Female', 'Other'],
                value: genderController.text.isEmpty
                    ? null
                    : genderController.text,
                onChanged: (value) {
                  setState(() {
                    genderController.text = value!;
                  });
                },
                optionLabel: (option) => option,
              ),
            ),
            const Gap(10),
            Expanded(
              child: AppCustomTextfield(
                controller: yearEnrolledController,
                label: 'Year Enrolled',
                validator: (value) => value == null || value.isEmpty
                    ? 'Year enrolled is required'
                    : null,
              ),
            ),
          ],
        ),

        const Gap(10),

        // Row 2: Year Graduated, Citizenship
        Row(
          children: [
            Expanded(
              child: AppCustomTextfield(
                controller: yearGraduateController,
                label: 'Year Graduate',
              ),
            ),
            const Gap(10),
            Expanded(
              child: AppCustomTextfield(
                controller: citizenshipController,
                label: 'Citizenship',
                validator: (value) => value == null || value.isEmpty
                    ? 'Citizenship is required'
                    : null,
              ),
            ),
          ],
        ),

        const Gap(10),

        // Row 3: Financial Assistance, Indigenous People, PWD
        Row(
          children: [
            Expanded(
              child: AppCustomTextfield(
                controller: financialAssistance,
                label: 'Financial Assistance',
                hintText: 'Enter details or amount',
              ),
            ),
            const Gap(10),
            Expanded(
              child: CheckboxListTile(
                title: const Text('Indigenous People'),
                value: indigenousPeople,
                onChanged: (value) {
                  setState(() {
                    indigenousPeople = value ?? false;
                  });
                },
              ),
            ),
            const Gap(10),
            Expanded(
              child: CheckboxListTile(
                title: const Text('PWD'),
                value: pwd,
                onChanged: (value) {
                  setState(() {
                    pwd = value ?? false;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildClusterDropdown() {
    return AppDropdownField<ProgramVm>(
      title: 'Cluster',
      options: widget.programs,
      value: selectedCluster,
      onChanged: (value) => setState(() {
        selectedCluster = value;
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
      title: 'Campus',
      options: selectedCluster?.campuses ?? [],
      value: selectedCampus,
      onChanged: (value) => setState(() {
        selectedCampus = value;
        selectedCollege = null;
        selectedProgram = null;
        selectedMajor = null;
      }),
      optionLabel: (value) => value.campusName,
    );
  }

  Widget _buildCollegeDropdown() {
    final colleges = selectedCampus?.colleges ?? [];
    return AppDropdownField<College?>(
      title: 'College (or None)',
      options: [null, ...colleges],
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

    if (selectedCollege == null) {
      // Show all programs in the campus if college is None
      if (selectedCampus != null) {
        for (var college in selectedCampus!.colleges) {
          programsToShow.addAll(college.programs ?? []);
        }
      }
    } else {
      // Show programs in selected college
      programsToShow = selectedCollege!.programs ?? [];
    }

    return AppDropdownField<Program>(
      title: 'Program',
      options: programsToShow,
      value: selectedProgram,
      onChanged: (value) => setState(() {
        selectedProgram = value;
        selectedMajor = null;
      }),
      optionLabel: (value) => value.programName,
    );
  }

  Widget _buildMajorDropdown() {
    return AppDropdownField<Major>(
      title: 'Major',
      options: selectedProgram?.majors ?? [],
      value: selectedMajor,
      onChanged: (value) => setState(() {
        selectedMajor = value;
      }),
      optionLabel: (value) => value.majorName,
    );
  }
}
