import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeFlatButton extends StatelessWidget {
  final String text;
  final Function clickHandler;

  AdaptativeFlatButton(this.text, this.clickHandler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(this.text),
            onPressed: clickHandler,
            color: Theme.of(context).primaryColor,
          )
        : FlatButton(
            child: Text(this.text),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: clickHandler,
          );
  }
}
