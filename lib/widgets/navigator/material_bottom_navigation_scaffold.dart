import 'index.dart';
import 'package:flutter/material.dart';

/// A Scaffold with a configured BottomNavigationBar, separate
/// Navigators for each tab view and state retaining across tab switches.
class MaterialBottomNavigationScaffold extends StatefulWidget {
  const MaterialBottomNavigationScaffold({
    required this.navigationBarItems,
    required this.onItemSelected,
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  /// List of the tabs to be displayed with their respective navigator's keys.
  final List<BottomNavigationTab> navigationBarItems;

  /// Called when a tab selection occurs.
  final ValueChanged<int> onItemSelected;

  final int selectedIndex;

  @override
  _MaterialBottomNavigationScaffoldState createState() =>
      _MaterialBottomNavigationScaffoldState();
}

class _MaterialBottomNavigationScaffoldState
    extends State<MaterialBottomNavigationScaffold> {
  final List<_MaterialBottomNavigationTab> materialNavigationBarItems = [];
  // final List<AnimationController> _animationControllers = [];

  /// Controls which tabs should have its content built. This enables us to
  /// lazy instantiate it.
  final List<bool> _shouldBuildTab = <bool>[];
  List<Widget> pages = [];

  @override
  void initState() {
    // _initAnimationControllers();
    //Build all item, but is's rebuild once time only
    _shouldBuildTab.addAll(List<bool>.filled(
      widget.navigationBarItems.length,
      true,
    ));
    _initMaterialNavigationBarItems();

    super.initState();
  }

  void _initMaterialNavigationBarItems() {
    materialNavigationBarItems.addAll(
      widget.navigationBarItems
          .map(
            (barItem) => _MaterialBottomNavigationTab(
              bottomNavigationBarItem: barItem.bottomNavigationBarItem,
              navigatorKey: barItem.navigatorKey,
              subtreeKey: GlobalKey(),
              initialPageBuilder: barItem.initialPageBuilder,
            ),
          )
          .toList(),
    );
    pages = materialNavigationBarItems.map(
      (barItem) {
        return _buildPageFlow(
          context,
          materialNavigationBarItems.indexOf(barItem),
          barItem,
        );
      },
    ).toList();
    print("pages: $pages");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        // fit: StackFit.expand,
        index: widget.selectedIndex,

        // children: materialNavigationBarItems.map(
        //   (barItem) {
        //     return _buildPageFlow(
        //       context,
        //       materialNavigationBarItems.indexOf(barItem),
        //       barItem,
        //     );
        //   },
        // ).toList(),
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.selectedIndex,
        items: materialNavigationBarItems
            .map(
              (item) => item.bottomNavigationBarItem,
            )
            .toList(),
        onTap: (index) {
          //disable item 2
          if (index == 2) {
            return;
          }

          // setState(() {
          //   currentIndex = index;
          // });
          widget.onItemSelected(index);
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }

  // The best practice here would be to extract this to another Widget,
  // however, moving it to a separate class would only harm the
  // readability of our guide.
  Widget _buildPageFlow(
    BuildContext context,
    int tabIndex,
    _MaterialBottomNavigationTab item,
  ) {
    final isCurrentlySelected = tabIndex == widget.selectedIndex;

    // We should build the tab content only if it was already built or
    // if it is currently selected.
    _shouldBuildTab[tabIndex] =
        isCurrentlySelected || _shouldBuildTab[tabIndex];

    final Widget view = KeyedSubtree(
      key: item.subtreeKey,
      child: _shouldBuildTab[tabIndex]
          ? Navigator(
              restorationScopeId: '$tabIndex',
              // The key enables us to access the Navigator's state inside the
              // onWillPop callback and for emptying its stack when a tab is
              // re-selected. That is why a GlobalKey is needed instead of
              // a simpler ValueKey.
              key: item.navigatorKey,
              // Since this isn't the purpose of this sample, we're not using
              // named routes. Because of that, the onGenerateRoute callback
              // will be called only for the initial route.
              onGenerateRoute: (settings) => MaterialPageRoute(
                settings: settings,
                builder: item.initialPageBuilder,
              ),
            )
          : Container(),
    );
    if (tabIndex == widget.selectedIndex) {
      // _animationControllers[tabIndex].forward();
      return view;
    } else {
      // _animationControllers[tabIndex].reverse();
      // if (_animationControllers[tabIndex].isAnimating) {
      //   return IgnorePointer(child: view);
      // }
      return view;

      // return Offstage(child: view);
    }
  }
}

/// Extension class of BottomNavigationTab that adds another GlobalKey to it
/// in order to use it within the KeyedSubtree widget.
class _MaterialBottomNavigationTab extends BottomNavigationTab {
  const _MaterialBottomNavigationTab({
    required BottomNavigationBarItem bottomNavigationBarItem,
    required GlobalKey<NavigatorState> navigatorKey,
    required WidgetBuilder initialPageBuilder,
    required this.subtreeKey,
  }) : super(
          bottomNavigationBarItem: bottomNavigationBarItem,
          navigatorKey: navigatorKey,
          initialPageBuilder: initialPageBuilder,
        );

  final GlobalKey subtreeKey;
}
