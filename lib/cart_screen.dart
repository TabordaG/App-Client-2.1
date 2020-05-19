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
                        text: "My Shopping Cart\n\n",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      TextSpan(
                        text: "Total 3 itens",
                        style: Theme.of(context).textTheme.button.copyWith(color: Colors.black.withOpacity(.7)),
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
                                width: 120,
                                height: 120,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: Container(
                                        width: 80,
                                        height: 80,                                        
                                        decoration: BoxDecoration(
                                          color: Colors.cyan,
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                          boxShadow: [
                                            BoxShadow(color: Colors.black54, offset: Offset(-8, 6), blurRadius: 12),
                                            BoxShadow(color: Colors.white, offset: Offset(8, -6), blurRadius: 12),
                                          ],
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  "Local",
                  style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 16),
                ),
              ),
              Padding(
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
              Padding(
                padding: EdgeInsets.all(20),
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