import 'package:drago/pojo/control_reminder_pojo.dart';
import 'package:drago/provider/control_reminder_provider.dart';
import 'package:drago/screens/expiries/control_reminder_add.dart';
import 'package:drago/screens/expiries/revision_add.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ControlReminderView extends StatelessWidget {
  List<ControlReminderPojo> controlReminderList =List();


  @override
  Widget build(BuildContext context) {
    final revisionProvider=Provider.of<ControlReminderProvider>(context);
    controlReminderList=revisionProvider.getControlReminderList;
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: controlReminderList.length,
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
                              MaterialPageRoute(builder: (context) => ControlReminderAdd(index),),
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
                                      '${controlReminderList[index].atKm} Kms entro il ${controlReminderList[index].atDate}',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      'Expires in ${controlReminderList[index].atDate}',
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
                                  revisionProvider.deleteControlReminder(index);
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
                    index != controlReminderList.length - 1
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
              MaterialPageRoute(builder: (context) => ControlReminderAdd(-1)),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.pink,
        )

    );
  }
}
