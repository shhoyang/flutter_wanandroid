import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wanandroid/bean/ad.dart';
import 'package:flutter_wanandroid/bean/author.dart';
import 'package:flutter_wanandroid/constant/images.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/page/wechat/wechat_controller.dart';
import 'package:flutter_wanandroid/page/wechat/wechat_article/wechat_article_page.dart';
import 'package:flutter_wanandroid/style/colors.dart';
import 'package:flutter_wanandroid/style/dimens.dart';
import 'package:flutter_wanandroid/style/text_styles.dart';
import 'package:flutter_wanandroid/widget/state/empty_view.dart';
import 'package:flutter_wanandroid/widget/state/loading_view.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class WechatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: MediaQueryData.fromWindow(window).padding.top,
            color: HColors.primary),
        _buildTitle(context),
        Expanded(child: _buildBody()),
      ],
    );
  }

  /// 标题
  Widget _buildTitle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: HColors.primary,
      height: Dimens.titleHeight,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Strings.appEnglishName,
                  style: TextStyles.title2(context)
                      .copyWith(color: HColors.textWhite)),
              Text(Strings.motto,
                  style: TextStyles.subtitle1(context)
                      .copyWith(color: HColors.textWhite, fontSize: 10.0)),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                icon: ClipOval(child: Image.asset(Images.avatar, width: 32.0)),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                }),
          ),
        ],
      ),
    );
  }

  /// 内容
  Widget _buildBody() {
    return GetBuilder<WechatController>(
        init: WechatController(),
        builder: (controller) {
          List<Author>? authors = controller.authors;
          if (authors == null) {
            controller.loadData();
            return LoadingView();
          } else if (authors.isEmpty) {
            return EmptyView();
          } else {
            return DefaultTabController(
              length: authors.length,
              child: NestedScrollView(
                physics: ScrollPhysics(parent: PageScrollPhysics()),
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      systemOverlayStyle: SystemUiOverlayStyle.light,
                      primary: false,
                      floating: true,
                      pinned: true,
                      snap: true,
                      expandedHeight:
                          MediaQuery.of(context).size.width / 16.0 * 9.0 + 46.0,
                      flexibleSpace: _buildBanner(controller.ad),
                      bottom: _buildTabBar(controller.authors!),
                    )
                  ];
                },
                body: _buildTabBarView(controller.authors!),
              ),
            );
          }
        });
  }

  /// 轮播图
  FlexibleSpaceBar _buildBanner(List<Ad> data) {
    Widget child;
    if (data.isEmpty) {
      child = Image.asset(Images.scenery, fit: BoxFit.fitWidth);
    } else {
      child = PageView(
        children: data.map((ad) {
          return CachedNetworkImage(imageUrl: ad.imagePath!, fit: BoxFit.cover);
        }).toList(),
      );
    }

    return FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      background: Container(
        padding: const EdgeInsets.only(bottom: 46.0),
        child: child,
      ),
    );
  }

  /// tab
  TabBar _buildTabBar(List<Author> data) {
    return TabBar(
      isScrollable: true,
      labelColor: HColors.tabActive,
      unselectedLabelColor: HColors.tabNormal,
      indicatorColor: HColors.tabActive,
      indicatorSize: TabBarIndicatorSize.label,
      tabs: data.map((author) {
        return Tab(text: author.name);
      }).toList(),
    );
  }

  /// page
  TabBarView _buildTabBarView(List<Author> data) {
    return TabBarView(
      children: data.map((author) {
        return WechatArticlePage(authorId: author.id!);
      }).toList(),
    );
  }
}
