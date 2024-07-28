import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditation_app/provider/firebase_provider.dart';
import 'package:provider/provider.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.customSearchBar,
    required this.onSubmitting,
  });

  final TextEditingController? customSearchBar;
  final void Function(String)? onSubmitting;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: TextField(
          controller: customSearchBar,
          decoration: InputDecoration(
              suffixIcon: InkWell(
                onTap: () {
                  customSearchBar!.clear();
                  Provider.of<FirebaseServiceProvider>(context, listen: false)
                      .refresh();
                },
                child: Icon(Icons.close),
              ),
              border: InputBorder.none,
              icon: SvgPicture.asset('assets/icons/search.svg'),
              hintText: 'Search'),
          onSubmitted: onSubmitting,
        ),
      ),
    );
  }
}
