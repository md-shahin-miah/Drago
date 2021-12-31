import 'file:///C:/Users/Shahin/StudioProjects/drago/lib/screens/maintenance/serviceview.dart';
import 'package:drago/pojo/control_reminder_pojo.dart';
import 'package:drago/pojo/insurence_pojo.dart';
import 'package:drago/pojo/others_expiries_pojo.dart';
import 'package:drago/pojo/revision_pojo.dart';
import 'package:drago/pojo/tax_pojo.dart';
import 'package:drago/provider/control_reminder_provider.dart';
import 'package:drago/provider/insurence_provider.dart';
import 'package:drago/provider/others_expiries_provider.dart';
import 'package:drago/provider/revision_provider.dart';
import 'package:drago/provider/tax_provider.dart';
import 'package:drago/screens/expiries/control_reminder_view.dart';
import 'package:drago/screens/expiries/insurance_add.dart';
import 'package:drago/screens/expiries/insurance_view.dart';
import 'package:drago/screens/expiries/others_expiries_view.dart';
import 'package:drago/screens/expiries/revision_view.dart';
import 'package:drago/screens/expiries/tax_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Expiries extends StatelessWidget {
  List<InsurencePojo> insurenceList = List();
  List<InsurencePojo> listShow = List();

  List<TaxPojo> taxList = List();
  List<TaxPojo> listShowTax= List();

  List<RevisionPojo> revisionList = List();
  List<RevisionPojo> listShowRevision= List();

  List<ControlReminderPojo> controlReminderList = List();
  List<ControlReminderPojo> listShowCR= List();

  List<OthersExpiriesPojo> otherExList = List();
  List<OthersExpiriesPojo> listShowOtherEx= List();
  @override
  Widget build(BuildContext context) {
    final insurenceProvider = Provider.of<InsurenceProvider>(context);
    insurenceList = insurenceProvider.getInsurenceList;

    if(insurenceList.length>0){
      listShow.add(insurenceList[insurenceList.length - 1]);
    }

    final taxProvider = Provider.of<TaxProvider>(context);
    taxList = taxProvider.getTaxList;

    if(taxList.length>0){
      listShowTax.add(taxList[taxList.length - 1]);
    }


    final revisionProvider = Provider.of<RevisionProvider>(context);
    revisionList = revisionProvider.getRevisionList;

    if(revisionList.length>0){
      listShowRevision.add(revisionList[revisionList.length - 1]);
    }



    final controlReminderProvider = Provider.of<ControlReminderProvider>(context);
    controlReminderList = controlReminderProvider.getControlReminderList;


    if(controlReminderList.length>0){
      listShowCR.add(controlReminderList[controlReminderList.length - 1]);
    }





    final othersProvider = Provider.of<OthersExpiriesProvider>(context);
    otherExList = othersProvider.getOtherExpiriesList;

    if(otherExList.length>0){
      listShowOtherEx.add(otherExList[otherExList.length - 1]);
    }

    
    
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InsurenceView()),
            );
          },
          child: Container(
            padding: EdgeInsets.all(20),

            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          'Insurance',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          listShow.length > 0
                              ? '${listShow[0].cost} €'
                              : 'no last insurence cost',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          listShow.length > 0
                              ? 'Expiring ${listShow[0].isSuspended?listShow[0].startDate:listShow[0].expiryDate}⚠'
                              : 'you have no last insurence date',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Icon(Icons.arrow_forward_ios)],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 0.5,
          color: Colors.black,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TaxView()),
            );
          },
          child: Container(
            padding: EdgeInsets.all(20),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          'Tax',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          listShowTax.length > 0
                              ? '${listShowTax[0].cost} €'
                              : 'no last Tax cost',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          listShowTax.length > 0
                              ? '${listShowTax[0].isTaxFree?'${
                            listShowTax[0].expiryMonth
                          },' '${listShowTax[0].expiryYear}': 'inset Expirity'}'
                              : 'you have no last insurence date',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Icon(Icons.arrow_forward_ios)],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 0.5,
          color: Colors.black,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RevisionView()),
            );
          },
          child: Container(
            padding: EdgeInsets.all(20),

            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          'Revision',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          listShowRevision.length>0?listShowRevision[0].cost:'No last revision',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          listShowRevision.length>0?listShowRevision[0].inspectionDate:'No last revision date',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Icon(Icons.arrow_forward_ios)],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 0.5,
          color: Colors.black,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ControlReminderView()),
            );
          },
          child: Container(
            padding: EdgeInsets.all(20),

            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          'Control reminder',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          listShowCR.length>0?listShowCR[0].atKm:'No last Control reminder',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          listShowCR.length>0?listShowCR[0].atDate:'No last Control reminder',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Icon(Icons.arrow_forward_ios)],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 0.5,
          color: Colors.black,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OtherExpiriesView()),
            );
          },
          child: Container(
            padding: EdgeInsets.all(20),

            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          'Other expiries',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          listShowOtherEx.length>0?listShowOtherEx[0].date:'No last others Expiries',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          listShowOtherEx.length>0?listShowOtherEx[0].date:'No last others Expiries date',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Icon(Icons.arrow_forward_ios)],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
