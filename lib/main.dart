import 'dart:math';

import 'package:animated_carousel/carousel_card.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const cards = [
    CarouselCard(icon: Icons.bolt_outlined, label: "Power"),
    CarouselCard(icon: Icons.edit_outlined, label: "Edit"),
    CarouselCard(icon: Icons.home_outlined, label: "Home"),
  ];

  final carouselController = PageController(viewportFraction: 0.7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carousel app"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const SizedBox(height: 36),
                ExpandablePageView.builder(
                  controller: carouselController,
                  clipBehavior: Clip.none,
                  itemCount: cards.length,
                  itemBuilder: (_, index) {
                    if (!carouselController.position.haveDimensions) {
                      return const SizedBox();
                    }
                    return AnimatedBuilder(
                      animation: carouselController,
                      builder: (_, __) => Transform.scale(
                        scale: max(
                          0.8,
                          (1 - (carouselController.page! - index).abs() / 2),
                        ),
                        child: cards[index],
                      ),
                    );
                  },
                ),
                const Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
