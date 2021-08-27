import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swift/models/service_category_model.dart';
import 'package:swift/models/service_model.dart';
import 'package:swift/services/repositories.dart';

part 'get_all_services_event.dart';
part 'get_all_services_state.dart';

class GetAllServicesBloc extends Bloc<GetAllServicesEvent, GetAllServicesState> {
  GetAllServicesBloc() : super(GetAllServicesInitial());
  Repositories _repos = Repositories();
  @override
  Stream<GetAllServicesState> mapEventToState(
    GetAllServicesEvent event,
  ) async* {
    if (event is GetAllServicesEvent) {
      try {
        var allServiceResponse = await _repos.getServices();
        var freqentServiceResponse = await _repos.getFrequentServices();
        if (allServiceResponse.statusCode == 200 && freqentServiceResponse.statusCode == 200) {
          List<ServiceModel> _allService;
          List<ServiceCategoryModel> _frequentService;
          var allServiceDecoded = jsonDecode(allServiceResponse.data);
          _allService = serviceModelFromJson(jsonEncode(allServiceDecoded['results']));
          var frequentServiceDecoded = jsonDecode(freqentServiceResponse.data);
          _frequentService =
              serviceCategoryModelFromJson(jsonEncode(frequentServiceDecoded['results']));
          yield GotServices(allServices: _allService, frequentServices: _frequentService);
        } else {
          print(allServiceResponse);
          print(freqentServiceResponse);
          yield GettingFailed();
        }
      } catch (_) {
        print(_);
        yield GettingFailed();
      }
    }
  }
}
