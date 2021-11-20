
%Module PyKF5.KDBusAddons

%ModuleHeaderCode
#pragma GCC visibility push(default)
%End

%Import QtDBus/QtDBusmod.sip

%Include kdbusconnectionpool.sip
%Include kdbusinterprocesslock.sip
%Include kdbusservice.sip
%Include kdedmodule.sip
%Include kdeinitinterface.sip
