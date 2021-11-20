
%Module PyKF5.KConfigGui

%ModuleHeaderCode
#pragma GCC visibility push(default)
%End

%Import QtGui/QtGuimod.sip

%Import PyKF5/KConfigCore/KConfigCoremod.sip

%Include kconfiggui.sip
%Include kconfigloader.sip
%Include kconfigskeleton.sip
%Include kstandardshortcut.sip
%Include kwindowconfig.sip
