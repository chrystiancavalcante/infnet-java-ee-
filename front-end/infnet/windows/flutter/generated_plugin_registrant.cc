//
//  Generated file. Do not edit.
//

#include "generated_plugin_registrant.h"

#include <catcher/catcher_plugin.h>
#include <desktop_window/desktop_window_plugin.h>
#include <printing/printing_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  CatcherPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("CatcherPlugin"));
  DesktopWindowPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("DesktopWindowPlugin"));
  PrintingPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("PrintingPlugin"));
}
