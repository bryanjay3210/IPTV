import 'package:flutter/material.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_menu/dvr_menu_cubit.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_delete_shows.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_series_manager.dart';

Padding seriesManagerTab({
  required BuildContext context,
  required DvrMenuState state,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 30,
      vertical: 30,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const DVRDeleteShows(),
              ),
            );
          },
          child: Container(
            color: !state.isNavigatingTabDrawer &&
                    state.currentManagedSelected == 1
                ? Colors.blue
                : Colors.transparent,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 3,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Delete Shows',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Select to delete shows.',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Divider(
          height: 10,
          color: Colors.grey,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const DVRSeriesManager(),
              ),
            );
          },
          child: Container(
            color: !state.isNavigatingTabDrawer &&
                    state.currentManagedSelected == 2
                ? Colors.blue
                : Colors.transparent,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 3,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Series Manager',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Changed priority of series recordings.',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
