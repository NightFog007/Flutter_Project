import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  StorePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  List<String> eventList = List<String>();

  @override
  void initState() {
    super.initState();
    eventList.add("单选题");
    eventList.add("多选题");
    eventList.add("判断题");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: eventList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: GestureDetector(
              child: Text(eventList[index]),
              onTap: () {
                Navigator.pushNamed(context, "/${eventList[index]}");
              },
            ),
          );
        },
      ),
    );
  }
}
