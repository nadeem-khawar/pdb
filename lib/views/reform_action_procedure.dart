import 'package:flutter/material.dart';
import 'package:pdb/common/styles.dart';
import 'package:pdb/view_models/reform_action_procedure_model.dart';
import 'package:pdb/widgets/pdb_appbar.dart';
import 'package:pdb/widgets/placeholder/placehoder_list.dart';
import 'package:pdb/widgets/placeholder/placeholder_card_short.dart';
import 'package:pdb/widgets/reform_procedure_item.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ReformActionProcedure extends StatefulWidget {
  final int reformTopicId;
  ReformActionProcedure({this.reformTopicId});
  @override
  _ReformActionProcedureState createState() => _ReformActionProcedureState();
}

class _ReformActionProcedureState extends State<ReformActionProcedure>
    with AfterLayoutMixin<ReformActionProcedure> {
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<ReformActionProcedureModel>(context)
        .fetchReformTopicProcedureArea(widget.reformTopicId);
  }

  @override
  Widget build(BuildContext context) {
    final ReformActionProcedureModel reformActionProcedureModel =
        Provider.of<ReformActionProcedureModel>(context);
    return Scaffold(
      appBar: PDBAppBar(
        title: 'PROCEDURE',
      ),
      body: SafeArea(
        child: ListenableProvider.value(
          value: reformActionProcedureModel,
          child: Consumer<ReformActionProcedureModel>(
            builder: (context, model, _) {
              if (model.busy) {
                return PlaceHolderList(
                  itemCount: 10,
                  child: PlaceholderCardShort(
                    color: kDBPrimaryColor,
                    backgroundColor: Color(0XFFC0C0C0),
                    height: 100,
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: model.reformProcedureArea.length,
                    itemBuilder: (context, index) {
                      return StickyHeader(
                          header: Container(
                            color: kDBPrimaryColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              model.reformProcedureArea[index].area,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children:
                                model.reformProcedureArea[index].procedures
                                    .map((item) => ReformProcedureItem(
                                          agency: item.agency,
                                          cost: item.cost,
                                          precessingTime: item.processingTime,
                                          stepDescription: item.stepDescription,
                                        ))
                                    .toList(),
                          ));
                    });
              }
            },
          ),
        ),
      ),
    );
  }
}
