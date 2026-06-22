import 'dart:math';
import 'package:curved_navigation_bar/src/nav_custom_clipper.dart';
import 'package:flutter/material.dart';

/// The style of the bottom bar (which screen it's used on)
enum BloodBankBarStyle {
  home, // used on BloodBankHome screen
  donor, // used on Donor screen
  collection, // used on Collection screen
  camp, // used on Camp screen
}

/// A reusable curved bottom navigation bar for the Blood Bank module.
/// It displays 4 tabs: Home, Donor, Collection, Camp.
/// The notch shape changes to match the original design of the given [style].
class BloodBankBottomNavigationBar extends StatefulWidget {
  final int currentIndex; // 0 = Home, 1 = Donor, 2 = Collection, 3 = Camp
  final ValueChanged<int> onTap; // Callback when a tab is tapped
  final BloodBankBarStyle style; // Which screen this bar belongs to
  final Color color; // Background color of the bar
  final Color? buttonBackgroundColor; // Color of the floating circle
  final Color backgroundColor; // Overall container background
  final Curve animationCurve;
  final Duration animationDuration;
  final double height;
  final double? maxWidth;
  final Color shadowColor;

  const BloodBankBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.style,
    this.color = Colors.white,
    this.buttonBackgroundColor = const Color(0xFF117A7A),
    this.backgroundColor = Colors.transparent,
    this.animationCurve = Curves.easeOut,
    this.animationDuration = Duration.zero,
    this.height = 90.0,
    this.maxWidth,
    this.shadowColor = Colors.grey,
  }) : super(key: key);

  @override
  _BloodBankBottomNavigationBarState createState() =>
      _BloodBankBottomNavigationBarState();
}

class _BloodBankBottomNavigationBarState
    extends State<BloodBankBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  late double _startingPos;
  late int _endingIndex;
  late double _pos;
  double _buttonHide = 0;
  late Widget _icon;
  late AnimationController _animationController;
  late int _length;

  // Icons and labels – exactly matching the original design
  final List<IconData> _icons = const [
    Icons.home,
    Icons.message, // Donor tab uses message icon
    Icons.collections,
    Icons.notifications, // Camp tab uses notifications icon
  ];
  final List<String> _labels = const ["Home", "Donor", "Collection", "Camp"];

  @override
  void initState() {
    super.initState();
    _length = _icons.length;
    _pos = widget.currentIndex / _length;
    _startingPos = widget.currentIndex / _length;
    _endingIndex = widget.currentIndex;
    _icon = _buildIconForIndex(widget.currentIndex);

    _animationController = AnimationController(vsync: this, value: _pos);
    _animationController.addListener(() {
      setState(() {
        _pos = _animationController.value;
        final endingPos = _endingIndex / _length;
        final middle = (endingPos + _startingPos) / 2;
        if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
          _icon = _buildIconForIndex(_endingIndex);
        }
        _buttonHide = (1 - ((middle - _pos) / (_startingPos - middle)).abs())
            .abs();
      });
    });
  }

  @override
  void didUpdateWidget(BloodBankBottomNavigationBar oldWidget) {
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
      _icon = _buildIconForIndex(_endingIndex);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildIconForIndex(int index) {
    final color = index == widget.currentIndex ? Colors.white : Colors.grey;
    return Icon(_icons[index], size: 26, color: color);
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);
    final items = List.generate(_length, (index) => _buildIconForIndex(index));

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

                    // Curved background bar – using the style-specific painter
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
                            widget.style, // 👈 pass the style
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
                                children: List.generate(_labels.length, (
                                  index,
                                ) {
                                  return _buildLabel(_labels[index], index);
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

// ================== Custom Painter (supports all four styles) ==================

class _NavCustomPainter extends CustomPainter {
  late double loc;
  late double s;
  Color color;
  TextDirection textDirection;
  Color shadowColor;
  Size size;
  final BloodBankBarStyle style;

  _NavCustomPainter(
    double startingLoc,
    int itemsLength,
    this.color,
    this.textDirection,
    this.shadowColor,
    this.size,
    this.style,
  ) {
    final span = 1.0 / itemsLength;
    s = 0.2;
    double l = startingLoc + (span - s) / 2;
    loc = textDirection == TextDirection.rtl ? 0.8 - l : l;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.height * 0.30; // corner radius
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = shadowColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    Path path;

    // Choose the notch shape based on the style
    switch (style) {
      case BloodBankBarStyle.home:
        path = _buildHomePath(radius, size);
        break;
      case BloodBankBarStyle.donor:
        path = _buildDonorPath(radius, size);
        break;
      case BloodBankBarStyle.collection:
        path = _buildCollectionPath(radius, size);
        break;
      case BloodBankBarStyle.camp:
        path = _buildCampPath(radius, size);
        break;
    }

    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(path, paint);
  }

  // ----- Original Home bar shape (very narrow notch) -----
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

  // ----- Original Donor bar shape (narrow notch, factor 1.2) -----
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

  // ----- Original Collection bar shape (medium notch, factor 2.5) -----
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

  // ----- Original Camp bar shape (wide notch, factor 3.8) -----
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
        oldDelegate.style != style;
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
