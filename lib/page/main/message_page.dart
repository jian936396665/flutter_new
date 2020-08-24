import 'package:flutter/material.dart';
import 'package:flutter_app_new/widget/net_loading_dialog.dart';

class MessagePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MessageState();
  }
}
class _MessageState extends State<MessagePage>{

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _showDialog,
        child: Text("dialog"),
      ),
    );
  }

  void _showDialog() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return NetLoadingDialog();
        });
  }

}