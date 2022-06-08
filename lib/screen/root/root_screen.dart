import 'package:flutter/material.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/screen/cart/cart_screen.dart';
import 'package:nike_store/screen/home/home.dart';
import 'package:nike_store/screen/profile/profile_screen.dart';
import 'package:nike_store/widgets/widgets.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  _RootScreenState createState() => _RootScreenState();
}

const int HOMEINDEX = 0;
const int CARTINDEX = 1;
const int PROFILEINDEX = 2;

class _RootScreenState extends State<RootScreen> {

  int selectedScreenIndex = HOMEINDEX;

  List<int> _history = [];

  GlobalKey<NavigatorState> _homeKey = GlobalKey();
  GlobalKey<NavigatorState> _cartKey = GlobalKey();
  GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    HOMEINDEX: _homeKey,
    CARTINDEX: _cartKey,
    PROFILEINDEX: _profileKey,
  };

  Future<bool> onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState =
    map[selectedScreenIndex]!.currentState!;
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false;
    }
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartRepository.count();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  bottom: 65,
                  child: IndexedStack(
                    index: selectedScreenIndex,
                    children: [
                      Navigator(
                        key: _homeKey,
                        onGenerateRoute: (settings) => MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      ),
                      Navigator(
                        key: _cartKey,
                        onGenerateRoute: (settings) => MaterialPageRoute(
                          builder: (context) => CartScreen(),
                        ),
                      ),
                      Navigator(
                        key: _profileKey,
                        onGenerateRoute: (settings) => MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: BottomNavigation(
                    onTab: (int index) {
                      setState(() {
                        _history.remove(selectedScreenIndex);
                        _history.add(selectedScreenIndex);
                        selectedScreenIndex = index;
                      });
                    },
                    selectIndex: selectedScreenIndex,
                  ),
                ),
              ],
            )),
        onWillPop: onWillPop);
  }
}
