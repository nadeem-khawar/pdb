import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class ReformItemCard extends StatelessWidget {
  final String actionName;
  final String status;
  final String agencyName;
  ReformItemCard({this.actionName,this.status,this.agencyName});
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:
              CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: status.toLowerCase() ==
                      'completed'
                      ? Icon(
                    FontAwesomeIcons.check,
                    color: Colors.green,
                  )
                      : Icon(
                    FontAwesomeIcons.spinner,
                    color:
                    status.toLowerCase() ==
                        'delayed'
                        ? Colors.orange
                        : Colors.red,
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        actionName,
                        style:
                        Theme.of(context).textTheme.title,
                      ),
                      Text(
                        agencyName,
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                  },
                  icon: Icon(Icons.feedback),
                  label: Text('Feedback'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
