
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_project/application/bloc/cart_bloc/cart_bloc.dart';
import 'package:main_project/application/bloc/cart_bloc/cart_event.dart';
import 'package:main_project/application/bloc/home_bloc/home_bloc.dart';
import 'package:main_project/application/bloc/home_bloc/home_event.dart';
import 'package:main_project/application/bloc/home_bloc/home_state.dart';
import 'package:main_project/domain/model/product_model.dart';
import 'package:main_project/presentation/widget/custom_snackbar.dart';

class PeoductShow extends StatelessWidget {
  final ProductModel product;
  final int index;
  const PeoductShow({super.key, required this.product,required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 227, 188, 234),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.width / 1.5,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(product.image),
                        fit: BoxFit.contain),
                    borderRadius: BorderRadius.circular(1000)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                product.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Price : ${product.price}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if(state is HomeStateWithData){
                    return  Row(
                      mainAxisAlignment: MainAxisAlignment.center
                      ,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<HomeBloc>().add(HomePageFavouriteEvent(
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
                                size: 40,
                              )
                            : const Icon(
                                Icons.favorite,
                                size: 40,
                                color: Colors.red,
                              ),
                      ),
                      IconButton(
                          onPressed: () {
                            context.read<CartBloc>().add(
                                  AddCartEvent(product: state.products[index]),
                                );
                            coustumSnackBar(
                                'added data to cart', context, Colors.green);
                          },
                          icon: const Icon(Icons.shopping_cart_outlined,size: 40,)),
                    ],
                  );
                  }
                  return const SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
