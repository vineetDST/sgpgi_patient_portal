import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // REQUIRED FOR SVG ICONS
import 'package:curved_navigation_bar/src/nav_custom_clipper.dart';

class HospitalBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final int notificationBadge;
  final Color color;
  final Color? buttonBackgroundColor;
  final Color backgroundColor;
  final Curve animationCurve;
  final Duration animationDuration;
  final double height;
  final double? maxWidth;
  final Color shadowColor;

  const HospitalBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    this.notificationBadge = 0,
    this.color = Colors.white,
    this.buttonBackgroundColor = const Color(0xFF117A7A),
    this.backgroundColor = Colors.transparent,
    this.animationCurve = Curves.easeOut,
    this.animationDuration = const Duration(milliseconds: 300),
    this.height = 90.0,
    this.maxWidth,
    this.shadowColor = Colors.grey,
  }) : super(key: key);

  @override
  _HospitalBottomNavigationBarState createState() =>
      _HospitalBottomNavigationBarState();
}

class _HospitalBottomNavigationBarState
    extends State<HospitalBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  late double _startingPos;
  late int _endingIndex;
  late double _pos;
  double _buttonHide = 0;
  late Widget _icon;
  late AnimationController _animationController;
  late int _length;

  // Using SVG asset names instead of Material Icons
  final List<Map<String, dynamic>> _navItems = [
    {'icon': 'home', 'label': 'Home'},
    {'icon': 'op', 'label': 'OP Workbench'},
    {'icon': 'ip', 'label': 'IP Workbench'},
    {'icon': 'notific', 'label': 'Notifications', 'badge': true},
  ];

  @override
  void initState() {
    super.initState();
    _length = _navItems.length;
    _pos = widget.currentIndex / _length;
    _startingPos = widget.currentIndex / _length;
    _endingIndex = widget.currentIndex;
    _icon = _buildIconWithBadge(widget.currentIndex, isFloating: true);

    _animationController = AnimationController(vsync: this, value: _pos);
    _animationController.addListener(() {
      setState(() {
        _pos = _animationController.value;
        final endingPos = _endingIndex / _length;
        final middle = (endingPos + _startingPos) / 2;
        if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
          _icon = _buildIconWithBadge(_endingIndex, isFloating: true);
        }
        _buttonHide = (1 - ((middle - _pos) / (_startingPos - middle)).abs())
            .abs();
      });
    });
  }

  @override
  void didUpdateWidget(HospitalBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      final newPosition = widget.currentIndex / _length;
      _startingPos = _pos;
      _endingIndex = widget.currentIndex;
      _animationController.animateTo(
        newPosition,
        duration: widget.animationDuration,
        curve: widget.animationCurve,
      );
    }
    if (!_animationController.isAnimating) {
      _icon = _buildIconWithBadge(_endingIndex, isFloating: true);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildIconWithBadge(int index, {required bool isFloating}) {
    final color = isFloating ? Colors.white : Colors.grey;

    Widget icon = SvgPicture.asset(
      'assets/${_navItems[index]['icon']}.svg',
      width: 28,
      height: 28,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      fit: BoxFit.contain,
      placeholderBuilder: (context) => const SizedBox(
        width: 28,
        height: 28,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );

    if (_navItems[index]['badge'] == true && widget.notificationBadge > 0) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          icon,
          Positioned(
            right: -4,
            top: -4,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
              child: Text(
                widget.notificationBadge.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);
    final items = List.generate(
      _length,
      (index) => _buildIconWithBadge(index, isFloating: false),
    );

    return SizedBox(
      height: widget.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = min(
            constraints.maxWidth,
            widget.maxWidth ?? constraints.maxWidth,
          );
          return Align(
            alignment: textDirection == TextDirection.ltr
                ? Alignment.bottomLeft
                : Alignment.bottomRight,
            child: Container(
              color: widget.backgroundColor,
              width: maxWidth,
              child: ClipRect(
                clipper: NavCustomClipper(
                  deviceHeight: MediaQuery.sizeOf(context).height,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    // Floating circle with the active icon
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

                    // Curved background bar
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0 - (75.0 - widget.height),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomPaint(
                          painter: _NavCustomPainter(
                            _pos,
                            _length,
                            widget.color,
                            textDirection,
                            widget.shadowColor,
                            MediaQuery.of(context).size,
                            _endingIndex,
                          ),
                          child: Container(height: 60.0),
                        ),
                      ),
                    ),

                    // Buttons (icons) and labels
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0 - (75.0 - widget.height),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 70.0,
                              child: Row(
                                children: items.asMap().entries.map((entry) {
                                  return _NavButton(
                                    onTap: _buttonTap,
                                    position: _pos,
                                    length: _length,
                                    index: entry.key,
                                    child: Center(child: entry.value),
                                  );
                                }).toList(),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(_navItems.length, (
                                  index,
                                ) {
                                  return _buildLabel(
                                    _navItems[index]['label'],
                                    index,
                                  );
                                }),
                              ),
                            ),
                          ],
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

  void _buttonTap(int index) {
    if (_animationController.isAnimating) return;

    // --- UPDATED: Removed the `if (index == 3) return;` block! ---
    widget.onTap(index);
  }

  Widget _buildLabel(String text, int index) {
    bool isSelected = widget.currentIndex == index;
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? const Color(0xFF0D7A75) : Colors.grey,
          ),
        ),
      ),
    );
  }
}

// ================== Custom Painter (Matches Blood Bank Mechanics) ==================

class _NavCustomPainter extends CustomPainter {
  late double loc;
  late double s;
  Color color;
  TextDirection textDirection;
  Color shadowColor;
  Size size;
  final int styleIndex; // 0=Home, 1=OP, 2=IP, 3=Notifications

  _NavCustomPainter(
    double startingLoc,
    int itemsLength,
    this.color,
    this.textDirection,
    this.shadowColor,
    this.size,
    this.styleIndex,
  ) {
    final span = 1.0 / itemsLength;
    s = 0.2;
    double l = startingLoc + (span - s) / 2;
    loc = textDirection == TextDirection.rtl ? 0.8 - l : l;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.height * 0.30;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = shadowColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    Path path;

    // Use corresponding blood bank curves based on index
    switch (styleIndex) {
      case 0:
        path = _buildHomePath(radius, size);
        break;
      case 1:
        path = _buildDonorPath(radius, size);
        break;
      case 2:
        path = _buildCollectionPath(radius, size);
        break;
      case 3:
        path = _buildCampPath(radius, size);
        break;
      default:
        path = _buildHomePath(radius, size);
    }

    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(path, paint);
  }

  Path _buildHomePath(double radius, Size size) {
    return Path()
      ..moveTo(7, 0)
      ..quadraticBezierTo(10, 0, 10, 5)
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
        (loc + s + 0.05) * size.width,
        0,
      )
      ..lineTo(size.width - radius, 0)
      ..quadraticBezierTo(size.width, 0, size.width, radius)
      ..lineTo(size.width, size.height - radius)
      ..quadraticBezierTo(
        size.width,
        size.height,
        size.width - radius,
        size.height,
      )
      ..lineTo(radius, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - radius)
      ..lineTo(0, radius)
      ..quadraticBezierTo(0, 0, 7, 0)
      ..close();
  }

  Path _buildDonorPath(double radius, Size size) {
    return Path()
      ..moveTo(20, 0)
      ..lineTo((s * 1.2) * size.width, 0)
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
        (loc + s + 0.05) * size.width,
        0,
      )
      ..lineTo(size.width - radius, 0)
      ..quadraticBezierTo(size.width, 0, size.width, radius)
      ..lineTo(size.width, size.height - radius)
      ..quadraticBezierTo(
        size.width,
        size.height,
        size.width - radius,
        size.height,
      )
      ..lineTo(radius, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - radius)
      ..lineTo(0, radius)
      ..quadraticBezierTo(0, 0, 20, 0)
      ..close();
  }

  Path _buildCollectionPath(double radius, Size size) {
    return Path()
      ..moveTo(20, 0)
      ..lineTo((s * 2.5) * size.width, 0)
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
        (loc + s + 0.05) * size.width,
        0,
      )
      ..lineTo(size.width - radius, 0)
      ..quadraticBezierTo(size.width, 0, size.width, radius)
      ..lineTo(size.width, size.height - radius)
      ..quadraticBezierTo(
        size.width,
        size.height,
        size.width - radius,
        size.height,
      )
      ..lineTo(radius, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - radius)
      ..lineTo(0, radius)
      ..quadraticBezierTo(0, 0, 20, 0)
      ..close();
  }

  Path _buildCampPath(double radius, Size size) {
    return Path()
      ..moveTo(20, 0)
      ..lineTo((s * 3.8) * size.width, 0)
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
        (loc + s - s * 0.10) * size.width,
        size.height * 0.05,
        (loc + s + 0.01) * size.width,
        0,
      )
      ..lineTo(size.width - 5, 0)
      ..quadraticBezierTo(size.width, 0, size.width, radius)
      ..lineTo(size.width, size.height - radius)
      ..quadraticBezierTo(
        size.width,
        size.height,
        size.width - radius,
        size.height,
      )
      ..lineTo(radius, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - radius)
      ..lineTo(0, radius)
      ..quadraticBezierTo(0, 0, 20, 0)
      ..close();
  }

  @override
  bool shouldRepaint(covariant _NavCustomPainter oldDelegate) {
    return oldDelegate.loc != loc ||
        oldDelegate.color != color ||
        oldDelegate.textDirection != textDirection ||
        oldDelegate.shadowColor != shadowColor ||
        oldDelegate.size != size ||
        oldDelegate.styleIndex != styleIndex;
  }
}

// ================== Helper Button ==================

class _NavButton extends StatelessWidget {
  final double position;
  final int length;
  final int index;
  final ValueChanged<int> onTap;
  final Widget child;

  const _NavButton({
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
        onTap: () => onTap(index),
        child: Container(
          height: 75.0,
          child: Transform.translate(
            offset: Offset(
              0,
              difference < 1.0 / length ? verticalAlignment * 40 : 0,
            ),
            child: Opacity(
              opacity: difference < 1.0 / length * 0.99 ? opacity : 1.0,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
