import 'package:flutter/material.dart';
import 'package:patients/zoom_scaffold.dart';

final menuScreenKey = new GlobalKey(debugLabel: 'MenuScreen');

class MenuScreen extends StatefulWidget {

  final Menu menu;
  final String selectedItemId;
  final Function(String) onMenuItemSelected;

  MenuScreen({
    this.menu,
    this.selectedItemId,
    this.onMenuItemSelected,
  }) : super(key: menuScreenKey);

  @override
  _MenuScreenState createState() => new _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {

  AnimationController titleAnimationController;
  double selectorYTop;
  double selectorYBottom;

  setSelectedRenderBox(RenderBox newRenderBox) async {
    final newYTop = newRenderBox.localToGlobal(const Offset(0.0, 0.0)).dy;
    final newYBottom = newYTop + newRenderBox.size.height;
    if (newYTop != selectorYTop) {
      setState(() {
        selectorYTop = newYTop;
        selectorYBottom = newYBottom;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    titleAnimationController = new AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  @override
  void dispose() {
    titleAnimationController.dispose();
    super.dispose();
  }

  createMenuTitle(MenuController menuController) {
    switch (menuController.state) {
      case MenuState.open:
      case MenuState.opening:
        titleAnimationController.forward();
        break;
      case MenuState.closed:
      case MenuState.closing:
        titleAnimationController.reverse();
        break;
    }
    var screenSize = MediaQuery.of(context).size;
    return new AnimatedBuilder(
      animation: titleAnimationController,
      child: new OverflowBox(
        maxWidth: double.infinity,
        alignment: Alignment.topLeft,
        child: Container(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 50.0),
          height: 100.0,
          width: screenSize.width,
          decoration: BoxDecoration(
            color: const Color(0xFF810055),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: <Widget>[
                 new Text(
                      "Name Surname of User",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'bebas-neue'
                      ),
                      textAlign: TextAlign.left,
                      softWrap: false,
                    ),
                   new Text(
                      "example@webdomain.com",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'bebas-neue'
                      ),
                      textAlign: TextAlign.left,
                      softWrap: false,
                    ),
                    
                  
              ],
            ),
        ),
      ),
      builder: (BuildContext context, Widget child) {
        return new Transform(
          transform: new Matrix4.translationValues(
            250.0 * (1.0 - titleAnimationController.value),
            0.0,
            0.0,
          ),
          child: child,
        );
      }
    );
  }

  createMenuItems(MenuController menuController) {
    final List<Widget> listItems = [];
    final animationIntervalDuration = 0.5;
    final perListItemDelay = menuController.state != MenuState.closing ? 0.15 : 0.0;
    for (var i = 0; i < widget.menu.items.length; ++i) {
      final animationIntervalStart = i * perListItemDelay;
      final animationIntervalEnd = animationIntervalStart + animationIntervalDuration;
      final isSelected = widget.menu.items[i].id == widget.selectedItemId;

      listItems.add(
          new AnimatedMenuListItem(
            menuState: menuController.state,
            isSelected: isSelected,
            duration: const Duration(milliseconds: 600),
            curve: new Interval(
                animationIntervalStart,
                animationIntervalEnd,
                curve: Curves.easeOut
            ),
            menuListItem: new _MenuListItem(
              title: widget.menu.items[i].title,
              isSelected: isSelected,
              onTap: () {
                widget.onMenuItemSelected(widget.menu.items[i].id);
                menuController.close();
              },
            ),
          )
      );
    }

    return new Transform(
      transform: new Matrix4.translationValues(
        0.0,
        115.0,
        0.0,
      ),
      child: Column(
        children: listItems,
        
      ),
    );
  }

  createFooterItem(MenuController menuController) {
    
    return Column(
      children: <Widget>[
        Expanded(
          child: Text(""),
        ),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          child: Text(
            "copyright \u00a9 Smartfact.ro",
            style: TextStyle(
              color: const Color(0xFF810055),
              fontSize: 12.0,
            ),
            ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return new ZoomScaffoldMenuController(
      builder: (BuildContext context, MenuController menuController) {
        
        return new Container(
          width: screenSize.width - 60.0,
          // alignment: Alignment.topCenter,
          decoration: new BoxDecoration(
            color: Colors.white,
          ),
          child: new Material(
            color: Colors.transparent,
            child: new Stack(
              children: [
                createFooterItem(menuController),
                createMenuTitle(menuController),
                createMenuItems(menuController),
              ],
            ),
          ),
        );
      }
    );
  }
}

class ItemSelector extends ImplicitlyAnimatedWidget {

  final double topY;
  final double bottomY;
  final double opacity;

  ItemSelector({
    this.topY,
    this.bottomY,
    this.opacity,
  }) : super(duration: const Duration(milliseconds: 250));

  @override
  _ItemSelectorState createState() => new _ItemSelectorState();
}

class _ItemSelectorState extends AnimatedWidgetBaseState<ItemSelector> {

  Tween<double> _topY;
  Tween<double> _bottomY;
  Tween<double> _opacity;

  @override
  void forEachTween(TweenVisitor visitor) {
    _topY = visitor(
      _topY,
      widget.topY,
      (dynamic value) => new Tween<double>(begin: value),
    );
    _bottomY = visitor(
      _bottomY,
      widget.bottomY,
      (dynamic value) => new Tween<double>(begin: value),
    );
    _opacity = visitor(
      _opacity,
      widget.opacity,
      (dynamic value) => new Tween<double>(begin: value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Positioned(
      top: _topY.evaluate(animation),
      child: new Opacity(
        opacity: _opacity.evaluate(animation),
        child: new Container(
          width: 5.0,
          height: _bottomY.evaluate(animation) - _topY.evaluate(animation),
          color: Colors.red,
        ),
      ),
    );
  }
}


class AnimatedMenuListItem extends ImplicitlyAnimatedWidget {

  final _MenuListItem menuListItem;
  final MenuState menuState;
  final bool isSelected;
  final Duration duration;

  AnimatedMenuListItem({
    this.menuListItem,
    this.menuState,
    this.isSelected,
    this.duration,
    curve,
  }) : super(duration: duration, curve: curve);

  @override
  _AnimatedMenuListItemState createState() => new _AnimatedMenuListItemState();
}

class _AnimatedMenuListItemState extends AnimatedWidgetBaseState<AnimatedMenuListItem> {

  final double closedSlidePosition = 200.0;
  final double openSlidePosition = 0.0;

  Tween<double> _translation;
  Tween<double> _opacity;

  updateSelectedRenderBox() {
    final renderBox = context.findRenderObject() as RenderBox;
    if (renderBox != null && widget.isSelected) {
      (menuScreenKey.currentState as _MenuScreenState).setSelectedRenderBox(renderBox);
    }
  }

  @override
  void forEachTween(TweenVisitor visitor) {
    var slide, opacity;

    switch (widget.menuState) {
      case MenuState.closed:
      case MenuState.closing:
        slide = closedSlidePosition;
        opacity = 0.0;
        break;
      case MenuState.open:
      case MenuState.opening:
        slide = openSlidePosition;
        opacity = 1.0;
        break;
    }

    _translation = visitor(
      _translation,
      slide,
      (dynamic value) => new Tween<double>(begin: value),
    );

    _opacity = visitor(
      _opacity,
      opacity,
      (dynamic value) => new Tween<double>(begin: value),
    );
  }

  @override
  Widget build(BuildContext context) {
    updateSelectedRenderBox();

    return new Opacity(
      opacity: _opacity.evaluate(animation),
      child: new Transform(
        transform: new Matrix4.translationValues(
          0.0,
          _translation.evaluate(animation),
          0.0,
        ),
        child: widget.menuListItem,
      ),
    );
  }
}


class _MenuListItem extends StatelessWidget {

  final String title;
  final bool isSelected;
  final Function() onTap;

  _MenuListItem({
    this.title,
    this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      splashColor: const Color(0x44000000),
      onTap: isSelected
          ? null
          : onTap,
      child: Container(
        // decoration: BoxDecoration(
        //   border: Border(bottom: BorderSide(width: 2.0, color: const Color(0xFFa9abae), style: BorderStyle.solid))
        // ),
        width: double.infinity,
        child: new Padding(
          padding: const EdgeInsets.only(left: 50.0, top: 8.0, bottom: 8.0),
          child: new Text(
            title,
            style: new TextStyle(
              color: isSelected ? const Color(0xFF810055) : const Color(0xFFa7c045),
              fontSize: 24.0,
              fontFamily: 'bebas-neue',
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}

class Menu {
  final List<MenuItem> items;

  Menu({
    this.items,
  });
}

class MenuItem {
  final String id;
  final String title;

  MenuItem({
    this.id,
    this.title,
  });
}