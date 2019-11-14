import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/bloc/bloc_provider.dart';
import 'package:flutter_wanandroid/bloc/knowledge_bloc.dart';
import 'package:flutter_wanandroid/bloc/project_bloc.dart';
import 'package:flutter_wanandroid/bloc/wechat_bloc.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/page/knowledge_page.dart';
import 'package:flutter_wanandroid/page/me_page.dart';
import 'package:flutter_wanandroid/page/project_page.dart';
import 'package:flutter_wanandroid/page/wechat_page.dart';
import 'package:flutter_wanandroid/utils/common_utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final TextStyle _styleNormal =
      TextStyle(fontSize: 12.0, color: Color(0xFF8A8A8A));
  final TextStyle _styleActive = TextStyle(fontSize: 12.0, color: Colors.black);

  int _tabIndex = 0;
  List<Widget> _page;
  List<TabItem> tabs;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() {
    _page = [
      BlocProvider<WechatBloc>(bloc: WechatBloc(), child: WechatPage()),
      BlocProvider<ProjectBloc>(bloc: ProjectBloc(), child: ProjectPage()),
      BlocProvider<KnowledgeBloc>(bloc: KnowledgeBloc(), child: KnowledgePage()),
      MePage()
    ];
    tabs = [
      TabItem(Strings.home, "home_normal", "home_active"),
      TabItem(Strings.project, "project_normal", "project_active"),
      TabItem(Strings.knowledge, "knowledge_normal", "knowledge_active"),
      TabItem(Strings.me, "me_normal", "me_active")
    ];
  }

  Widget _getIcon(path) {
    return Image.asset(CommonUtils.getImage(path), width: 24.0, height: 24.0);
  }

  void _onTabTaped(int index) {
    if (index != _tabIndex) {
      setState(() {
        _tabIndex = index;
      });
    }
  }

  BottomNavigationBarItem _createBarItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: _getIcon(tabItem.icon),
      activeIcon: _getIcon(tabItem.activeIcon),
      title: Text(
        tabItem.title,
        style: tabs.indexOf(tabItem) == _tabIndex ? _styleActive : _styleNormal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
//      body:  PageView.builder(
//          physics: NeverScrollableScrollPhysics(),
//          controller: _pageController,
//          itemCount: tabs.length,
//          onPageChanged: (index) {
//            if (index != _tabIndex) {
//              setState(() {
//                _tabIndex = index;
//              });
//            }
//          },
//          itemBuilder: (context, index) {
//            return _page[index];
//          }),
      body: IndexedStack(
        children: _page,
        index: _tabIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: tabs.map(_createBarItem).toList(),
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
        iconSize: 24.0,
        onTap: _onTabTaped,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TabItem {
  String title;
  String icon;
  String activeIcon;

  TabItem(this.title, this.icon, this.activeIcon);
}
