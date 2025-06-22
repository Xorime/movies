import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies/utils/constants.dart';

// ignore: must_be_immutable
class Input extends StatefulWidget {
  String? hint;
  int? minLines;
  String? Function(String?)? validator;
  String? Function(String?)? onSaved;
  String? Function(String?)? onChangeText;
  String? Function(String?)? onFieldSubmittedText;
  void Function()? onTap;
  TextEditingController? controller;
  FloatingLabelBehavior? floating;
  bool isDense;
  TextStyle? style;
  Color? hintStyle;
  InputBorder? inputBorder;
  TextInputType? inputType;
  bool isPassword;
  EdgeInsets? contentPadding;
  Color? bgColor;
  double borderRadius;
  bool enabled;
  Icon? trailing;

  int? maxLength;
  Widget? prefix;
  bool? disabled;
  bool? isPhoneType;
  bool? isCurrency;
  String? labelText;
  TextStyle? labelStyle;
  InputBorder? focusedBorder;
  InputBorder? enabledBorder;
  TextStyle? hintStyleExtended;
  int? maxLines;
  TextCapitalization? textCapitalization;

  Input({
    Key? key,
    this.hint,
    this.hintStyle,
    this.validator,
    this.controller,
    this.onSaved,
    this.minLines,
    this.isPassword = false,
    this.floating,
    this.isDense = false,
    this.style,
    this.inputBorder,
    this.inputType,
    this.onChangeText,
    this.contentPadding,
    this.bgColor,
    this.borderRadius = 0.0,
    this.enabled = true,
    this.trailing,
    this.maxLength = 0,
    this.prefix,
    this.disabled = false,
    this.isPhoneType = false,
    this.onFieldSubmittedText,
    this.isCurrency = false,
    this.onTap,
    this.labelText,
    this.labelStyle,
    this.focusedBorder,
    this.enabledBorder,
    this.hintStyleExtended,
    this.maxLines,
    this.textCapitalization,
  }) : super(key: key);

  @override
  InputState createState() => InputState();
}

class InputState extends State<Input> {
  FocusNode _focusNode = new FocusNode();
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.bgColor ?? Colors.transparent, borderRadius: BorderRadius.circular(widget.borderRadius)),
      child: TextFormField(
          textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
          onTap: widget.onTap,
          maxLength: widget.maxLength! > 0 ? widget.maxLength : null,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          readOnly: widget.disabled ?? false,
          enabled: widget.enabled,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          minLines: widget.minLines ?? 1,
          maxLines: widget.maxLines ?? widget.minLines ?? 1,
          focusNode: _focusNode,
          keyboardType: widget.inputType != null ? widget.inputType : null,
          cursorColor: kColorPrimaryBlue,
          obscureText: showPassword,
          style: widget.style != null ? widget.style : Theme.of(context).textTheme.headlineMedium,
          onChanged: widget.onChangeText != null ? (val) => widget.onChangeText!(val) : null,
          decoration: InputDecoration(
            labelText: widget.labelText,
            contentPadding: widget.contentPadding ?? EdgeInsets.zero,
            isDense: widget.isDense,
            floatingLabelBehavior: widget.floating != null ? widget.floating : FloatingLabelBehavior.auto,
            hintText: widget.hint != null ? "${widget.hint}" : null,
            // labelText: widget.hint != null ? "${widget.hint}" : null,
            // labelText: (widget.floating == FloatingLabelBehavior.never) ? null : widget.hint ?? null,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            hintStyle: widget.hintStyleExtended ?? TextStyle(color: widget.hintStyle ?? kColorCoolGray),
            alignLabelWithHint: true,
            labelStyle: widget.labelStyle ??
                Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _focusNode.hasFocus ? kColorPrimaryBlue : kColorCoolGray,
                    ),
            errorBorder: widget.inputBorder != null
                ? widget.inputBorder
                : UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
            focusedBorder: widget.inputBorder ??
                widget.focusedBorder ??
                UnderlineInputBorder(
                  borderSide: BorderSide(color: kColorPrimaryBlue, width: 2),
                ),
            enabledBorder: widget.inputBorder ??
                widget.enabledBorder ??
                UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.25)),
                ),
            disabledBorder: widget.inputBorder != null
                ? widget.inputBorder
                : UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[700]!),
                  ),
            border: widget.inputBorder != null ? widget.inputBorder : UnderlineInputBorder(),
            suffixIcon:
                widget.isPassword ? InkWell(onTap: () => togglePassword(), child: _trailingIcon()) : widget.trailing,
            prefixIcon: widget.prefix,
            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
          ),
          controller: widget.controller,
          validator: widget.validator,
          onSaved: widget.onSaved,
          onFieldSubmitted: widget.onFieldSubmittedText ?? null),
    );
  }

  Icon _trailingIcon() {
    return Icon(
      showPassword ? Icons.visibility : Icons.visibility_off,
      color: Colors.grey[400],
    );
  }

  void togglePassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }
}
