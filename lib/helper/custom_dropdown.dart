import 'package:flutter/material.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class CustomDropdownWidget extends StatelessWidget {
  final String labelText;
  final List<String> options;
  final String selectedValue;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const CustomDropdownWidget({
    super.key,
    required this.labelText,
    required this.options,
    required this.selectedValue,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        // hintText: labelText,
        // Use the same border styles and dimensions as CustomTextField
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 0.3,
            color: Theme.of(context).primaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 1,
            color: Theme.of(context).primaryColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 0.3,
            color: Theme.of(context).primaryColor,
          ),
        ),
        isDense: true,
        fillColor: Theme.of(context).cardColor,
        filled: true,
        hintStyle: robotoRegular.copyWith(
          fontSize: Dimensions.fontSizeLarge,
          color: Theme.of(context).hintColor,
        ),
      ),
      value: selectedValue.isEmpty ? null : selectedValue,
      items: options.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(
            option,
            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
          ),
        );
      }).toList(),
      onChanged: (value) {
        // selectedValue = value!;
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      validator: validator ??
          (value) => value == null || value.isEmpty
              ? 'Please select your $labelText'
              : null,
    );
  }
}
