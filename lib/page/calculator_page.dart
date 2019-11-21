import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utils/snack.dart';
import 'package:flutter_wanandroid/widget/simple_app_bar.dart';
import 'package:flutter_wanandroid/widget/style/h_colors.dart';
import 'package:flutter_wanandroid/widget/style/h_radius.dart';
import 'package:flutter_wanandroid/widget/style/space.dart';

class CalculatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar("计算器"),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController _controller1;
  TextEditingController _controller2;
  TextEditingController _controller3;

  String _interest = "";

  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
  }

  _calculate(int a, int b, int c) {
    int day = 365 * b;
    double principal = a * 10000.0;
    double m = principal / b / 6;
    List<double> arr = List();
    for (int i = 0; i < c; i++) {
      arr.add(principal);
    }

    double totalInterest = 0;
    for (var i = c; i <= day; i++) {
      double interest = arr[0] / 100000 * 6;
      totalInterest = totalInterest + interest;
      double temp = arr[c - 1] + interest;
      if (i % 30 == 0) {
        temp = temp - m;
        print('剩余本金-----------------------------');
        print(temp);
      }
      if (temp < 0) {
        temp = 0;
      }
      arr.removeAt(0);
      arr.add(temp);
    }

    setState(() {
      _interest = "按照日利率十万分支六计算，$a万，存$b年，可获得利润约${totalInterest.toInt()}元";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: new ListView(
        children: <Widget>[
          TextField(
            controller: _controller1,
            style: TextStyle(color: HColors.gray),
            keyboardType: TextInputType.number,
            maxLength: 3,
            decoration: InputDecoration(
              labelText: "请输入存款金额(单位:万)",
              labelStyle: TextStyle(color: HColors.darkGray),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: HColors.darkGray),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: HColors.cornflowerBlue),
              ),
            ),
          ),
          TextField(
            controller: _controller2,
            style: TextStyle(color: HColors.gray),
            keyboardType: TextInputType.number,
            maxLength: 2,
            decoration: InputDecoration(
              labelText: "请输入存款年限(单位:年)",
              labelStyle: TextStyle(color: HColors.darkGray),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: HColors.darkGray),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: HColors.cornflowerBlue),
              ),
            ),
          ),
          TextField(
            controller: _controller3,
            style: TextStyle(color: HColors.gray),
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              labelText: "本金产生收益延迟(单位:天)",
              labelStyle: TextStyle(color: HColors.darkGray),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: HColors.darkGray),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: HColors.cornflowerBlue),
              ),
            ),
          ),
          Space.v16,
          InkWell(
            borderRadius: HRadius.r4,
            child: Container(
              width: double.infinity,
              height: 40.0,
              alignment: Alignment.center,
              child: Text(
                "开始计算",
                style: TextStyle(color: HColors.white, fontSize: 16.0),
              ),
              decoration: BoxDecoration(
                color: HColors.cornflowerBlue,
                borderRadius: HRadius.r4,
              ),
            ),
            onTap: () {
              print('11111111111111111111111111111111111111');
              if (_controller1.text.isEmpty || _controller1.text == "0") {
                Snack.show(context, "你到底有钱没钱");
                return;
              }

              if (_controller2.text.isEmpty || _controller2.text == "0") {
                Snack.show(context, "你存0天有意思吗");
                return;
              }

              if (_controller3.text.isEmpty || _controller3.text == "0") {
                Snack.show(context, "马上产生收益是不可能的");
                return;
              }

              _calculate(
                int.parse(_controller1.text.trim()),
                int.parse(_controller2.text.trim()),
                int.parse(_controller3.text.trim()),
              );
            },
          ),
          Space.v16,
          Text(_interest)
        ],
      ),
    );
  }
}
