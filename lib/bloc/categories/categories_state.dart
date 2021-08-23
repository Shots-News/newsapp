part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {
  final List<CategoriesModel>? categories;

  CategoriesLoading({required this.categories});
}

class CategoriesLoaded extends CategoriesState {
  final List<CategoriesModel> categories;

  CategoriesLoaded({required this.categories});
}

class CategoriesError extends CategoriesState {
  final error;

  CategoriesError({this.error});
}
