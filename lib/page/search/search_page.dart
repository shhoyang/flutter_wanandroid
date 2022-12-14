import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/bean/hot_word.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/page/search/search_controller.dart';
import 'package:flutter_wanandroid/routes/navigator_utils.dart';
import 'package:flutter_wanandroid/routes/routes.dart';
import 'package:flutter_wanandroid/style/colors.dart';
import 'package:flutter_wanandroid/style/radius.dart';
import 'package:flutter_wanandroid/style/text_styles.dart';
import 'package:flutter_wanandroid/widget/simple_app_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(Strings.search),
      body: GetBuilder<SearchController>(
        init: SearchController(),
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearch(context, _),
              _buildHotWord(context, _),
            ],
          );
        },
      ),
    );
  }

  /// 搜索
  Widget _buildSearch(BuildContext context, SearchController controller) {
    return Container(
      color: HColors.grayWhite,
      height: 48.0,
      child: Row(
        children: [
          _buildInput(context, controller),
          TextButton(
            style: TextButton.styleFrom(minimumSize: Size(64.0, 48.0)),
            child: Text(Strings.search),
            onPressed: () {
              if (controller.content.isNotEmpty) {
                NavigatorUtils.pushNamed(context, Routes.SEARCH_RESULT, controller.content);
              }
            },
          ),
        ],
      ),
    );
  }

  /// 输入框
  Widget _buildInput(BuildContext context, SearchController controller) {
    return Expanded(
      child: Container(
        height: 32.0,
        margin: const EdgeInsets.only(left: 8.0),
        child: TextField(
          maxLength: 16,
          style: TextStyles.bodyText1(context),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
            hintText: Strings.hintSearch,
            counterText: "",
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
          controller: controller.contentController,
        ),
        decoration: BoxDecoration(borderRadius: HRadius.r32, color: HColors.white),
      ),
    );
  }

  /// 热词
  Widget _buildHotWord(BuildContext context, SearchController controller) {
    return GetBuilder<SearchController>(
        id: "HotWord",
        init: controller,
        builder: (controller) {
          if (controller.data.isEmpty) {
            return Container();
          } else {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 16.0, top: 8.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 32.0,
                    child: Text(Strings.hot, style: TextStyles.subtitle2(context)),
                  ),
                  _buildWrap(context, controller.data)
                ],
              ),
            );
          }
        });
  }

  /// 关键词
  Widget _buildWrap(BuildContext context, List<HotWord> data) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: data.map((hotWord) {
        return _buildItem(context, hotWord.name!);
      }).toList(),
    );
  }

  /// 关键词item
  Widget _buildItem(BuildContext context, String text) {
    return SizedBox(
        height: 28.0,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: BorderSide(color: HColors.textLink),
              shape:
                  StadiumBorder().copyWith(side: BorderSide(color: HColors.hotWord, width: 0.5))),
          child: Text(text,
              style:
                  TextStyles.bodyText1(context).copyWith(color: HColors.textLink, fontSize: 12.0)),
          onPressed: () {
            NavigatorUtils.pushNamed(context, Routes.SEARCH_RESULT, text);
          },
        ));
  }
}
