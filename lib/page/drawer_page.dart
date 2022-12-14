import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_wanandroid/constant/images.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/controller/user_manager_controller.dart';
import 'package:flutter_wanandroid/routes/navigator_utils.dart';
import 'package:flutter_wanandroid/routes/routes.dart';
import 'package:flutter_wanandroid/style/colors.dart';
import 'package:flutter_wanandroid/style/space.dart';
import 'package:flutter_wanandroid/style/text_styles.dart';
import 'package:flutter_wanandroid/utils/t.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-13

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildBody(context),
    );
  }

  List<Widget> _buildBody(BuildContext context) {
    List<Widget> children = [];
    children.add(
      DrawerHeader(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Images.scenery), fit: BoxFit.cover)),
        child: Center(
          child: GestureDetector(
            child: Column(
              children: [
                ClipOval(child: Image.asset(Images.avatar, width: 72.0)),
                Space.v8,
                GetBuilder<UserManagerController>(
                    init: UserManagerController(),
                    builder: (controller) {
                      return Text(controller.username,
                          style: TextStyles.bodyText2(context)
                              .copyWith(color: HColors.textWhite));
                    })
              ],
            ),
            onTap: () {
              if (!UserManagerController().isLogin) {
                NavigatorUtils.pushNamed(context, Routes.LOGIN);
              }
            },
          ),
        ),
      ),
    );
    children.add(_buildMenu(Images.iconFavorite, Strings.favorite, () {
      if (!UserManagerController().isLogin) {
        NavigatorUtils.pushNamed(context, Routes.LOGIN);
      }
    }));
    children.add(_buildMenu(Images.iconClearCache, Strings.clearCache, () {
      T.show(Strings.clearCompleted);
    }));
    children.add(_buildMenu(Images.iconNew, Strings.upgrade, () {
      T.show(Strings.lastVersion);
    }));
    children.add(_buildMenu(Images.iconSetting, Strings.setting, () {}));
    children.add(_buildMenu(Images.iconAbout, Strings.about, () {}));
    children.add(_buildLogout());

    return children;
  }

  Widget _buildLogout() {
    return GetBuilder<UserManagerController>(
        init: UserManagerController(),
        builder: (controller) {
          if (controller.isLogin) {
            return _buildMenu(Images.iconExit, Strings.logout, () {
              controller.logout();
            });
          } else {
            return Container();
          }
        });
  }

  Widget _buildMenu(String name, String text, [GestureTapCallback? onTap]) {
    return ListTile(
      leading: SvgPicture.asset(name, width: 24.0, color: HColors.black),
      title: Text(text),
      onTap: onTap,
    );
  }
}
