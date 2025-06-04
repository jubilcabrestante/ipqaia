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
import 'package:ipqaia/talker_service.dart';

@RoutePage()
class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AcademicOfferingsCubit>().getStudentProfiles();
  }

  final List<String> _columnTitle = [
    'Cluster',
    'Campus',
    'Program',
    'Major',
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
        TalkerService.talker.debug(student);
        if (student != null) {
          acadCubit.addStudentProfile(student);
          // Reset filters to show all students including the new one
          acadCubit.updateSelectedCluster('');
          acadCubit.updateSelectedCampus('');
          acadCubit.getStudentProfiles(); // Refresh data
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
                            DataCell(Center(
                                child: Text(student.major ??
                                    '-'))), // Show '-' for null

                            DataCell(Center(child: Text(student.yearEnrolled))),
                            DataCell(Center(
                                child: Text(student.yearGraduate ?? ''))),
                            DataCell(Center(child: Text(student.citizenship))),
                            DataCell(Center(
                              child: Text(
                                  student.ethnicGroup == true ? "Yes" : "No"),
                            )),
                            DataCell(Center(
                                child:
                                    Text(student.financialAssistance ?? ''))),
                            DataCell(
                                Center(child: Text((student.pwd.toString())))),
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
                                          acadCubit.deleteStudentProfileMain(
                                              student.studentId);
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

  // Validation flags
  bool clusterValidated = false;
  bool campusValidated = false;
  bool programValidated = false;

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
      // Additional validation for academic structure
      if (selectedCluster == null) {
        setState(() => clusterValidated = true);
        return null;
      }
      if (selectedCampus == null) {
        setState(() => campusValidated = true);
        return null;
      }
      if (selectedProgram == null) {
        setState(() => programValidated = true);
        return null;
      }

      return StudentProfileVm(
        studentId: studentId.text,
        cluster: selectedCluster!.cluster,
        campus: selectedCampus!.campusName,
        program: selectedProgram!.programName,
        major: selectedMajor?.majorName,
        yearEnrolled: yearEnrolledController.text,
        yearGraduate: yearGraduateController.text.isEmpty
            ? null
            : yearGraduateController.text,
        citizenship: citizenshipController.text,
        ethnicGroup: indigenousPeople,
        financialAssistance:
            financialAssistance.text.isEmpty ? null : financialAssistance.text,
        pwd: pwd, // Keep as boolean for backend
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

        Row(
          children: [
            Expanded(
              child: AppCustomTextfield(
                controller: studentId,
                label: 'Student ID',
                validator: (value) =>
                    value!.isEmpty ? 'Required' : null, // Add validator
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
                validator: (value) => value == null ? 'Select gender' : null,
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
                hintText: 'What kind of financial?',
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppDropdownField<ProgramVm>(
          title: 'Cluster',
          options: widget.programs,
          value: selectedCluster,
          onChanged: (value) => setState(() {
            selectedCluster = value;
            selectedCampus = null;
            selectedCollege = null;
            selectedProgram = null;
            selectedMajor = null;
            clusterValidated = false;
          }),
          optionLabel: (value) => value.cluster,
        ),
        if (clusterValidated && selectedCluster == null)
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              'Cluster is required',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildCampusDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppDropdownField<Campus>(
          title: 'Campus',
          options: selectedCluster?.campuses ?? [],
          value: selectedCampus,
          onChanged: (value) => setState(() {
            selectedCampus = value;
            selectedCollege = null;
            selectedProgram = null;
            selectedMajor = null;
            campusValidated = false;
          }),
          optionLabel: (value) => value.campusName,
        ),
        if (campusValidated && selectedCampus == null)
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              'Campus is required',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
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
      if (selectedCampus != null) {
        for (var college in selectedCampus!.colleges) {
          programsToShow.addAll(college.programs ?? []);
        }
      }
    } else {
      programsToShow = selectedCollege!.programs ?? [];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppDropdownField<Program>(
          title: 'Program',
          options: programsToShow,
          value: selectedProgram,
          onChanged: (value) => setState(() {
            selectedProgram = value;
            selectedMajor = null;
            programValidated = false;
          }),
          optionLabel: (value) => value.programName,
        ),
        if (programValidated && selectedProgram == null)
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              'Program is required',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
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
