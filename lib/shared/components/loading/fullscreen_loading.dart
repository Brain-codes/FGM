import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const <Widget>[
        Opacity(
          opacity: 0.5,
          child: ModalBarrier(
            color: Colors.grey,
            dismissible: false,
          ),
        ),
        Center(
          child: CupertinoActivityIndicator(),
        ),
      ],
    );
  }
}
