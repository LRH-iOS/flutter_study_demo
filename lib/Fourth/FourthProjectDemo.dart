import 'package:flutter/material.dart';
import 'RowColumnDemo.dart';

class FourthProjectWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold (
      appBar: AppBar(
        title: Text('布局类组件'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FlatButton(
            child: Text('线性布局'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute (
                  builder: (context) {
                    return RowColumnWidget();
                  }
              ));
            },
          ),
        ],
      ),
    );
  }
}
