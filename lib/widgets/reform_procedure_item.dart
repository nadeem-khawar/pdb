import 'package:flutter/material.dart';

class ReformProcedureItem extends StatelessWidget {
  final String stepDescription;
  final String agency;
  final String precessingTime;
  final String cost;
  ReformProcedureItem({this.stepDescription,this.agency,this.cost,this.precessingTime});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 5, right: 5, top: 5, bottom: 5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$stepDescription',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.title,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                Text(
                  '$agency',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Row(
              //crossAxisAlignment: CrossAxisAlignment,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Time to complete',
                  style: Theme.of(context).textTheme.subhead,
                ),
                Text(
                  precessingTime,
                  style: Theme.of(context).textTheme.subhead,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Asscoiated cost',
                  style: Theme.of(context).textTheme.subhead,
                ),
                Text(
                  '$cost',
                  style: Theme.of(context).textTheme.subhead,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
