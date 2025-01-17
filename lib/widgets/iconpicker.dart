import 'package:flutter/material.dart';
import 'package:get/get.dart';

showIconPickerCustom(
  BuildContext context,
  Function(IconData, String?) onSelected,
) async {
  List<IconData> travel = [
    Icons.map_outlined,
    Icons.explore_outlined,
    Icons.travel_explore_outlined,
    Icons.map_rounded,
    Icons.flight_outlined,
    Icons.directions_car_outlined,
    Icons.cottage_outlined,
    Icons.directions_bus_outlined,
    Icons.directions_railway_outlined,
    Icons.directions_boat_outlined,
    Icons.hotel_outlined,
    Icons.beach_access_outlined,
    Icons.hiking_outlined,
    Icons.festival_outlined,
    Icons.airplanemode_active_outlined,
    Icons.local_taxi_outlined,
    Icons.tram_outlined,
    Icons.airport_shuttle_outlined,
    Icons.landscape_outlined,
    Icons.paragliding_outlined,
  ];

  List<IconData> food = [
    Icons.menu_book_outlined,
    Icons.restaurant_outlined,
    Icons.restaurant_menu_outlined,
    Icons.lunch_dining_outlined,
    Icons.icecream_outlined,
    Icons.fastfood_outlined,
    Icons.coffee_outlined,
    Icons.local_pizza_outlined,
    Icons.cake_outlined,
    Icons.local_cafe_outlined,
    Icons.bakery_dining_outlined,
    Icons.kebab_dining_outlined,
    Icons.dining_outlined,
    Icons.local_dining_outlined,
    Icons.local_bar_outlined,
    Icons.ramen_dining_outlined,
    Icons.soup_kitchen_outlined,
    Icons.brunch_dining_outlined,
    Icons.wine_bar_outlined,
    Icons.set_meal_outlined,
  ];

  List<IconData> social = [
    Icons.group_outlined,
    Icons.person_outlined,
    Icons.people_outlined,
    Icons.chat_outlined,
    Icons.video_call_outlined,
    Icons.call_outlined,
    Icons.message_outlined,
    Icons.notifications_outlined,
    Icons.face_outlined,
    Icons.contact_mail_outlined,
    Icons.sentiment_satisfied_outlined,
    Icons.camera_outlined,
    Icons.share_outlined,
    Icons.thumb_up_outlined,
    Icons.thumb_down_outlined,
    Icons.handshake_outlined,
    Icons.tag_faces_outlined,
    Icons.event_outlined,
    Icons.comment_outlined,
    Icons.group_add_outlined,
  ];

  List<IconData> work = [
    Icons.work_outlined,
    Icons.laptop_outlined,
    Icons.desktop_mac_outlined,
    Icons.devices_outlined,
    Icons.folder_outlined,
    Icons.print_outlined,
    Icons.attach_file_outlined,
    Icons.assignment_outlined,
    Icons.calendar_today_outlined,
    Icons.schedule_outlined,
    Icons.email_outlined,
    Icons.task_outlined,
    Icons.note_outlined,
    Icons.document_scanner_outlined,
    Icons.access_time_outlined,
    Icons.cloud_outlined,
    Icons.business_outlined,
    Icons.analytics_outlined,
    Icons.data_usage_outlined,
    Icons.engineering_outlined,
  ];

  List<IconData> entertainment = [
    Icons.movie_outlined,
    Icons.music_note_outlined,
    Icons.tv_outlined,
    Icons.games_outlined,
    Icons.headphones_outlined,
    Icons.radio_outlined,
    Icons.speaker_outlined,
    Icons.theaters_outlined,
    Icons.queue_music_outlined,
    Icons.video_library_outlined,
    Icons.audiotrack_outlined,
    Icons.library_books_outlined,
    Icons.library_music_outlined,
    Icons.library_add_outlined,
    Icons.play_circle_outlined,
    Icons.slideshow_outlined,
    Icons.videogame_asset_outlined,
    Icons.subscriptions_outlined,
    Icons.mic_outlined,
    Icons.camera_roll_outlined,
  ];

  List<IconData> tech = [
    Icons.computer_outlined,
    Icons.memory_outlined,
    Icons.phone_android_outlined,
    Icons.phonelink_outlined,
    Icons.smartphone_outlined,
    Icons.tablet_outlined,
    Icons.watch_outlined,
    Icons.devices_other_outlined,
    Icons.router_outlined,
    Icons.build_outlined,
    Icons.wifi_outlined,
    Icons.bluetooth_outlined,
    Icons.usb_outlined,
    Icons.headset_outlined,
    Icons.settings_outlined,
    Icons.code_outlined,
    Icons.vpn_key_outlined,
    Icons.security_outlined,
    Icons.bug_report_outlined,
    Icons.developer_mode_outlined,
  ];

  List<IconData> nature = [
    Icons.grass_outlined,
    Icons.park_outlined,
    Icons.eco_outlined,
    Icons.terrain_outlined,
    Icons.forest_outlined,
    Icons.water_outlined,
    Icons.sunny,
    Icons.cloud_outlined,
    Icons.storm_outlined,
    Icons.wb_sunny_outlined,
    Icons.waves_outlined,
    Icons.forest_outlined,
    Icons.landscape_outlined,
    Icons.nature_outlined,
    Icons.spa_outlined,
    Icons.eco_outlined,
    Icons.nature_people_outlined,
    Icons.landscape_outlined,
    Icons.fireplace_outlined,
    Icons.night_shelter_outlined,
  ];

  List<IconData> emoji = [
    Icons.emoji_emotions_outlined,
    Icons.emoji_events_outlined,
    Icons.emoji_objects_outlined,
    Icons.emoji_people_outlined,
    Icons.emoji_nature_outlined,
    Icons.emoji_flags_outlined,
    Icons.emoji_nature_outlined,
    Icons.emoji_objects_outlined,
    Icons.emoji_people_outlined,
    Icons.emoji_flags_outlined,
    Icons.emoji_flags_outlined,
  ];

  return await showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return DefaultTabController(
        length: 8,
        child: SizedBox(
          width: Get.width,
          child: Column(
            children: [
              TabBar(
                isScrollable: true,
                tabs: [
                  Tab(
                    icon: Icon(Icons.travel_explore_outlined),
                  ),
                  Tab(
                    icon: Icon(Icons.lunch_dining_outlined),
                  ),
                  Tab(
                    icon: Icon(Icons.group_outlined),
                  ),
                  Tab(
                    icon: Icon(Icons.work_outline),
                  ),
                  Tab(
                    icon: Icon(Icons.music_note_outlined),
                  ),
                  Tab(
                    icon: Icon(Icons.devices_outlined),
                  ),
                  Tab(
                    icon: Icon(Icons.nature_outlined),
                  ),
                  Tab(
                    icon: Icon(Icons.emoji_emotions_outlined),
                  ),
                ],
              ),
              // Add TabBarView here
              Expanded(
                child: TabBarView(
                  children: [
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 60,
                        childAspectRatio: 1,
                      ),
                      itemCount: travel.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            onSelected(travel[index], travel[index].fontFamily);
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Get.theme.colorScheme.surface,
                            ),
                            child: Icon(
                              travel[index],
                              color: Get.theme.colorScheme.onSurface,
                            ),
                          ),
                        );
                      },
                    ),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 60,
                        childAspectRatio: 1,
                      ),
                      itemCount: food.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            onSelected(food[index], food[index].fontFamily);
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              food[index],
                              color: Get.theme.colorScheme.onSurface,
                            ),
                          ),
                        );
                      },
                    ),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 60,
                        childAspectRatio: 1,
                      ),
                      itemCount: social.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            onSelected(social[index], social[index].fontFamily);
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Get.theme.colorScheme.surface,
                            ),
                            child: Icon(
                              social[index],
                              color: Get.theme.colorScheme.onSurface,
                            ),
                          ),
                        );
                      },
                    ),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 60,
                        childAspectRatio: 1,
                      ),
                      itemCount: work.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            onSelected(work[index], work[index].fontFamily);
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Get.theme.colorScheme.surface,
                            ),
                            child: Icon(
                              work[index],
                              color: Get.theme.colorScheme.onSurface,
                            ),
                          ),
                        );
                      },
                    ),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 60,
                        childAspectRatio: 1,
                      ),
                      itemCount: entertainment.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            onSelected(entertainment[index],
                                entertainment[index].fontFamily);
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Get.theme.colorScheme.surface,
                            ),
                            child: Icon(
                              entertainment[index],
                              color: Get.theme.colorScheme.onSurface,
                            ),
                          ),
                        );
                      },
                    ),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 60,
                        childAspectRatio: 1,
                      ),
                      itemCount: tech.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            onSelected(tech[index], tech[index].fontFamily);
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Get.theme.colorScheme.surface,
                            ),
                            child: Icon(
                              tech[index],
                              color: Get.theme.colorScheme.onSurface,
                            ),
                          ),
                        );
                      },
                    ),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 60,
                        childAspectRatio: 1,
                      ),
                      itemCount: nature.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            onSelected(nature[index], nature[index].fontFamily);
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Get.theme.colorScheme.surface,
                            ),
                            child: Icon(
                              nature[index],
                              color: Get.theme.colorScheme.onSurface,
                            ),
                          ),
                        );
                      },
                    ),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 60,
                        childAspectRatio: 1,
                      ),
                      itemCount: emoji.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            onSelected(emoji[index], emoji[index].fontFamily);
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Get.theme.colorScheme.surface,
                            ),
                            child: Icon(
                              emoji[index],
                              color: Get.theme.colorScheme.onSurface,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
