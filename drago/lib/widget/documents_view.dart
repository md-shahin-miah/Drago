
import 'dart:io';

import 'package:drago/pojo/documents_pojo.dart';
import 'package:drago/provider/documents_provider.dart';
import 'package:drago/screens/documents_add.dart';
import 'package:drago/widget/documents_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DocumentsWidget extends StatelessWidget {
   List<DocumentsPojo> documentsList =List();

  // [
  //   Documents(
  //       'hjdkfgdfh',
  //       'https://www.extremetech.com/wp-content/uploads/2019/12/SONATA-hero-option1-764A5360-edit-640x354.jpg',
  //       'title',
  //       'titleee'),
  //   Documents(
  //       'hjdkfgdfh',
  //       'https://akm-img-a-in.tosshub.com/sites/btmt/images/stories/lamborghini_660_140220101539.jpg',
  //       'title',
  //       'titleee'),
  //   Documents(
  //       'hjdkfgdfh',
  //       'https://media.wired.com/photos/5e162edc7ecdd1000834110d/master/w_2560%2Cc_limit/Transpo_Ta11.jpg',
  //       'title',
  //       'titleee'),
  // ];

  @override
  Widget build(BuildContext context) {

    final documentProvider=Provider.of<DocumentsProvider>(context);
    documentsList=documentProvider.getDocumentsList;
    return Column(
      children: [

        Container(
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: documentsList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (ctx, i) => DocumentsItem(
              documentsList[i].type,
              documentsList[i].image,
              documentsList[i].description,

            ),

          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DocumentsAdd()),
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.pink,
          ),
        )


      ],
    );


  }
}
