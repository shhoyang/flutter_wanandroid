import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wanandroid/bean/banner_item.dart';
import 'package:flutter_wanandroid/bean/wx_author.dart';
import 'package:flutter_wanandroid/bloc/bloc_provider.dart';
import 'package:flutter_wanandroid/bloc/wx_article_bloc.dart';
import 'package:flutter_wanandroid/bloc/wechat_bloc.dart';
import 'package:flutter_wanandroid/page/search_page.dart';
import 'package:flutter_wanandroid/page/wx_article_page.dart';
import 'package:flutter_wanandroid/utils/common_utils.dart';
import 'package:flutter_wanandroid/utils/navigator_utils.dart';

class WechatPage extends StatefulWidget {
  @override
  _WechatPageState createState() => _WechatPageState();
}

class _WechatPageState extends State<WechatPage> {
  @override
  Widget build(BuildContext context) {
    final WechatBloc bloc = BlocProvider.of<WechatBloc>(context);
    return StreamBuilder(
        stream: bloc.authorsStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<WxAuthor>> snapshot) {
          if (snapshot.data == null) {
            bloc.loadData();
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            List<WxAuthor> data = snapshot.data;
            return DefaultTabController(
              length: data.length,
              child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        brightness: Brightness.light,
                        pinned: true,
                        floating: true,
                        expandedHeight:
                            MediaQuery.of(context).size.width / 16.0 * 9.0,
                        actions: <Widget>[
                          IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                NavigatorUtils.pushPage(context, SearchPage());
                              }),
                        ],
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: StreamBuilder(
                            stream: bloc.bannerStream,
                            builder: (BuildContext context,
                                AsyncSnapshot<List<BannerItem>> snapshot) {
                              List<BannerItem> data = snapshot.data;
                              if (data == null || data.isEmpty) {
                                return Image.asset(
                                  CommonUtils.getImage("motto", "jpeg"),
                                  fit: BoxFit.fitWidth,
                                );
                              } else {
                                return PageView(
                                  children:
                                      snapshot.data.map((BannerItem banner) {
                                    return CachedNetworkImage(
                                      imageUrl: banner.imagePath,
                                      fit: BoxFit.cover,
                                    );
                                  }).toList(),
                                );
                              }
                            },
                          ),
                        ),
                        bottom: TabBar(
                          isScrollable: true,
                          labelColor: Colors.blue,
                          unselectedLabelColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.label,
                          tabs: data.map((WxAuthor author) {
                            return Tab(text: author.name);
                          }).toList(),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                      children: data.map((WxAuthor author) {
                    return BlocProvider(
                        bloc: WxArticleBloc(author.id), child: WxArticlePage());
                  }).toList())),
            );
          }
        });
  }
}
