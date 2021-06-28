import 'package:flutter/material.dart';
import 'package:list_treeview/tree/node/tree_node.dart';

class TreeNodeModel extends NodeData {
  /// Other properties that you want to define
  final String name;
  final int diagnosedCasesCount;
  final Color color;

  TreeNodeModel({this.name, this.diagnosedCasesCount, this.color}) : super();
  ///...
}