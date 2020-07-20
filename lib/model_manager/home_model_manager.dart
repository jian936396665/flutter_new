import 'package:flutter_app_new/http/dio_helper.dart';
import 'package:flutter_app_new/model/home_model.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class HomeModelManager{
  final homeModel = HomeModel();

  void feed()=>homeModel.feed()
  .listen((event) {
    
  });
}