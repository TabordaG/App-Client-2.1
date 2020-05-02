import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/main.dart';

class DetailsScreen extends StatefulWidget {
  final Food product;

  DetailsScreen(this.product);
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  ScrollController _controller;
  Color _color = Colors.black;
  double _percent;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _percent = .65;

    _controller.addListener(() {
      if(_controller.offset > 340) {
        setState(() {
          _color = Colors.black.withOpacity(0);
        });
      }       
      else {
        setState(() {
          _color = Colors.black.withOpacity(1);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: _controller,
            slivers: <Widget>[
              SliverAppBar(
                elevation: 30,
                backgroundColor: Colors.white,
                expandedHeight: 420,
                pinned: true,
                floating: false,            
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: _color,), 
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return HomeScreen();
                      }),
                    );
                  }
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: EdgeInsets.symmetric(horizontal: 20),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${widget.product.title}\n",
                                style: TextStyle(
                                  fontFamily: Theme.of(context).textTheme.headline6.fontFamily,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                                ),
                              ),
                              TextSpan(
                                text: "Gabriel Moreira",
                                style: TextStyle(
                                  fontFamily: Theme.of(context).textTheme.subtitle2.fontFamily,
                                  fontSize: 12,
                                  color: Colors.black
                                ),
                                // style: TextStyle(
                                //   color: kTextColor.withOpacity(.5),
                                // ),
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
                  // title: Text(
                  //   widget.product.title,
                  //   style: Theme.of(context).textTheme.title,
                  // ),
                  collapseMode: CollapseMode.parallax,
                  background: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 30),
                          padding: EdgeInsets.only(right: 6, left: 6, bottom: 6),
                          height: 305,
                          width: 305,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kSecondaryColor,
                          ),
                          child: Container(
                            child: Hero(
                              tag: widget.product.image,
                              child: Image(
                                fit: BoxFit.cover,
                                image: AssetImage(widget.product.image),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.product.description + '. ' + 
                      widget.product.description + '. ' + 
                      widget.product.description + '. ' + 
                      widget.product.description
                      // "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: -70,
                        right: -50,
                        child: Opacity(
                          opacity: .2,
                          child: Image.asset('assets/images/leaf.png', height: 250,),
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
                            DataCell(Text('Produtos oriundos de quintais produtivos')),
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
                ])
              )
            ],
          ),
          Column(
            children: <Widget>[
              Expanded(child: Container()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                  border: Border.all(
                    color: Colors.black26,
                    width: .4
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: AnimatedContainer(
                        duration: Duration(microseconds: 200),
                        curve: Curves.easeIn,
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 27),
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(_percent),
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
                          _percent = 1;
                          carrinho += 1;
                        });
                      },  
                      onLongPressEnd: (details) {
                        setState(() {
                          _percent = .65;
                        });
                      },            
                      onTap: () {
                        setState(() {
                          _percent = 1;
                          carrinho += 1;                          
                        });
                        Future.delayed(Duration(milliseconds: 200),(){
                          setState(() {                          
                            _percent = .65;
                          }); 
                        });
                                                 
                        // _onTapDelay();
                      },
                    ),
                    Container(
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
                  ],
                ),
              ),
            ],
          ),
        ],
      )
    );
  }

  Future _onTapDelay() async {
    await Future.delayed(Duration(milliseconds: 1000));
  }
}