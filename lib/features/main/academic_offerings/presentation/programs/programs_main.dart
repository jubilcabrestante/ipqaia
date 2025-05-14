import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/shared/app_containers/app_body_container.dart';
import 'package:ipqaia/core/shared/app_drop_down_field.dart';
import 'package:ipqaia/features/main/academic_offerings/domain/academic_offerings/academic_offerings_cubit.dart';

@RoutePage()
class ProgramsMainScreen extends StatefulWidget {
  const ProgramsMainScreen({super.key});

  @override
  State<ProgramsMainScreen> createState() => _ProgramsMainScreenState();
}

class _ProgramsMainScreenState extends State<ProgramsMainScreen> {
  final TextEditingController _college = TextEditingController();
  final List<String> _programs = [
    'All',
    'BSc Computer Science',
    'BSc Information Technology',
    'BSc Software Engineering',
    'BSc Data Science',
    'BSc Cyber Security',
  ];

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
                  width: 300,
                  child: AppDropdownField<String>(
                    title: 'PSU College',
                    options: _programs,
                    value: _college.text.isNotEmpty ? _college.text : null,
                    optionLabel: (value) => value,
                    onChanged: (value) {
                      setState(() {
                        _college.text = value ?? '';
                      });
                    },
                    validator: (value) =>
                        value == null ? "Select college here" : null,
                  ),
                ),
                // SizedBox(
                //   width: 200,
                //   child: AppDropdownField<String>(
                //     title: "Select program here",
                //     options: ['All'] + _programs,
                //     // state.program
                //     //     .map((p) => p.program)
                //     //     .whereType<String>()
                //     //     .toSet()
                //     //     .toList(),
                //     value: state.selectedProgram,
                //     onChanged: (value) {
                //       context
                //           .read<AcademicOfferingsCubit>()
                //           .updateSelectedProgram(value!);

                //       // TODO: Add search using program
                //     },
                //     optionLabel: (option) => option,
                //   ),
                // ),
                Gap(20),
                SizedBox(
                  width: 300,
                  child: AppDropdownField<String>(
                    title: 'Semester Year',
                    options: _programs,
                    value: _college.text.isNotEmpty ? _college.text : null,
                    optionLabel: (value) => value,
                    onChanged: (value) {
                      setState(() {
                        _college.text = value ?? '';
                      });
                    },
                    validator: (value) =>
                        value == null ? "Select college here" : null,
                  ),
                ),
                // SizedBox(
                //   width: 200,
                //   child: AppDropdownField<String>(
                //     title: "Select year here", options: ['All'] + _programs,
                //     // state.program
                //     //     .map((p) => p.perYear)
                //     //     .whereType<String>()
                //     //     .toSet()
                //     //     .toList(),
                //     value: state.selectedYear,
                //     onChanged: (value) {
                //       context
                //           .read<AcademicOfferingsCubit>()
                //           .updateSelectedYear(value!);

                //       // TODO: Add search using year
                //     },
                //     optionLabel: (option) => option,
                //   ),
                // )
              ],
            ),
          ),
          body: AppBodyContainer(
            child: Column(
              children: [],
            ),
          ),
        );
      },
    );
  }
}
