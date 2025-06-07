import 'package:flutter/material.dart';

class AllNowWorkWidget extends StatefulWidget {
  const AllNowWorkWidget(Key key) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AllNowWorkWidgetState();
  }
}

class AllNowWorkWidgetState extends State<AllNowWorkWidget> {
  List<Widget> allWork = [];

  @override
  Widget build(BuildContext context) {
    return Column(children: allWork);
  }
}
