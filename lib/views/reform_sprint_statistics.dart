

import 'package:flutter/material.dart';
import 'package:pdb/widgets/sprint_chart.dart';
import 'package:pdb/widgets/sprint_overall_chart.dart';
import 'package:pdb/widgets/sprint_reform_action.dart';
class ReformSprintStatistics extends StatelessWidget {
  final int sprintNo;
  ReformSprintStatistics({this.sprintNo});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pakistan Doing Business'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Reforms',
              ),
              Tab(
                text: 'Status',
              ),
              Tab(
                text: 'Region',
              ),
              Tab(
                text: 'Agency',
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: <Widget>[
              SprintReformAction(sprintNo: sprintNo,),
              SprintOverallChart(sprintNo: sprintNo,),
              SprintChart(agency: false,sprintNo: sprintNo,),
              SprintChart(agency: true,sprintNo: sprintNo,),
            ],
          ),
        ),
      ),
    );
  }
}
