import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/widgets/soft_buttom.dart';

import 'main.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 90, right: 20),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan> [
                      TextSpan(
                        text: "My Shopping Cart\n",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      TextSpan(
                        text: "Total 3 itens",
                        style: Theme.of(context).textTheme.button.copyWith(color: Colors.black.withOpacity(.6)),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(                    
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Slidable(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 110,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: 10,
                                      left: 0,
                                      child: Container(
                                        width: 90,
                                        height: 90,                                        
                                        decoration: BoxDecoration(
                                          color: Colors.cyan,
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                          boxShadow: [
                                            BoxShadow(color: Colors.black38, offset: Offset(-8, 6), blurRadius: 20),
                                          ],
                                        ),
                                      ), 
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        child: Image( 
                                          height: 90,
                                          width: 90,                                         
                                          image: AssetImage('assets/images/alface.png'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text('Item $index'),
                            ],
                          ),
                        ),
                        actionPane: SlidableDrawerActionPane(),
                        secondaryActions: <Widget>[
                        IconSlideAction(
                          // caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {},
                        ),
                      ],
                      );
                    }
                  ),
                ),
              ),
              SizedBox(
                height: 120,
              ),
            ],
          ),
          Container(
            child: Column(
              children: [
                Expanded(child: Container()),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    color: Colors.white,
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey,
                    //     offset: Offset(0.0, 1.0), //(x,y)
                    //     blurRadius: 6.0,
                    //   ),
                    // ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Local",
                        style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Entrega em Domicílio",
                          style: Theme.of(context).textTheme.button.copyWith(fontSize: 14, color: Colors.black.withOpacity(.6)),
                        ),
                        Text(
                          "22/05/2020",
                          style: Theme.of(context).textTheme.button.copyWith(fontSize: 14, color: Colors.black.withOpacity(.6)),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'R\$172',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                  child: FlatButton(
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8)
                      ),
                    ),
                    onPressed: () {
                      print('tap');
                    }, 
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Finalizar Compra',
                          style: Theme.of(context).textTheme.headline6
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: CircularSoftButton(
              icon: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 28,
                  ),
                  // onPressed: widget.closedBuilder,
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (BuildContext context, _, __) {
                            return HomeScreen();
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = Offset(0.0, -1.0);
                            var end = Offset.zero;
                            var tween = Tween(begin: begin, end: end);
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                          transitionDuration: Duration(milliseconds: 600),
                        ));
                  }
                ),
              radius: 22,
            ),
          ),
        ],
      ),
    );
  }
}