import 'package:flutter/material.dart';
import 'package:pdb/view_models/reform_sprints_model.dart';
import 'package:pdb/widgets/pdb_appbar.dart';
import 'package:pdb/widgets/placeholder/placehoder_list.dart';
import 'package:pdb/widgets/placeholder/placeholder_card_short.dart';
import 'package:pdb/widgets/sprint_overall_summary.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pdb/widgets/sprint_summary.dart';
import 'package:provider/provider.dart';
class ReformSprints extends StatefulWidget {
  @override
  _ReformSprintsState createState() => _ReformSprintsState();
}

class _ReformSprintsState extends State<ReformSprints> with AfterLayoutMixin<ReformSprints>{

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<ReformSprintsModel>(context).getOverall();
  }

  @override
  Widget build(BuildContext context) {
    final reformPlanModel = Provider.of<ReformSprintsModel>(context);

    return Scaffold(
      appBar: PDBAppBar(title: 'REFORM SPRINTS',),
      body: SafeArea(
        child: ListenableProvider.value(
          value: reformPlanModel,
          child: Consumer<ReformSprintsModel>(
            builder: (context, value, _) {
              return Column(children: <Widget>[
                SprintOverallSummary(
                  isLoading: value.busy? true:false,
                  titleText: value.busy? 'LOADING...':'PERFORMANCE DASHBOARD',
                  total: value.busy? 0: value.reformOverall.totalItems,
                  completed: value.busy? 0: value.reformOverall.completed,
                  inProgress: value.busy? 0: value.reformOverall.inProgress,
                  delayed: value.busy? 0: value.reformOverall.delayed,
                ),
                if(value.busy == true)
                  Expanded(
                    child: PlaceHolderList(
                      itemCount: 10,
                      child: PlaceholderCardShort(
                        color: Color(0XFFACACAA),
                        backgroundColor: Color(0XFFDEDEDC),
                        height: 100,
                      ),
                    ),
                  ),
                if(value.busy == false)
                  Expanded(
                    child: SprintSummary(
                    reformSprint: value.reformSprints,
                  ),
                ),
              ]);
            },
          ),
        ),
      ),
    );
  }
}
