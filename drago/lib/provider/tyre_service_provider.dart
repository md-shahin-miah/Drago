import 'package:drago/pojo/tire_service_pojo.dart';
import 'package:flutter/cupertino.dart';

class TireServiceProvider extends ChangeNotifier {
  List<TyreServicePojo> tyreServiceList = List();

  void addTyreService(String date, String tireType, String position,
      String condition, String cost, String mileage, String notes) {
    TyreServicePojo tyreServicePojo = TyreServicePojo(
        date, tireType, position, condition, cost, mileage, notes);

    tyreServiceList.add(tyreServicePojo);
    notifyListeners();
  }

  void updateTyreService(int index ,String date, String tireType, String position,
      String condition, String cost, String mileage, String notes) {
    TyreServicePojo tyreServicePojo = TyreServicePojo(
        date, tireType, position, condition, cost, mileage, notes);

    tyreServiceList[index]=tyreServicePojo;
    notifyListeners();
  }

  List<TyreServicePojo> get getTyreServiceList{
    return tyreServiceList;
  }


  void deleteTyreService(int index){
    tyreServiceList.removeAt(index);
    notifyListeners();
  }

}
