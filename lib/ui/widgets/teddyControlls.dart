import 'package:flare_flutter/flare_controls.dart';

class TeddyControls extends FlareControls {
  void lookAtTextField(String value) {
    if (value.isEmpty) {
      play("idle"); // Default animation
    } else {
      play("look"); // Animation to follow input
    }
  }

  void coverEyes(bool cover) {
    if (cover) {
      play("hands_up"); // Animation where the teddy covers its eyes
    } else {
      play("hands_down"); 
    }
  }
}
