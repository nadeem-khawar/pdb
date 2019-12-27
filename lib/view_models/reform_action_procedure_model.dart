

import 'package:pdb/models/reform_procedure.dart';
import 'package:pdb/services/doing_business_api.dart';
import 'package:pdb/view_models/base_model.dart';

class ReformActionProcedureModel extends BaseModel{
  DoingBusinessApi _api = DoingBusinessApi();

  List<ReformProcedureArea> _reformProcedureArea = [];

  List<ReformProcedureArea> get reformProcedureArea{
    return [..._reformProcedureArea];
  }

  Future fetchReformTopicProcedureArea(int reformId) async {
    setBusy(true);
    _reformProcedureArea = await _api.fetchReformTopicProcedureArea(reformId);
    setBusy(false);
  }
}