
%Module PyKF5.KAuth

%ModuleHeaderCode
#pragma GCC visibility push(default)
%End

%Import QtWidgets/QtWidgetsmod.sip

%Import PyKF5/KCoreAddons/KCoreAddonsmod.sip

%Include kauth.sip
%Include kauthhelpersupport.sip
%Include kauthaction.sip
%Include kauthactionreply.sip
%Include kauthexecutejob.sip
%Include kauthobjectdecorator.sip
