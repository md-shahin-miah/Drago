import 'package:drago/pojo/documents_pojo.dart';
import 'package:flutter/cupertino.dart';

class DocumentsProvider extends ChangeNotifier{

  List<DocumentsPojo> documentsList=List();

  addDocuments(DocumentsPojo documentsPojo){

    documentsList.add(documentsPojo);
    notifyListeners();
  }

  deleteDocuments(int index){
    documentsList.removeAt(index);
    notifyListeners();
  }

  get getDocumentsList{
    return [...documentsList];
  }

}