
import 'package:flutter/material.dart';
import 'package:task_P2/ui/shared/shared_widgets/templates/site_layout.dart';
import 'package:task_P2/ui/views/news_view/responsive_screeens/news_desktop.dart';
import 'package:task_P2/ui/views/news_view/responsive_screeens/news_mobile.dart';
import 'package:task_P2/ui/views/news_view/responsive_screeens/news_tablet.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(desktop: NewsViewDesktop(),mobile: NewsViewMobil(),tablet: NewsViewTablet(),);
  }
}