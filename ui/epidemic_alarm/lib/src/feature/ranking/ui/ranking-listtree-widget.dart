import 'dart:math';

import 'package:epidemic_alarm/src/feature/ranking/model/tree-node.dart';
import 'package:flutter/material.dart';
import 'package:list_treeview/tree/controller/tree_controller.dart';
import 'package:list_treeview/tree/node/tree_node.dart';
import 'package:list_treeview/tree/tree_view.dart';

class RankingListTreeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RankingListTreeWidgetState();
  }
}

class _RankingListTreeWidgetState extends State<RankingListTreeWidget>
    with SingleTickerProviderStateMixin {
  TreeViewController _controller;
  bool _isSuccess = false;
  List<Color> _colors = [];
  @override
  void initState() {
    super.initState();

    ///The controller must be initialized when the treeView create
    _controller = TreeViewController();

    for (int i = 0; i < 100; i++) {
      if (randomColor() != null) {
        _colors.add(randomColor());
      }
    }

    ///Data may be requested asynchronously
    getData();
  }

  void getData() async {
    print('start get data');
    _isSuccess = false;
    await Future.delayed(Duration(seconds: 2));

    var colors1 = TreeNodeModel(label: 'Colors1');
    var color11 = TreeNodeModel(
        label: 'rgb(0,139,69)', color: Color.fromARGB(255, 0, 139, 69));
    var color12 = TreeNodeModel(
        label: 'rgb(0,139,69)', color: Color.fromARGB(255, 0, 191, 255));
    var color13 = TreeNodeModel(
        label: 'rgb(0,139,69)', color: Color.fromARGB(255, 255, 106, 106));
    var color14 = TreeNodeModel(
        label: 'rgb(0,139,69)', color: Color.fromARGB(255, 160, 32, 240));
    colors1.addChild(color11);
    colors1.addChild(color12);
    colors1.addChild(color13);
    colors1.addChild(color14);

    var colors2 = TreeNodeModel(label: 'Colors2');
    var color21 = TreeNodeModel(
        label: 'rgb(0,139,69)', color: Color.fromARGB(255, 255, 64, 64));
    var color22 = TreeNodeModel(
        label: 'rgb(0,139,69)', color: Color.fromARGB(255, 28, 134, 238));
    var color23 = TreeNodeModel(
        label: 'rgb(0,139,69)', color: Color.fromARGB(255, 255, 106, 106));
    var color24 = TreeNodeModel(
        label: 'rgb(0,139,69)', color: Color.fromARGB(255, 205, 198, 115));
    colors2.addChild(color21);
    colors2.addChild(color22);
    colors2.addChild(color23);
    colors2.addChild(color24);

    /// set data
    _controller.treeData([colors1]);
    print('set treeData suceess');

    setState(() {
      _isSuccess = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Color getColor(int level) {
    return _colors[level % _colors.length];
  }

  Color randomColor() {
    int r = Random.secure().nextInt(200);
    int g = Random.secure().nextInt(200);
    int b = Random.secure().nextInt(200);
    return Color.fromARGB(255, r, g, b);
  }

  /// Add
  void add(TreeNodeModel dataNode) {
    /// create New node
//    DateTime time = DateTime.now();
//    int milliseconds = time.millisecondsSinceEpoch ~/ 1000;
    int r = Random.secure().nextInt(255);
    int g = Random.secure().nextInt(255);
    int b = Random.secure().nextInt(255);

    var newNode = TreeNodeModel(
        label: 'rgb($r,$g,$b)', color: Color.fromARGB(255, r, g, b));

    _controller.insertAtFront(dataNode, newNode);
//    _controller.insertAtRear(dataNode, newNode);
//    _controller.insertAtIndex(1, dataNode, newNode);
  }

  void delete(dynamic item) {
    _controller.removeItem(item);
  }

  void select(dynamic item) {
    _controller.selectItem(item);
  }

  void selectAllChild(dynamic item) {
    _controller.selectAllChild(item);
  }

  /*
  * TODO: add usage of fencesModel
  * Consumer<FencesModel>(
        builder: (context, fences, child) => ListTreeView(
  * */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isSuccess ? getBody() : getProgressView(),
    );
  }

  Widget getProgressView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget getBody() {
    return ListTreeView(
      shrinkWrap: false,
      padding: EdgeInsets.all(0),
      itemBuilder: (BuildContext context, NodeData data) {
        TreeNodeModel item = data as TreeNodeModel;
//              double width = MediaQuery.of(context).size.width;
        double offsetX = item.level * 16.0;
        return Container(
          height: 54,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: offsetX),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'level-${item.level}-${item.indexInParent}',
                        style: TextStyle(
                            fontSize: 15, color: getColor(item.level)),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Text("8")
              )
            ],
          ),
        );
      },
      onTap: (NodeData data) {
        print('index = ${data.index}');
      },
      onLongPress: (data) {
        delete(data);
      },
      controller: _controller,
    );
  }
}