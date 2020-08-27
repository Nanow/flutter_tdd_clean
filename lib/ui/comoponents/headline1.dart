import 'package:flutter/material.dart';

class HeadLine1 extends StatelessWidget {
  final String text;
  const HeadLine1({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline1,
    );
  }
}
