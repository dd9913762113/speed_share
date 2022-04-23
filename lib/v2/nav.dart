import 'dart:math';

import 'package:flutter/material.dart';
import 'package:global_repository/global_repository.dart';
import 'package:speed_share/routes/page_route_builder.dart';

import 'send_file_bottom_sheet.dart';

class Nav extends StatefulWidget {
  const Nav({Key key, this.value, this.onTap}) : super(key: key);
  final int value;
  final void Function(int value) onTap;

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  @override
  Widget build(BuildContext context) {
    Widget center = Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xff6A6DED),
          ),
          transformAlignment: Alignment.center,
          transform: Matrix4.identity()..rotateZ(pi / 4),
          width: 42.w,
          height: 42.w,
        ),
        Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 28.w,
          ),
        ),
      ],
    );
    return Stack(
      alignment: Alignment.center,
      children: [
        BottomTab(
          onChange: (value) {
            value = min(value, 4);
            widget.onTap?.call(value);
            setState(() {});
          },
          children: [
            Builder(builder: (context) {
              bool enable = widget.value == 0;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    enable
                        ? 'assets/icon/home_sel.png'
                        : 'assets/icon/home.png',
                    width: 20.w,
                    height: 20.w,
                    color: enable ? Theme.of(context).primaryColor : null,
                    gaplessPlayback: false,
                  ),
                  SizedBox(height: 2.w),
                  Text(
                    '首页',
                    style: TextStyle(
                      fontSize: 14.w,
                      color: enable
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              );
            }),
            Builder(builder: (context) {
              bool enable = widget.value == 1;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.swap_horiz,
                    color: enable ? Theme.of(context).primaryColor : null,
                    size: 20.w,
                  ),
                  SizedBox(height: 2.w),
                  Text(
                    '远程',
                    style: TextStyle(
                      fontSize: 14.w,
                      color: enable
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              );
            }),
            SizedBox(),
            Builder(builder: (context) {
              bool enable = widget.value == 3;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    enable
                        ? 'assets/icon/file_sel.png'
                        : 'assets/icon/file.png',
                    width: 20.w,
                    height: 20.w,
                    gaplessPlayback: false,
                    color: enable ? Theme.of(context).primaryColor : null,
                  ),
                  SizedBox(height: 2.w),
                  Text(
                    '文件',
                    style: TextStyle(
                      fontSize: 14.w,
                      color: enable
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              );
            }),
            Builder(builder: (context) {
              bool enable = widget.value == 4;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    enable
                        ? 'assets/icon/setting.png'
                        : 'assets/icon/setting.png',
                    width: 20.w,
                    height: 20.w,
                    gaplessPlayback: false,
                    color: enable ? Theme.of(context).primaryColor : null,
                  ),
                  SizedBox(height: 2.w),
                  Text(
                    '设置',
                    style: TextStyle(
                      fontSize: 14.w,
                      color: enable
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
        GestureWithScale(
          onTap: () {
            Navigator.of(context).push(CustomRoute(
              SendFilePage(
                child: center,
              ),
            ));
          },
          child: center,
        ),
      ],
    );
  }
}

class BottomTab extends StatefulWidget {
  const BottomTab({Key key, this.children, this.onChange}) : super(key: key);
  final List<Widget> children;
  final void Function(int index) onChange;

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: Colors.white,
      child: SizedBox(
        height: 66.w,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < widget.children.length; i++)
              IconButton(
                padding: EdgeInsets.all(4.w),
                onPressed: () {
                  widget.onChange?.call(i);
                },
                icon: widget.children[i],
              ),
          ],
        ),
      ),
    );
  }
}