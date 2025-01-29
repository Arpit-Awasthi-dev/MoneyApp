import 'dart:async';

import 'package:money_app/core/network/api_service.dart';

String handleFailure(dynamic e) {
  if (e is ApiException) {
    return e.message;
  } else if (e is TimeoutException) {
    return 'Servers are busy or something with you network';
  } else {
    return 'Something went wrong';
  }
}
