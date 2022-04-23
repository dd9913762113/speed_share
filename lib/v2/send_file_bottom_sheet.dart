import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_repository/global_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speed_share/app/controller/controller.dart';

class SendFilePage extends StatefulWidget {
  const SendFilePage({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  State<SendFilePage> createState() => _SendFilePageState();
}

class _SendFilePageState extends State<SendFilePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  ChatController chatController = Get.find();
  Animation color;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    color = ColorTween(
      begin: const Color(0xff6A6DED),
      end: const Color(0xff424242),
    ).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget center = Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: color.value,
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
    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 92.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.w),
                topRight: Radius.circular(16.w),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop();
                    final ImagePicker _picker = ImagePicker();
                    final List<XFile> images = await _picker.pickMultiImage();
                    if (images != null) {
                      for (var element in images) {
                        chatController.sendFileFromPath(element.path);
                      }
                    }
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 24.w,
                      ),
                      Image.asset(
                        'assets/icon/gallery.png',
                        width: 32.w,
                        height: 32.w,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        '上传图片',
                        style: TextStyle(fontSize: 14.w, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                GestureWithScale(
                  onTap: () async {
                    Navigator.of(context).pop();
                    final ImagePicker _picker = ImagePicker();
                    final XFile photo = await _picker.pickImage(
                      source: ImageSource.camera,
                    );
                    if (photo != null) {
                      chatController.sendFileFromPath(photo.path);
                    }
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8.w,
                      ),
                      Image.asset(
                        'assets/icon/camera.png',
                        width: 32.w,
                        height: 32.w,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        '拍照',
                        style: TextStyle(fontSize: 14.w, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                GestureWithScale(
                  onTap: () {
                    Navigator.of(context).pop();
                    chatController.sendFileForAndroid(
                      useSystemPicker: false,
                    );
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 24.w,
                      ),
                      Image.asset(
                        'assets/icon/upload.png',
                        width: 32.w,
                        height: 32.w,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        '上传文件',
                        style: TextStyle(fontSize: 14.w, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 66.w,
            child: GestureWithScale(
              onTap: () async {
                await controller.reverse();
                Navigator.of(context).pop();
              },
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateZ(controller.value * pi / 4),
                    child: child,
                  );
                },
                child: center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}