import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/bean/article.dart';
import 'package:flutter_wanandroid/bean/project_type.dart';
import 'package:flutter_wanandroid/constant/images.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/page/project/project_controller.dart';
import 'package:flutter_wanandroid/routes/navigator_utils.dart';
import 'package:flutter_wanandroid/routes/routes.dart';
import 'package:flutter_wanandroid/style/colors.dart';
import 'package:flutter_wanandroid/style/radius.dart';
import 'package:flutter_wanandroid/style/space.dart';
import 'package:flutter_wanandroid/style/text_styles.dart';
import 'package:flutter_wanandroid/widget/article_item.dart';
import 'package:flutter_wanandroid/widget/simple_app_bar.dart';
import 'package:flutter_wanandroid/widget/state/empty_view.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-06

class ProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(Strings.project),
      body: GetBuilder<ProjectController>(
        init: ProjectController(),
        builder: (controller) {
          return SmartRefresher(
            controller: controller.refreshController,
            child: _buildBody(controller.projectTypes, controller.data),
            header: MaterialClassicHeader(),
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoadMore,
          );
        },
      ),
    );
  }

  /// 列表
  Widget _buildBody(List<ProjectType> projectTypes, List<Article>? data) {
    if (projectTypes.isEmpty && (data == null || data.isEmpty)) {
      return EmptyView();
    }
    var children = <Widget>[];
    children.add(_buildProjectType(projectTypes));
    data!.forEach((article) {
      children.add(ArticleItem(article: article));
    });
    return ListView(
      children: children,
    );
  }

  /// 分类列表
  Widget _buildProjectType(List<ProjectType> data) {
    return Container(
      height: 192.0,
      child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.0),
          itemBuilder: (context, index) {
            return _buildTypeItem(context, data[index]);
          }),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(width: 8.0, color: HColors.grayWhite)),
      ),
    );
  }

  /// 分类item
  Widget _buildTypeItem(BuildContext context, ProjectType projectType) {
    return InkWell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Images.icon, width: 48.0),
          Space.getV(4.0),
          Text(projectType.showName,
              maxLines: 1,
              style: TextStyles.bodyText1(context).copyWith(fontSize: 12.0))
        ],
      ),
      borderRadius: HRadius.r50,
      onTap: () {
        NavigatorUtils.pushNamed(context, Routes.PROJECT_ARTICLE, projectType);
      },
    );
  }
}
