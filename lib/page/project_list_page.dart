import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wanandroid/bean/article.dart';
import 'package:flutter_wanandroid/bloc/bloc_provider.dart';
import 'package:flutter_wanandroid/bloc/project_list_bloc.dart';
import 'package:flutter_wanandroid/utils/list_state.dart';
import 'package:flutter_wanandroid/widget/article_list.dart';
import 'package:flutter_wanandroid/widget/simple_app_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProjectListPage extends StatefulWidget {
  final String type;

  ProjectListPage({Key key, this.type}) : super(key: key);

  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    ProjectListBloc bloc = BlocProvider.of<ProjectListBloc>(context);
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
