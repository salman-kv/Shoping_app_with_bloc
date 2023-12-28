import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_project/application/bloc/cart_bloc/cart_bloc.dart';
import 'package:main_project/application/bloc/cart_bloc/cart_event.dart';
import 'package:main_project/application/bloc/cart_bloc/cart_state.dart';
import 'package:main_project/domain/model/product_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
       title: const Text('Cart',style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
      ),
      body: BlocBuilder<CartBloc,CartState>(
        builder: (context, state) {
          List<ProductModel> listOfCartproduct=[];
          List<int> listOfCartCount=[];
          for(ProductModel i in state.cartProduct.keys){
            listOfCartproduct.add(i);
            listOfCartCount.add(state.cartProduct[i]!);
          }
          return state.cartProduct.isEmpty ? const Center(child: Text('No data found'),) : ListView(
          children: List.generate(listOfCartproduct.length, (index){
            return Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.network(listOfCartproduct[index].image),
                  ),
                  Expanded(child: Text(listOfCartproduct[index].title.substring(0,10))),
                  ElevatedButton(onPressed: (){
                    context.read<CartBloc>().add(RemoveCartEvent(product: listOfCartproduct[index]));
                  }, child: const Icon(Icons.minimize)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(listOfCartCount[index].toString()),
                  ),
                  ElevatedButton(onPressed: (){
                    context.read<CartBloc>().add(AddCartEvent(product: listOfCartproduct[index]));
                  }, child: const Icon(Icons.add)),
                ],
              ),
            );
          })
        );
        },
      ),
    ));
  }
}