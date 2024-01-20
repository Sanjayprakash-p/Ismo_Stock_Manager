import 'package:flutter/material.dart';
import 'package:flutter_application_2/CustomWidget/imagecache.dart';
import 'package:flutter_application_2/PDF/All_Product_Export/all_product_expt.dart';
// import 'package:intl/intl.dart';

import 'colors.dart';

//TextField
hintt() {
  return const TextStyle(color: Colors.grey);
}

textt() {
  return TextStyle(
    color: typetextcolor,
  );
}

texttt() {
  return const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
}

// info page
textt1() {
  return TextStyle(color: typetextcolor);
}

labell() {
  return const TextStyle(color: Colors.grey);
}

reporthintxt() {
  return const (color: Colors.grey,);
}

labelladd() {
  return const TextStyle(color: Colors.grey);
}

// info page
labell1() {
  return TextStyle(color: labeltextcolor);
}

enabled() {
  return UnderlineInputBorder(
    borderSide: BorderSide(color: enabledbordercolor),
  );
}

enabledadd() {
  return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(15));
}

reportborder() {
  return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade100),
      borderRadius: BorderRadius.circular(15));
}

// info page
enabled1() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.circular(30),
  );
}

focuss() {
  return UnderlineInputBorder(
    borderSide: BorderSide(color: focusedbordercolor),
  );
}

focussadd() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.circular(15),
  );
}

// add page
errorfocusadd() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.circular(30),
  );
}

errorborderadd() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.circular(30),
  );
}

// info page
focuss1() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.circular(30),
  );
}

numberkeyboardtype() {
  return const TextInputType.numberWithOptions(decimal: true);
}

//CheckBox
checkboxtileshape() {
  return RoundedRectangleBorder(borderRadius: BorderRadius.circular(30));
}

checkboxsplash() {
  return BorderSide.strokeAlignCenter;
}

checkboxshape() {
  return const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.zero));
}

//Heading
headingstyle() {
  return TextStyle(
      color: headingcolor,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 4,
      overflow: TextOverflow.ellipsis);
}

//Search
searchborders() {
  return InputDecoration(
      border: InputBorder.none,
      prefixIcon: const Icon(Icons.search),
      hintText: "Search",
      prefixIconColor: searchiconcolor,
      hintStyle: hintt());
}

searchtextt() {
  return const TextStyle(color: Colors.orangeAccent);
}

//dropdown
dropdownborder() {
  return BorderRadius.circular(25);
}

//Button
buttontextstyle() {
  return TextStyle(
      color: buttontextcolor, fontWeight: FontWeight.bold, fontSize: 16);
}

buttonstyle() {
  return ElevatedButton.styleFrom(
      backgroundColor: buttonbackgroundcolor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))));
}

//AppBar
appbarshape() {
  return RoundedRectangleBorder(borderRadius: BorderRadius.circular(0));
}

//Text
stabletextstyle() {
  return TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: stabletextcolor,
  );
}

stabletextstyle1() {
  return TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: black,
  );
}

//Drawer
drawershape() {
  return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
    topRight: Radius.circular(10),
    bottomRight: Radius.circular(10),
  ));
}

/*drawerlisttileshape() {
  return RoundedRectangleBorder(borderRadius: BorderRadius.circular(0));
}*/

drawerlisttiletextstyle() {
  return const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
}

drawerheadercolorshape() {
  return BoxDecoration(color: drawerheadbackcolor);
}

drawerpadding() {
  return const EdgeInsets.fromLTRB(10, 5, 10, 0);
}

drawerheadershape() {
  return const BoxDecoration(
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)));
}

//ListTile
listtileshape() {
  return RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
}

listtiletextstyle() {
  return TextStyle(
      color: listtiletextcolor, fontSize: 16, fontWeight: FontWeight.bold);
}

listsubtitlestyle() {
  return const TextStyle(
      color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold);
}

//Quantity Color Grading
text(String qtyyy, String mqtyy) {
  int newqtyy = int.parse(qtyyy);
  int newmin = int.parse(mqtyy);
  if (newqtyy > newmin) {
    return Colors.greenAccent;
  } else if (newqtyy == newmin) {
    return Colors.yellowAccent;
  } else if (newqtyy < newmin && newqtyy > 0) {
    return Colors.redAccent;
  } else if (newqtyy == 0) {
    return Colors.grey;
  }
}

quantitygrade(String q, String mq) {
  return CircleAvatar(
      radius: 12,
      backgroundColor: text(q, mq),
      child: Text(
        q,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: listtiletextcolor,
            fontSize: 10),
      ));
}
// datetimeformat(var date){
//   // var dateTime = DateTime.parse(date) ;
//   // var format = DateFormat('dd-MM-yyyy (hh:mm:ss a )');
//   var dat = DateTime.parse("${date}");
//   return Text('$dat');
// }

//Slider
colorrr<MaterialAccentColor>(double value) {
  if (value == 0) {
    return Colors.orangeAccent;
  } else if (value > 0 && value <= 30) {
    return Colors.green;
  } else if (value > 30 && value <= 70) {
    return Colors.yellow;
  } else if (value > 70 && value <= 100) {
    return Colors.red;
  }
}

// Category
imagee(documentSnapshot, String nameee, double rad) {
  if (documentSnapshot == null) {
    String name = nameee.substring(0, 2);
    return CircleAvatar(
      radius: rad,
      backgroundColor: Colors.white,
      child: Text(
        name,
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 40),
      ),
    );
  }
  return CircleAvatar(
    radius: rad,
    // child: catchimage(documentSnapshot),
    backgroundImage: NetworkImage(documentSnapshot),
  );
}

//Auth TextField
authdecoration(String s) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: errortextcolor),
    ),
    hintText: s,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: errortextcolor),
    ),
    fillColor: Colors.grey.shade200,
    filled: true,
  );
}

authdecorationpass() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.transparent),
  );
}

authpadding() {
  return const EdgeInsets.symmetric(horizontal: 25);
}

authbuttonshape() {
  return const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)));
}

//SnackBar
snacks(String alert) {
  return SnackBar(
    showCloseIcon: true,
    // closeIconColor: Colors.white,
    // backgroundColor: Colors.grey.shade900,
    content: Text(
      alert,
      // style: const TextStyle(color: Colors.white),
    ),
    duration: const Duration(seconds: 1),
  );
}
