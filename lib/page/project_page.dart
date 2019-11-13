import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wanandroid/bean/article.dart';
import 'package:flutter_wanandroid/bean/project_type.dart';
import 'package:flutter_wanandroid/bloc/bloc_provider.dart';
import 'package:flutter_wanandroid/bloc/project_bloc.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/event/list_state.dart';
import 'package:flutter_wanandroid/utils/common_utils.dart';
import 'package:flutter_wanandroid/widget/article_item.dart';
import 'package:flutter_wanandroid/widget/simple_app_bar.dart';
import 'package:flutter_wanandroid/widget/space.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    ProjectBloc bloc = BlocProvider.of<ProjectBloc>(context);
//    bloc.stateStream.listen((state) {
//      if (state & ListState.NO_DATA != ListState.EMPTY) {}
//
//      if (state & ListState.REFRESH != ListState.EMPTY) {
//        _refreshController?.refreshCompleted();
//      } else {
//        if (state & ListState.LOAD_MORE_FAILED != ListState.EMPTY) {
//          _refreshController?.loadFailed();
//        } else if (state & ListState.NO_MORE != ListState.EMPTY) {
//          _refreshController?.loadNoData();
//        } else {
//          _refreshController?.loadComplete();
//        }
//      }
//    });

    Widget _buildProjectType() {
      return SliverToBoxAdapter(
        child: Container(
          height: 200.0,
          child: StreamBuilder(
              stream: bloc.projectTypeStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ProjectType>> snapshot) {
                return GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
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
                              snapshot.data[index].name.replaceAll("&amp;", ""),
                              maxLines: 1,
                              style: TextStyle(fontSize: 12.0),
                            )
                          ],
                        ),
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(50.0)),
                        onTap: () {},
                      );
                    });
              }),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 8.0, color: Color(0xFFF0F0F0)))),
        ),
      );
    }

    Widget _buildList(List<Article> data) {
      if (data == null) {
        bloc.refresh();
        return Container(
          child: Center(
            child: Text("LOADING..."),
          ),
        );
      }

      if (data.isEmpty) {
        return Container(
          child: Center(
            child: Text("NO DATA"),
          ),
        );
      }

      return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          Article article = data[index];
          return ArticleItem(
              article: article, onPressed: () {}, onFavPressed: () {});
        }, childCount: data.length),
      );
    }

    return Scaffold(
      appBar: SimpleAppBar(Strings.PROJECT),
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
              child: CustomScrollView(
                slivers: <Widget>[
                  _buildProjectType(),
                  _buildList(snapshot.data),
                ],
              ),
            );
          }),
    );
  }
}
