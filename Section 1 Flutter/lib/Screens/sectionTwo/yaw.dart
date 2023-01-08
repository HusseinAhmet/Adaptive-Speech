import 'package:flutter/material.dart';
class yaw extends StatelessWidget {
  List <String> taw;
  yaw(this.taw);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),

          onPressed: () {
    taw=[];
            Navigator.of(context).pop();
  }
        ),
        title: Text("Pictures"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var v=0 ;v<taw.length;v++)
            Image.network(taw[v])
          ],
        ),
      ),




    );
  }

  clearList() {
    taw.clear();
  }


}