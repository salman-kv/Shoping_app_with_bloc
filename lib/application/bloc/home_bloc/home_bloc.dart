import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_project/application/bloc/home_bloc/home_event.dart';
import 'package:main_project/application/bloc/home_bloc/home_state.dart';
import 'package:main_project/domain/api_calling/product_api.dart';
import 'package:main_project/domain/model/product_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialHomeState()) {
    on<LoadingHomePageEvent>((event, emit) async {
      emit(LoadingHomeState());
      List<ProductModel> val = await takingAllProductFromApi();
      emit(HomeStateWithData(products: val));
    });
    on<HomePageFavouriteEvent>((event, emit) {
      List<ProductModel> updatedProductModel=[];
      for(var i in event.listproductModel){
        if(i.title==event.product.title){
          bool tempFav=!event.product.fav;
          var val=ProductModel(fav: tempFav, title: event.product.title, price: event.product.price, image: event.product.image);
          updatedProductModel.add(val);
        }
        else{
          updatedProductModel.add(i);
        }
      }
      emit(HomeStateWithData(products: updatedProductModel));
    });
  }
}
