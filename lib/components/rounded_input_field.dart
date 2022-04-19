import 'package:flutter/material.dart';
import 'package:test/color.dart';
import 'package:test/components/text_field_container.dart';

class RoundedInputField extends StatefulWidget {
  final String hintText;
  final TextEditingController myController;
  const RoundedInputField(
      {Key? key, required this.hintText, required this.myController})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _RoundedInputField createState() => _RoundedInputField();
}

class _RoundedInputField extends State<RoundedInputField> {
//  _RoundedInputField(TextEditingController myController);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      // ignore: prefer_const_constructors
      child: TextFormField(
        validator: ((value) => value!.isEmpty ? 'Entre un email valide' : null),
        decoration: InputDecoration(
          icon: Icon(
            Icons.person,
            color: primaryColor,
          ),
          hintText: "Email",
          border: InputBorder.none,
        ),
        controller: widget.myController,
      ),
    );
  }
}
