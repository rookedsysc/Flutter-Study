import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/layout/default_layout.dart';
import 'package:riverpod_sample/screen/auto_dispose_modifier_screen.dart';
import 'package:riverpod_sample/screen/family_modifier_screen.dart';
import 'package:riverpod_sample/screen/future_provider_screen.dart';
import 'package:riverpod_sample/screen/listen_provider_screen.dart';
import 'package:riverpod_sample/screen/provider_screen.dart';
import 'package:riverpod_sample/screen/select_provider_screen.dart';
import 'package:riverpod_sample/screen/state_notifier_provider_screen.dart';
import 'package:riverpod_sample/screen/state_provider_screen.dart';
import 'package:riverpod_sample/screen/stream_provider_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: 'HomeScreen',
        body: ListView(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          StateRiverpodScreen()));
                },
                child: Text("State Riverpod Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          StateNotifierProviderScreen()));
                },
                child: Text("State Notifier Provider Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          FutureProviderScreen()));
                },
                child: Text("Future Provider Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          StreamProviderScreen()));
                },
                child: Text("Stream Provider Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          FamilyModifierScreen()));
                },
                child: Text("Family Modifier Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AutoDisposeModifierScreen()));
                },
                child: Text("Auto Dispose Modifier Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ListenProviederScreen()));
                },
                child: Text("Listen Provider Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          SelectProviderScreen()));
                },
                child: Text("Select Provider Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ProviderScreen()));
                },
                child: Text("Provider Screen"))
          ],
        ));
  }
}
