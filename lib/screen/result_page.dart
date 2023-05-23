import 'package:booking_hotel/bloc/bloc_search_all/search_bloc.dart';
import 'package:booking_hotel/bloc/bloc_search_all/search_event.dart';
import 'package:booking_hotel/bloc/bloc_search_all/search_state.dart';
import 'package:booking_hotel/screen/detail_hotel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/detailItem_hotel_bloc/detail_item_hotel_bloc.dart';
import '../service/search_all.dart';

class ResultPage extends StatefulWidget {
  final String result;
  final String dateResult;
  final String formattedDateStart;
  final String formattedDateEnd;
  final int countRoom;
  final int countPeople;

  const ResultPage(
      {required this.countRoom,
      required this.countPeople,
      required this.formattedDateStart,
      required this.formattedDateEnd,
      required this.result,
      required this.dateResult,
      super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  TextEditingController _searchController = TextEditingController();
  bool _showClearIcon = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _searchController.text = '${widget.result}  ${widget.dateResult}';
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      /*  appBar: AppBar(
        backgroundColor: Color(0xff003580),
        automaticallyImplyLeading: false,
      ), */
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              AppBar(
                backgroundColor: Color(0xff003580),
                automaticallyImplyLeading: false,
              ),
            ],
          ),
          Positioned(
            top: kToolbarHeight + 25,
            left: 15,
            right: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: TextField(
                      enabled: false,
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(fontSize: 15),
                        fillColor: Colors.white,
                        hoverColor: Colors.white,
                        filled: true,
                        border: const OutlineInputBorder(),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 3, color: Colors.amber)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 3, color: Colors.amber)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 3, color: Colors.amber)),
                        prefixIcon: GestureDetector(
                          child: Icon(
                            Icons.chevron_left_outlined,
                            size: 45,
                          ),
                        ),
                        prefixIconColor: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: kToolbarHeight + 100,
              left: 5,
              right: 5,
              bottom: 0,
              child: BlocProvider(
                create: (context) => SearchAllDataBloc(SearchAllData())
                  ..add(SearchAllDataEvent(
                      address: widget.result,
                      checkinDate: widget.formattedDateStart,
                      checkoutDate: widget.formattedDateEnd,
                      numberPeople: widget.countPeople,
                      numberRooms: widget.countRoom)),
                child: BlocBuilder<SearchAllDataBloc, SearchAllDataState>(
                  builder: (context, state) {
                    if (state is SearchAllDataLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is SearchAllDataLoaded) {
                      final dataItem = state.hotels;
                      return Scrollbar(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 3),
                          child: ListView.builder(
                            cacheExtent: 1000.0,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: dataItem.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailHotel(),
                                          ));
                                      context.read<DetailItemHotelBloc>().add(
                                          FetchDetailHotelEvent(
                                              dataItem[index].id));
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      elevation: 4,
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(
                                                  10), //dataItem[index].image
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: dataItem[index].image,
                                              width: size.width,
                                              height: 200,
                                              fit: BoxFit.cover,
                                              /* placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error), */
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  dataItem[index].name,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Icon(Icons
                                                        .location_on_outlined),
                                                    Flexible(
                                                      child: Text(
                                                        dataItem[index].address,
                                                        maxLines: 2,
                                                        overflow:
                                                            TextOverflow.clip,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      height: 20,
                                                      child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          padding:
                                                              EdgeInsets.zero,
                                                          itemCount:
                                                              dataItem[index]
                                                                  .starNumber,
                                                          physics:
                                                              ClampingScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return Icon(
                                                              Icons
                                                                  .star_outlined,
                                                              size: 15,
                                                              color: Color(
                                                                  0xffFEBB02),
                                                            );
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Giá khách sạn',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14),
                                                    ),
                                                    Text(
                                                      '${dataItem[index].lowestPrice.toString()} US\$ / đêm',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: Text(
                        'k co da ta',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }
}
