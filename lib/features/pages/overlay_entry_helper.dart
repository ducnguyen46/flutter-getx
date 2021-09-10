import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:searchfield/searchfield.dart';

enum OVERLAY_POSITION { TOP, BOTTOM }

class OverLayEntryHelper extends StatefulWidget {
  OverLayEntryHelper({Key? key}) : super(key: key);

  @override
  _OverLayEntryHelperState createState() => _OverLayEntryHelperState();
}

class _OverLayEntryHelperState extends State<OverLayEntryHelper> {
  TapDownDetails? _tapDownDetails;
  OverlayEntry? _overlayEntry;
  OVERLAY_POSITION? _overlayPosition;
  final LayerLink _layerLink = LayerLink();

  double? _statusBarHeight;
  double _toolBarHeight = 50;

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    var size = renderBox.size;

    var offset = renderBox.localToGlobal(Offset.zero);
    var globalOffset = renderBox.localToGlobal(_tapDownDetails!.globalPosition);

    _statusBarHeight = MediaQuery.of(context).padding.top;

    var screenHeight = MediaQuery.of(context).size.height;

    var remainingScreenHeight =
        screenHeight - _statusBarHeight! - _toolBarHeight;

    if (globalOffset.dy > remainingScreenHeight / 2) {
      _overlayPosition = OVERLAY_POSITION.TOP;
    } else {
      _overlayPosition = OVERLAY_POSITION.BOTTOM;
    }
    return OverlayEntry(builder: (context) {
      return Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _overlayEntry?.remove();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          Positioned(
            left: 10,
            top: _overlayPosition == OVERLAY_POSITION.TOP
                ? _statusBarHeight! + _toolBarHeight
                : globalOffset.dy + 5.0,
            width: MediaQuery.of(context).size.width - 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // ignore: sdk_version_ui_as_code
                if (_overlayPosition == OVERLAY_POSITION.BOTTOM) nip(),
                body(context, offset.dy),
                // ignore: sdk_version_ui_as_code
                if (_overlayPosition == OVERLAY_POSITION.TOP) nip(),
              ],
            ),
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 100, left: 10, right: 100),
        child: GestureDetector(
          child: Container(
            width: 100,
            height: 40,
            color: Colors.blueGrey,
          ),
          onTapDown: (TapDownDetails tapDown) {
            setState(() {
              _tapDownDetails = tapDown;
            });
            this._overlayEntry = this._createOverlayEntry();
            Overlay.of(context)!.insert(this._overlayEntry!);
          },
        ),
      ),
    );
  }

  Widget body(BuildContext context, double offset) {
    return Material(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: _overlayPosition == OVERLAY_POSITION.BOTTOM
            ? MediaQuery.of(context).size.height -
                _tapDownDetails!.globalPosition.dy -
                20
            : _tapDownDetails!.globalPosition.dy -
                _toolBarHeight -
                _statusBarHeight! -
                15,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: MultiSelectBottomSheet(
          items: [],
          initialValue: [],
        ),
      ),
    );
  }

  Widget nip() {
    return Container(
      height: 10.0,
      width: 10.0,
      margin: EdgeInsets.only(left: _tapDownDetails!.globalPosition.dx),
      child: CustomPaint(
        painter: OpenPainter(_overlayPosition!),
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  final OVERLAY_POSITION overlayPosition;

  OpenPainter(this.overlayPosition);

  @override
  void paint(Canvas canvas, Size size) {
    switch (overlayPosition) {
      case OVERLAY_POSITION.TOP:
        var paint = Paint()
          ..style = PaintingStyle.fill
          ..color = Colors.white
          ..isAntiAlias = true;

        _drawThreeShape(
            canvas, Offset(0, 0), Offset(20, 0), Offset(10, 15), size, paint);

        break;
      case OVERLAY_POSITION.BOTTOM:
        var paint = Paint()
          ..style = PaintingStyle.fill
          ..color = Colors.white
          ..isAntiAlias = true;

        _drawThreeShape(
            canvas, Offset(15, 0), Offset(0, 20), Offset(30, 20), size, paint);

        break;
    }

    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  void _drawThreeShape(Canvas canvas, Offset first, Offset second, Offset third,
      Size size, paint) {
    var path1 = Path()
      ..moveTo(first.dx, first.dy)
      ..lineTo(second.dx, second.dy)
      ..lineTo(third.dx, third.dy);
    canvas.drawPath(path1, paint);
  }

  void _drawTwoShape(
      Canvas canvas, Offset first, Offset second, Size size, paint) {
    var path1 = Path()
      ..moveTo(first.dx, first.dy)
      ..lineTo(second.dx, second.dy);
    canvas.drawPath(path1, paint);
  }
}
