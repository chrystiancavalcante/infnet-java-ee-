import 'dart:async';
import 'package:flutter/material.dart';

import 'package:infnet/src/model/menu/menu.dart';
import 'package:infnet/src/infra/constantes.dart';

class MenuViewModel {
  final menuStreamController = StreamController<List<Menu>>();
  Stream<List<Menu>> get menuItemsStream => menuStreamController.stream;

  MenuViewModel() {
    menuStreamController.add(getMenuItems());
  }

  List<Menu> menuItems;
  getMenuItems() {
    return menuItems = <Menu>[
      Menu(
          title: "Cadastros",
          menuColor: Colors.black,
          icon: Icons.person,
          image: Constantes.menuCadastrosImage,
          route: "/cadastrosMenu",),
    
    ]; 
  }
}