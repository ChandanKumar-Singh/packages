import 'package:just_audio/just_audio.dart';

import '../constants/index.dart';
import '../utils/index.dart';

late AudioPlayer buttonClickPlayer;

class ButtonSoundServices {
  ButtonSoundServices._() {
    init();
  }
  static ButtonSoundServices get instance => ButtonSoundServices._();

  static Future<void> init() async {
    logg('ButtonSoundServices init');
    buttonClickPlayer = AudioPlayer();
    buttonClickPlayer
        .setAsset('assets/sounds/button-press-sound.mp3')
        .then((value) {});
  }

  static Future<void> playButtonClick() async {
    await buttonClickPlayer.setAsset('assets/sounds/button_click.mp3');
    await buttonClickPlayer.play();
  }
}
