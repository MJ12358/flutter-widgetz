import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class AuthButtonPage extends StatelessWidget {
  const AuthButtonPage({super.key});

  // ignore: prefer_function_declarations_over_variables
  static final VoidCallback _defaultOnTap = () {};

  @override
  Widget build(BuildContext context) {
    return SpacedColumn(
      children: <Widget>[
        AuthButton.apple(onTap: _defaultOnTap),
        AuthButton.facebook(onTap: _defaultOnTap),
        AuthButton.github(onTap: _defaultOnTap),
        AuthButton.google(onTap: _defaultOnTap),
        AuthButton.microsoft(onTap: _defaultOnTap),
        AuthButton.twitter(onTap: _defaultOnTap),
      ],
    );
  }
}
