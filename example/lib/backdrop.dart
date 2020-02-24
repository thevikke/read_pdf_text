import 'package:flutter/material.dart';
import 'package:read_pdf_text_example/pdf_reader.dart';
import 'package:read_pdf_text_example/twopanels.dart';

class BackdropPage extends StatefulWidget {
  @override
  _BackdropPageState createState() => _BackdropPageState();
}

class _BackdropPageState extends State<BackdropPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 100), value: 1.0);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  bool isPanelVisible() {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.chrome_reader_mode), title: Text("Reader")),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text("Favorites"),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text("PDF OUT LOUD"),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            controller.fling(velocity: isPanelVisible() ? -1.0 : 1.0);
          },
          icon: AnimatedIcon(
            icon: AnimatedIcons.close_menu,
            progress: controller.view,
          ),
        ),
      ),
      body: TwoPanels(
          controller: controller,
          backPanel: Center(
            child: Text("Backpanel"),
          ),
          frontPanel: PDFreader(),
          frontPanelHeader: "Front panel header",
          isPanelVisible: isPanelVisible),
    );
  }
}
