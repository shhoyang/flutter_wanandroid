import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/page/pages.dart';
import 'package:flutter_wanandroid/style/colors.dart';
import 'package:flutter_wanandroid/constant/images.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-06

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? _lastPressedAt; //上次点击时间
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> tabs = [
      _createBottomNavigationBarItem(Strings.wechat, Images.iconWechat),
      _createBottomNavigationBarItem(Strings.project, Images.iconAndroid),
      _createBottomNavigationBarItem(Strings.knowledge, Images.iconKnowledge),
      _createBottomNavigationBarItem(Strings.search, Images.iconSearch),
    ];
    List<Widget> pages = [WechatPage(), ProjectPage(), KnowledgePage(), SearchPage()];
    return Scaffold(
      drawer: Drawer(child: DrawerPage()),
      body: WillPopScope(
        child: IndexedStack(children: pages, index: _tabIndex),
        onWillPop: () async {
          if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 1)) {
            _lastPressedAt = DateTime.now();
            return false;
          } else {
            return true;
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: tabs,
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
        onTap: _onTabTaped,
      ),
    );
  }

  BottomNavigationBarItem _createBottomNavigationBarItem(String label, String assetName) {
    return BottomNavigationBarItem(
      label: label,
      icon: SvgPicture.asset(
        assetName,
        width: 24.0,
        height: 24.0,
        color: HColors.tabNormal,
      ),
      activeIcon: SvgPicture.asset(
        assetName,
        width: 24.0,
        height: 24.0,
        color: HColors.tabActive,
      ),
    );
  }

  void _onTabTaped(int index) {
    if (index != _tabIndex) {
      setState(() {
        _tabIndex = index;
      });
    }
  }
}
