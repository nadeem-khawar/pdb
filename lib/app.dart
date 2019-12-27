import 'package:flutter/material.dart';
import 'package:pdb/common/route_constants.dart';
import 'package:pdb/common/routes.dart';
import 'package:pdb/common/styles.dart';
import 'package:pdb/view_models/app_model.dart';
import 'package:pdb/view_models/home_model.dart';
import 'package:pdb/view_models/news_model.dart';
import 'package:pdb/view_models/reform_action_faq_model.dart';
import 'package:pdb/view_models/reform_action_procedure_model.dart';
import 'package:pdb/view_models/reform_sprint_statistics_model.dart';
import 'package:pdb/view_models/reform_sprints_model.dart';
import 'package:pdb/view_models/reform_topic_action_model.dart';
import 'package:pdb/view_models/reform_topic_model.dart';
import 'package:pdb/view_models/registration_model.dart';
import 'package:pdb/view_models/sprint_reform_action_model.dart';

import 'package:provider/provider.dart';
class App extends StatelessWidget {
  final AppModel _appModel = AppModel();
  final HomeModel _homeModel = HomeModel();
  final NewsModel _newsModel = NewsModel();
  final ReformSprintsModel _reformSprintModel = ReformSprintsModel();
  final ReformSprintStatisticsModel _reformSprintStatisticsModel = ReformSprintStatisticsModel();
  final ReformTopicModel _reformTopicModel = ReformTopicModel();
  final ReformTopicActionModel _reformTopicActionModel = ReformTopicActionModel();
  final ReformActionFaqModel _reformActionFaqModel = ReformActionFaqModel();
  final ReformActionProcedureModel _reformActionProcedureModel = ReformActionProcedureModel();
  final RegistrationModel _registrationModel = RegistrationModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppModel>.value(
      value: _appModel,
      child: Consumer<AppModel>(
        builder: (context,value,_){
          return MultiProvider(
            providers:[
              Provider<HomeModel>.value(value: _homeModel),
              Provider<NewsModel>.value(value: _newsModel),
              Provider<ReformSprintsModel>.value(value: _reformSprintModel),
              Provider<ReformSprintStatisticsModel>.value(value: _reformSprintStatisticsModel),
              Provider<ReformTopicModel>.value(value: _reformTopicModel),
              Provider<ReformTopicActionModel>.value(value: _reformTopicActionModel),
              Provider<ReformActionFaqModel>.value(value: _reformActionFaqModel),
              Provider<ReformActionProcedureModel>.value(value: _reformActionProcedureModel),
              Provider<RegistrationModel>.value(value: _registrationModel),
              ChangeNotifierProvider<SprintReformActionModel>(create: (context) => SprintReformActionModel(),)
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Pakistan Doing Business',
              theme: buildDoingBusinessTheme(context),
              initialRoute: splashRoute,
              onGenerateRoute: Routes.generateRoute,
            ),
          );
        },
      ),
    );
  }
}
