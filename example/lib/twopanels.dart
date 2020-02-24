import 'package:flutter/material.dart';

class TwoPanels extends StatefulWidget {
  final AnimationController controller;
  final Widget frontPanel;
  final Widget backPanel;
  final String frontPanelHeader;
  final Function isPanelVisible;
  TwoPanels(
      {this.controller,
      this.frontPanel,
      this.backPanel,
      this.frontPanelHeader,
      this.isPanelVisible});

  @override
  _TwoPanelsState createState() => _TwoPanelsState();
}

class _TwoPanelsState extends State<TwoPanels> {
  static const header_height = 32.0;

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final backPanelHeight = height - header_height;
    final frontPanelHeight = -header_height;

    return RelativeRectTween(
            begin: RelativeRect.fromLTRB(
                0.0, backPanelHeight, 0.0, frontPanelHeight),
            end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0))
        .animate(
            CurvedAnimation(parent: widget.controller, curve: Curves.linear));
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    final ThemeData theme = Theme.of(context);

    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            color: theme.primaryColor,
            child: widget.backPanel,
          ),
          PositionedTransition(
            rect: getPanelAnimation(constraints),
            child: Material(
              elevation: 12.0,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0)),
              child: GestureDetector(
                onTap: () {
                  // When the [frontPanel] is up don't recognize gestures
                  if (!widget.isPanelVisible()) {
                    widget.controller.fling(velocity: 1.0);
                  }
                },
                child: Container(
                  // It won't recognize the gesture if it is not painted
                  color: Colors.transparent,
                  child: Column(
                    children: <Widget>[
                      widget.isPanelVisible()
                          ? Container()
                          : Container(
                              height: header_height,
                              child: Center(
                                child: Text(
                                  widget.frontPanelHeader,
                                  style: theme.textTheme.button,
                                ),
                              ),
                            ),
                      Expanded(
                        child: widget.frontPanel,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }
}
