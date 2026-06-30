import 'package:flutter/material.dart';

import 'diary_card.dart';
import 'diary_section_header.dart';

class DiarySection extends StatelessWidget {

  final IconData icon;

  final String title;

  final String badge;

  final Color color;

  final List<Widget> children;

  const DiarySection({

    super.key,

    required this.icon,

    required this.title,

    required this.badge,

    required this.color,

    required this.children,
  });

  @override
  Widget build(BuildContext context) {

    return DiaryCard(

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          DiarySectionHeader(

            icon: icon,

            title: title,

            badge: badge,

            color: color,
          ),

          ..._addSpacing(children),
        ],
      ),
    );
  }

  List<Widget> _addSpacing(List<Widget> widgets) {

    if (widgets.isEmpty) return [];

    final List<Widget> list = [];

    for (int i = 0; i < widgets.length; i++) {

      list.add(widgets[i]);

      if (i != widgets.length - 1) {

        list.add(

          const SizedBox(height: 0),
        );
      }
    }

    return list;
  }
}