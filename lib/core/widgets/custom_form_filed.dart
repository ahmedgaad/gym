import 'package:flutter/material.dart';
import 'package:gym/core/extensions/sized_box.dart';
import 'package:gym/core/utils/colors.dart';

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    super.key,
    required this.controller,
    this.keyboardType,
    this.hint,
    this.prefixIC,
    this.suffixIC,
    this.insertTitle = false,
    this.title,
    this.obscureText, 
    this.onChanged,
  });

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hint;
  final Widget? prefixIC;
  final Widget? suffixIC;
  final bool insertTitle;
  final String? title;
  final bool? obscureText; 
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (insertTitle) ...[
          Text(
            title ?? '',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: ColorUtils.grey4A),
          ),
          8.ph,
        ],
        SizedBox(
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: ColorUtils.primary,
            autocorrect: true,
            keyboardType: keyboardType,
            controller: controller,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            obscureText: obscureText ?? false,
            decoration: InputDecoration(
              filled: true,
              fillColor: ColorUtils.whiteF3,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 19, horizontal: 13),
              hintText: hint,
              hintMaxLines: 1,
              hintStyle:
                  const TextStyle(color: ColorUtils.grey4A, fontSize: 14),
              prefixIcon: prefixIC,
              suffixIcon: suffixIC,
              suffixIconColor: ColorUtils.grey4A,
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
