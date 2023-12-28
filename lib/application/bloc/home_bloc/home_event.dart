import 'package:main_project/domain/model/product_model.dart';

abstract class HomeEvent{}

class LoadingHomePageEvent extends HomeEvent{}

class HomePageFavouriteEvent extends HomeEvent{
  final ProductModel product;
  final List<ProductModel> listproductModel;

  HomePageFavouriteEvent({required this.listproductModel,required this.product});
}