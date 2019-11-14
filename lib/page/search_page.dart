import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wanandroid/bean/hot_word.dart';
import 'package:flutter_wanandroid/bloc/bloc_provider.dart';
import 'package:flutter_wanandroid/bloc/search_bloc.dart';
import 'package:flutter_wanandroid/constant/h_colors.dart';
import 'package:flutter_wanandroid/utils/navigator_utils.dart';
import 'package:flutter_wanandroid/widget/space.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _editingController;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    SearchBloc bloc = BlocProvider.of<SearchBloc>(context);

    return Scaffold(
      appBar: new AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
              child: new TextField(
                controller: _editingController,
                decoration: InputDecoration(
                  hintText: "请输入搜索内容",
                  labelStyle: TextStyle(fontSize: 14.0),
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                String text = _editingController.text;
                if (text.isNotEmpty) {
                  NavigatorUtils.pushSearchResult(context, text);
                }
              }),
        ],
      ),
      body: StreamBuilder(
        stream: bloc.stream,
        builder: (BuildContext context, AsyncSnapshot<List<HotWord>> snapshot) {
          if (snapshot.data == null) {
            bloc.loadData();
            return Container();
          }

          if (snapshot.data.isEmpty) {
            return Container();
          }

          return Container(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                Text("大家都在搜"),
                Space.v16,
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: snapshot.data.map((hotWord) {
                    return InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 8.0,
                        ),
                        child: Text(
                          hotWord.name,
                          style: TextStyle(
                            color: Color(HColors.hotWord),
                            fontSize: 13.0,
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(HColors.hotWord)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(32.0),
                          ),
                        ),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {
                        NavigatorUtils.pushSearchResult(context, hotWord.name);
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _editingController?.dispose();
  }
}
