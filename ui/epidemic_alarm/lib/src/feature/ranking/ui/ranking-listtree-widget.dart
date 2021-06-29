import 'dart:math';

import 'package:epidemic_alarm/src/feature/main/controller/color_controller.dart';
import 'package:epidemic_alarm/src/feature/map/fences/model/fences_model.dart';
import 'package:epidemic_alarm/src/feature/ranking/model/tree-node.dart';
import 'package:flutter/material.dart';
import 'package:list_treeview/tree/controller/tree_controller.dart';
import 'package:list_treeview/tree/node/tree_node.dart';
import 'package:list_treeview/tree/tree_view.dart';
import 'package:provider/provider.dart';

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
  @override
  void initState() {
    super.initState();

    ///The controller must be initialized when the treeView create
    _controller = TreeViewController();
    _isSuccess = true;
  }


  @override
  void dispose() {
    super.dispose();
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

  Color _getItemBackgroundColor(int level) {
    if(level == 0) {
      return Colors.blue[500];
    }
    if (level == 1) {
      return Colors.blue[400];
    }
    if (level == 2) {
      return Colors.blue[300];
    }
    return Colors.blue[200];
  }

  double _getItemFontSize(int level) {
    if(level == 0) {
      return 19.0;
    }
    if (level == 1) {
      return 17.0;
    }
    if (level == 2) {
      return 15.0;
    }
    return 13.0;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FencesModel>(
      builder: (context, fences, child) => Scaffold(
        body: _isSuccess ? getBody(fences) : getProgressView(),
      ),
    );
  }

  Widget getProgressView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget getBody(FencesModel fences) {
    _controller.treeData(fences.regionsDiagnosedCasesTree);
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
              color: _getItemBackgroundColor(item.level),
              border: Border(bottom: BorderSide(width: 1, color: Colors.white70))),
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
                        item.name,
                        style: TextStyle(
                            fontSize: _getItemFontSize(item.level),
                            color: Colors.white
                        )
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Text(
                    item.diagnosedCasesCount.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: ColorController.getDangerPrimaryColor(item.diagnosedCasesCount)
                    )
                ),
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