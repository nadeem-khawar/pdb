import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pdb/models/faq.dart';
import 'package:pdb/models/news.dart';
import 'package:intl/intl.dart';
import 'package:pdb/models/reform_action.dart';
import 'package:pdb/models/reform_data.dart';
import 'package:pdb/models/reform_procedure.dart';
import 'package:pdb/models/reform_sprint.dart';
import 'package:pdb/models/registration.dart';

class DoingBusinessApi{
  static const String endPoint =
      "http://kilimz.com/pakistandoingbusiness/appapi";
  static const String wpEndPoint =
      "https://pakistandoingbusiness.com/index.php";
  final dio = Dio();

  Future<List<ReformProcedureArea>> fetchReformTopicProcedureArea(
      int reformId) async {
    Response response = await dio.get('$endPoint/get_procedure',
        queryParameters: {'indicator_id': reformId.toString()});
    List<ReformProcedureArea> items =
    await compute(_parseReformTopicProcedureArea, response.data as dynamic);
    return items;
  }

  Future<List<ReformSprint>> fetchReformSprints() async {
    Response response = await dio.get('$endPoint/get_all_sprints');
    List<ReformSprint> reformSprints =
    await compute(_parseReformSprints, response.data as dynamic);
    return reformSprints;
  }

  Future<List<ReformActionAgency>> fetchReformTopicActions(int reformId) async {
    Response response = await dio.get('$endPoint/get_all_actions_by_agencies',
        queryParameters: {'indicator_id': reformId.toString()});
    List<ReformActionAgency> items =
    await compute(_parseReformTopicActions, response.data as dynamic);
    return items;
  }
  Future<List<Registration>> fetchRegistrationLinks() async {
    Response response = await dio.get('$endPoint/get_registration');
    List<Registration> items =
    await compute(_parseRegistrationLinks, response.data as dynamic);
    return items;
  }
  Future<ReformStatistic> fetchReformTopicStatistics(int id) async {
    Response response = await dio.get('$endPoint/get_actions_by_indicator_id',
        queryParameters: {'indicator_id': id.toString()});
    ReformStatistic reformStatistics =
    await compute(_parseReformStatistic, response.data as dynamic);
    return reformStatistics;
  }

  Future<ReformSprint> fetchReformOverall() async {
    Response response = await dio.get('$endPoint/get_overall_reform_stats');
    ReformSprint reformSprint =
    await compute(_parseReform, response.data as dynamic);
    return reformSprint;
  }

  Future<Map<String,List<ReformActionDetail>>> fetchReformActionsAllSprints() async {
    Response response = await dio.get('$endPoint/get_all_actions_by_sprint_no');
    Map<String,List<ReformActionDetail>> items =
    await compute(_parseSprintReformActions, response.data as dynamic);
    return items;
  }

  Future<ReformStatistic> fetchReformSprintStatistics(int id) async {
    Response response = await dio.get('$endPoint/search_sprints',
        queryParameters: {'sprint_num': id.toString()});
    ReformStatistic reformStatistics =
    await compute(_parseReformStatistic, response.data as dynamic);
    return reformStatistics;
  }

  Future<ReformStatistic> fetchReformStatistics() async {
    Response response = await dio.get('$endPoint/search_sprints');
    ReformStatistic reformStatistics =
    await compute(_parseReformStatistic, response.data as dynamic);
    return reformStatistics;
  }

  Future<Map<String,List<ReformActionDetail>>> fetchReformActionsBySprint(int sprintNo) async {
    Response response = await dio.get('$endPoint/get_all_actions_by_sprint_no',
        queryParameters: {'sprint_num': sprintNo.toString()});
    Map<String,List<ReformActionDetail>> items =
    await compute(_parseSprintReformActions, response.data as dynamic);
    return items;
  }

  Future<List<News>> fetchLatestNews() async {
    Response response = await dio.get('$wpEndPoint',
        queryParameters: {'rest_route': '/restapi/getlatestnews'});
    List<News> news = await compute(_parseNews, response.data as List<dynamic>);
    return news;
  }

  Future<List<News>> fetchNews(String slug) async {
    Response response = await dio.get('$wpEndPoint',
        queryParameters: {'rest_route': '/restapi/getposts/$slug'});
    List<News> news = await compute(_parseNews, response.data as List<dynamic>);
    return news;
  }
  Future<List<News>> fetchLawsRegulations(String reformName) async {
    Response response = await dio.get('$wpEndPoint',
        queryParameters: {'rest_route': '/restapi/getpdfsforlawandregulations/$reformName'});
    List<News> news = await compute(_parseLawsRegulations, response.data as dynamic);
    return news;
  }

  Future<List<FAQ>> fetchReformTopicFaq(int reformId) async {
    Response response = await dio.get('$endPoint/get_FAQ',
        queryParameters: {'indicator_id': reformId.toString()});
    List<FAQ> items =
    await compute(_parseReformTopicFAQ, response.data as dynamic);
    return items;
  }

}

List<FAQ> _parseReformTopicFAQ(dynamic responseBody) {
  List<FAQ> faqs = [];
  Map<String, dynamic> json = jsonDecode(responseBody);

  for (var faq in json['data']) {
    var question = faq['Question'] as String;
    var answer = faq['Answer'] as String;
    faqs.add(FAQ(question, answer));
  }
  return faqs;
}

List<Registration> _parseRegistrationLinks(dynamic responseBody) {
  List<Registration> reformRegistrationLinks = [];
  Map<String, dynamic> json = jsonDecode(responseBody);
  for (var regSection in json['data']) {
    String heading = regSection['name'] as String;
    List<LinkItem> links = [];
    for (var procedure in regSection['Links']) {
      String url = procedure['url'] as String;
      String linkText = procedure['link_text'] as String;
      links.add(LinkItem(url, linkText));
    }
    reformRegistrationLinks.add(Registration(heading, links));
  }
  return reformRegistrationLinks;
}

List<ReformProcedureArea> _parseReformTopicProcedureArea(dynamic responseBody) {
  List<ReformProcedureArea> reformProcedureArea = [];
  Map<String, dynamic> json = jsonDecode(responseBody);
  for (var reformArea in json['data']) {
    String area = reformArea['Area'] as String;
    List<ReformProcedure> procedures = [];
    for (var procedure in reformArea['procedures']) {
      String stepText = procedure['Step_text'] as String;
      String agency = procedure['Agency'] as String;
      String completionTime = procedure['Completion_time'] as String;
      String associatedCost = procedure['AssociatedCost'] as String;
      procedures.add(
          ReformProcedure(stepText, agency, completionTime, associatedCost));
    }
    reformProcedureArea
        .add(ReformProcedureArea(area: area, procedures: procedures));
  }

  return reformProcedureArea;
}

List<ReformActionAgency> _parseReformTopicActions(dynamic responseBody) {
  List<ReformActionAgency> reformAgencies = List<ReformActionAgency>();
  Map<String, dynamic> json = jsonDecode(responseBody);

  for (var agency in json['agencies']) {
    String agencyName = agency['name'] as String;
    String agencyFullName = agency['full_name'] as String;
    List<ReformAction> reformTopics = [];
    for (var action in agency['actions']) {
      String actionName = action['Action_name'] as String;
      int id = action['Action_id'] as int;
      //String actionDetail = agency['Action_detail'] as String;
      String status = action['Status'] as String;
      reformTopics.add(ReformAction(id, actionName, status));
    }
    reformAgencies
        .add(ReformActionAgency(agencyName, agencyFullName, reformTopics));
  }
  return reformAgencies;
}

ReformStatistic _parseReformStatistic(dynamic responseBody) {
  ReformStatistic reformStatistic;
  List<ReformDataCategory> areaReformData = [];
  List<ReformDataCategory> agencyReformData = [];
  Map<String, dynamic> json = jsonDecode(responseBody);
  var name;
  var totalNoOfReform = json['data']['TotalNoOfReform'] as int;
  var completed = json['data']['Completed'] as int;
  var inProgress = json['data']['InProgress'] as int;
  var delayed = json['data']['Delayed'] as int;

  ReformData reformData =
  ReformData(totalNoOfReform, completed, inProgress, delayed);
  //print(json);
  for (var sprint in json['data']['Area']) {
    name = sprint['Name'] as String;
    totalNoOfReform = sprint['TotalNoOfReform'] as int;
    completed = sprint['Completed'] as int;
    inProgress = sprint['InProgress'] as int;
    delayed = sprint['Delayed'] as int;

    areaReformData.add(ReformDataCategory(
        name, totalNoOfReform, completed, inProgress, delayed));
  }
  for (var sprint in json['data']['Agency']) {
    name = sprint['Name'] as String;
    totalNoOfReform = sprint['TotalNoOfReform'] as int;
    completed = sprint['Completed'] as int;
    inProgress = sprint['InProgress'] as int;
    delayed = sprint['Delayed'] as int;

    agencyReformData.add(ReformDataCategory(
        name, totalNoOfReform, completed, inProgress, delayed));
  }
  reformStatistic =
      ReformStatistic(reformData, areaReformData, agencyReformData);
  return reformStatistic;
}

ReformSprint _parseReform(dynamic responseBody) {
  var reformSprint;
  Map<String, dynamic> json = jsonDecode(responseBody);

  var totalNoOfReform = json['data']['TotalNoOfReform'] as int;
  var completed = json['data']['Completed'] as int;
  var inProgress = json['data']['InProgress'] as int;
  var delayed = json['data']['Delayed'] as int;
  reformSprint =
      ReformSprint('0', totalNoOfReform, completed, inProgress, delayed);
  return reformSprint;
}

Map<String,List<ReformActionDetail>> _parseSprintReformActions(dynamic responseBody) {
  Map<String,List<ReformActionDetail>> sprintReforms = Map<String,List<ReformActionDetail>>();

  Map<String, dynamic> json = jsonDecode(responseBody);

  List<ReformActionDetail> completedSprintActions = [];
  for (var completed in json['data']['Completed']) {
    String agencyName = completed['name'] as String;
    String agencyFullName = completed['full_name'] as String;
    String actionName = completed['Action_name'] as String;
    int id = completed['Action_id'] as int;
    String regionName = completed['Region_name'] as String;
    completedSprintActions.add(ReformActionDetail(regionName: regionName, agency: agencyName,fullName: agencyFullName,id: id,actionName: actionName,status:'completed'));
  }
  sprintReforms['Completed'] = completedSprintActions;

  List<ReformActionDetail> inProgressSprintActions = [];
  for (var inProgress in json['data']['InProgress']) {
    String agencyName = inProgress['name'] as String;
    String agencyFullName = inProgress['full_name'] as String;
    String actionName = inProgress['Action_name'] as String;
    int id = inProgress['Action_id'] as int;
    String regionName = inProgress['Region_name'] as String;
    inProgressSprintActions.add(ReformActionDetail(regionName: regionName,agency: agencyName,fullName: agencyFullName,id: id,actionName: actionName,status:'inprogress'));
  }
  sprintReforms['InProgress'] = inProgressSprintActions;

  List<ReformActionDetail> delayedSprintActions = [];
  for (var delayed in json['data']['Delayed']) {
    String agencyName = delayed['name'] as String;
    String agencyFullName = delayed['full_name'] as String;
    String actionName = delayed['Action_name'] as String;
    int id = delayed['Action_id'] as int;
    String regionName = delayed['Region_name'] as String;
    delayedSprintActions.add(ReformActionDetail(regionName: regionName,agency: agencyName,fullName: agencyFullName,id: id,actionName: actionName,status:'inprogress'));
  }
  sprintReforms['Delayed'] = delayedSprintActions;
  return sprintReforms;
}

List<ReformSprint> _parseReformSprints(dynamic responseBody) {
  var reformSprints = List<ReformSprint>();
  Map<String, dynamic> json = jsonDecode(responseBody);

  for (var sprint in json['data']['sprints']) {
    var sprintNo = sprint['sprint'] as String;
    var totalNoOfReform = sprint['TotalNoOfReform'] as int;
    var completed = sprint['Completed'] as int;
    var inProgress = sprint['InProgress'] as int;
    var delayed = sprint['Delayed'] as int;

    reformSprints.add(ReformSprint(
        sprintNo, totalNoOfReform, completed, inProgress, delayed));
  }
  return reformSprints;
}


List<News> _parseNews(List<dynamic> newsJson) {
  return newsJson.map((f) {
    var links = f['links_in_content'];
    List<String> linksList = new List<String>.from(links);
    return News(
        title: f['Title'] as String,
        newsDate: DateFormat("yyyy-MM-dd").parse(f['date'] as String),
        externalLink: f['external_link'] as String,
        linksInContent:linksList
    );
  }).toList();
}

List<News> _parseLawsRegulations(dynamic newsJson) {
  List<News> items = [];
  //Map<String, dynamic> json = jsonDecode(newsJson);

  for (var laws in newsJson['Laws']) {
    String title = laws['Title'] as String;
    String externalLink = laws['external_link'] as String;
    items.add(News(title: title,externalLink: externalLink));
  }
  for (var regulations in newsJson['Regulations']) {
    String title = regulations['Title'] as String;
    String externalLink = regulations['external_link'] as String;
    items.add(News(title: title,externalLink: externalLink));
  }
  for (var notifications in newsJson['Notifications']) {
    String title = notifications['Title'] as String;
    String externalLink = notifications['external_link'] as String;
    items.add(News(title: title,externalLink: externalLink));
  }
  return items;
}