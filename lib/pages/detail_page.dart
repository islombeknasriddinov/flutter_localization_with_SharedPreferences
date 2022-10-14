import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/model/note_model.dart';
import 'package:flutter_localization/services/pref_service.dart';
import 'package:flutter_localization/services/rtdb_service.dart';

class DetailPage extends StatefulWidget {
  static final String id = "detail_page";

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var titleController = TextEditingController();
  var contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.orange[700],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          actions: [
            IconButton(
              onPressed: _addNote,
              icon: Icon(Icons.check),
              color: Colors.white,
            ),
            SizedBox(width: 10,)
          ],
        ),
        body:SingleChildScrollView(
          child:Container(
            height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(right: 30, left: 30),
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.next,
            minLines: 1,
            maxLines: 20,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22
            ),
            controller: titleController,
            decoration: InputDecoration(
                hintText: "Title",
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: InputBorder.none
            ),
          ),

          SizedBox(height: 15,),

          Expanded(
              child: Container(
                child: TextField(
                  style: TextStyle(
                      fontSize: 18
                  ),
                  keyboardType: TextInputType.multiline,
                  expands: true,
                  maxLines: null,
                  controller: contentController,
                  decoration: InputDecoration(
                      hintText: "Content",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: InputBorder.none
                  ),
                ),
              )
          )
        ],
      ),
    ),
        )
    );
  }

  _addNote() async {
    String title = titleController.text.toString();
    String content = contentController.text.toString();
    if (title.isEmpty || content.isEmpty) return;
    var now = DateTime.now();
    var formatterDate = DateFormat('dd/MM/yyyy');
    var formatterTime = DateFormat('kk:mm');
    String actualDate = formatterDate.format(now);
    String actualTime = formatterTime.format(now);
    String date = actualDate + "  " + actualTime;
    _apiSetNotes(title, content, date);
  }

  _apiSetNotes(String title, String content, String date) async {
    var id = await Prefs.loadUserId();
    RTDBService.storeNote(new Note(id, title, content, date)).then((response) =>
    {
      Navigator.of(context).pop({'data': 'done'})
    });
  }
}
