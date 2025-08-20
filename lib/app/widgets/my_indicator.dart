
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:gogo/app/utils/constants/app_colors.dart';




class MyIndicator extends StatelessWidget {
  const MyIndicator(
      this.status, {super.key,
        this.tryAgain,
        this.isSliver = false,
        this.emptyWidget,
      });

  ///Status of indicator
  final IndicatorStatus status;

  ///call back of loading failed
  final Function? tryAgain;

  ///whether it need sliver as container
  final bool isSliver;

  ///emppty widget
  final Widget? emptyWidget;
  @override
  @override
  Widget build(BuildContext context) {
    Widget? widget;
    switch (status) {
      case IndicatorStatus.none:
        widget = Container(height: 0.0);
        break;
      case IndicatorStatus.loadingMoreBusying:
        widget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 5.0),
              height: 15.0,
              width: 15.0,
              child: getIndicator(context),
            ),
            SizedBox(width: 10.w,),
            AutoSizeText('Loading...', style: TextStyle(color: Colors.black),)
          ],
        );
        widget = _setbackground(false, widget, 35.0);
        break;
      case IndicatorStatus.fullScreenBusying:
        widget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 0.0),
              height: 30.0,
              width: 30.0,
              child: getIndicator(context),
            ),
            SizedBox(width: 10.w,),
            AutoSizeText('Loading...', style: TextStyle(color: Colors.black),)
          ],
        );
        widget = _setbackground(true, widget, double.infinity);
        if (isSliver) {
          widget = SliverFillRemaining(
            child: widget,
          );
        } else {
          widget = CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                child: widget,
              )
            ],
          );
        }
        break;
      case IndicatorStatus.error:
        widget = AutoSizeText(
          'No data found to load', style: TextStyle(color: Colors.black),
        );
        widget = _setbackground(false, widget, 35.0);
        if (tryAgain != null) {
          widget = GestureDetector(
            onTap: () {
              tryAgain!();
            },
            child: widget,
          );
        }
        break;
      case IndicatorStatus.fullScreenError:
        widget = AutoSizeText(
         'Failed to load data', style: TextStyle(color: Colors.black),
        );
        widget = _setbackground(true, widget, double.infinity);
        if (tryAgain != null) {
          widget = GestureDetector(
            onTap: () {
              tryAgain!();
            },
            child: widget,
          );
        }
        if (isSliver) {
          widget = SliverFillRemaining(
            child: widget,
          );
        } else {
          widget = CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                child: widget,
              )
            ],
          );
        }
        break;
      case IndicatorStatus.noMoreLoad:
        widget = AutoSizeText('No more items', style: TextStyle(color: Colors.black),);
        widget = _setbackground(false, widget, 35.0);
        break;
      case IndicatorStatus.empty:
        widget = Text(('No data found'));
        widget = _setbackground(true, widget, double.infinity);
        if (isSliver) {
          widget = SliverFillRemaining(
            child: widget,
          );
        } else {
          widget = CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                child: widget,
              )
            ],
          );
        }
        break;
    }
    return widget;
  }

  Widget _setbackground(bool full, Widget widget, double height) {
    widget = Container(
        width: double.infinity,
        height: height,
        child: widget,
        color: CustomColors.transparent,
        alignment: Alignment.center);
    return widget;
  }

  Widget getIndicator(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.platform == TargetPlatform.iOS
        ? const CupertinoActivityIndicator(
      animating: true,
      radius: 16.0,
    )
        : CircularProgressIndicator(
      strokeWidth: 2.0,
      color: CustomColors.yollow,
      // valueColor: AlwaysStoppedAnimation<Color>(colorPrimary),
    );
  }
}
