import 'package:flutter/material.dart';

class SprintStatisticsItem extends StatelessWidget {
  final String text;
  final String num;
  final Color color;
  SprintStatisticsItem({this.text,this.num,this.color});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: Theme.of(context).textTheme.subtitle.copyWith(color: color),
          ),
          Text(
            num,
            style: Theme.of(context).textTheme.subtitle.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}