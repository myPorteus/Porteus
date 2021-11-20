// Discarded CLASS_DECL on line 21 'QWidget' (by default forward declaration handling)
// Discarded CLASS_DECL on line 23 'KToggleFullScreenActionPrivate' (by default forward declaration handling)
class KToggleFullScreenAction: KToggleAction
{
%TypeHeaderCode
#include <ktogglefullscreenaction.h>
%End
    // Discarded VAR_DECL on line 46 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 46 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 46 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 46 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 46 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 46 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 55 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KToggleFullScreenAction(QObject*  parent /TransferThis/);
    // Modified PARM_DECL on line 62 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KToggleFullScreenAction(QWidget*  window, QObject*  parent /TransferThis/);
    virtual ~KToggleFullScreenAction();
    void setWindow(QWidget*  window);
    static void setFullScreen(QWidget*  window, bool set);
protected:
    virtual bool eventFilter(QObject*  object, QEvent*  event);
protected Q_SLOTS:
    virtual void slotToggled(bool checked);
private:
    private:
        KToggleFullScreenAction(const KToggleFullScreenAction &); // Generated
};
