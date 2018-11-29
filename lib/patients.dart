import 'package:flutter/material.dart';
import 'package:patients/zoom_scaffold.dart';

import 'package:flutter/gestures.dart';

final TextEditingController searchController = new TextEditingController();
final Screen patientsScreen = new Screen(
    title: 'APPOINMENT',
    floatingButton: FloatingActionButton(
      backgroundColor: const Color(0xFF810055),
      
      child: IconButton(
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 34.0,
         
        ),
      ),
    ),
    contentBuilder: (BuildContext context) => new Padding(        
        padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
        child: new Column(children: <Widget>[
          new Container(
            margin: EdgeInsets.all(15.0),
            height: 60.0,
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: const Color(0xFFa9abae), style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(100.0),
              color: Colors.white,
            ),
            child: new TextField(
              controller: searchController,
              obscureText: false,
              keyboardType: TextInputType.text,
              scrollPadding: EdgeInsets.only(top: 2.0, bottom: 2.0, left:8.0, right: 8.0),
              
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.only(left: 8.0, right: 8.0,bottom: 8.0),
                // border: OutlineInputBorder(borderSide: BorderSide(width: 3.0, color: const Color(0xFF000000), style: BorderStyle.solid), borderRadius: BorderRadius.circular(100.0)),
                labelText: "Search Keywork",
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: new Icon(Icons.search),
                  onPressed: () {},
                )
                
              ),  
            ),
          ),
          new Expanded(
            child:
            ScrollBar(),),
        ],
        )
    )
);



class ScrollBar extends StatelessWidget {
  //provide the same scrollController for list and draggableScrollbar
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return  new DraggableScrollbar(
          child: _buildGrid(),
          heightScrollThumb: 40.0,
          controller: controller,
        
    );
  }

  Widget _buildGrid() {
    return GridView.builder(

      controller: controller,//scrollController is final in this stateless widget
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: (2.4),
      ),
      
      padding: EdgeInsets.zero,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0.0,
          child: Padding(
            padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 20.0),
            child: new Container(
              height: 135.0,
              
              child: new Row(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: 100.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/person.jpg'),fit: BoxFit.cover),
                      
                    ),
                  ),
                  Expanded(
                    child: new Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            "KELEMEN JANOS DUMMY",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: const Color(0xFFa7c045),
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          SizedBox(height: 6.0,),
                          Text(
                            "data nasterii: 2018-11.06",
                            style: TextStyle(
                              color: const Color(0xFFa9abae),
                              fontSize: 14.0
                            )
                          ),
                          Text(
                            "e-mail: ume@webdomain.com",
                            style: TextStyle(
                              color: const Color(0xFFa9abae),
                              fontSize: 14.0
                            )
                          ),
                          Text(
                            "Tel Mobile: 0770999333",
                            style: TextStyle(
                              color: const Color(0xFFa9abae),
                              fontSize: 14.0
                            )
                          ),
                          SizedBox(height: 6.0),
                          new Row(
                            children: <Widget>[
                              gridListIcons(
                                backColor: const Color(0xFFa7c045),
                                containerSize: 40.0,
                                icon: Icons.phone,
                                iconSize: 24.0,
                              ),
                              SizedBox(width: 10.0,),
                              gridListIcons(
                                backColor: const Color(0xFFa7c045),
                                containerSize: 40.0,
                                icon: Icons.more_horiz,
                                iconSize: 24.0,
                              )
                            ],
                          ),
                          
                        ],
                      ),

                    ),
                  )
                ],
              )
            ),
          ),
        );
      },
    );
  }
  
}

class gridListIcons extends StatelessWidget {
  final double containerSize;
  final double iconSize;
  final Color backColor;
  final IconData icon;
  final VoidCallback callBack;
  
  gridListIcons({
    this.containerSize,
    this.iconSize,
    this.backColor,
    this.icon,
    this.callBack
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerSize,
      width: containerSize,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backColor,
      ),
      child: Center(
        child: new IconButton(
          alignment: Alignment.center,
          onPressed: () {
            callBack;
          },
          icon: Icon(
            icon,
            size: iconSize,
            color: Colors.white,
          )
        ),
      ),
    );
  }
}

class DraggableScrollbar extends StatefulWidget {
  final double heightScrollThumb;
  final Widget child;
  final ScrollController controller;

  DraggableScrollbar({this.heightScrollThumb, this.child, this.controller});

  @override
  _DraggableScrollbarState createState() => new _DraggableScrollbarState();
}

class _DraggableScrollbarState extends State<DraggableScrollbar> {
  //this counts offset for scroll thumb in Vertical axis
  double _barOffset;
  //this counts offset for list in Vertical axis
  double _viewOffset;
  //variable to track when scrollbar is dragged
  bool _isDragInProcess;

  @override
  void initState() {
    super.initState();
    _barOffset = 0.0;
    _viewOffset = 0.0;
    _isDragInProcess = false;
  }

  //if list takes 300.0 pixels of height on screen and scrollthumb height is 40.0
  //then max bar offset is 260.0
  double get barMaxScrollExtent =>
      context.size.height - widget.heightScrollThumb;
  double get barMinScrollExtent => 0.0;

  //this is usually lenght (in pixels) of list
  //if list has 1000 items of 100.0 pixels each, maxScrollExtent is 100,000.0 pixels
  double get viewMaxScrollExtent => widget.controller.position.maxScrollExtent;
  //this is usually 0.0
  double get viewMinScrollExtent => widget.controller.position.minScrollExtent;

  double getScrollViewDelta(
    double barDelta,
    double barMaxScrollExtent,
    double viewMaxScrollExtent,
  ) {//propotion
    return barDelta * viewMaxScrollExtent / barMaxScrollExtent;
  }

  double getBarDelta(
    double scrollViewDelta,
    double barMaxScrollExtent,
    double viewMaxScrollExtent,
  ) {//propotion
    return scrollViewDelta * barMaxScrollExtent / viewMaxScrollExtent;
  }

  void _onVerticalDragStart(DragStartDetails details) {
    setState(() {
      _isDragInProcess = true;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    setState(() {
      _isDragInProcess = false;
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _barOffset += details.delta.dy;

      if (_barOffset < barMinScrollExtent) {
        _barOffset = barMinScrollExtent;
      }
      if (_barOffset > barMaxScrollExtent) {
        _barOffset = barMaxScrollExtent;
      }

      double viewDelta = getScrollViewDelta(
          details.delta.dy, barMaxScrollExtent, viewMaxScrollExtent);

      _viewOffset = widget.controller.position.pixels + viewDelta;
      if (_viewOffset < widget.controller.position.minScrollExtent) {
        _viewOffset = widget.controller.position.minScrollExtent;
      }
      if (_viewOffset > viewMaxScrollExtent) {
        _viewOffset = viewMaxScrollExtent;
      }
      widget.controller.jumpTo(_viewOffset);
    });
  }

  //this function process events when scroll controller changes it's position
  //by scrollController.jumpTo or scrollController.animateTo functions.
  //It can be when user scrolls, drags scrollbar (see line 139)
  //or any other manipulation with scrollController outside this widget
  changePosition(ScrollNotification notification) {
    //if notification was fired when user drags we don't need to update scrollThumb position
    if (_isDragInProcess) {
      return;
    }

    setState(() {
      if (notification is ScrollUpdateNotification) {
        _barOffset += getBarDelta(
          notification.scrollDelta,
          barMaxScrollExtent,
          viewMaxScrollExtent,
        );

        if (_barOffset < barMinScrollExtent) {
          _barOffset = barMinScrollExtent;
        }
        if (_barOffset > barMaxScrollExtent) {
          _barOffset = barMaxScrollExtent;
        }

        _viewOffset += notification.scrollDelta;
        if (_viewOffset < widget.controller.position.minScrollExtent) {
          _viewOffset = widget.controller.position.minScrollExtent;
        }
        if (_viewOffset > viewMaxScrollExtent) {
          _viewOffset = viewMaxScrollExtent;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          changePosition(notification);
        },
        child: new Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
          widget.child,
          _buildScrollBack(),
          GestureDetector(
              //we've add functions for onVerticalDragStart and onVerticalDragEnd
              //to track when dragging starts and finishes
              onVerticalDragStart: _onVerticalDragStart,
              onVerticalDragUpdate: _onVerticalDragUpdate,
              onVerticalDragEnd: _onVerticalDragEnd,
              child: Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: _barOffset),
                  child: _buildScrollThumb())),
        ]));
  }
  Widget _buildScrollBack() {
    return new Container(
        margin: EdgeInsets.only(top:8.0, bottom: 8.0, left: 8.0,right: 8.0,),
        child: Material(
          elevation: 4.0,
          
          borderRadius: BorderRadius.circular(5.0),
          color: const Color(0xFFe6e7e8),
          child: Center(
            child: Text(""),
          ),
        ),
      height: widget.heightScrollThumb * 20.0,
      width: 18.0
    );
  }

  Widget _buildScrollThumb() {
    return new Container(
        margin: EdgeInsets.all(8.0),
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(5.0),
          color: const Color(0xFFa9abae),
          child: Center(
            child: Text(""),
          ),
        ),
      height: widget.heightScrollThumb,
      width: 18.0,
    
    );
  }
}