#include "include/fiddler_network_override/fiddler_network_override_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "fiddler_network_override_plugin.h"

void FiddlerNetworkOverridePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  fiddler_network_override::FiddlerNetworkOverridePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
