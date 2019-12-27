import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pdb/common/styles.dart';
import 'package:pdb/models/reform_action.dart';
import 'package:pdb/models/reform_data.dart';
import 'package:pdb/view_models/reform_sprint_statistics_model.dart';
import 'package:pdb/view_models/sprint_reform_action_model.dart';
import 'package:pdb/widgets/backdrop/backdrop_panel.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pdb/widgets/placeholder/placehoder_list.dart';
import 'package:pdb/widgets/placeholder/placeholder_card_short.dart';
import 'package:pdb/widgets/reform_item_card.dart';
import 'package:provider/provider.dart';

class SprintChart extends StatefulWidget {
  final int sprintNo;
  final bool agency;
  SprintChart({this.sprintNo, this.agency});
  @override
  _SprintChartState createState() => _SprintChartState();
}

class _SprintChartState extends State<SprintChart>
    with
        AutomaticKeepAliveClientMixin<SprintChart>,
        AfterLayoutMixin<SprintChart>,
        SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<ReformSprintStatisticsModel>(context, listen: false)
        .getSprintStatistics(widget.sprintNo);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  bool get _backdropPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropPanelVisibility() {
    _controller.fling(velocity: _backdropPanelVisible ? -2.0 : 2.0);
  }

  double get _backdropHeight {
    final RenderBox renderBox =
        _backdropKey.currentContext.findRenderObject() as RenderBox;
    return renderBox.size.height;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    _controller.value -=
        details.primaryDelta / (_backdropHeight ?? details.primaryDelta);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / _backdropHeight;
    if (flingVelocity < 0.0)
      _controller.fling(velocity: math.max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: math.min(-2.0, -flingVelocity));
    else
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
  }

  List<charts.Series<ChartData, String>> _createData(
      List<ReformDataCategory> agencyReformData) {
    List<ChartData> completedData = [];
    List<ChartData> inProgressData = [];
    List<ChartData> delayedData = [];

    for (ReformDataCategory reformDataCategory in agencyReformData) {
      completedData.add(
          ChartData(reformDataCategory.name, reformDataCategory.completed));
      inProgressData.add(
          ChartData(reformDataCategory.name, reformDataCategory.inProgress));
      delayedData
          .add(ChartData(reformDataCategory.name, reformDataCategory.delayed));
    }

    return [
      new charts.Series<ChartData, String>(
        id: 'Completed',
        domainFn: (ChartData data, _) => data.name,
        measureFn: (ChartData data, _) => data.noOfReforms,
        data: completedData,
      ),
      new charts.Series<ChartData, String>(
        id: 'In Progress',
        domainFn: (ChartData data, _) => data.name,
        measureFn: (ChartData data, _) => data.noOfReforms,
        data: inProgressData,
      ),
      new charts.Series<ChartData, String>(
        id: 'Delayed',
        domainFn: (ChartData data, _) => data.name,
        measureFn: (ChartData data, _) => data.noOfReforms,
        data: delayedData,
        fillPatternFn: (ChartData sales, _) =>
            charts.FillPatternType.forwardHatch,
      ),
    ];
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final reformSprintStatisticsModel =
        Provider.of<ReformSprintStatisticsModel>(context, listen: false);
    const double panelTitleHeight = 48;
    final Size panelSize = constraints.biggest;
    final double panelTop = panelSize.height - panelTitleHeight;

    final Animation<RelativeRect> panelAnimation = _controller.drive(
      RelativeRectTween(
        end: RelativeRect.fromLTRB(
          0.0,
          panelTop - MediaQuery.of(context).padding.bottom,
          0.0,
          panelTop - panelSize.height,
        ),
        begin: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
      ),
    );

    return Container(
      key: _backdropKey,
      child: Stack(
        children: <Widget>[
          Container(
            height: panelSize.height - panelTitleHeight,
            child: ListenableProvider.value(
              value: reformSprintStatisticsModel,
              child: Consumer<ReformSprintStatisticsModel>(
                builder: (context, value, _) {
                  List<charts.Series> seriesList = [];
                  if(value.busy){
                    return Center(child: Text('PLEASE WAIT...',style: Theme.of(context).textTheme.title.copyWith(color: kDBPrimaryColor),));
                  }
                  else {
                    if (widget.agency == true) {
                      seriesList =
                          _createData(value.reformStatistics.agencyReformData);
                    } else {
                      seriesList =
                          _createData(value.reformStatistics.areaReformData);
                    }
                    return charts.BarChart(
                      seriesList,
                      animate: true,
                      animationDuration: Duration(seconds: 1),
                      barGroupingType: charts.BarGroupingType.grouped,
                      vertical: false,
                      domainAxis: charts.OrdinalAxisSpec(
                        renderSpec: charts.SmallTickRendererSpec(
                          // Tick and Label styling here.
                          labelStyle: charts.TextStyleSpec(
                              fontSize: 12, // size in Pts.
                              color: charts.MaterialPalette.black),

                          // Change the line colors to match text color.
                          lineStyle: charts.LineStyleSpec(
                              color: charts.MaterialPalette.black),
                        ),
                      ),
                      selectionModels: [
                        charts.SelectionModelConfig(
                            type: charts.SelectionModelType.info,
                            changedListener:
                                (charts.SelectionModel<String> model) {
                              String name = model.selectedDatum.first.datum.name
                                  .toString()
                                  .toLowerCase();
                              //reformActions.getReforms(name);
                              if (widget.agency) {
                                Provider.of<SprintReformActionModel>(context,
                                    listen: false)
                                    .fetchAgencySprintReformActions(
                                    widget.sprintNo, name);
                              } else {
                                Provider.of<SprintReformActionModel>(context,
                                    listen: false)
                                    .fetchAreaSprintReformActions(
                                    widget.sprintNo, name);
                              }
                              _toggleBackdropPanelVisibility();
                            }),
                      ],
                      primaryMeasureAxis: charts.NumericAxisSpec(
                        renderSpec: charts.GridlineRendererSpec(
                          // Tick and Label styling here.
                          labelStyle: charts.TextStyleSpec(
                              fontSize: 12, // size in Pts.
                              color: charts.MaterialPalette.black),

                          // Change the line colors to match text color.
                          lineStyle: charts.LineStyleSpec(
                              color: charts.MaterialPalette.black),
                        ),
                      ),
                      behaviors: [
                        charts.InitialHintBehavior(
                          maxHintTranslate: 4.0,
                          hintDuration: Duration.zero,
                        ),
                        charts.PanAndZoomBehavior(),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          PositionedTransition(
            rect: panelAnimation,
            child: BackdropPanel(
              onTap: _toggleBackdropPanelVisibility,
              onVerticalDragUpdate: _handleDragUpdate,
              onVerticalDragEnd: _handleDragEnd,
              title: Consumer<SprintReformActionModel>(
                  builder: (context, model, _) {
                if (model.busy) {
                  return Text('');
                } else {
                  return widget.agency == true?  Text(model.agencyName.toUpperCase(),style: Theme.of(context).textTheme.headline,):Text(model.areaName.toUpperCase(),style: Theme.of(context).textTheme.headline);
                }
              }),
              child: Consumer<SprintReformActionModel>(
                builder: (context, model, _) {
                  if (model.busy) {
                    return PlaceHolderList(
                      itemCount: 5,
                      child: PlaceholderCardShort(
                        color: Color(0XFFACACAA),
                        backgroundColor: Color(0XFFDEDEDC),
                        height: 100,
                      ),
                    );
                  } else {
                    List<ReformActionDetail> reformAction = [];
                    if (widget.agency) {
                      reformAction = model.sprintAgencyReformActions;
                    } else {
                      reformAction = model.sprintRegionReformActions;
                    }
                    int completed = reformAction
                        .where((l) => l.status.toLowerCase() == 'completed')
                        .length;
                    int inProgress = reformAction
                        .where((l) => l.status.toLowerCase() == 'inprogress')
                        .length;
                    int delayed = reformAction
                        .where((l) => l.status.toLowerCase() == 'delayed')
                        .length;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text('Completed: $completed | In Progress: $inProgress | Delayed: $delayed',style: Theme.of(context).textTheme.subhead,)),
                        ),
                        Flexible(
                          child: ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: reformAction.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ReformItemCard(
                                  actionName: reformAction[index].actionName,
                                  status: reformAction[index].status,
                                  agencyName: reformAction[index].fullName,
                                );
                              }),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(
      builder: _buildStack,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

class ChartData {
  final String name;
  final int noOfReforms;

  ChartData(this.name, this.noOfReforms);
}
