import 'package:drago/pojo/insurence_pojo.dart';
import 'package:flutter/cupertino.dart';

class InsurenceProvider extends ChangeNotifier{

  List<InsurencePojo> insurenceList=List();


  void addInsurence(InsurencePojo insurenceListVal){
    insurenceList.add(insurenceListVal);
    notifyListeners();
  }

  void deleteInsurence(int index){
    insurenceList.removeAt(index);
    notifyListeners();
  }


  void replaceInsurence(int index, InsurencePojo insurencePojo) {
    insurenceList[index] = insurencePojo;
    notifyListeners();
  }

  get getInsurenceList{
    return [...insurenceList];
  }



}