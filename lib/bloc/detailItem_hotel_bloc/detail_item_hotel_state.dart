part of 'detail_item_hotel_bloc.dart';

abstract class DetailItemHotelState extends Equatable {
  const DetailItemHotelState();

  @override
  List<Object> get props => [];
}

class DetailItemHotelInitial extends DetailItemHotelState {}

class DetailDataHotelLoading extends DetailItemHotelState {}

class DetailDataHotelLoaded extends DetailItemHotelState {
  final DetailDataHotel detailDataHotel;
  const DetailDataHotelLoaded(this.detailDataHotel);
  @override
  List<Object> get props => [detailDataHotel];
}

class DetailDataHotelError extends DetailItemHotelState {
  final String message;

  const DetailDataHotelError(this.message);

  @override
  List<Object> get props => [message];
}
