import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wanandroid/bean/article.dart';
import 'package:flutter_wanandroid/bloc/bloc_provider.dart';
import 'package:flutter_wanandroid/bloc/knowledge_project_list_bloc.dart';
import 'package:flutter_wanandroid/utils/list_state.dart';
import 'package:flutter_wanandroid/widget/article_list.dart';
import 'package:flutter_wanandroid/widget/simple_app_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class KnowledgeProjectListPage extends StatefulWidget {
  final String type;

  KnowledgeProjectListPage({Key key, this.type}) : super(key: key);

  @override
  _KnowledgeProjectListPageState createState() =>
      _KnowledgeProjectListPageState();
}

class _KnowledgeProjectListPageState extends State<KnowledgeProjectListPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    KnowledgeProjectListBloc bloc =
        BlocProvider.of<KnowledgeProjectListBloc>(context);
    bloc.stateStream.listen((state) {
      ListState.setController(_refreshController, state);
    });
    return Scaffold(
      appBar: SimpleAppBar(widget.type),
      body: StreamBuilder(
          stream: bloc.stream,
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            return SmartRefresher(
              enablePullUp: true,
              enablePullDown: true,
              onRefresh: bloc.refresh,
              onLoading: bloc.loadMore,
              controller: _refreshController,
              header: WaterDropHeader(),
              child: ArticleList(
                data: snapshot.data,
                refresh: bloc.refresh,
              ).build(context),
            );
          }),
    );
  }

  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }
}
