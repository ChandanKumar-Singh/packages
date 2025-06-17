//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <fiddler_network_override/fiddler_network_override_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) fiddler_network_override_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FiddlerNetworkOverridePlugin");
  fiddler_network_override_plugin_register_with_registrar(fiddler_network_override_registrar);
}
