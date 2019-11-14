import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wanandroid/bean/article.dart';
import 'package:flutter_wanandroid/bean/project_tree.dart';
import 'package:flutter_wanandroid/bloc/bloc_provider.dart';
import 'package:flutter_wanandroid/bloc/project_bloc.dart';
import 'package:flutter_wanandroid/bloc/project_list_bloc.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/page/project_list_page.dart';
import 'package:flutter_wanandroid/utils/common_utils.dart';
import 'package:flutter_wanandroid/utils/list_state.dart';
import 'package:flutter_wanandroid/utils/navigator_utils.dart';
import 'package:flutter_wanandroid/widget/article_item.dart';
import 'package:flutter_wanandroid/widget/simple_app_bar.dart';
import 'package:flutter_wanandroid/widget/space.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ProjectBloc bloc = BlocProvider.of<ProjectBloc>(context);
    bloc.stateStream.listen((state) {
      ListState.setController(_refreshController, state);
    });

    Widget _buildProjectType() {
      return Container(
        height: 200.0,
        child: StreamBuilder(
            stream: bloc.projectTreeStream,
            builder: (BuildContext context,
                AsyncSnapshot<List<ProjectTree>> snapshot) {
              return GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    ProjectTree projectTree = snapshot.data[index];
                    return InkWell(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            CommonUtils.getImage("icon"),
                            width: 48,
                            height: 48,
                          ),
                          Space.getV(4.0),
                          Text(
                            projectTree.name.replaceAll("&amp;", ""),
                            maxLines: 1,
                            style: TextStyle(fontSize: 12.0),
                          )
                        ],
                      ),
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(50.0)),
                      onTap: () {
                        NavigatorUtils.pushPage(
                          context,
                          BlocProvider<ProjectListBloc>(
                            bloc: ProjectListBloc(projectTree.id),
                            child: ProjectListPage(
                              type: projectTree.name.replaceAll("&amp;", ""),
                            ),
                          ),
                        );
                      },
                    );
                  });
            }),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 8.0, color: Color(0xFFF0F0F0)))),
      );
    }

    List<Widget> _buildList(List<Article> data) {
      if (data == null) {
        bloc.refresh();
        return [_buildProjectType()];
      }

      if (data.isEmpty) {
        return [_buildProjectType()];
      }

      List<Widget> list = [];
      list.add(_buildProjectType());
      data.forEach((article) {
        list.add(ArticleItem(
            article: article, onPressed: () {}, onFavPressed: () {}));
      });

      return list;
    }

    return Scaffold(
      appBar: SimpleAppBar(Strings.project),
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
              child: ListView(
                children: _buildList(snapshot.data),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
