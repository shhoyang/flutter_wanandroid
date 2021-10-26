/// @Author: Yang Shihao
/// @Date: 2021-01-06

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/bean/knowledge.dart';
import 'package:flutter_wanandroid/controller/knowledge_controller.dart';
import 'package:flutter_wanandroid/routes/routes.dart';
import 'package:flutter_wanandroid/style/colors.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/style/text_styles.dart';
import 'package:flutter_wanandroid/utils/navigator_utils.dart';
import 'package:flutter_wanandroid/widget/simple_app_bar.dart';
import 'package:flutter_wanandroid/widget/state/empty_view.dart';
import 'package:flutter_wanandroid/widget/state/loading_view.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class KnowledgePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(Strings.knowledge),
      body: GetBuilder(
        init: KnowledgeController(),
        builder: (controller) {
          return _buildBody(context, controller);
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, KnowledgeController controller) {
    if (controller.data == null) {
      controller.loadData();
      return LoadingView();
    }

    if (controller.data.isEmpty) {
      return EmptyView();
    }

    return Stack(
      children: [
        Container(
          width: 128.0,
          height: double.infinity,
          child: _buildLeftList(context, controller),
        ),
        Container(
          margin: const EdgeInsets.only(left: 128.0),
          width: double.infinity,
          height: double.infinity,
          child: _buildRightList(context, controller.children),
        )
      ],
    );
  }

  Widget _buildLeftList(BuildContext context, KnowledgeController controller) {
    return ListView.builder(
        itemCount: controller.data.length,
        itemBuilder: (BuildContext context, int index) {
          Knowledge knowledge = controller.data[index];
          return FlatButton(
              height: 48.0,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              color: knowledge.isSelected ? HColors.transparent : HColors.grayWhite,
              child: Text(knowledge.showName,
                  textAlign: TextAlign.center,
                  style: TextStyles.bodyText2(context)
                      .copyWith(color: knowledge.isSelected ? HColors.textPrimary : HColors.textBlack)),
              onPressed: () {
                controller.selected(knowledge);
              });
        });
  }

  Widget _buildRightList(BuildContext context, List<Knowledge> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          Knowledge knowledge = data[index];
          return FlatButton(
              height: 48.0,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              color: HColors.transparent,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(knowledge.showName, style: TextStyles.bodyText1(context).copyWith(color: HColors.textLink)),
              ),
              onPressed: () {
                NavigatorUtils.toPage(Routes.KNOWLEDGE_ARTICLE, knowledge);
              });
        });
  }
}
