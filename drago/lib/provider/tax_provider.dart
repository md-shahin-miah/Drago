import 'package:drago/pojo/tax_pojo.dart';
import 'package:flutter/cupertino.dart';

class TaxProvider extends ChangeNotifier{

  List<TaxPojo> taxList=List();


  addTax(TaxPojo taxPojo){
    taxList.add(taxPojo);
    notifyListeners();
  }

  deleteTaxByIndex(int index){
    taxList.removeAt(index);
    notifyListeners();
  }

  replaceTax(int index,TaxPojo taxPojo){

    taxList[index]=taxPojo;
    notifyListeners();
  }

  get getTaxList{
    return [...taxList];
  }

}