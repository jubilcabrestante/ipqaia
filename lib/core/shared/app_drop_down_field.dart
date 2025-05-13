import 'package:flutter/material.dart';

class AppDropdownField<T> extends StatelessWidget {
  final String title;
  final List<T> options;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String Function(T) optionLabel;
  final String? Function(T?)? validator;

  const AppDropdownField({
    super.key,
    required this.title,
    required this.options,
    required this.value,
    required this.onChanged,
    required this.optionLabel,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$title :",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold)),
        SizedBox(
          width: 250,
          child: DropdownButtonFormField<T>(
            value: value,
            onChanged: onChanged,
            items: options.map((T option) {
              return DropdownMenuItem<T>(
                value: option,
                child: Text(optionLabel(option)),
              );
            }).toList(),
            hint: Text("Select here"), // Displays when no option is selected
            decoration: const InputDecoration(
              border: InputBorder.none, // Removes underline
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
