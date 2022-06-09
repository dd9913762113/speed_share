import 'package:flutter/material.dart';
import 'package:global_repository/global_repository.dart';
import 'package:qr_flutter/qr_flutter.dart';

// 展示二维码的弹窗
class ShowQRPage extends StatefulWidget {
  const ShowQRPage({Key key, this.port}) : super(key: key);
  final int port;

  @override
  State<ShowQRPage> createState() => _ShowQRPageState();
}

class _ShowQRPageState extends State<ShowQRPage> {
  List<String> address = [];
  @override
  void initState() {
    super.initState();
    PlatformUtil.localAddress().then((value) {
      address = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40.w),
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: 360.w,
            width: 300.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: address.length,
                    itemBuilder: (c, i) {
                      Log.i('http://${address[i]}:${widget.port}');
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.w),
                            child: QrImage(
                              data: 'http://${address[i]}:${widget.port}',
                              version: QrVersions.auto,
                              size: 280.w,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          SelectableText(
                            'http://${address[i]}:${widget.port}',
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const Text(
                  '左右滑动切换网卡',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}