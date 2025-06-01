import 'package:base_project/l10n/localization_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base_project/core/helpers/utils.dart';

class SearchWidget extends StatefulWidget {
  final TextEditingController textController;
  final Function onSearch;
  const SearchWidget({
    super.key,
    required this.textController,
    required this.onSearch,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: TextField(
        style: const TextStyle(
          color: Colors.black,
        ),
        onSubmitted: (value) {
          widget.onSearch();
        },
        textInputAction: TextInputAction.search,
        controller: widget.textController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(38),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(38),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(38),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          hintText: LocalizationKeys.search.tr(),
          hintStyle: const TextStyle(
            color: Color(0xFFB0B6B5),
            fontSize: 12,
          ),
          prefixIcon: Image.asset(
            Utils.getAssetPNGPath(
              "search",
            ),
            color: Color(0xFFB0B6B5),
          ),
          suffixIcon: widget.textController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    widget.textController.clear();
                    widget.onSearch();
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
