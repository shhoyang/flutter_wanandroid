import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wanandroid/bean/project_tree.dart';
import 'package:flutter_wanandroid/bloc/bloc_provider.dart';
import 'package:flutter_wanandroid/bloc/knowledge_bloc.dart';
import 'package:flutter_wanandroid/bloc/knowledge_project_list_bloc.dart';
import 'package:flutter_wanandroid/widget/style/h_colors.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/page/knowledge_project_list_page.dart';
import 'package:flutter_wanandroid/utils/common_utils.dart';
import 'package:flutter_wanandroid/utils/list_state.dart';
import 'package:flutter_wanandroid/utils/navigator_utils.dart';
import 'package:flutter_wanandroid/widget/simple_app_bar.dart';
import 'package:flutter_wanandroid/widget/style/h_radius.dart';
import 'package:flutter_wanandroid/widget/style/space.dart';
import 'package:flutter_wanandroid/widget/state/empty_view.dart';
import 'package:flutter_wanandroid/widget/state/loading_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class KnowledgePage extends StatefulWidget {
  @override
  _KnowledgePageState createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    KnowledgeBloc bloc = BlocProvider.of<KnowledgeBloc>(context);
    bloc.stateStream.listen((state) {
      ListState.setController(_refreshController, state);
    });
    return Scaffold(
      appBar: SimpleAppBar(Strings.knowledge),
      body: StreamBuilder(
          stream: bloc.stream,
          builder: (BuildContext context,
              AsyncSnapshot<List<ProjectTree>> snapshot) {
            return SmartRefresher(
              enablePullUp: false,
              enablePullDown: true,
              onRefresh: bloc.refresh,
              onLoading: bloc.loadMore,
              controller: _refreshController,
              header: WaterDropHeader(),
              child: _buildList(bloc, snapshot.data),
            );
          }),
    );
  }

  Widget _buildList(KnowledgeBloc bloc, List<ProjectTree> data) {
    if (data == null) {
      bloc.refresh();
      return LoadingView();
    }

    if (data.isEmpty) {
      return EmptyView();
    }

    return ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        ProjectTree projectTree = data[index];
        return Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              alignment: Alignment.centerLeft,
              color: HColors.lightGrey,
              child: Text(
                projectTree.name,
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: projectTree.children.map((tree) {
                  return InkWell(
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 3.0,
                        top: 3.0,
                        right: 12.0,
                        bottom: 3.0,
                      ),
                      child:  Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CircleAvatar(
                            child: Image.asset(
                              CommonUtils.getImage("icon"),
                            ),
                            radius: 12.0,
                            backgroundColor: HColors.hotWord,
                          ),
                          Space.getH(6.0),
                          Text(
                            tree.name,
                            style: TextStyle(
                              color: HColors.hotWord,
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFE0E0E0),
                        borderRadius: HRadius.r32,
                      ),
                    ),
                    borderRadius: HRadius.r32,
                    onTap: () {
                      NavigatorUtils.pushPage(
                        context,
                        BlocProvider<KnowledgeProjectListBloc>(
                          bloc: KnowledgeProjectListBloc(tree.id),
                          child: KnowledgeProjectListPage(type: tree.name),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }
}
