import 'package:flutter/foundation.dart';

class ReformAction{
  final int id;
  final String actionName;
  final String status;

  ReformAction(this.id,this.actionName,this.status);

  factory ReformAction.fromJson(Map<String, dynamic> json) {
    return ReformAction(
      json[''] as int,
      json[''] as String,
      json[''] as String,
    );
  }
}

class ReformActionAgency{
  final String agency;
  final String fullName;
  final List<ReformAction> reformActions;

  ReformActionAgency(this.agency,this.fullName,this.reformActions);
}

class ReformActionDetail extends ReformAction{
  final String agency;
  final String fullName;
  final String regionName;
  ReformActionDetail({this.regionName,this.agency,this.fullName,int id,String actionName,String status}):super(id,actionName,status);

  factory ReformActionDetail.empty(){
    return ReformActionDetail(id: 0,actionName: '',agency: '',fullName: '',regionName: '',status: '' );
  }
}