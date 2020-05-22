import 'dart:async';
import 'package:food_app/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/widgets/soft_buttom.dart';
import 'package:palette_generator/palette_generator.dart';

import 'main.dart';

List<Pedido> pedidos;
double total = 0;
bool initialSet;

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  StreamController<List<Pedido>> _streamControllerPedido;
  ScrollController scrollController = ScrollController();
  SlidableController slidableController = SlidableController();

  @override
  void initState() {
    super.initState();
    initialSet = true;
    pedidos = [];
    total = 0;
    _carregarProdutos();
    print(pedidos.length);    
  }

  void dispose() {
    super.dispose();
    _streamControllerPedido.close();
  }

  _carregarProdutos() async {
    _streamControllerPedido = StreamController<List<Pedido>>();
    pedidos = await obterPedidos(); 
    _streamControllerPedido.sink.add(pedidos);
  }
  
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
                    left: 20, top: 85, right: 20),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan> [
                      TextSpan(
                        text: "Meu Carrinho\n",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      TextSpan(
                        text: "Total ${cart.length} itens",
                        style: Theme.of(context).textTheme.button.copyWith(color: Colors.black.withOpacity(.6)),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: _streamControllerPedido.stream,
                  builder: (context, snapshot) {
                    if(snapshot.hasError || !snapshot.hasData) return Center(child: CircularProgressIndicator(),);
                    List<Pedido> cestas = snapshot.data;
                    // total = 0;
                    // cestas.forEach((element) {
                    //   element.produtos.forEach((produto) {
                    //     total = total + produto.price * produto.quantidade;
                    //   });
                    // });
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
                        return ListView(
                          controller: scrollController,
                          shrinkWrap: true,                       
                          children: [                            
                            for (Pedido item in cestas) 
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        'Produtor: ${item.produtor}',
                                        style: Theme.of(context).textTheme.button,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    thickness: .5,
                                    indent: 20,
                                    endIndent: 80,
                                  ),
                                  Container(
                                    height: 110 * item.produtos.length.toDouble(),
                                    child: ListView.builder(   
                                      controller: scrollController,    
                                      shrinkWrap: true,
                                      itemCount: item.produtos.length,
                                      itemBuilder: (context, index2) {
                                        return Slidable(
                                          key: Key(item.produtos[index2].title),
                                          controller: slidableController,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      PageRouteBuilder(
                                                        pageBuilder: (BuildContext context, _, __) {
                                                          return DetailsScreen(item.produtos[index2]);
                                                        },
                                                      )
                                                    );
                                                  },
                                                  child: Container(
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
                                                              color: item.produtos[index2].color.withOpacity(.4),
                                                              borderRadius: BorderRadius.all(Radius.circular(8)),
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
                                                              image: AssetImage(item.produtos[index2].image),
                                                              fit: BoxFit.contain,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                                                          child: Text(
                                                            item.produtos[index2].title,
                                                            style: Theme.of(context).textTheme.button.copyWith(fontSize: 18),
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        Container(
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
                                                                    color: kPrimaryColor.withOpacity(.1),
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
                                                                  if(item.produtos[index2].quantidade > 1) {
                                                                    setState(() {
                                                                      item.produtos[index2].quantidade--;
                                                                      total -= item.produtos[index2].price;
                                                                      carrinho -= 1;
                                                                    });
                                                                  }                                
                                                                },
                                                              ),
                                                              Text(item.produtos[index2].quantidade.toString()),
                                                              GestureDetector(
                                                                child: Container(             
                                                                  padding: EdgeInsets.all(2),                                   
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                                                    color: kPrimaryColor.withOpacity(.1),
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
                                                                  setState(() {
                                                                    item.produtos[index2].quantidade++;
                                                                    total = total + item.produtos[index2].price;
                                                                    carrinho += 1;                                                 
                                                                  });                          
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(right: 10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Align(
                                                        alignment: Alignment.centerRight,
                                                        child: Text(
                                                          '*Valor ajustado a qtd',
                                                          style: Theme.of(context).textTheme.button.copyWith(fontSize: 7),
                                                        ),
                                                      ),
                                                      Text(
                                                        'R\$${(item.produtos[index2].price * item.produtos[index2].quantidade).toStringAsFixed(2)}',
                                                        style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 20),
                                                      ),
                                                    ]
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actionPane: SlidableDrawerActionPane(),
                                          secondaryActions: <Widget>[
                                          IconSlideAction(
                                            color: Colors.red,
                                            icon: Icons.delete,
                                            onTap: () {
                                              setState(() {
                                                carrinho -= item.produtos[index2].quantidade.toInt();
                                                total = total - item.produtos[index2].price * item.produtos[index2].quantidade;
                                                cart.remove(item.produtos[index2]);
                                                cestas.remove(item.produtos[index2]);
                                                item.produtos.remove(item.produtos[index2]);               
                                              });
                                              if (item.produtos.length == 0) {
                                                setState(() {
                                                  cestas.remove(item);                                           
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                        );
                                      }
                                    ),
                                  ),
                                ]
                              ),
                          ],
                        );
                    }
                  }
                ),
              ),
              Divider(
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      'R\$${total.toStringAsFixed(2)}',
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

Future<List<Pedido>> obterPedidos() async {
  bool verificado = false;
  PaletteGenerator paletteGenerator;
  pedidos = [];
  cart.forEach((element) async {
    print(element.title);
    total = total + element.price * element.quantidade;
    if(element.color == null) {
      paletteGenerator = await PaletteGenerator.fromImageProvider(AssetImage(element.image));
      element.color = paletteGenerator.darkVibrantColor?.color == null ? Colors.grey : paletteGenerator.darkVibrantColor?.color;
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
  initialSet = false;
  print('Pedidos: ${pedidos.length}');
  pedidos.forEach((element) {print(element.produtos.length);});
  
  await Future.delayed(Duration(seconds: 2));
  return pedidos;
}

class Pedido {
  final String produtor;
  final List<Food> produtos;

  Pedido({
    this.produtos,
    this.produtor
  });
}