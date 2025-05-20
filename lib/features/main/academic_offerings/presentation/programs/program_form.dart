import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/core/enum/enum_campus.dart';
import 'package:ipqaia/core/shared/app_custom_textfield.dart';

class ProgramsForm extends StatefulWidget {
  final Campus campus;
  final TextEditingController? program;
  final TextEditingController? college;
  final TextEditingController? cluster;
  final TextEditingController? major;
  const ProgramsForm(
      {super.key,
      this.program,
      this.college,
      this.cluster,
      this.major,
      required this.campus});
  @override
  State<ProgramsForm> createState() => _ProgramsFormState();
}

class _ProgramsFormState extends State<ProgramsForm> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formkey,
        child: Column(
          children: [
            Text(
              'Add Program to ${widget.campus == Campus.main ? 'Main Campus' : 'External Campus'}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Gap(20),
            if (widget.campus == Campus.main)
              AppCustomTextfield(
                controller: widget.college!,
                label: 'College',
                validator: (value) {
                  if (widget.college!.text.isEmpty) {
                    return 'College is required';
                  }
                  return null;
                },
              ),
            AppCustomTextfield(
              controller: widget.program!,
              label: 'Program',
              validator: (value) {
                if (widget.program!.text.isEmpty) {
                  return 'Program is required';
                }
                return null;
              },
            ),
            AppCustomTextfield(
              controller: widget.cluster!,
              label: 'Cluster',
              validator: (value) {
                if (widget.cluster!.text.isEmpty) {
                  return 'Cluster is required';
                }
                return null;
              },
            ),
            AppCustomTextfield(
              controller: widget.major!,
              label: 'Major',
              validator: (value) {
                if (widget.major!.text.isEmpty) {
                  return 'Program is required';
                }
                return null;
              },
            ),
          ],
        ));
  }
}
