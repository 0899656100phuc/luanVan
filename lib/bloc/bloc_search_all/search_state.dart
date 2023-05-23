import 'package:equatable/equatable.dart';

import '../../model/search_all_data.dart';

abstract class SearchAllDataState extends Equatable {
  const SearchAllDataState();
  @override
  List<Object> get props => [];
}

class SearchAllDataInitial extends SearchAllDataState {}

class SearchAllDataLoading extends SearchAllDataState {}

class SearchAllDataLoaded extends SearchAllDataState {
  final List<Hotel> hotels;
  const SearchAllDataLoaded(this.hotels);
  @override
  List<Object> get props => [hotels];
}

class SearchAllDataError extends SearchAllDataState {
  final String message;

  const SearchAllDataError(this.message);

  @override
  List<Object> get props => [message];
}
