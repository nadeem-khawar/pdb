
import 'package:pdb/models/reform_action.dart';
import 'package:pdb/services/doing_business_api.dart';
import 'package:pdb/view_models/base_model.dart';

class ReformTopicActionModel extends BaseModel{
  DoingBusinessApi _api = DoingBusinessApi();

  List<ReformActionAgency> _reformActionAgencies = [];

  List<ReformActionAgency> get reformActionAgencies{
    return [..._reformActionAgencies];
  }


  Future fetchReformTopicActions(int reformId) async {
    setBusy(true);
    _reformActionAgencies = await _api.fetchReformTopicActions(reformId);
    setBusy(false);
  }
}