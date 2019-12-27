import 'package:flutter/material.dart';
import 'package:pdb/common/styles.dart';

class ViewTitle extends StatelessWidget {
  final String text;
  ViewTitle({this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 15),
      decoration: BoxDecoration(
        color: kDBPrimaryColor,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20)),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
      ),
    );
  }
}
