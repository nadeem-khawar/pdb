import 'package:flutter/material.dart';
import 'package:pdb/common/navigation_args.dart';
import 'package:pdb/common/route_constants.dart';
import 'package:pdb/models/reform_sprint.dart';
import 'package:pdb/widgets/sprint_statistics_item.dart';

class SprintSummary extends StatelessWidget {
  final List<ReformSprint> reformSprint;
  SprintSummary({this.reformSprint});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: reformSprint.length,
        itemBuilder: (ctx, index) {
          final sprint = reformSprint[index];
          final sprintNo = sprint.sprintNo.toString();
          final totalItems = sprint.totalItems.toString();
          final completed = sprint.completed.toString();
          final inProgress = sprint.inProgress.toString();
          final delayed = sprint.delayed.toString();

          return Card(
            margin: EdgeInsets.all(10),
            elevation: 1,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '100 DAYS REFORM SPRINT $sprintNo',
                          style: Theme.of(context).textTheme.title,
                        ),
                        Text(
                          totalItems,
                          style: Theme.of(context).textTheme.title,
                        ),
                      ],
                    ),
                  ),
                  SprintStatisticsItem(text:'Completed', num:completed,color: Colors.black,),
                  SprintStatisticsItem(text:'In Progress', num:inProgress,color: Colors.black),
                  SprintStatisticsItem(text:'Delayed', num:delayed,color: Colors.black),
                  ButtonBarTheme(
                    data: ButtonBarThemeData(
                      alignment: MainAxisAlignment.end,
                    ),
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton.icon(
                          onPressed: (){
                            Navigator.pushNamed(
                              context,
                              reformSprintRoute,
                              arguments: ReformSprintStatisticsArguments(
                                  sprintNo: int.parse(sprint.sprintNo)),
                            );
                          },
                          icon: Icon(Icons.navigate_next),
                          label: Text('VIEW DETAILS'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
