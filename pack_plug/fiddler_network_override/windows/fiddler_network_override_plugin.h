#ifndef FLUTTER_PLUGIN_FIDDLER_NETWORK_OVERRIDE_PLUGIN_H_
#define FLUTTER_PLUGIN_FIDDLER_NETWORK_OVERRIDE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace fiddler_network_override {

class FiddlerNetworkOverridePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FiddlerNetworkOverridePlugin();

  virtual ~FiddlerNetworkOverridePlugin();

  // Disallow copy and assign.
  FiddlerNetworkOverridePlugin(const FiddlerNetworkOverridePlugin&) = delete;
  FiddlerNetworkOverridePlugin& operator=(const FiddlerNetworkOverridePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace fiddler_network_override

#endif  // FLUTTER_PLUGIN_FIDDLER_NETWORK_OVERRIDE_PLUGIN_H_
