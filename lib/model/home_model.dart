import 'package:flutter_app_new/http/dio_helper.dart';
import 'package:rxdart/rxdart.dart';

class HomeModel{
  Observable feed() => Observable.fromFuture(
      DioHelper.getInstance().get('/feed')
  );
}