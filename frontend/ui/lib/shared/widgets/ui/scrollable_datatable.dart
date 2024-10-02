import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
// class ScrollableWidget extends StatelessWidget {
//   final Widget child;

//   const ScrollableWidget({
//     Key? key,
//     required this.child,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) => InteractiveViewer(
//         constrained: false,
//         scaleEnabled: false,
//         child: child,
//       );

//   // InteractiveViewer(
//   //       constrained: false,
//   //       child: child,
//   //     );

//   // SingleChildScrollView(
//   //       physics: const BouncingScrollPhysics(),
//   //       scrollDirection: Axis.horizontal,
//   //       child: SingleChildScrollView(
//   //         physics: const BouncingScrollPhysics(),
//   //         scrollDirection: Axis.vertical,
//   //         child: child,
//   //       ),
//   //     );
// }
