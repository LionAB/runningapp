import 'package:flutter/material.dart';
import 'package:test/color.dart';
import 'package:test/components/text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final TextEditingController myController;
  const RoundedPasswordField({
    Key? key,
    required this.myController,
  }) : super(key: key);

  @override
  _RoundedPasswordField createState() => _RoundedPasswordField();
}

class _RoundedPasswordField extends State<RoundedPasswordField> {
  @override
  Widget build(BuildContext context) {
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

    return TextFieldContainer(
        child: TextFormField(
      validator: ((value) => value!.isEmpty ? 'Entre un email valide' : null),
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Mot de passe",
        icon: Icon(
          Icons.lock,
          color: primaryColor,
        ),
        suffixIcon: Icon(
          Icons.visibility,
          color: primaryColor,
        ),
        border: InputBorder.none,
      ),
      controller: widget.myController,
    ));
  }
}
