import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../bloc/detailItem_hotel_bloc/detail_item_hotel_bloc.dart';

import '../service/detail_hotel.dart';
import '../style/const/colors.dart';
import 'list_room_page.dart';

class DetailHotel extends StatefulWidget {
  const DetailHotel({super.key});

  @override
  State<DetailHotel> createState() => _DetailHotelState();
}

class _DetailHotelState extends State<DetailHotel> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int _currentIndex = 0;
  bool _isExpanded = false;
  late GoogleMapController googleMapController;
  void _onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  static final CameraPosition _position = CameraPosition(
      target: LatLng(
        10.7603712,
        106.6803003,
      ),
      zoom: 17);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<DetailItemHotelBloc, DetailItemHotelState>(
      builder: (context, state) {
        if (state is DetailDataHotelLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is DetailDataHotelLoaded) {
          final dataItem = state.detailDataHotel;

          print(dataItem);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff003580),
              elevation: 0,
              centerTitle: true,
              title: Text(
                dataItem.name,
                style: TextStyle(fontSize: 13),
              ),
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Stack(
                                  children: [
                                    CarouselSlider(
                                      options: CarouselOptions(
                                        initialPage: 0,
                                        viewportFraction: 1.0,
                                        pauseAutoPlayOnTouch: true,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            _currentIndex = index;
                                          });
                                        },
                                      ),
                                      items: dataItem.images.map((item) {
                                        return Container(
                                          child: Center(
                                            child: CachedNetworkImage(
                                              imageUrl: item.image,
                                              progressIndicatorBuilder: (context,
                                                      url, downloadProgress) =>
                                                  Image.asset(
                                                      'assets/images/noimage.png'),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              width: size.width,
                                              height: 200,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    Positioned(
                                      bottom: 18,
                                      right: 10,
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: Icon(
                                                Icons
                                                    .picture_in_picture_outlined,
                                                size: 17,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              '${_currentIndex + 1} / ${dataItem.images.length}',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dataItem.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_outlined),
                                        Flexible(
                                          child: Text(
                                            dataItem.address,
                                            maxLines: 2,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          height: 20,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              padding: EdgeInsets.zero,
                                              itemCount: dataItem.starNumber,
                                              physics: ClampingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Icon(
                                                  Icons.star_outlined,
                                                  size: 15,
                                                  color: Color(0xffFEBB02),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.grey[200],
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _nameService(nameService: 'Dịch vụ'),
                                  ],
                                ),
                              ),
                              Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        (dataItem.services.length / 2).ceil(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8.0,
                                        ),
                                        child: Wrap(
                                          spacing:
                                              2.0, // khoảng cách giữa các item
                                          children: [
                                            Container(
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      24.0) /
                                                  2, // tính toán chiều rộng của item
                                              child: Text(
                                                  '- ${dataItem.services[index * 2].name}'),
                                            ),
                                            Container(
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      24.0) /
                                                  2, // tính toán chiều rộng của item
                                              child: (index * 2 + 1 <
                                                      dataItem.services.length)
                                                  ? Text(
                                                      '- ${dataItem.services[index * 2 + 1].name}')
                                                  : SizedBox(),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )),
                              Container(
                                color: Colors.grey[200],
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    _nameService(nameService: 'Bản đồ'),
                                    Container(
                                      height: 200,
                                      child: GoogleMap(
                                        initialCameraPosition: _position,
                                        mapType: MapType.normal,
                                        onMapCreated: _onMapCreated,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.grey[200],
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    _nameService(nameService: 'Mô tả'),
                                    Text(
                                      dataItem.description,
                                      maxLines: _isExpanded ? null : 3,
                                      overflow: _isExpanded
                                          ? null
                                          : TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              _isExpanded = !_isExpanded;
                                            });
                                          },
                                          child: Text(_isExpanded
                                              ? 'Thu gọn'
                                              : 'Hiển thị thêm')),
                                    ),
                                  ],
                                ),
                              ),
                              _isExpanded
                                  ? SizedBox(
                                      height: 80,
                                    )
                                  : SizedBox(
                                      height: 70,
                                    )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          color: AppColors.button,
                          shape: RoundedRectangleBorder(),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ListRoom(
                                    detailDataHotel: dataItem,
                                  ),
                                ));
                          },
                          child: const Text('Xem các lựa chọn',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ))
              ],
            ),
          );
        }
        return Center(
          child: Text('k co data'),
        );
      },
    );
  }

  _nameService({required String nameService}) {
    return Row(
      children: [
        Container(
          color: Colors.amber,
          height: 20,
          width: 4,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          nameService,
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
