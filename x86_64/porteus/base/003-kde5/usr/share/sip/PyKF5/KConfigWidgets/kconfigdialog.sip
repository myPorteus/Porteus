// Discarded CLASS_DECL on line 17 'KConfig' (by default forward declaration handling)
// Discarded CLASS_DECL on line 18 'KCoreConfigSkeleton' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'KConfigDialogManager' (by default forward declaration handling)
class KConfigDialog: KPageDialog
{
%TypeHeaderCode
#include <kconfigdialog.h>
%End
    // Discarded VAR_DECL on line 67 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 67 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 67 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 67 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 67 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 67 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
Q_SIGNALS:
    void widgetModified();
    void settingsChanged(const QString & dialogName);
public:
    // Modified PARM_DECL on line 95 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KConfigDialog(QWidget*  parent /TransferThis/, const QString & name, KCoreConfigSkeleton*  config);
    virtual ~KConfigDialog();
    KPageWidgetItem * addPage(QWidget*  page, const QString & itemName, const QString & pixmapName = QString(), const QString & header = QString(), bool manage = true);
    KPageWidgetItem * addPage(QWidget*  page, KCoreConfigSkeleton*  config, const QString & itemName, const QString & pixmapName = QString(), const QString & header = QString());
    static KConfigDialog * exists(const QString & name);
    static bool showDialog(const QString & name);
protected Q_SLOTS:
    virtual void updateSettings();
    virtual void updateWidgets();
    virtual void updateWidgetsDefault();
    void updateButtons();
    void settingsChangedSlot();
    void setHelp(const QString & anchor, const QString & appname = QString());
    virtual void showHelp();
protected:
    virtual bool hasChanged();
    virtual bool isDefault();
    virtual void showEvent(QShowEvent*  e);
private:
private:
    // Discarded CLASS_DECL on line 248 'KConfigDialogPrivate' (by default forward declaration handling)
    KConfigDialog(const KConfigDialog & __0);
};
