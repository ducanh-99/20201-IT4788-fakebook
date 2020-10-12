import 'package:flutter/material.dart';

void showModal(BuildContext context, List<Widget> widget) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
            height: double.infinity,
            child: Expanded(
                child: Column(
              children: widget,
            )),
            decoration: BoxDecoration(color: Theme.of(context).canvasColor));
      });
}
