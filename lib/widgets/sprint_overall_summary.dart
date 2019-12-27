import 'package:flutter/material.dart';
import 'package:pdb/common/navigation_args.dart';
import 'package:pdb/common/route_constants.dart';
import 'package:pdb/common/styles.dart';
import 'package:pdb/widgets/sprint_statistics_item.dart';

class SprintOverallSummary extends StatelessWidget {
  final int total;
  final int completed;
  final int inProgress;
  final int delayed;
  final String titleText;
  final bool isLoading;
  SprintOverallSummary(
      {this.titleText,
        this.total,
        this.completed,
        this.inProgress,
        this.delayed,
        this.isLoading});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 4.0,
      color: kDBPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                titleText,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Colors.white),
              ),
            ),
            SprintStatisticsItem(
              text: 'Total',
              num: total.toString(),
              color: Colors.white,
            ),
            SprintStatisticsItem(
              text: 'Completed',
              num: completed.toString(),
              color: Colors.white,
            ),
            SprintStatisticsItem(
              text: 'In Progress',
              num: inProgress.toString(),
              color: Colors.white,
            ),
            SprintStatisticsItem(
              text: 'Delayed',
              num: delayed.toString(),
              color: Colors.white,
            ),
            ButtonBarTheme(
              data: ButtonBarThemeData(
                alignment: MainAxisAlignment.end,
              ),
              child: ButtonBar(
                children: <Widget>[
                  if (!isLoading)
                    FlatButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          reformSprintRoute,
                          arguments:
                          ReformSprintStatisticsArguments(sprintNo: 0),
                        );
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      label: Text(
                        'VIEW DETAILS',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
