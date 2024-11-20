import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';

class DemoUsage extends StatefulWidget {
  const DemoUsage({super.key});

  @override
  State<DemoUsage> createState() => _DemoUsageState();
}

class _DemoUsageState extends State<DemoUsage> {
  bool renderCardIntroOverlay = false;

  @override
  Widget build(BuildContext context) {
    // renderCardIntroOverlay = Intro.of(context).currentStep?.order == 2;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: IntroStepBuilder(
                order: 2,
                text:
                    'I can help you quickly implement the Step By Step guide in the Flutter project.',
                borderRadius: BorderRadius.circular(16),
                builder: (context, key) => Container(
                  key: key,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white10,
                  ),
                  height: 450,
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Image.network(
                            'https://is1-ssl.mzstatic.com/image/thumb/Music124/v4/63/2d/c7/632dc719-fd73-225c-e15a-23aaa5e07e9d/075679915313.jpg/1000x1000bb.jpg',
                          ),
                          const Spacer(),
                          Text(
                            // 'Track name',
                            Intro.of(context).currentStep?.order?.toString() ??
                                'dsadasads',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      if (renderCardIntroOverlay)
                        // Container(
                        //   // color: Colors.black54,
                        //   width: double.infinity,
                        //   height: 450,
                        // ),
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            width: double.infinity,
                            height: 450,
                            color: Colors.black26,
                          ),
                        ),
                      if (renderCardIntroOverlay)
                        const Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.thumb_up,
                                    size: 64,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    'Like',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.thumb_down,
                                    size: 64,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    'Dislike',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            IntroStepBuilder(
              order: 3,
              text:
                  'My usage is also very simple, you can quickly learn and use it through example and api documentation.',
              builder: (context, key) => Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        print('button pressed');
                      },
                      child: const Text('Dislike'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        print('button pressed');
                      },
                      child: const Text('Like'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: IntroStepBuilder(
              order: 1,
              text: 'Welcome to flutter_intro',
              padding: const EdgeInsets.only(
                bottom: 20,
                left: 16,
                right: 16,
                top: 8,
              ),
              onWidgetLoad: () {
                Intro.of(context).start();
                //   Intro.of(context).statusNotifier.addListener(() {
                //     print('status changed');
                //     print(Intro.of(context).status);
                //   });
              },
              builder: (context, key) => Icon(
                Icons.home,
                key: key,
              ),
            ),
          ),
          const BottomNavigationBarItem(
            label: 'Book',
            icon: Icon(Icons.book),
          ),
          const BottomNavigationBarItem(
            label: 'School',
            icon: Icon(Icons.school),
          ),
        ],
      ),
    );
  }
}
