

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/constante_colors.dart';
import '../../common/size_config.dart';

class CustomInput extends StatefulWidget {
  const CustomInput({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.validator,
    this.KeyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassWord = false,
    this.isRequired = false
  });

  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType? KeyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isPassWord;
  final bool isRequired;
  @override
  State<StatefulWidget> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  String? _validateField(String? value){
    if (widget.isRequired && (value == null || value.isEmpty)) {
      return '${widget.labelText}' "est obligatoir"'';
    }
    return widget.validator?.call(value);

  }
  @override
  Widget build(BuildContext context) {
    Sizeconfig.init(context);
    return  TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassWord,
      validator: _validateField,
      decoration: InputDecoration(
          label: Text(widget.labelText),
          hintText: widget.hintText?? '',
          enabledBorder: _buildBorder(
              color: kgreyColor
          ),
          focusedBorder: _buildBorder(
              color: kPrimaryColor
          ),
          errorBorder: _buildBorder(
              color: kErrorColor,
              width: 2
          ),
          focusedErrorBorder: _buildBorder(
              color: kErrorColor),
          contentPadding: EdgeInsets.symmetric(
            horizontal: Sizeconfig.getProportionateScreenWidth(30),
            vertical: Sizeconfig.getProportionateScreenHeight(20),
          ),
          errorStyle: TextStyle(
              fontSize: 16
          ),
          suffixIcon: Icon(
              widget.suffixIcon
          ),
          prefixIcon: Icon(
              widget.prefixIcon
          )
      ),

    );
  }

  static OutlineInputBorder _buildBorder({
    required Color color,
    double width = 1,
  }){
    return  OutlineInputBorder(
        borderSide: BorderSide(
            color: color,
            width: width
        ),
        borderRadius: BorderRadius.circular(20.0)
    );

  }

}