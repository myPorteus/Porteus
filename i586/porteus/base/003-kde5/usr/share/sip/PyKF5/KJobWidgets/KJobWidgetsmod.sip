
%Module PyKF5.KJobWidgets

%ModuleHeaderCode
#pragma GCC visibility push(default)
%End

%Import QtWidgets/QtWidgetsmod.sip

%Import PyKF5/KCoreAddons/KCoreAddonsmod.sip

%Include kabstractwidgetjobtracker.sip
%Include kdialogjobuidelegate.sip
%Include kuiserverjobtracker.sip
%Include kuiserverv2jobtracker.sip
%Include kjobwidgets.sip
%Include kstatusbarjobtracker.sip
%Include kwidgetjobtracker.sip
