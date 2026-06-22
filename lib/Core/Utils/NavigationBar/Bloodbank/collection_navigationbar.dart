// import 'package:flutter/material.dart';
// import 'dart:ui' as ui;
// class HospitalBottomBar extends StatefulWidget {
//   const HospitalBottomBar({super.key});
//
//   @override
//   State<HospitalBottomBar> createState() => _HospitalBottomBarState();
// }
//
// class _HospitalBottomBarState extends State<HospitalBottomBar> {
//   int _selectedIndex = 2; // Default OP Workbench selected
//
//   final List<Map<String, dynamic>> _navItems = [
//     {'icon': Icons.home_filled, 'label': 'Home'},
//     {'icon': Icons.medical_services, 'label': 'OP Workbench'},
//     {'icon': Icons.add_business_outlined, 'label': 'IP Workbench'},
//     {'icon': Icons.notifications, 'label': 'Notifications', 'badge': '2'},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double barWidth = screenWidth - 40; // Side se padding ke liye
//     double itemWidth = barWidth / _navItems.length;
//
//     return Container(
//       height: 120, // Height thodi zyada taaki shadow aur notch clear dikhe
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//
//       child: Stack(
//         children: [
//           // 1. Background Bar with moving notch and shadow
//           Positioned(
//             bottom: 20,
//             left: 0,
//             right: 0,
//             top: 20,
//             child: CustomPaint(
//               size: Size(barWidth, 75),
//               painter: NotchPainter(
//                 selectedIndex: _selectedIndex,
//                 itemWidth: itemWidth,
//               ),
//             ),
//           ),
//
//           // 2. Moving Floating Teal Circle
//           AnimatedPositioned(
//             duration: const Duration(milliseconds: 350),
//             curve: Curves.easeOutBack,
//             left: (itemWidth * _selectedIndex) + (itemWidth / 2) - 28,
//             top: 10,
//             child: Container(
//               width: 56,
//               height: 56,
//               decoration: const BoxDecoration(
//                 color: Color(0xFF0D7A75), // Exact Teal color
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 _navItems[_selectedIndex]['icon'],
//                 color: Colors.white,
//                 size: 26,
//               ),
//             ),
//           ),
//
//           // 3. Navigation Icons and Labels
//           Positioned(
//             bottom: 30,
//             left: 0,
//             right: 0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: List.generate(_navItems.length, (index) {
//                 bool isSelected = _selectedIndex == index;
//                 return GestureDetector(
//                   // onTap: () => setState(() => _selectedIndex = index),
//                   behavior: HitTestBehavior.opaque,
//                   child: SizedBox(
//                     width: itemWidth,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         // Icon sirf tab dikhega jab select nahi hoga
//                         Opacity(
//                           opacity: isSelected ? 0 : 1,
//                           child: _buildIconWithBadge(index),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           _navItems[index]['label'],
//                           style: TextStyle(
//                             fontSize: 11,
//                             fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                             color: isSelected ? const Color(0xFF0D7A75) : Colors.grey[400],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildIconWithBadge(int index) {
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         Icon(_navItems[index]['icon'], color: Colors.grey[400], size: 24),
//         if (_navItems[index].containsKey('badge'))
//           Positioned(
//             right: -4,
//             top: -4,
//             child: Container(
//               padding: const EdgeInsets.all(2),
//               decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
//               constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
//               child: Text(
//                 _navItems[index]['badge'],
//                 style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
//
// class NotchPainter extends CustomPainter {
//   final int selectedIndex;
//   final double itemWidth;
//
//   NotchPainter({required this.selectedIndex, required this.itemWidth});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()..color = Colors.white..style = PaintingStyle.fill;
//     final ui.Path path = ui.Path();
//     double centerX = (itemWidth * selectedIndex) + (itemWidth / 2);
//
//
//     path.moveTo(25, 0);
//
//     path.lineTo(centerX - 45, 0);
//
//     path.quadraticBezierTo(
//         centerX - 35, 0,
//         centerX - 30, 35
//     );
//     path.arcToPoint(
//       Offset(centerX + 30, 28),
//       radius: Radius.circular(32),
//       clockwise: false,
//     );
//
//
//     path.quadraticBezierTo(
//         centerX + 35, 0,   // control point
//         centerX + 45, 0    // end point (back to top bar)
//     );
//
//     path.lineTo(size.width - 25, 0);
//     path.quadraticBezierTo(size.width, 0, size.width, 25);
//
//     path.lineTo(size.width, size.height - 20);
//     path.quadraticBezierTo(
//         size.width,
//         size.height,
//         size.width - 25,
//         size.height
//     );
//
//     path.lineTo(25, size.height);
//     path.quadraticBezierTo(0, size.height, 0, size.height - 25);
//
//     path.lineTo(0, 25);
//     path.quadraticBezierTo(0, 0, 25, 0);
//
//
//
//
//     path.close();
//     canvas.drawShadow(
//         path,
//         Colors.black.withOpacity(0.5),
//         10,
//         true
//     );
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(NotchPainter oldDelegate) => oldDelegate.selectedIndex != selectedIndex;
// }

import 'dart:math';

import 'package:curved_navigation_bar/src/nav_custom_clipper.dart';
import 'package:flutter/material.dart';


typedef _LetIndexPage = bool Function(int value);

class BloodBankCollectionNavigationBar extends StatefulWidget {
  final List<Widget> items;
  final int index;
  final Color color;
  final Color? buttonBackgroundColor;
  final Color backgroundColor;
  final ValueChanged<int>? onTap;
  final _LetIndexPage letIndexChange;
  final Curve animationCurve;
  final Duration animationDuration;
  final double height;
  final double? maxWidth;
  int page;

  // Extra Added
  final Color shadowColor;

  BloodBankCollectionNavigationBar({
    Key? key,
    this.items = const [
      Icon(Icons.home, size: 26, color: Colors.grey),
      Icon(Icons.message, size: 26, color: Colors.grey),
      Icon(Icons.collections, size: 26, color: Colors.white),
      Icon(Icons.notifications, size: 26, color: Colors.grey),
    ],
    required this.index,
    this.color = Colors.white,
    this.buttonBackgroundColor = const Color(0xFF117A7A),
    this.backgroundColor = Colors.transparent,
    this.onTap,
    _LetIndexPage? letIndexChange,
    this.animationCurve = Curves.easeOut,
    this.animationDuration =  Duration.zero,
    this.height = 90.0,
    this.maxWidth,
    // Extra Added
    this.shadowColor = Colors.grey,
    required this.page,
  })  : letIndexChange = letIndexChange ?? ((_) => true),
        assert(items.isNotEmpty),
        assert(0 <= index && index < items.length),
        assert(0 <= height && height <= 90.0),
        assert(maxWidth == null || 0 <= maxWidth),
        super(key: key);

  @override
  CurvedNavigationBarState createState() => CurvedNavigationBarState();
}

class CurvedNavigationBarState extends State<BloodBankCollectionNavigationBar>
    with SingleTickerProviderStateMixin {
  late double _startingPos;
  late int _endingIndex;
  late double _pos;
  double _buttonHide = 0;
  late Widget _icon;
  late AnimationController _animationController;
  late int _length;

  @override
  void initState() {
    super.initState();
    _icon = widget.items[widget.index];
    _length = widget.items.length;
    _pos = widget.index / _length;
    _startingPos = widget.index / _length;
    _endingIndex = widget.index;
    _animationController = AnimationController(vsync: this, value: _pos);
    _animationController.addListener(() {
      setState(() {
        _pos = _animationController.value;
        final endingPos = _endingIndex / widget.items.length;
        final middle = (endingPos + _startingPos) / 2;
        if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
          _icon = widget.items[_endingIndex];
        }
        _buttonHide =
            (1 - ((middle - _pos) / (_startingPos - middle)).abs()).abs();
      });
    });


  }

  @override
  void didUpdateWidget(BloodBankCollectionNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      final newPosition = widget.index / _length;
      _startingPos = _pos;
      _endingIndex = widget.index;
      _animationController.animateTo(newPosition,
          duration: widget.animationDuration, curve: widget.animationCurve);
    }
    if (!_animationController.isAnimating) {
      _icon = widget.items[_endingIndex];
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {





    final textDirection = Directionality.of(context);
    return SizedBox(
      height: widget.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = min(
              constraints.maxWidth, widget.maxWidth ?? constraints.maxWidth);
          return Align(
            alignment: textDirection == TextDirection.ltr
                ? Alignment.bottomLeft
                : Alignment.bottomRight,
            child: Container(
              // color: widget.backgroundColor,
              color: Colors.transparent,

              width: maxWidth,
              child: ClipRect(
                clipper: NavCustomClipper(
                  deviceHeight: MediaQuery.sizeOf(context).height,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Positioned(
                      bottom: -45 - (75.0 - widget.height),
                      left: textDirection == TextDirection.rtl
                          ? null
                          : 20 + (_pos * (maxWidth - 40)),
                      right: textDirection == TextDirection.rtl
                          ? 20 + (_pos * (maxWidth - 40))
                          : null,
                      width: (maxWidth - 40) / _length,
                      child: Center(
                        child: Transform.translate(
                          offset: Offset(0, -(1 - _buttonHide) * 80),
                          child: Material(
                            color: widget.buttonBackgroundColor ?? widget.color,
                            type: MaterialType.circle,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: _icon,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0 - (75.0 - widget.height),
                      child: Padding(

                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: CustomPaint(
                          painter: NavCustomPainter(
                              _pos, _length, widget.color, textDirection,widget.shadowColor,MediaQuery.of(context).size),
                          child: Container(
                            height: 60.0,

                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0 - (75.0 - widget.height),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Stack(
                            children:[
                              SizedBox(
                                  height: 70.0,
                                  child: Row(
                                      children: widget.items.map((item) {
                                        return NavButton(
                                          onTap: _buttonTap,
                                          position: _pos,
                                          length: _length,
                                          index: widget.items.indexOf(item),
                                          child: Center(child: item),
                                        );
                                      }).toList())),
                              Positioned(
                                bottom: 5,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildLabel("Home", 0),
                                    _buildLabel("Donor", 1),
                                    _buildLabel("Collection", 2),
                                    _buildLabel("Camp", 3),

                                  ],
                                ),
                              ),
                            ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void setPage(int index) {
    _buttonTap(index);
  }

  void _buttonTap(int index) {
    if (!widget.letIndexChange(index) || _animationController.isAnimating) {
      return;
    }
    if (widget.onTap != null) {
      widget.onTap!(index);
    }
    // final newPosition = index / _length;
    // setState(() {
    //   _startingPos = _pos;
    //   _endingIndex = index;
    //   _animationController.animateTo(newPosition,
    //       duration: widget.animationDuration, curve: widget.animationCurve);
    // });




  }


  Widget _buildLabel(String text, int index) {
    bool isSelected = widget.page == index;
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ?   Color(0xFF0D7A75) : Colors.grey,
          ),
        ),
      ),
    );
  }
}

class NavCustomPainter extends CustomPainter {
  late double loc;
  late double s;
  Color color;
  TextDirection textDirection;

  // Extra Modified
  Color shadowColor;
  Size size;



  NavCustomPainter(
      double startingLoc,
      int itemsLength,
      this.color,
      this.textDirection,
      this.shadowColor,
      this.size,
      ) {
    final span = 1.0 / itemsLength;
    s = 0.2;
    double l = startingLoc + (span - s) / 2;
    loc = textDirection == TextDirection.rtl ? 0.8 - l : l;
  }




  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.height * 0.30;   // corner radius
    final double notchDepth = size.height * 0.48; // 🔥 curve depth
    final double notchTop = size.height * 0.06;   // top smoothness
    final double edgePadding = size.width * 0.04; // horizontal safe area

    final double shadowStroke = size.height * 0.06;
    final double shadowBlur = size.height * 0.10;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.grey.withOpacity(0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    /// 🔥 Shadow follows border + curve
    final shadowPaint = Paint()
      ..color = shadowColor // 🔥 lighter
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        6, // 🔥 tighter shadow
      );


    final path = Path()
    // 🔹 Top-left corner
      ..moveTo(20, 0)
      ..lineTo((s * 2.5) * size.width, 0)

    // 🔹 Notch start
      ..cubicTo(
        (loc + s * 0.02) * size.width,
        size.height * 0.05,
        loc * size.width,
        size.height * 0.60,
        (loc + s * 0.50) * size.width,
        size.height * 0.60,
      )
      ..cubicTo(
        (loc + s) * size.width,
        size.height * 0.60,
        (loc + s - s * 0.20) * size.width,
        size.height * 0.05,
        (loc + s  + 0.05) * size.width,
        0,
      )

    // 🔹 Top-right corner
      ..lineTo(size.width - radius, 0)
      ..quadraticBezierTo(size.width, 0, size.width, radius)

    // 🔹 Right side
      ..lineTo(size.width, size.height - radius)
      ..quadraticBezierTo(
          size.width, size.height, size.width - radius, size.height)

    // 🔹 Bottom
      ..lineTo(radius, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - radius)

    // 🔹 Left side
      ..lineTo(0, radius)
      ..quadraticBezierTo(0, 0, 20, 0)

      ..close();


    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
class NavButton extends StatelessWidget {
  final double position;
  final int length;
  final int index;
  final ValueChanged<int> onTap;
  final Widget child;

  NavButton({
    required this.onTap,
    required this.position,
    required this.length,
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final desiredPosition = 1.0 / length * index;
    final difference = (position - desiredPosition).abs();
    final verticalAlignment = 1 - length * difference;
    final opacity = length * difference;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          onTap(index);
        },
        child: Container(
            height: 75.0,

            child: Transform.translate(
              offset: Offset(
                  0, difference < 1.0 / length ? verticalAlignment * 40 : 0),
              child: Opacity(
                  opacity: difference < 1.0 / length * 0.99 ? opacity : 1.0,
                  child: child),
            )),
      ),
    );
  }
}
