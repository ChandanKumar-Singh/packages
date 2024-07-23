import 'package:flutter/material.dart';
import '/utils/extentions/index.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? label;
  final Widget? prefix;
  final bool isPassword;
  final TextInputAction inputAction;
  final TextInputType keyboardType;
  final String? hint;
  final bool shadow;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final bool readOnly;
  final bool enabled;
  final String? initialValue;
  final bool required;
  final Function(String)? onSubmit;
  final List<String> autofillHints;

  const MyTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.label,
    this.prefix,
    this.isPassword = false,
    this.inputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.hint,
    this.shadow = false,
    this.validator,
    this.onSubmit,
    this.readOnly = false,
    this.enabled = true,
    this.initialValue,
    this.onTap,
    this.required = true,
    this.autofillHints = const [],
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  ValueNotifier<bool> obscure = ValueNotifier<bool>(false);
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (widget.isPassword) {
      obscure.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputDecorationTheme = Theme.of(context).inputDecorationTheme;

    return ValueListenableBuilder<bool>(
        valueListenable: obscure,
        builder: (context, hidden, child) {
          return Container(
            decoration: !widget.shadow
                ? null
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: inputDecorationTheme.fillColor ??
                        (context.isDark ? Colors.grey[800] : Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
            child: TextFormField(
                autocorrect: true,
                controller: _controller,
                onChanged: widget.onChanged,
                obscureText: hidden,
                readOnly: widget.readOnly,
                enabled: widget.enabled,
                initialValue: widget.initialValue,
                validator: _validator,
                onTap: widget.onTap,
                autofillHints: widget.autofillHints,
                onFieldSubmitted: (value) {
                  if (widget.inputAction == TextInputAction.next) {
                    FocusScope.of(context).nextFocus();
                    return;
                  }
                  if (widget.inputAction == TextInputAction.done) {
                    FocusScope.of(context).unfocus();
                    widget.onSubmit?.call(value);
                    return;
                  }
                },
                textInputAction: widget.inputAction,
                keyboardType: widget.keyboardType,
                decoration: InputDecoration(
                  hintStyle: inputDecorationTheme.hintStyle,
                  border: inputDecorationTheme.border,
                  labelText: widget.label,
                  prefixIcon: widget.prefix,
                  hintText: widget.hint,
                  suffixIcon: widget.isPassword
                      ? IconButton(
                          icon: Icon(
                              hidden ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            obscure.value = !hidden;
                          },
                        )
                      : null,
                )),
          );
        });
  }

  String? _validator(String? value) {
    if (widget.required && value.isNullOrEmpty) {
      return 'This field is required';
    }
    return widget.validator?.call(value);
  }
}
