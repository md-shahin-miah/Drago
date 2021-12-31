import 'package:flutter/material.dart';

class DocumentsItem extends StatelessWidget {
String id;
String titleTop;
String titleBottom;
String  imageUrl;


  DocumentsItem(this.titleTop,this.titleBottom,this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return GridTile(child: Image.network(imageUrl),
    footer: GridTileBar(
      backgroundColor: Colors.black54,
      leading: IconButton(icon: Icon(Icons.delete,
        color: Colors.white,
      ),

      ),
      title: Text(titleBottom,style: TextStyle(color: Colors.white70),),
    ),
    );
  }
}
