import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:drago/pojo/documents_pojo.dart';
import 'package:drago/provider/documents_provider.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DocumentsAdd extends StatefulWidget {
  @override
  _DocumentsAddState createState() => _DocumentsAddState();
}

class _DocumentsAddState extends State<DocumentsAdd> {
  final TextEditingController _controllerMessage = TextEditingController();
  final TextEditingController _controllerType = TextEditingController();
  String description = '';
  String type = '';
  String imagePath = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static final String uploadEndPoint =
      'http://localhost/flutter_test/upload_image.php';
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

  upload(String fileName) {
    http.post(uploadEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  String date = '';
  TextEditingController _controllerDescription = TextEditingController();

  List<String> localData = [
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
    'Eight',
    'Nine',
    'Ten',
    'Seven',
    'Seven',
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
    'Eight',
    'Nine',
    'Ten',
    'Seven',
    'Seven',
  ];

  @override
  Widget build(BuildContext context) {
    final documentsProvider = Provider.of<DocumentsProvider>(context);

    final format = DateFormat("yyyy-MM-dd");

    _saveData() {
      DocumentsPojo documentsPojo = DocumentsPojo(type, description, base64Image);
      if (base64Image.isNotEmpty) {
        documentsProvider.addDocuments(documentsPojo);
        Navigator.pop(context);
      }
    }

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
            "Documents",
            style: TextStyle(
                fontWeight: FontWeight.normal, color: Colors.grey[600]),
          ),
          centerTitle: true,
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                _saveData();
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Save",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Colors.black),
                    )),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(
                          color: Colors.black54, // set border color
                          width: 1.0), // set border width
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)), // set rounded corner radius
                      // boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))]// make rounded corner of border
                    ),
                    child: DropDownField(
                      textStyle: TextStyle(fontWeight: FontWeight.normal),
                      controller: _controllerType,
                      itemsVisibleInDropdown: 5,
                      hintText: 'Description type',
                      enabled: true,
                      items: localData,
                      onValueChanged: (value) {
                        type = value;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Container(
                    child: TextField(
                      controller: _controllerDescription,
                      onChanged: (text) {
                        description = text;
                      },
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(4.0),
                            ),
                          ),
                          filled: true,
                          labelText: "Description",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          fillColor: Colors.white70),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: GestureDetector(
                    onTap: () {
                      // pickImageFromGallery(ImageSource.gallery);
                      chooseImage();
                      if(file!=null){
                        print('file data in---------------------------------------- $file');
                        startUpload();
                      }

                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: DottedBorder(
                        padding: EdgeInsets.all(1),
                        borderType: BorderType.RRect,
                        radius: Radius.circular(5),
                        // padding: EdgeInsets.all(6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(1)),
                          child: Container(
                            color: Colors.grey[100],
                            height: 160,

                            width: double.infinity,

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Take an image  ",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Icon(
                                  Icons.image,
                                  color: Colors.grey,
                                  size: 60,
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
                // RaisedButton(
                //   child: Text("Select Image from Gallery"),
                //   onPressed: () {
                //
                //   },
                // ),
                showImage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
