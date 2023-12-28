import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_project/application/bloc/home_bloc/home_bloc.dart';
import 'package:main_project/application/bloc/home_bloc/home_event.dart';
import 'package:main_project/application/bloc/home_bloc/home_state.dart';
import 'package:main_project/presentation/widget/custom_snackbar.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favourite',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeStateWithData) {
            return ListView(
                children: List.generate(state.products.length, (index) {
              if (state.products[index].fav) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.network(state.products[index].image),
                      ),
                      Expanded(
                          child: Text(
                              state.products[index].title.substring(0, 10))),
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
                              )
                            : const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            }));
          }
          return const Text('No data found');
        },
      ),
    ));
  }
}
