import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AddsAndOffersView extends StatelessWidget {
  const AddsAndOffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddsAndOffersPage();
  }
}

class AddsAndOffersPage extends StatefulWidget {
  const AddsAndOffersPage({super.key});

  @override
  State<AddsAndOffersPage> createState() => _AddsAndOffersPageState();
}

class _AddsAndOffersPageState extends State<AddsAndOffersPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}