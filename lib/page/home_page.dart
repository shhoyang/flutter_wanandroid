/// @Author: Yang Shihao
/// @Date: 2021-01-06

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/page/pages.dart';
import 'package:flutter_wanandroid/style/colors.dart';
import 'package:flutter_wanandroid/constant/images.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> tabs = [
      BottomNavigationBarItem(
        label: Strings.wechat,
        icon: _getIcon(Images.iconWechat, HColors.tabNormal),
        activeIcon: _getIcon(Images.iconWechat, HColors.tabActive),
      ),
      BottomNavigationBarItem(
        label: Strings.project,
        icon: _getIcon(Images.iconAndroid, HColors.tabNormal),
        activeIcon: _getIcon(Images.iconAndroid, HColors.tabActive),
      ),
      BottomNavigationBarItem(
        label: Strings.knowledge,
        icon: _getIcon(Images.iconKnowledge, HColors.tabNormal),
        activeIcon: _getIcon(Images.iconKnowledge, HColors.tabActive),
      ),
      BottomNavigationBarItem(
        label: Strings.search,
        icon: _getIcon(Images.iconSearch, HColors.tabNormal),
        activeIcon: _getIcon(Images.iconSearch, HColors.tabActive),
      ),
    ];
    List<Widget> pages = [WechatPage(), ProjectPage(), KnowledgePage(), SearchPage()];
    return Scaffold(
      drawer: Drawer(child: DrawerPage()),
      body: IndexedStack(children: pages, index: _tabIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: tabs,
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
        onTap: _onTabTaped,
      ),
    );
  }

  Widget _getIcon(String name, Color color) {
    return SvgPicture.asset(
      name,
      width: 24.0,
      height: 24.0,
      color: color,
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
