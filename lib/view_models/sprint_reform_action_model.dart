
import 'package:pdb/models/reform_action.dart';
import 'package:pdb/models/reform_sprint.dart';
import 'package:pdb/services/doing_business_api.dart';
import 'package:pdb/view_models/base_model.dart';

class SprintReformActionModel extends BaseModel{
  DoingBusinessApi _api = DoingBusinessApi();

  Map<String,List<ReformActionDetail>> _sprintReformActions;
  Map<String,List<ReformActionDetail>> get sprintReformActions{
    return _sprintReformActions;
  }

  String _status = '';

  String get status {
    return _status;
  }

  String _agencyName = '';

  String get agencyName {
    return _agencyName;
  }

  String _areaName = '';

  String get areaName {
    return _areaName;
  }

  List<ReformActionDetail> _sprintAgencyReformActions = [];

  List<ReformActionDetail> get sprintAgencyReformActions {
    return _sprintAgencyReformActions;
  }

  List<ReformActionDetail> _sprintStatusReformActions = [];

  List<ReformActionDetail> get sprintStatusReformActions {
    return _sprintStatusReformActions;
  }

  List<ReformActionDetail> _sprintRegionReformActions = [];

  List<ReformActionDetail> get sprintRegionReformActions {
    return _sprintRegionReformActions;
  }

  Future fetchAgencySprintReformActions(int sprintNo,String agencyName) async {
    setBusy(true);
    _agencyName = agencyName;
    Map<String,List<ReformActionDetail>> sprintReformActions = Map<String,List<ReformActionDetail>>();
    if(sprintNo > 0){
      sprintReformActions = await _api.fetchReformActionsBySprint(sprintNo);
    }
    else{
      sprintReformActions = await _api.fetchReformActionsAllSprints();
    }
    _sprintAgencyReformActions = sprintReformActions['Completed'].where((l) => l.agency.toLowerCase() == agencyName).toList();
    _sprintAgencyReformActions.addAll(sprintReformActions['InProgress'].where((l) => l.agency.toLowerCase() == agencyName).toList());
    _sprintAgencyReformActions.addAll(sprintReformActions['Delayed'].where((l) => l.agency.toLowerCase() == agencyName).toList());

    setBusy(false);
  }
  Future fetchAreaSprintReformActions(int sprintNo,String areaName) async {
    setBusy(true);
    _areaName = areaName;
    Map<String,List<ReformActionDetail>> sprintReformActions;
    if(sprintNo > 0){
      sprintReformActions = await _api.fetchReformActionsBySprint(sprintNo);
    }
    else{
      sprintReformActions = await _api.fetchReformActionsAllSprints();
    }
    print(sprintReformActions['Completed']);
    _sprintRegionReformActions = sprintReformActions['Completed'].where((l) => l.regionName.toLowerCase() == areaName).toList();
    print(sprintReformActions['InProgress']);
    _sprintRegionReformActions.addAll(sprintReformActions['InProgress'].where((l) => l.regionName.toLowerCase() == areaName).toList());
    print(sprintReformActions['Delayed']);
    _sprintRegionReformActions.addAll(sprintReformActions['Delayed'].where((l) => l.regionName.toLowerCase() == areaName).toList());

    setBusy(false);
  }

  Future fetchSprintReformActionsByStatus(int sprintNo,String status) async {
    setBusy(true);
    Map<String,List<ReformActionDetail>> sprintReformActions;
    if(sprintNo > 0){
      sprintReformActions = await _api.fetchReformActionsBySprint(sprintNo);
    }
    else{
      sprintReformActions = await _api.fetchReformActionsAllSprints();
    }
    if(status == 'completed'){
      _sprintStatusReformActions = sprintReformActions['Completed'];
      _status = 'Completed';
    }
    else if(status == 'in progress'){
      _sprintStatusReformActions = sprintReformActions['InProgress'];
      _status = 'In Progress';
    }
    else if(status == 'delayed'){
      _sprintStatusReformActions = sprintReformActions['Delayed'];
      _status = 'Delayed';
    }
    else{
      _sprintStatusReformActions = [];
    }
    setBusy(false);
  }
  Future fetchSprintReformActions(int sprintNo) async {
    setBusy(true);
    if(sprintNo > 0){
      _sprintReformActions = await _api.fetchReformActionsBySprint(sprintNo);
    }
    else{
      _sprintReformActions = await _api.fetchReformActionsAllSprints();
    }
    setBusy(false);
  }
}