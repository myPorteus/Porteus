// Discarded CLASS_DECL on line 9 'KConfigGroup' (by default forward declaration handling)
class KConfigViewStateSaver: KViewStateSerializer
{
%TypeHeaderCode
#include <kconfigviewstatesaver.h>
%End
    // Discarded VAR_DECL on line 18 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 18 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 18 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 18 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 18 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 18 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 20 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KConfigViewStateSaver(QObject*  parent /TransferThis/ = nullptr);
    void saveState(KConfigGroup & configGroup);
    void restoreState(const KConfigGroup & configGroup);
    private:
        KConfigViewStateSaver(const KConfigViewStateSaver &); // Generated
};
