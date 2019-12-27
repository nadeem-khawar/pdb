
import 'package:pdb/models/reform_action.dart';
import 'package:pdb/models/reform_data.dart';
import 'package:pdb/services/doing_business_api.dart';
import 'package:pdb/view_models/base_model.dart';

class ReformSprintStatisticsModel extends BaseModel{
  DoingBusinessApi _api = DoingBusinessApi();

  ReformStatistic _reformStatistic = ReformStatistic(ReformData(0,0,0,0),[],[]);

  ReformStatistic get reformStatistics{
    return _reformStatistic;
  }

  Future getSprintStatistics(int sprintNo) async {
    setBusy(true);
    if(sprintNo > 0){
      _reformStatistic = await _api.fetchReformSprintStatistics(sprintNo);
    }
    else{
      _reformStatistic = await _api.fetchReformStatistics();
    }
    setBusy(false);
  }

}