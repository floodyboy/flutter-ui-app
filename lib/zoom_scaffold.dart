import 'package:flutter/material.dart';
import 'package:patients/loginscreen.dart';
import 'package:patients/menu_screen.dart';

class ZoomScaffold extends StatefulWidget {

  final Widget menuScreen;
  final Screen contentScreen;

  ZoomScaffold({
    this.menuScreen,
    this.contentScreen,
  });

  @override
  _ZoomScaffoldState createState() => new _ZoomScaffoldState();
}

class _ZoomScaffoldState extends State<ZoomScaffold> with TickerProviderStateMixin {

  MenuController menuController;
  Curve scaleDownCurve = new Interval(0.0, 0.3, curve: Curves.easeOut);
  Curve scaleUpCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideOutCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideInCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);

  

  @override
  void initState() {
    super.initState();

    menuController = new MenuController(
      vsync: this,
    )
    ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }

  createMenuDisplay() {
    return zoomAndSlideMenu(
       widget.menuScreen,
        
    );
  }

  createContentDisplay() {
    return 
      new Container(
        alignment: Alignment.topCenter,
        
        decoration: new BoxDecoration(
          color: Colors.white,
          //image: widget.contentScreen.background,
          
        ),
        child: new Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(75.0),
            child: new AppBar(
              backgroundColor: const Color(0xFFa7c045),
              
              elevation: 0.0,
              leading: new IconButton(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 24.0, left: 30.0, bottom: 20.0,right: 30.0 ),
                  icon: menuController.state == MenuState.closed  ?  new Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 30.0
                    ) : new Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30.0,
                      ),
                  onPressed: () {
                    menuController.toggle();
                  }
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 22.5, bottom: 0.0),
                child: new Image.asset(
                  "assets/logo.png",
                  height: 59.0,
                )
              ),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 24.0, left: 30.0, bottom: 20.0,right: 30.0 ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) { return LoginScreen();}));
                  },
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30.0
                    )
                ),
                
              ],
              bottom: widget.contentScreen.bottomAppBar,
            ),
          ),
          body: widget.contentScreen.contentBuilder(context),
          floatingActionButton: widget.contentScreen.floatingButton,
        ),
        
    );
  }

  zoomAndSlideMenu(Widget content) {
    var slidePercent, scalePercent;
    switch (menuController.state) {
      case MenuState.closed:
        slidePercent = 1.0;
        scalePercent = 1.0;
        break;
      case MenuState.open:
        slidePercent = 0.0;
        scalePercent = 0.0;
        break;
      case MenuState.opening:
        slidePercent = slideOutCurve.transform(menuController.percentOpen);
        scalePercent = scaleDownCurve.transform(menuController.percentOpen);
        break;
      case MenuState.closing:
        slidePercent = slideInCurve.transform(menuController.percentOpen);
        scalePercent = scaleUpCurve.transform(menuController.percentOpen);
        break;
    }
    var screenSize = MediaQuery.of(context).size;
    final slideAmount = -(screenSize.width) * slidePercent;
    final contentScale = 1.0 - (0.2 * scalePercent);
    final cornerRadius = 10.0 * menuController.percentOpen;

    return new Transform(
      transform: new Matrix4
        .translationValues(slideAmount, 0.0, 0.0),
      alignment: Alignment.bottomLeft,
      
      child: new Container(
        height: screenSize.height - 110.0,
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: const Color(0x44000000),
              offset: const Offset(0.0, 5.0),
              blurRadius: 20.0,
              spreadRadius: 10.0,
            ),
          ],
        ),
        child: new ClipRRect(
          borderRadius: new BorderRadius.circular(0.0),
          child: content
        ),
      ),
    );
  }

  zoomAndSlideContent(Widget content) {
    var slidePercent, scalePercent;
    switch (menuController.state) {
      case MenuState.closed:
        slidePercent = 0.0;
        scalePercent = 0.0;
        break;
      case MenuState.open:
        slidePercent = 1.0;
        scalePercent = 1.0;
        break;
      case MenuState.opening:
        slidePercent = slideOutCurve.transform(menuController.percentOpen);
        scalePercent = scaleDownCurve.transform(menuController.percentOpen);
        break;
      case MenuState.closing:
        slidePercent = slideInCurve.transform(menuController.percentOpen);
        scalePercent = scaleUpCurve.transform(menuController.percentOpen);
        break;
    }

    final slideAmount = -275.0 * slidePercent;
    final contentScale = 1.0 - (0.3 * scalePercent);
    final cornerRadius = 10.0 * menuController.percentOpen;

    return new Transform(
      transform: new Matrix4
        .translationValues(slideAmount, 0.0, 0.0)
        ..scale(contentScale, contentScale),
      alignment: Alignment.centerLeft,
      child: new Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: const Color(0x44000000),
              offset: const Offset(0.0, 5.0),
              blurRadius: 20.0,
              spreadRadius: 10.0,
            ),
          ],
        ),
        child: new ClipRRect(
          borderRadius: new BorderRadius.circular(cornerRadius),
          child: content
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        createContentDisplay(),
         GestureDetector(
           onTap: () => menuController.close(),
           child: menuController.state == MenuState.closed ? Container(height: 0.0, width: 0.0,) :
        new Container(
            width: screenSize.width,
            height: screenSize.height -100.0,
            color: Colors.black.withOpacity(.5),
            
        ),
         ),  
        createMenuDisplay(),
       
        
      ],
    );
  }
}

class ZoomScaffoldMenuController extends StatefulWidget {

  final ZoomScaffoldBuilder builder;

  ZoomScaffoldMenuController({
    this.builder,
  });

  @override
  ZoomScaffoldMenuControllerState createState() {
    return new ZoomScaffoldMenuControllerState();
  }
}

class ZoomScaffoldMenuControllerState extends State<ZoomScaffoldMenuController> {

  MenuController menuController;

  @override
  void initState() {
    super.initState();

    menuController = getMenuController(context);
    menuController.addListener(_onMenuControllerChange);
  }

  @override
  void dispose() {
    menuController.removeListener(_onMenuControllerChange);
    super.dispose();
  }

  getMenuController(BuildContext context) {
    final scaffoldState = context.ancestorStateOfType(
        new TypeMatcher<_ZoomScaffoldState>()
    ) as _ZoomScaffoldState;
    return scaffoldState.menuController;
  }

  _onMenuControllerChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, getMenuController(context));
  }

}

typedef Widget ZoomScaffoldBuilder(
  BuildContext context,
  MenuController menuController
);

class Screen {
  final String title;
  final DecorationImage background;
  final WidgetBuilder contentBuilder;
  final Widget bottomAppBar;
  final FloatingActionButton floatingButton;

  Screen({
    this.title,
    this.background,
    this.contentBuilder,
    this.bottomAppBar,
    this.floatingButton,
  });
}

class MenuController extends ChangeNotifier {
  final TickerProvider vsync;
  
  final AnimationController _animationController;
  
  MenuState state = MenuState.closed;

  MenuController({
    this.vsync,
  }) : _animationController = new AnimationController(vsync: vsync) {
    _animationController
      ..duration = const Duration(milliseconds: 250)
      ..addListener(() {
        notifyListeners();
      })
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            state = MenuState.opening;
            break;
          case AnimationStatus.reverse:
            state = MenuState.closing;
            break;
          case AnimationStatus.completed:
            state = MenuState.open;
            break;
          case AnimationStatus.dismissed:
            state = MenuState.closed;
            break;
        }
        notifyListeners();
      });
      
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  get percentOpen {
    return _animationController.value;
  }

  open() {
    _animationController.forward(from: 1);
  }

  close() {
    _animationController.reverse(from: 0);
  }

  toggle() {
    if (state == MenuState.open) {
      close();
    } else if (state == MenuState.closed) {
      open();
    }
  }
}

enum MenuState {
  closed,
  opening,
  open,
  closing,
}