// Discarded CLASS_DECL on line 24 'KPasteTextActionPrivate' (by default forward declaration handling)
class KPasteTextAction: QAction
{
%TypeHeaderCode
#include <kpastetextaction.h>
%End
    // Discarded VAR_DECL on line 40 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 40 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 40 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 40 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 40 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 40 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 48 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KPasteTextAction(QObject*  parent /TransferThis/);
    // Modified PARM_DECL on line 63 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KPasteTextAction(const QString & text, QObject*  parent /TransferThis/);
    // Modified PARM_DECL on line 77 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KPasteTextAction(const QIcon & icon, const QString & text, QObject*  parent /TransferThis/);
    virtual ~KPasteTextAction();
    void setMixedMode(bool mode);
private:
    private:
        KPasteTextAction(const KPasteTextAction &); // Generated
};
