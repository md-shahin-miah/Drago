import 'package:drago/pojo/control_pojo.dart';
import 'package:drago/pojo/revision_pojo.dart';
import 'package:drago/pojo/tax_pojo.dart';
import 'package:drago/provider/control_provider.dart';
import 'package:drago/provider/maintenance_provider.dart';
import 'package:drago/provider/revision_provider.dart';
import 'package:drago/provider/tax_provider.dart';
import 'package:drago/screens/expiries/revision_add.dart';
import 'package:drago/screens/maintenance/controls_add.dart';
import 'package:drago/screens/maintenance/service_add.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RevisionView extends StatelessWidget {
  List<RevisionPojo> revisionList =List();


  @override
  Widget build(BuildContext context) {
    final revisionProvider=Provider.of<RevisionProvider>(context);
    revisionList=revisionProvider.getRevisionList;
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: revisionList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RevisionAdd(index),),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.80,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      'Inspection done',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      '${revisionList[index].cost} €',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      '${revisionList[index].inspectionDate}',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.06,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  revisionProvider.deleteRevision(index);
                                },

                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,

                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    index != revisionList.length - 1
                        ? Container(
                      margin: EdgeInsets.only(top: 5),
                      height: 0.5,
                      color: Colors.black26,
                    )
                        : Container()
                  ],
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RevisionAdd(-1)),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.pink,
        )

    );
  }
}
