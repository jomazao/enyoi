import 'package:flutter/material.dart';

abstract class TextStyles {
  static final TextStyle bodyM = TextStyle(fontSize: 14, fontFamily: 'Inter');

  static final TextStyle bodyS = TextStyle(fontSize: 12);

  static final TextStyle header3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w900,
  );
  static final TextStyle header4 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
}
