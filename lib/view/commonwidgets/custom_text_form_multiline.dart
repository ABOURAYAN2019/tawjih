import 'package:flutter/material.dart';
import 'package:tawjih/core/constant/text_styles.dart';

class CustumtextformfieldMultiline extends StatelessWidget {
  final String? headingText;
  final String hintText;
  final bool readonly;

  final Widget? prefixIcon;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final String? Function(String?)? valid;
  final void Function(String?)? onSave;
  final void Function()? onTap;
  const CustumtextformfieldMultiline({
    Key? key,
    this.headingText,
    required this.hintText,
    required this.readonly,
    this.textInputType,
    this.textInputAction,
    this.controller,
    this.onSave,
    this.onTap,
    this.prefixIcon,
    this.valid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          keyboardType: TextInputType.multiline,
          minLines: 1, // <-- SEE HERE
          maxLines: 3,
          validator: valid,
          onSaved: onSave,
          readOnly: readonly,
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(vertical: 15.0),
              prefixIcon: prefixIcon,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.5, color: Colors.green),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.5, color: Colors.grey),
              )),
        ));
  }
}
