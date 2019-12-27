

import 'package:pdb/models/registration.dart';
import 'package:pdb/services/doing_business_api.dart';
import 'package:pdb/view_models/base_model.dart';

class RegistrationModel extends BaseModel{
  DoingBusinessApi _api = DoingBusinessApi();
  List<Registration> _registrations = [];

  List<Registration> get registrations{
    return [..._registrations];
  }

  Future fetchRegistrationInfo() async {
    setBusy(true);
    _registrations = await _api.fetchRegistrationLinks();
    setBusy(false);
  }
}