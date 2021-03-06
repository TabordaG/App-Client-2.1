import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/main.dart';
import 'package:food_app/widgets/soft_buttom.dart';
import 'package:toast/toast.dart';

import 'cart.dart';

class DetailsScreen extends StatefulWidget {
  final Food product;
  final VoidCallback openContainer;
  final OpenContainerBuilder closedBuilder;

  DetailsScreen(this.product, {this.openContainer, this.closedBuilder});
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  ScrollController _controller;
  double _percentColor;
  Color _color = Colors.white;
  int _count = 1;
  StreamController<int> streamController = StreamController<int>();

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _percentColor = .65;
    streamController.sink.add(_count);

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _color = kPrimaryColor.withOpacity(.1);//kSecondaryColor;
      });
    });
  }

  Future<bool> onWillPop() async {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (BuildContext context, _, __) {
          return HomeScreen(
            offsetPage: scrollValue,
          );
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
    return true;
  }

  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: _controller,
            slivers: <Widget>[
              SliverAppBar(
                elevation: 18,
                backgroundColor: Colors.white,
                expandedHeight: 420,
                pinned: true,
                floating: false,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: EdgeInsets.symmetric(horizontal: 20),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // SizedBox(
                      //   width: 45 * (1 - _percentOpacity),
                      // ), // to move text and show back button
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${widget.product.title}\n",
                                style: TextStyle(
                                    fontFamily: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .fontFamily,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: "Gabriel Moreira",
                                style: TextStyle(
                                    fontFamily: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .fontFamily,
                                    fontSize: 12,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "R\$20",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: kPrimaryColor, fontSize: 19),
                      )
                    ],
                  ),
                  collapseMode: CollapseMode.pin,
                  background: Stack(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => Center( // Aligns the container to center
                              child: Container( // A simplified version of dialog. 
                                width: MediaQuery.of(context).size.width * .95,
                                height: MediaQuery.of(context).size.height * .7,
                                color: Colors.transparent,
                                child: Stack(
                                  children: <Widget>[
                                    Center(
                                      child: Image(
                                        fit: BoxFit.scaleDown,
                                        image: AssetImage(widget.product.image),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      right: 20,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Icon(
                                          (Icons.fullscreen_exit), 
                                          size: 34, 
                                          color: Colors.white, 
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            )
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25, bottom: 10),
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 800),
                                  curve: Curves.easeInOutBack,
                                  margin: EdgeInsets.only(bottom: 30),
                                  padding:
                                      EdgeInsets.only(right: 6, left: 6, bottom: 6),
                                  height: 305,
                                  width:
                                      MediaQuery.of(context).size.width - 12, //305,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    shape: BoxShape.rectangle,
                                    color: _color,
                                  ),
                                  child: Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Hero(
                                        tag: widget.product.image,
                                        child: Image(
                                          fit: BoxFit.cover,
                                          image: AssetImage(widget.product.image),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        bottom: 120,
                        child: IconButton(
                          icon: Icon(Icons.fullscreen), 
                          iconSize: 34, 
                          color: Colors.white,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => Center( // Aligns the container to center
                                child: Container( // A simplified version of dialog. 
                                  width: MediaQuery.of(context).size.width * .95,
                                  height: MediaQuery.of(context).size.height * .7,
                                  color: Colors.transparent,
                                  child: Stack(
                                    children: <Widget>[
                                      Center(
                                        child: Image(
                                          fit: BoxFit.scaleDown,
                                          image: AssetImage(widget.product.image),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        right: 20,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Icon(
                                            (Icons.fullscreen_exit), 
                                            size: 34, 
                                            color: Colors.white, 
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              )
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(widget.product.description),
                ),
                Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: -70,
                      right: -50,
                      child: Opacity(
                        opacity: .2,
                        child: Image.asset(
                          'assets/images/leaf.png',
                          height: 250,
                        ),
                      ),
                    ),
                    DataTable(
                      columns: [
                        DataColumn(label: Icon(Icons.info)),
                        DataColumn(label: Icon(Icons.description)),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text('Marca do Produto')),
                          DataCell(Text('Sem Marca')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('Condições do Produto')),
                          DataCell(
                              Text('Produtos oriundos de quintais produtivos')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('Estoque Atual')),
                          DataCell(Text('2')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('Unidade')),
                          DataCell(Text('Unitário')),
                        ]),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 120),
              ]))
            ],
          ),
          // addCart1(context),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              height: 60,
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * .45,
                    child: Center(
                      child: Container(
                        height: 30,
                        width: 115,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: Container(             
                                padding: EdgeInsets.all(2),                                   
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  color: kPrimaryColor.withOpacity(.4),
                                  shape: BoxShape.rectangle
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.remove, 
                                    color: Colors.black,
                                  ),
                                ),
                              ),                               
                              onTap: () {
                                if(_count > 1) {
                                  _count--;
                                  streamController.sink.add(_count);
                                }                                
                              },
                            ),
                            StreamBuilder<Object>(
                              stream: streamController.stream,
                              initialData: 1,
                              builder: (context, snapshot) {
                                return Text(snapshot.data.toString());
                              }
                            ),
                            GestureDetector(
                              child: Container(             
                                padding: EdgeInsets.all(2),                                   
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  color: kPrimaryColor.withOpacity(.4),
                                  shape: BoxShape.rectangle
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add, 
                                    color: Colors.black,
                                  ),
                                ),
                              ),                               
                              onTap: () {
                                if(_count > 1) {
                                  _count++;
                                  streamController.sink.add(_count);
                                }                                
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * .55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                      ),
                      color: kPrimaryColor.withOpacity(.9)
                    ),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          _percentColor = 1;
                          carrinho += _count;
                          if(cart.contains(widget.product)) {
                            int index = cart.indexWhere((element) => element == widget.product);
                            cart[index].quantidade +=  _count;
                          } else {
                            widget.product.quantidade = _count.toDouble();
                            cart.add(widget.product);
                          }
                        });
                        Toast.show(
                          "Adicionado ao carrinho",
                          context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.CENTER,
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40)
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            child: SvgPicture.asset("assets/icons/bag.svg"),
                          ),
                          SizedBox(width: 10,),
                          Text(
                            'Add Carrinho',
                            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 16)
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
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
                            return HomeScreen(
                              offsetPage: scrollValue,
                            );
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
      )),
    );
  }

  Column addCart1(BuildContext context) {
    return Column(
          children: <Widget>[
            Expanded(child: Container()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)),
                border: Border.all(color: Colors.black26, width: .4),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    child: AnimatedContainer(
                      duration: Duration(microseconds: 200),
                      curve: Curves.easeIn,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 27),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(_percentColor),
                        borderRadius: BorderRadius.circular(27),
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Add carrinho",
                            style: Theme.of(context).textTheme.button,
                          ),
                          SizedBox(width: 15),
                          SvgPicture.asset(
                            "assets/icons/forward.svg",
                            height: 11,
                          ),
                        ],
                      ),
                    ),
                    onLongPress: () {
                      setState(() {
                        _percentColor = 1;
                        carrinho += 1;
                        if(cart.contains(widget.product)) {
                          int index = cart.indexWhere((element) => element == widget.product);
                          cart[index].quantidade +=  1;
                        } else {
                          widget.product.quantidade = 1;
                          cart.add(widget.product);
                        }
                      });
                      Toast.show(
                        "Adicionado ao carrinho",
                        context,
                        duration: Toast.LENGTH_SHORT,
                        gravity: Toast.CENTER,
                      );
                    },
                    onLongPressEnd: (details) {
                      setState(() {
                        _percentColor = .65;
                      });
                    },
                    onTap: () {
                      setState(() {
                        _percentColor = 1;
                        carrinho += 1;
                        if(cart.contains(widget.product)) {
                          int index = cart.indexWhere((element) => element == widget.product);
                          cart[index].quantidade +=  1;
                        } else {
                          widget.product.quantidade = 1;
                          cart.add(widget.product);
                        }                          
                      });
                      Toast.show(
                        "Adicionado ao carrinho",
                        context,
                        duration: Toast.LENGTH_SHORT,
                        gravity: Toast.CENTER,
                      );
                      Future.delayed(Duration(milliseconds: 200), () {
                        setState(() {
                          _percentColor = .65;
                        });
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (BuildContext context, _, __) {
                            return Cart();
                          },
                        ),
                      );
                      Toast.show(
                        "Abrir Carrinho",
                        context,
                        duration: Toast.LENGTH_SHORT,
                        gravity: Toast.CENTER,
                      );
                    },
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPrimaryColor.withOpacity(.26),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(15),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kPrimaryColor,
                            ),
                            child: SvgPicture.asset("assets/icons/bag.svg"),
                          ),
                          Positioned(
                            right: 15,
                            bottom: 10,
                            child: Container(
                              alignment: Alignment.center,
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kWhiteColor,
                              ),
                              child: Text(
                                carrinho.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(color: kPrimaryColor, fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
  }
}
