import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class AddCompany extends StatefulWidget {
  @override
  _AddCompanyState createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  final TextEditingController _controllerMessage = TextEditingController();

  List<String> attachments = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String message = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SvgPicture.asset(
                  "assets/close.svg",
                  color: Colors.black,
                ),
              ),
            ),
            title: Text(
              "Email",
              style:
              TextStyle(fontWeight: FontWeight.normal, color: Colors.grey[600]),
            ),
            centerTitle: true,

          ),
          body: SingleChildScrollView(
            child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "Hello,",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                      fontSize: 26),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "How can i help you?",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "In this section you can find the answer  to the most frequently asked "
                  "questions about the app.You can  also contact us directly by "
                  "filling out the form below.",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 5,
                  left: 15,
                  right: 0,
                ),
                child: Text(
                  "FAQ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: ExpansionTile(
                  title: Text('Payments method'),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'The accepted payment metods are: Apple pay and Google pay',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: ExpansionTile(
                  title: Text('How many vehicles can i manage?'),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '1 completely free  up to a total of six  at the cost of € 0.99 / year / vehicle ,',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: ExpansionTile(
                  title: Text('I can not add any more vehicle?'),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'you can  manage up to six vehicles in total,Have you reached the  maximum?  contacts us now so we can find a solution together',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: ExpansionTile(
                  title: Text('Prices'),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '€ 0.99 / year / vehicle',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: Colors.black54,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text('Your message'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  child: TextField(
                    controller: _controllerMessage,
                    onChanged: (text) {
                      message = text;
                    },
                    decoration: new InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(bottom: 100.0, left: 10),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(4.0),
                          ),
                        ),
                        filled: true,
                        labelText: "your message here ",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        fillColor: Colors.white70),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: GestureDetector(
                  onTap: () {
                    _openImagePicker();
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: DottedBorder(
                      padding:EdgeInsets.all(1) ,
                      borderType: BorderType.RRect,
                      radius: Radius.circular(5),
                      // padding: EdgeInsets.all(6),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                        child: Container(
                          color: Colors.grey[100],
                          height: 40,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Take an attachment  ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Icon(
                                Icons.add,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          // color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    for (var i = 0; i < attachments.length; i++) Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            attachments[i],
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () => { _removeAttachment(i) },
                        )
                      ],
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: RaisedButton(
                  color: Colors.green,
                  onPressed: () {
                    send();

                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.green)),
                  child: Text('Send',style: TextStyle(color: Colors.white),),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Text('Our team will process your request as soon as possible',style: TextStyle(color: Colors.grey[400]),),
              )
            ],
        ),
      ),
          )),
    );
  }

  void _openImagePicker() async {
    File pick = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (pick != null) {
      setState(() {
        attachments.add(pick.path);
      });
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      attachments.removeAt(index);
    });
  }

  Future<void> send() async {
    final Email email = Email(
      body: message,
      // subject: _subjectController.text,
      recipients:['example@example.com'],
      attachmentPaths: attachments,
      // isHTML: isHTML,
    );

    String platformResponse;
    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }
}
