import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';

class AdvancedUsage extends StatefulWidget {
  const AdvancedUsage({super.key});

  @override
  State<AdvancedUsage> createState() => _AdvancedUsageState();
}

class _AdvancedUsageState extends State<AdvancedUsage> {
  bool rendered = false;
  bool renderCardIntroOverlay = false;
  double cardOffset = 0.0; // Add this to track the card position

  @override
  Widget build(BuildContext context) {
    Intro intro = Intro.of(context);

    return ValueListenableBuilder(
      valueListenable: intro.statusNotifier,
      builder: (context, value, child) {
        return PopScope(
          canPop: !value.isOpen,
          child: Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: IntroStepBuilder(
                        order: 2,
                        padding: const EdgeInsets.all(0),
                        text:
                            'I can help you quickly implement the Step By Step guide in the Flutter project.',
                        borderRadius: BorderRadius.circular(16),
                        onHighlightWidgetPanUpdate: (details) {
                          setState(() {
                            cardOffset += details.delta.dx;
                          });
                        },
                        onHighlightWidgetPanEnd: (details) async {
                          if (cardOffset.abs() > 100) {
                            // Swiped far enough to count as action
                            setState(() {
                              // Animate off screen
                              cardOffset = cardOffset.sign *
                                  MediaQuery.of(context).size.width;
                            });
                            await Future.delayed(
                                const Duration(milliseconds: 1000));
                            cardOffset = 0;
                            // Handle like/dislike action here
                          } else {
                            // Return to center
                            setState(() {
                              cardOffset = 0;
                            });
                          }
                        },
                        builder: (context, key) => Transform.translate(
                          offset: Offset(cardOffset, 0),
                          child: Transform.rotate(
                            angle: (cardOffset /
                                1000), // Subtle rotation while dragging
                            child: Container(
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
                                        Intro.of(context)
                                                .currentStep
                                                ?.order
                                                ?.toString() ??
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
                                  if (renderCardIntroOverlay =
                                      intro.currentStep?.order == 2)
                                    BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5, sigmaY: 5),
                                      child: Container(
                                        width: double.infinity,
                                        height: 450,
                                        color: Colors.black26,
                                      ),
                                    ),
                                  if (renderCardIntroOverlay =
                                      intro.currentStep?.order == 2)
                                    const Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // IntroStepBuilder(
                    //   /// 2nd guide
                    //   order: 2,
                    //   // getOverlayPosition: ({
                    //   //   required Offset offset,
                    //   //   required Size screenSize,
                    //   //   required Size size,
                    //   // }) {
                    //   //   return OverlayPosition(
                    //   //     top: size.height + offset.dy,
                    //   //     width: screenSize.width,
                    //   //     crossAxisAlignment: CrossAxisAlignment.end,
                    //   //   );
                    //   // },

                    //   overlayBuilder: (params) {
                    //     return Container(
                    //       color: Colors.teal,
                    //       // padding: const EdgeInsets.all(16),
                    //       child: Column(
                    //         children: [
                    //           params.onNext == null
                    //               ? const Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text(
                    //                       'Of course, you can also render what you want through overlayBuilder.',
                    //                       style: TextStyle(height: 1.6),
                    //                     ),
                    //                     Text(
                    //                       'In addition, we can finally add new guide widget dynamically.',
                    //                       style: TextStyle(height: 1.6),
                    //                     ),
                    //                     Text(
                    //                       'Click highlight area to add new widget.',
                    //                       style: TextStyle(height: 1.6),
                    //                     )
                    //                   ],
                    //                 )
                    //               : const Text(
                    //                   'As you can see, you can move on to the next step',
                    //                 ),
                    //           Padding(
                    //             padding: const EdgeInsets.only(
                    //               top: 16,
                    //             ),
                    //             child: Row(
                    //               children: [
                    //                 IntroButton(
                    //                   text: 'Prev',
                    //                   onPressed: params.onPrev,
                    //                   style: OutlinedButton.styleFrom(
                    //                     backgroundColor: Colors.red,
                    //                     foregroundColor: Colors.white,
                    //                     side: const BorderSide(
                    //                       color: Colors.red,
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 const SizedBox(width: 4),
                    //                 IntroButton(
                    //                   text: 'Next',
                    //                   onPressed: params.onNext,
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    //   onHighlightWidgetTap: () {
                    //     print('highlight widget tapped');
                    //     setState(() {
                    //       rendered = true;
                    //     });
                    //   },
                    //   builder: (context, key) => Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       Placeholder(
                    //         key: key,
                    //         fallbackWidth: 100,
                    //         fallbackHeight: 100,
                    //         color: Colors.blue,
                    //         // child: ElevatedButton(
                    //         //   onPressed: () {
                    //         //     print('button pressed  2');
                    //         //   },
                    //         //   child: const Text('Button'),
                    //         // ),
                    //         // child: SizedBox(
                    //         //   width: 150,
                    //         //   height: 150,
                    //         //   child: Padding(
                    //         //     padding: const EdgeInsets.all(8.0),
                    //         // child: Container(
                    //         //   color: Colors.green,
                    //         //   width: 50,
                    //         //   height: 50,
                    //         //   child: ElevatedButton(
                    //         //     onPressed: () {
                    //         //       print('button pressed 5');
                    //         //     },
                    //         //     child: const Text('Button'),
                    //         //   ),
                    //         //   //   ),
                    //         //   // ),
                    //         // ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(
                      height: 16,
                    ),
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
                    // rendered
                    //     ?
                    // IntroStepBuilder(
                    //   order: 3,
                    //   onWidgetLoad: () {
                    //     Intro.of(context).refresh();
                    //   },
                    //   overlayBuilder: (params) {
                    //     return Container(
                    //       padding: const EdgeInsets.all(16),
                    //       color: Colors.teal,
                    //       child: Column(
                    //         children: [
                    //           const Text(
                    //             'That\'s it, hopefully version 3.0 makes you feel better than 2.0',
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.only(
                    //               top: 16,
                    //             ),
                    //             child: Row(
                    //               children: [
                    //                 IntroButton(
                    //                   onPressed: params.onPrev,
                    //                   text: 'Prev',
                    //                 ),
                    //                 const SizedBox(width: 4),
                    //                 IntroButton(
                    //                   onPressed: params.onNext,
                    //                   text: 'Next',
                    //                 ),
                    //                 const SizedBox(width: 4),
                    //                 IntroButton(
                    //                   onPressed: params.onFinish,
                    //                   text: 'Finish',
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    //   builder: (context, key) => Text(
                    //     'I am a delay render widget.',
                    //     key: key,
                    //   ),
                    // )
                    // : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            floatingActionButton: IntroStepBuilder(
              /// 1st guide
              order: 1,
              text:
                  'Some properties on IntroStepBuilder like `borderRadius` `padding`'
                  ' allow you to configure the configuration of this step.',
              padding: const EdgeInsets.all(0),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              onWidgetLoad: () {
                Intro.of(context).start();
              },
              builder: (context, key) => FloatingActionButton(
                key: key,
                child: const Icon(
                  Icons.play_arrow,
                ),
                onPressed: () {
                  Intro.of(context).start();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
