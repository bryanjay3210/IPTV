import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iptv/app/dvr_service.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_menu/dvr_menu_cubit.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_search_result.dart';
import 'package:iptv/app/home/bloc/channel_bloc.dart';
import 'package:iptv/core/device_id.dart';
import 'package:iptv/core/helpers/date_converter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

Widget searchTab({
  required BuildContext context,
  required DvrMenuState state,
  required ItemScrollController itemScrollController2,
  required ItemPositionsListener itemPositionsListener2,
  required TextEditingController searchCtrl,
}) {
  return BlocBuilder<DvrMenuCubit, DvrMenuState>(
    builder: (context, state) {
      if (DvrService.channelsAndProgram.isEmpty && state.isSearchLoading) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.staggeredDotsWave(color: Colors.amber, size: 50),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Initializing Search...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            )
          ],
        );
      }

      if(!DeviceId.isStb){
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white38,
                ),
                child: TextField(
                  controller: searchCtrl,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    context.read<DvrMenuCubit>().searchRecord(search: searchCtrl.text);
                  },
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              child: BlocBuilder<DvrMenuCubit, DvrMenuState>(
                builder: (context, state) {
                  if(state.searchResultList.isEmpty && !state.isLoading){
                    return const Center(child: Text('Empty Search'),);
                  }
                  if(state.searchResultList.isNotEmpty && !state.isLoading){
                    return Scrollbar(
                      child: ListView.builder(
                        itemCount: state.searchResultList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.of(context)
                                  .pushAndRemoveUntil(
                                MaterialPageRoute<void>(
                                  builder: (context) => DVRSearchResult(
                                    searchResult:
                                    state.searchResultList[index],
                                  ),
                                ),
                                (route) => false,
                              );
                            },
                            child: SizedBox(
                              height: 35,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Expanded(flex: 3,child: Text(state.searchResultList[index].programTitle.toString())),
                                  Expanded(flex: 3,child: Text(state.searchResultList[index].channelName.toString())),
                                  Expanded(flex: 2,child: Text(state.searchResultList[index].showDate.toString().contains('-') ? formatDateTime(DateTime.parse(state.searchResultList[index].showDate.toString())) : dateTimeStringConverter(state.searchResultList[index].showDate.toString()))),
                                ],
                              ),
                            ),
                          );
                        },),
                    );
                  }
                  return const Center(child: CircularProgressIndicator.adaptive(),);
                },
              ),
            )
          ],
        );
      }

      return Row(
        children: [
          Column(
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: GridView.builder(
                  itemCount: state.alphanumeric.characters.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(2),
                      child: Container(
                        height: 50,
                        width: 50,
                        color: state.alphanumericIndex == index &&
                                state.inAlphaNumeric
                            ? Colors.blue
                            : Colors.transparent,
                        child: Center(child: Text(state.alphanumeric[index])),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: Row(
                    children: [
                      controls(
                        text: 'Del',
                        color:
                            state.isNavigatingControl && state.controlIndex == 0
                                ? Colors.blue
                                : Colors.transparent,
                        flex: 2,
                        context: context,
                        state: state,
                      ),
                      controls(
                        text: 'Space',
                        color:
                            state.isNavigatingControl && state.controlIndex == 1
                                ? Colors.blue
                                : Colors.transparent,
                        flex: 4,
                        context: context,
                        state: state,
                      ),
                      controls(
                        text: 'Clear',
                        color:
                            state.isNavigatingControl && state.controlIndex == 2
                                ? Colors.blue
                                : Colors.transparent,
                        flex: 2,
                        context: context,
                        state: state,
                      ),
                      // controls(text: 'OK', color: state.isNavigatingControl && state.controlIndex == 3 ? Colors.blue : Colors.transparent, flex: 3, context: context, state: state,),
                    ],
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: state.textSearch == ''
                              ? const Text(
                                  'Search',
                                  style: TextStyle(color: Colors.grey),
                                )
                              : Text(state.textSearch),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 30,
                  width: double.infinity,
                  child: Row(
                    children: const [
                      SizedBox(width: 30,),
                      Expanded(flex: 6, child: Text('Program Title', style: TextStyle(fontWeight: FontWeight.bold),)),
                      Expanded(flex: 6, child: Text('Channel', style: TextStyle(fontWeight: FontWeight.bold),)),
                      Expanded(flex: 4, child: Text('Show Date', style: TextStyle(fontWeight: FontWeight.bold),)),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<DvrMenuCubit, DvrMenuState>(
                    builder: (context, state) {
                      if (state.isSearchLoading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      if (state.searchResultList.isEmpty ||
                          state.textSearch.isEmpty) {
                        return const Center(
                          child: Text('Empty Search'),
                        );
                      }
                      return ScrollablePositionedList.builder(
                        initialScrollIndex: state.searchIndex,
                        itemCount: state.searchResultList.length,
                        itemPositionsListener: itemPositionsListener2,
                        itemScrollController: itemScrollController2,
                        itemBuilder: (context, index) {
                          return BlocBuilder<ChannelBloc, ChannelState>(
                            builder: (context, channelState) {
                              return channelState.maybeMap(
                                loaded: (channelState) {
                                  final channel =
                                      channelState.channels.firstWhereOrNull(
                                    (element) =>
                                        element.epgChannelId ==
                                        state.searchResultList[index].channelId,
                                  );
                                  final isSelected = index == state.searchIndex;

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 1,
                                    ),
                                    child: Container(
                                      color: isSelected && state.inSearchList
                                          ? Colors.blue
                                          : Colors.transparent,
                                      height: 30,
                                      child: Row(
                                        children: [
                                          const Icon(Icons.movie, size: 25),
                                          const SizedBox(width: 5,),
                                          Expanded(
                                            flex: 6,
                                            child: Text(
                                              state.searchResultList[index]
                                                  .programTitle
                                                  .toString(),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 6,
                                            child: Text(
                                              channel != null
                                                  ? channel.channelName
                                                  : '',
                                            ),
                                          ),
                                          Expanded(flex: 4,child: Text(state.searchResultList[index].showDate.toString().contains('-') ? formatDateTime(DateTime.parse(state.searchResultList[index].showDate.toString())) : dateTimeStringConverter(state.searchResultList[index].showDate.toString()))),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                orElse: SizedBox.new,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      );
    },
  );
}

Widget controls({
  required String text,
  required int flex,
  required BuildContext context,
  required DvrMenuState state,
  required Color color,
}) {
  return Expanded(
    flex: flex,
    child: Padding(
      padding: const EdgeInsets.all(2),
      child: ColoredBox(
        color: color,
        child: Center(
          child: Text(text),
        ),
      ),
    ),
  );
}
