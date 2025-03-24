import 'package:flutter/material.dart';

class DropdownField<T> extends StatelessWidget {
  final String title;
  final List<T> options;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String Function(T) optionLabel;

  const DropdownField({
    super.key,
    required this.title,
    required this.options,
    required this.value,
    required this.onChanged,
    required this.optionLabel,
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
          width: 150, // Adjust width as needed
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
          ),
        ),
      ],
    );
  }
}
