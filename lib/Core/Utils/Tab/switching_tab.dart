import 'package:flutter/material.dart';

class SwitchingTab extends StatefulWidget {
  final List<String> tabs;
  final int currentIndex;
  final Function(int) onTabChanged;
  final double fontSize;

  const SwitchingTab({
    Key? key,
    required this.tabs,
    required this.currentIndex,
    required this.onTabChanged,
    this.fontSize = 14.0,
  }) : super(key: key);

  @override
  State<SwitchingTab> createState() => _SwitchingTabState();
}

class _SwitchingTabState extends State<SwitchingTab> {
  late final ScrollController _scrollController;

  late List<GlobalKey> _tabKeys;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _tabKeys = List.generate(widget.tabs.length, (_) => GlobalKey());

    // Handles initial selected tab if it is partially/off screen.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedTab();
    });
  }

  @override
  void didUpdateWidget(covariant SwitchingTab oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Re-create keys if tab count changes.
    if (oldWidget.tabs.length != widget.tabs.length) {
      _tabKeys = List.generate(widget.tabs.length, (_) => GlobalKey());
    }

    // Important:
    // This catches programmatic tab changes such as _switchTab(3).
    if (oldWidget.currentIndex != widget.currentIndex) {
      _scrollToSelectedTab();
    }
  }

  void _scrollToSelectedTab() {
    if (!mounted) return;

    if (widget.currentIndex < 0 || widget.currentIndex >= _tabKeys.length) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final BuildContext? tabContext =
          _tabKeys[widget.currentIndex].currentContext;

      if (tabContext == null) return;

      Scrollable.ensureVisible(
        tabContext,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,

        // 0.5 means try to place the selected tab
        // around the center of the visible area.
        alignment: 0.5,

        alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
      );
    });
  }

  void _onTabTap(int index) {
    // First update the parent.
    widget.onTabChanged(index);

    // Then make sure the tapped tab becomes visible.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final BuildContext? tabContext = _tabKeys[index].currentContext;

      if (tabContext == null) return;

      Scrollable.ensureVisible(
        tabContext,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.5,
        alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(widget.tabs.length, (index) {
            return Container(
              key: _tabKeys[index],
              child: _buildTabItem(widget.tabs[index], index),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    final bool isActive = widget.currentIndex == index;

    return GestureDetector(
      onTap: () => _onTabTap(index),
      child: Container(
        padding: const EdgeInsets.only(bottom: 12, right: 16, left: 8),
        decoration: BoxDecoration(
          border: isActive
              ? const Border(
                  bottom: BorderSide(color: Color(0xFF117A7A), width: 2),
                )
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: widget.fontSize,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isActive ? const Color(0xFF117A7A) : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}
