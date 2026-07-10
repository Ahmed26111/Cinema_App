import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/constants/routes%20constants/routes_constants.dart';
import 'package:cinema_app/ui/search_result_screen/search_result_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DefaultSearchBarWidget extends StatefulWidget {
  const DefaultSearchBarWidget({super.key, required this.controller, required this.hintText , this.isSearchResult = false});

  final TextEditingController controller;


  final bool isSearchResult; //? To Know if the search bar is active or it just a UI

  final String hintText;

  @override
  State<DefaultSearchBarWidget> createState() => _DefaultSearchBarWidgetState();
}

class _DefaultSearchBarWidgetState extends State<DefaultSearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return TextSelectionTheme(
      data: TextSelectionThemeData(
        cursorColor: ColorsManager.primaryBlueAccentColor,
        selectionColor: ColorsManager.primaryBlueAccentColorLessOpacity,
        selectionHandleColor: ColorsManager.primaryBlueAccentColor,
      ),
      child: TextField(
          autofocus: widget.isSearchResult, //? if the search bar is in search Result so it will auto focus on it
          controller: widget.controller,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.04
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.04
            ),
            filled: true,
            fillColor: ColorsManager.primarySoftColor,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorsManager.primarySoftColor,
                width: 2
              ),
              borderRadius: BorderRadius.circular(50)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorsManager.primarySoftColor,
                    width: 2
                ),
                borderRadius: BorderRadius.circular(50)
            ),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorsManager.primarySoftColor,
                    width: 2
                ),
                borderRadius: BorderRadius.circular(50)
            ),
            prefixIcon: Icon(Icons.search_outlined , size: 22),
            prefixIconColor: ColorsManager.greyColor,
            suffixIcon: (widget.isSearchResult && widget.controller.text.isNotEmpty)
                ? IconButton(
                onPressed: () {
                    setState(() {
                      widget.controller.clear();
                    });
               },
                icon: Icon(Icons.close, size: 22,),
                style: IconButton.styleFrom(backgroundColor: ColorsManager.transparent),
            )
                : null,
            suffixIconColor: (widget.isSearchResult && widget.controller.text.isNotEmpty) ? ColorsManager.greyColor : null,
            counterText: "",
          ),
          onEditingComplete: (widget.isSearchResult) ? (){
            FocusScope.of(context).unfocus();
          } : null,
          onTap: (widget.isSearchResult) ? null : (){
            context.pushNamed(RoutesConstants.searchResultScreen);
          },
          onChanged: (widget.isSearchResult) ? (String value){
            setState(() {});
            context.read<SearchResultCubit>().onSearchChanged(value);
          } : null,
          readOnly: (!widget.isSearchResult), //? if the search bar is in search Result so it will not be read only
          autocorrect: widget.isSearchResult, //? if the search bar is in search Result so it will be autocorrect
          maxLength: (widget.isSearchResult) ? 100 : 1,
      ),
    );
  }
}
