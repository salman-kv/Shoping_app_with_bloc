import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_project/application/bloc/cart_bloc/cart_bloc.dart';
import 'package:main_project/application/bloc/cart_bloc/cart_event.dart';
import 'package:main_project/application/bloc/cart_bloc/cart_state.dart';
import 'package:main_project/application/bloc/home_bloc/home_bloc.dart';
import 'package:main_project/application/bloc/home_bloc/home_event.dart';
import 'package:main_project/application/bloc/home_bloc/home_state.dart';
import 'package:main_project/presentation/screens/cart_screen.dart';
import 'package:main_project/presentation/screens/fav_screen.dart';
import 'package:main_project/presentation/screens/product_show.dart';
import 'package:main_project/presentation/widget/custom_snackbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoadingHomeState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is HomeStateWithData) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'FlipCart',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return const FavScreen();
                    }));
                  },
                  icon: const Icon(Icons.favorite_border,size: 30,),),
                  Stack(
                    children: [
                          IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return const CartScreen();
                            }));
                          },
                          icon: const Icon(Icons.shopping_cart_outlined)),
                           Positioned(
                            top: 5,
                            right: 5,
                             child: BlocBuilder<CartBloc,CartState>(
                                builder: (context, state) {
                                 return state.cartProduct.isNotEmpty ?
                                    CircleAvatar(
                                  minRadius: 9,
                                  backgroundColor: Colors.red,
                                  child: Text(state.cartProduct.length.toString(),style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  ),),
                                ) :const SizedBox();
                                },
                              ),
                           ),
                        ],
                  ),
                ],
              ),
              body: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(state.products.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                          return PeoductShow(product: state.products[index],index: index,);
                        }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                            )),
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.width / 6,
                              width: MediaQuery.of(context).size.width / 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(state.products[index].image),
                              ),
                            ),
                            Text(state.products[index].title.length < 17
                                ? state.products[index].title
                                : state.products[index].title.substring(0, 17)),
                            Text('Price : ${state.products[index].price}'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    context.read<HomeBloc>().add(
                                        HomePageFavouriteEvent(
                                            product: state.products[index],
                                            listproductModel: state.products));
                                    coustumSnackBar(
                                        state.products[index].fav == false
                                            ? 'added item to favorite'
                                            : 'remove item from fav',
                                        context,
                                        state.products[index].fav == false
                                            ? Colors.green
                                            : Colors.red);
                                  },
                                  icon: state.products[index].fav == false
                                      ? const Icon(
                                          Icons.favorite_border,
                                        )
                                      : const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      context.read<CartBloc>().add(
                                            AddCartEvent(
                                                product: state.products[index]),
                                          );
                                      coustumSnackBar(
                                          'added data to cart', context,Colors.green);
                                    },
                                    icon:
                                        const Icon(Icons.shopping_cart_outlined)),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  })),
            ),
          );
        }
        return const Text('No data');
      },
    );
  }
}
