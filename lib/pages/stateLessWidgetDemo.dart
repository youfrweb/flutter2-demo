
import 'package:flutter/material.dart';

class StateLessWidgetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SelectableText(
          'StatelessWidget',
          toolbarOptions: ToolbarOptions(copy: false, cut: false, paste: false, selectAll: true),
          onSelectionChanged: (TextSelection selection, cause) {
            print(selection);
          },
          enableInteractiveSelection: true,
        ),
      ),
    );
  }
}