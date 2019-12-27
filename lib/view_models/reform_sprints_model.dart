
import 'package:pdb/models/reform_sprint.dart';
import 'package:pdb/services/doing_business_api.dart';
import 'package:pdb/view_models/base_model.dart';

class ReformSprintsModel extends BaseModel{
  final DoingBusinessApi _api = DoingBusinessApi();

  ReformSprint _reformOverall = ReformSprint.empty();

  ReformSprint get reformOverall{
    return _reformOverall;
  }

  List<ReformSprint> _reformSprints = [];
  List<ReformSprint> get reformSprints{
    return [..._reformSprints];
  }

  void getOverall() async{
    try{
      setBusy(true);
      _reformOverall = await _api.fetchReformOverall();
      _reformSprints = await _api.fetchReformSprints();
      setBusy(false);
    }catch(err){
      setMessage(err.toString());
      setBusy(false);
    }
  }
}