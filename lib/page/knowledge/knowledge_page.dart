import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/bean/knowledge.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/page/knowledge/knowledge_controller.dart';
import 'package:flutter_wanandroid/routes/navigator_utils.dart';
import 'package:flutter_wanandroid/routes/routes.dart';
import 'package:flutter_wanandroid/style/colors.dart';
import 'package:flutter_wanandroid/style/text_styles.dart';
import 'package:flutter_wanandroid/widget/simple_app_bar.dart';
import 'package:flutter_wanandroid/widget/state/empty_view.dart';
import 'package:flutter_wanandroid/widget/state/loading_view.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-06

class KnowledgePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(Strings.knowledge),
      body: GetBuilder<KnowledgeController>(
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

    if (controller.data!.isEmpty) {
      return EmptyView();
    }

    return Stack(
      children: [
        Container(
          width: 128.0,
          height: double.infinity,
          child: _buildLeftList(controller),
        ),
        Container(
          margin: const EdgeInsets.only(left: 128.0),
          width: double.infinity,
          height: double.infinity,
          child: _buildRightList(controller.children),
        )
      ],
    );
  }

  Widget _buildLeftList(KnowledgeController controller) {
    return ListView.builder(
        itemCount: controller.data!.length,
        itemBuilder: (context, index) {
          Knowledge knowledge = controller.data![index];
          return TextButton(
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(TextStyles.subtitle1(context).copyWith(
                      color: knowledge.isSelected ? HColors.textPrimary : HColors.textBlack)),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 8.0)),
                  minimumSize: MaterialStateProperty.all(Size.fromHeight(48.0)),
                  backgroundColor: MaterialStateProperty.all(
                      knowledge.isSelected ? HColors.transparent : HColors.grayWhite),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder())),
              child: Text(
                knowledge.showName,
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                controller.selected(knowledge);
              });
        });
  }

  Widget _buildRightList(List<Knowledge> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          var knowledge = data[index];
          return TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 16.0)),
                minimumSize: MaterialStateProperty.all(Size.fromHeight(48.0)),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(knowledge.showName,
                    style: TextStyles.bodyText1(context).copyWith(color: HColors.textLink)),
              ),
              onPressed: () {
                NavigatorUtils.pushNamed(context, Routes.KNOWLEDGE_ARTICLE, knowledge);
              });
        });
  }
}
