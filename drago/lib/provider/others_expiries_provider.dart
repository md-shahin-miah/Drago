
import 'package:drago/pojo/others_expiries_pojo.dart';
import 'package:flutter/cupertino.dart';

class OthersExpiriesProvider extends ChangeNotifier{

  List<OthersExpiriesPojo> otexLIst=List();


  void addOtherExpiries(OthersExpiriesPojo othersExpiriesPojo){
    otexLIst.add(othersExpiriesPojo);
    notifyListeners();
  }

  void deleteOtherExpiries(int index){
    otexLIst.removeAt(index);
    notifyListeners();
  }


  void replaceOtherExpiries(int index, OthersExpiriesPojo othersExpiriesPojo) {
    otexLIst[index] = othersExpiriesPojo;
    notifyListeners();
  }

  get getOtherExpiriesList{

    return [...otexLIst];
  }



}