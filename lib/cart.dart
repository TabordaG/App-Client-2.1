import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/widgets/card_cart.dart';
import 'package:food_app/widgets/soft_buttom.dart';
import 'package:palette_generator/palette_generator.dart';
import 'main.dart';

List<Pedido> pedidos;

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  StreamController<List<Pedido>> _streamController;
  ScrollController controller;
  List<List<bool>> _isSelected = List<List<bool>>();
  List<List<bool>> _changeQuantidade = List<List<bool>>();

  @override
  void initState() {
    super.initState();
    pedidos = [];
    _carregarProdutos();
  }

  void dispose() {
    super.dispose();
    _streamController.close();
  }

  _carregarProdutos() async {
    _streamController = StreamController<List<Pedido>>();
    pedidos = await obterPedidos();
    pedidos.forEach((element) {
      List<bool> list = new List<bool>();
      element.produtos.forEach((item) {
        list.add(false);
      });
      _isSelected.add(list);
      _changeQuantidade.add(list);
    });
    print(_isSelected);    
    _streamController.sink.add(pedidos);
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            bottom: -70,
            right: -150,
            child: Opacity(
              opacity: .2,
              child: Image.asset(
                'assets/images/leaf.png',
                height: 550,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 35.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 10,),
                    Text(
                    "Carrinho", //"Simple way to find \nTasty food",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Icon(Icons.shopping_basket, size: 28,),
                    )
                  ],
                ),
              ),
              Expanded(                
                child: StreamBuilder<List<Pedido>>(
                  stream: _streamController.stream,
                  builder: (context, snapshot) {
                    if(snapshot.hasError || !snapshot.hasData) return Center(child: CircularProgressIndicator(),);
                    List<Pedido> cestas = snapshot.data;
                    if(cestas.length == 0) {
                      return Center(
                        child: Text(
                          'Carrinho Vazio', 
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      );
                    }
                    switch(snapshot.connectionState) {
                      case ConnectionState.none:
                        return Center(child: Text('Não conectado'));
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator(),);
                      default:
                        return Scrollbar(
                          controller: controller,
                          child: ListView.builder(
                            controller: controller,
                            scrollDirection: Axis.vertical,
                            itemCount: cestas.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Produtor: ${cestas[index].produtor}', //"Simple way to find \nTasty food",
                                          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    height: _isSelected[index].contains(true) ? 253 : 205,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: cestas[index].produtos.length,
                                      itemBuilder: (context, index2) {
                                        if(cestas == null || cestas.isEmpty) {
                                          return Center(
                                            child: Text(
                                              'Carrinho Vazio', 
                                              style: Theme.of(context).textTheme.headline6,
                                            ),
                                          );
                                        }
                                        return Column(
                                          children: <Widget>[
                                            GestureDetector(
                                              onLongPress: () {
                                                for(var list in _isSelected) {
                                                  for (int i = 0; i < list.length; i++) {
                                                    setState(() {
                                                      list[i] = false;
                                                    });                                                      
                                                  }
                                                }
                                                setState(() {
                                                  _changeQuantidade[index][index2] = false;
                                                  _isSelected[index][index2] = true;                                                  
                                                });
                                                print("Selected: $_isSelected");
                                                print("Quantidade: $_changeQuantidade");
                                              },
                                              onTap: () {
                                                if(!_isSelected[index][index2]) {
                                                  for(var list in _isSelected) {
                                                    for (int i = 0; i < list.length; i++) {
                                                      setState(() {
                                                        list[i] = false;
                                                      });                                                      
                                                    }
                                                  }
                                                  setState(() {
                                                    _changeQuantidade[index][index2] = true;
                                                    _isSelected[index][index2] = true;
                                                  });
                                                  print(_isSelected);
                                                } else {
                                                  for(var list in _isSelected) {
                                                    for (int i = 0; i < list.length; i++) {
                                                      setState(() {
                                                        list[i] = false;
                                                      });                                                      
                                                    }
                                                  }
                                                  print(_isSelected);
                                                }
                                              },
                                              child: CartCard(
                                                press: () {},
                                                title: cestas[index].produtos[index2].title,
                                                image: cestas[index].produtos[index2].image,
                                                price: cestas[index].produtos[index2].price,
                                                produtor: cestas[index].produtos[index2].produtor,
                                                description: cestas[index].produtos[index2].description,
                                                color: cestas[index].produtos[index2].color,
                                                quantidade: cestas[index].produtos[index2].quantidade,
                                              ),
                                            ),
                                            _isSelected[index][index2] == true
                                              ? _changeQuantidade[index][index2]
                                                  ? Container(
                                                    width: 130,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        IconButton(
                                                          icon: Icon(
                                                            Icons.remove_circle,
                                                            color: Colors.redAccent,
                                                            size: 28,
                                                          ), 
                                                          onPressed: () {
                                                            if(pedidos[index].produtos[index2].quantidade > 0) {
                                                              setState(() {
                                                                pedidos[index].produtos[index2].quantidade -= 1;
                                                                carrinho -= 1;
                                                                int indice = cart.indexWhere((element) => element.title == pedidos[index].produtos[index2].title && element.produtor == pedidos[index].produtor);
                                                                cart[indice].quantidade = pedidos[index].produtos[index2].quantidade;
                                                              });
                                                              _streamController.sink.add(pedidos);
                                                            }                                                            
                                                          }
                                                        ),
                                                        Text(pedidos[index].produtos[index2].quantidade.toString(), style: TextStyle(fontSize: 18),),
                                                        IconButton(
                                                          icon: Icon(
                                                            Icons.add_circle,
                                                            color: Colors.teal,
                                                            size: 28,
                                                          ), 
                                                          onPressed: () {
                                                            setState(() {
                                                              pedidos[index].produtos[index2].quantidade += 1;
                                                              carrinho += 1;
                                                              int indice = cart.indexWhere((element) => element.title == pedidos[index].produtos[index2].title && element.produtor == pedidos[index].produtor);
                                                              cart[indice].quantidade = pedidos[index].produtos[index2].quantidade;
                                                            });                                                            
                                                            print(cart.length);
                                                            _streamController.sink.add(pedidos);
                                                          }
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                  : Container(
                                                    width: 130,
                                                    child: Center(
                                                      child: IconButton(
                                                        icon: Icon(Icons.delete_forever, color: Colors.red, size: 32,), 
                                                        onPressed: () {
                                                          cart.removeWhere((element) => element.title == pedidos[index].produtos[index2].title && element.produtor == pedidos[index].produtor);
                                                          carrinho -= pedidos[index].produtos[index2].quantidade.round();
                                                          pedidos[index].produtos.removeAt(index2);                                                      
                                                          pedidos[index].produtos.forEach((element) {print(element.title);});
                                                          if(pedidos[index].produtos.isEmpty) {
                                                            pedidos.removeAt(index);
                                                            _isSelected.removeAt(index);
                                                          } else _isSelected[index].removeAt(index2);
                                                          _streamController.sink.add(pedidos);
                                                        }
                                                      ),
                                                    ),
                                                  )
                                              : Container(),
                                          ],
                                        );
                                      }
                                    ),
                                  ),
                                  index == cestas.length - 1 
                                    ? SizedBox(height: 50)
                                    : SizedBox(height: 20),
                                ],
                              );
                            }
                          ),
                        );
                    }                                        
                  }
                ),
              ),
              Container(height: 60,),
            ],
          ),
          Column(
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
                    Text(
                      'Total: R\$23.50',
                      style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 16),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: kPrimaryColor)
                      ),
                      color: kPrimaryColor,
                      onPressed: () {
                        print('Comprar');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.attach_money),
                            Text(
                              "Comprar",
                              style:Theme.of(context).textTheme.button.copyWith(fontSize: 20)
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (BuildContext context, _, __) {
                        return HomeScreen();
                      },
                    )
                  );
                }
              ),
              radius: 22,
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Pedido>> obterPedidos() async {
    bool verificado = false;
    PaletteGenerator paletteGenerator;
    pedidos = [];
    cart.forEach((element) async {
      print(element.title);
      if(element.color == null) {
        paletteGenerator = await PaletteGenerator.fromImageProvider(AssetImage(element.image));
        element.color = paletteGenerator.darkVibrantColor?.color;
      }      
      verificado = false;
      for (var pedido in pedidos) {
        if(pedido.produtor == element.produtor) {
          pedido.produtos.add(element);
          verificado = true;
          break;
        }
      }
      if(!verificado) {
        pedidos.add(Pedido(
        produtor: element.produtor,
        produtos: [element],
        ));
      }
    });
    
    await Future.delayed(Duration(seconds: 2));
    return pedidos;
  }
}

class Pedido {
  final String produtor;
  final List<Food> produtos;

  Pedido({
    this.produtos,
    this.produtor
  });
}