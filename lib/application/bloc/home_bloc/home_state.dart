import 'package:main_project/domain/model/product_model.dart';

abstract class HomeState{}

class HomeStateWithData extends HomeState{
  final  List<ProductModel> products;
  HomeStateWithData({required this.products});
}

class InitialHomeState extends HomeState{}


class LoadingHomeState extends HomeState{}
