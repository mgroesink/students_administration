import 'package:flutter/cupertino.dart';

class StudentImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: NetworkImage(
          'https://th.bing.com/th/id/OIP.AywqK88V0S_yuyA3kjOMvwAAAA?pid=ImgDet&rs=1',
        ),
      ),
    );
  }
}
