import 'package:flutter/material.dart';

extension EmptyPadding on num {
  get ph => SizedBox(
        height: toDouble(),
      );
  get pw => SizedBox(
        width: toDouble(),
      );
}
