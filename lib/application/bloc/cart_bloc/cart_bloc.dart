import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_project/application/bloc/cart_bloc/cart_event.dart';
import 'package:main_project/application/bloc/cart_bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(InitialCartState()) {
    on<AddCartEvent>((event, emit) {
      final updatedCartProduct = {...state.cartProduct};
      if(!updatedCartProduct.containsKey(event.product)){
        updatedCartProduct[event.product]=1;
      }
      else{
        updatedCartProduct[event.product]=state.cartProduct[event.product]!+1;
      }
      emit(CartState(cartProduct: updatedCartProduct));
    });
    on<RemoveCartEvent>((event, emit){
        final updatedCartProduct = {...state.cartProduct};
        if(updatedCartProduct.containsKey(event.product)){
          if(updatedCartProduct[event.product]!<=1){
            updatedCartProduct.remove(event.product);
          }
          else{
            updatedCartProduct[event.product]=updatedCartProduct[event.product]!-1;
          }
        }
        emit(CartState(cartProduct: updatedCartProduct));
    });
  }
}
