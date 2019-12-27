import 'package:flutter/material.dart';
import 'package:pdb/common/navigation_args.dart';
import 'package:pdb/common/route_constants.dart';
import 'package:pdb/views/home.dart';
import 'package:pdb/views/news.dart';
import 'package:pdb/views/reform_action_faq.dart';
import 'package:pdb/views/reform_action_procedure.dart';
import 'package:pdb/views/reform_sprint_statistics.dart';
import 'package:pdb/views/reform_sprints.dart';
import 'package:pdb/views/reform_topic.dart';
import 'package:pdb/views/reform_topic_actions.dart';
import 'package:pdb/views/registration.dart';
import 'package:pdb/views/splash.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => Splash());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => Home());
      case reformPlanRoute:
        return MaterialPageRoute(builder: (_) => ReformSprints());
      case newsRoute:
        if (args is NewsArgs) {
          return MaterialPageRoute(builder: (_) => News(
            newsRegion: args.title,
            slug: args.slug,
          ));
        }
        return _errorRoute();
      case reformSprintRoute:
        if (args is ReformSprintStatisticsArguments) {
          return MaterialPageRoute(builder:(_) => ReformSprintStatistics(
            sprintNo: args.sprintNo,
          ));
        }
        return _errorRoute();
      case reformTopicRoute:
        if (args is ReformTopicArguments) {
          return MaterialPageRoute(builder:(_) =>ReformTopic(
            reformTopicId: args.reformTopicId,
            reformTopicName: args.reformTopicName,
            logo: args.logo,
            slug: args.slug,
          ));
        }
        return _errorRoute();
      case reformTopicActionRoute:
        if (args is ReformArgs) {
          return MaterialPageRoute(builder:(_) =>ReformTopicAction(
            reformTopicId: args.reformTopicId,
          ));
        }
        return _errorRoute();
      case procedureRoute:
        if (args is ReformArgs) {
          return MaterialPageRoute(builder:(_) => ReformActionProcedure(
            reformTopicId: args.reformTopicId,
          ));
        }
        return _errorRoute();
      case reformFaqRoute:
        if (args is ReformArgs) {
          return MaterialPageRoute(builder:(_) => ReformActionFaq(
            reformId: args.reformTopicId,
          ));
        }
        return _errorRoute();
      case registrationRoute:
        return MaterialPageRoute(builder:(_) => Registration());
    /*


      case reformPlanRoute:
        return FadeRoute(page: ReformPlan());
      case procedureRoute:
        if (args is ReformArgs) {
          return FadeRoute(page: ReformProcedure(
            reformTopicId: args.reformTopicId,
          ));
        }
        return _errorRoute();

      case contactFeedbackRoute:
        if (args is FeedbackArgs) {
          return FadeRoute(page:ContactFeedback(args.subject));
        }
        return FadeRoute(page: ContactFeedback(''));
      case reformFaqRoute:
        if (args is ReformArgs) {
          return FadeRoute(page: ReformFaq(
            reformId: args.reformTopicId,
          ));
        }
        return _errorRoute();

      */
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
