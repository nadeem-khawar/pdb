
import 'package:pdb/models/faq.dart';
import 'package:pdb/services/doing_business_api.dart';
import 'package:pdb/view_models/base_model.dart';

class ReformActionFaqModel extends BaseModel{
  DoingBusinessApi _api = DoingBusinessApi();

  List<FAQ> _faqs = [];

  List<FAQ> get faqs{
    return [..._faqs];
  }

  Future fetchReformTopicFaq(int reformId) async {
    setBusy(true);
    _faqs = await _api.fetchReformTopicFaq(reformId);
    setBusy(false);
  }
}