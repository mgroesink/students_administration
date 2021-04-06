import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentImage extends StatelessWidget {
  StudentImage({this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
            Expanded(
              flex: 1,
              child: FlatButton(
                child: Text('Back'),
                color: Colors.amberAccent,
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
            Expanded(
              flex:9,
              child: Image(
                image: NetworkImage(
                  url,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
