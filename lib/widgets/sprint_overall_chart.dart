import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pdb/common/styles.dart';
import 'package:pdb/models/reform_data.dart';
import 'package:pdb/view_models/reform_sprint_statistics_model.dart';
import 'package:pdb/view_models/sprint_reform_action_model.dart';
import 'package:pdb/widgets/backdrop/backdrop_panel.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pdb/widgets/placeholder/placehoder_list.dart';
import 'package:pdb/widgets/placeholder/placeholder_card_short.dart';
import 'package:pdb/widgets/reform_item_card.dart';
import 'package:provider/provider.dart';

class SprintOverallChart extends StatefulWidget {
  final int sprintNo;
  SprintOverallChart({this.sprintNo});
  @override
  _SprintOverallChartState createState() => _SprintOverallChartState();
}

class _SprintOverallChartState extends State<SprintOverallChart> with AutomaticKeepAliveClientMixin<SprintOverallChart>,AfterLayoutMixin<SprintOverallChart>,SingleTickerProviderStateMixin{
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<ReformSprintStatisticsModel>(context,listen: false).getSprintStatistics(widget.sprintNo);
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

  List<charts.Series<PieChartData, String>> _createData(ReformData reformData) {
    final data = [
      new PieChartData('Completed', reformData.completed),
      new PieChartData('In progress', reformData.inProgress),
      new PieChartData('Delayed', reformData.delayed),
    ];

    return [
      new charts.Series<PieChartData, String>(
        id: 'Sales',
        domainFn: (PieChartData sales, _) => sales.name,
        measureFn: (PieChartData sales, _) => sales.noOfReforms,
        data: data,
        labelAccessorFn: (PieChartData row, _) => '${row.noOfReforms}',
      )
    ];
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {

    final reformSprintStatisticsModel = Provider.of<ReformSprintStatisticsModel>(context,listen: false);
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
                builder: (context, value, _){
                  if(value.busy){
                    return Center(child: Text('PLEASE WAIT...',style: Theme.of(context).textTheme.title.copyWith(color: kDBPrimaryColor),));
                  }
                  else{
                    List<charts.Series> seriesList;
                    seriesList = _createData(value.reformStatistics.reformData);

                    return charts.BarChart(
                      seriesList,
                      animate: true,
                      vertical: false,
                      selectionModels: [
                        charts.SelectionModelConfig(
                            type: charts.SelectionModelType.info,
                            changedListener:
                                (charts.SelectionModel<String> model) {
                              String name = model
                                  .selectedDatum.first.datum.name
                                  .toString()
                                  .toLowerCase();
                              //reformActions.getReforms(name);
                              Provider.of<SprintReformActionModel>(context,listen: false).fetchSprintReformActionsByStatus(widget.sprintNo,name);
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
                  builder: (context, model, _){
                    if(model.busy){
                      return Text('');
                    }
                    else{
                      int total = model.sprintStatusReformActions.length;
                      return Text(model.status.toUpperCase(),style: Theme.of(context).textTheme.headline,);
                    }
                  }
              ),
              child:  Consumer<SprintReformActionModel>(
                builder: (context, model, _){
                  if(model.busy){
                    return PlaceHolderList(
                      itemCount: 5,
                      child: PlaceholderCardShort(
                        color: Color(0XFFACACAA),
                        backgroundColor: Color(0XFFDEDEDC),
                        height: 100,
                      ),
                    );
                  }
                  else{
                    return ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount:  model.sprintStatusReformActions.length,
                        itemBuilder: (BuildContext context,int index){
                          return ReformItemCard(
                            actionName: model.sprintStatusReformActions[index].actionName,
                            status: model.sprintStatusReformActions[index].status,
                            agencyName: model.sprintStatusReformActions[index].fullName,
                          );
                        });
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
class PieChartData {
  final String name;
  final int noOfReforms;

  PieChartData(this.name, this.noOfReforms);
}