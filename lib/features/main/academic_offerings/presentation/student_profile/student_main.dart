import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/shared/app_containers/app_body_container.dart';
import 'package:ipqaia/core/shared/app_drop_down_field.dart';

@RoutePage()
class StudentMainScreen extends StatefulWidget {
  const StudentMainScreen({super.key});

  @override
  State<StudentMainScreen> createState() => _StudentMainScreenState();
}

class _StudentMainScreenState extends State<StudentMainScreen> {
  final TextEditingController _college = TextEditingController();
  final List<String> options = [
    'PSU College',
    'PSU College 2',
    'PSU College 3',
    'PSU College 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundSecondary,
          title: Row(
            children: [
              LayoutBuilder(builder: (context, constraints) {
                return ConstrainedBox(
                  constraints: constraints.maxWidth > 600
                      ? const BoxConstraints(maxWidth: 300)
                      : const BoxConstraints(maxWidth: 200),
                  child: AppDropdownField<String>(
                    title: 'PSU College',
                    options: options,
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
                );
              }),
            ],
          ),
        ),
        body: AppBodyContainer(
          child: Column(),
        ));
  }
}
