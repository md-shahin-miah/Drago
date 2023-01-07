import 'package:drago/pojo/revision_pojo.dart';
import 'package:flutter/cupertino.dart';

class RevisionProvider extends ChangeNotifier{
  List<RevisionPojo> revisionList=List();

  addRevision(RevisionPojo revisionPojo){
    revisionList.add(revisionPojo);
    notifyListeners();
  }

  deleteRevision(int index){
    revisionList.removeAt(index);
    notifyListeners();
  }

  replaceRevision(int index,RevisionPojo revisionPojo){
    revisionList[index]=revisionPojo;
    notifyListeners();

  }

  get getRevisionList{
    return [...revisionList];
  }
}