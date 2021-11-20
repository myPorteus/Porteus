// Discarded CLASS_DECL on line 24 'KGuiItem' (by default forward declaration handling)
// Discarded CLASS_DECL on line 25 'KToggleActionPrivate' (by default forward declaration handling)
class KToggleAction: QAction
{
%TypeHeaderCode
#include <ktoggleaction.h>
%End
    // Discarded VAR_DECL on line 37 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 37 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 37 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 37 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 37 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 37 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 45 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KToggleAction(QObject*  parent /TransferThis/);
    // Modified PARM_DECL on line 59 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KToggleAction(const QString & text, QObject*  parent /TransferThis/);
    // Modified PARM_DECL on line 72 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KToggleAction(const QIcon & icon, const QString & text, QObject*  parent /TransferThis/);
    virtual ~KToggleAction();
    void setCheckedState(const KGuiItem & checkedItem);
protected Q_SLOTS:
    virtual void slotToggled(bool checked);
protected:
    // Discarded CONSTRUCTOR on line 95 'KToggleAction' (by rules_PyKF5.py:FunctionRuleDb[21],function_discard)
private:
    private:
        KToggleAction(const KToggleAction &); // Generated
};
