import 'package:flutter/material.dart';
import 'package:flutter_localization/pages/detail_page.dart';
import 'package:flutter_localization/services/pref_service.dart';
import 'package:flutter_localization/services/rtdb_service.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../model/note_model.dart';
import '../services/auth_service.dart';

class HomePage extends StatefulWidget {
  static final String id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiGetNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: Text("Notes"),
        actions: [
          IconButton(
            onPressed: () {
              AuthService.signOutUser(context);
            },
            icon: Icon(Icons.logout_sharp),
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: MasonryGridView.builder(
        padding: EdgeInsets.only(right: 5, left: 5),
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (ctx, i) {
          return _itemOfNotes(items[i]);
        },
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openDetail,
        child: Icon(Icons.edit_note_sharp),
        backgroundColor: Colors.orange[700],
      ),
    );
  }

  Widget _itemOfNotes(Note note) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25))),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black, fontSize: 20,),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            note.content!,
            maxLines: 4,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black, fontSize: 16,),
          ),

      SizedBox(height: 20,),

      Text(
        note.date!,
        maxLines: 4,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.grey[500], fontSize: 10,),
      )
        ],
      ),
    );
  }

  Future _openDetail() async {
    Map results = await Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new DetailPage();
    }));
    if (results != null && results.containsKey("data")) {
      print(results['data']);
      _apiGetNotes();
    }
  }

  _apiGetNotes() async {
    var id = await Prefs.loadUserId();
    print(id);
    RTDBService.loadNotes(id).then((value) => {_respNotes(value)});
  }

  _respNotes(List<Note> notes) {
    setState(() {
      items = notes.reversed.toList();
    });
  }
}
