import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/home_page/home/home_bloc.dart';
import 'index.dart';

/// A platform-aware Scaffold which encapsulates the common behaviour between
/// material's and cupertino's bottom navigation pattern.
class AdaptiveBottomNavigationScaffold extends StatefulWidget {
  /// List of the tabs to be displayed with their respective navigator's keys.
  final List<BottomNavigationTab> navigationBarItems;

  const AdaptiveBottomNavigationScaffold({
    required this.navigationBarItems,
    Key? key,
  }) : super(key: key);

  @override
  AdaptiveBottomNavigationScaffoldState createState() =>
      AdaptiveBottomNavigationScaffoldState();
}

class AdaptiveBottomNavigationScaffoldState
    extends State<AdaptiveBottomNavigationScaffold> {
  int _currentlySelectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialBottomNavigationScaffold(
      navigationBarItems: widget.navigationBarItems,
      onItemSelected: onTabSelected,
      selectedIndex: _currentlySelectedIndex,
    );
  }

  /// Called when a tab selection occurs.
  void onTabSelected(int newIndex) {
    if (newIndex == 0) {
      BlocProvider.of<HomeBloc>(context).add(ChangeMenuItem(
          type: MenuItemType.values[newIndex],
          data: DateTime.now().toIso8601String()));
    } else {
      BlocProvider.of<HomeBloc>(context).add(ChangeMenuItem(
        type: MenuItemType.values[newIndex],
      ));
    }

    FocusScope.of(context).requestFocus(FocusNode());
    if (_currentlySelectedIndex == newIndex) {
      // If the user is re-selecting the tab, the common
      // behavior is to empty the stack.
      if (widget.navigationBarItems[newIndex].navigatorKey.currentState !=
          null) {
        widget.navigationBarItems[newIndex].navigatorKey.currentState!
            .popUntil((route) => route.isFirst);
      }
    }
    setState(() {
      _currentlySelectedIndex = newIndex;
    });
  }
}
