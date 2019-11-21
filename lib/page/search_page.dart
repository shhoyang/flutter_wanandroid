import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wanandroid/bean/hot_word.dart';
import 'package:flutter_wanandroid/bloc/bloc_provider.dart';
import 'package:flutter_wanandroid/bloc/search_bloc.dart';
import 'package:flutter_wanandroid/widget/style/h_colors.dart';
import 'package:flutter_wanandroid/utils/navigator_utils.dart';
import 'package:flutter_wanandroid/widget/style/h_radius.dart';
import 'package:flutter_wanandroid/widget/style/space.dart';

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
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
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
                            color: HColors.hotWord,
                            fontSize: 13.0,
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: HColors.hotWord),
                          borderRadius: HRadius.r32,
                        ),
                      ),
                      borderRadius: HRadius.r32,
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
