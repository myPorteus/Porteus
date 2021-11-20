class LineEditUrlDropEventFilter: QObject
{
%TypeHeaderCode
#include <lineediturldropeventfilter.h>
%End
    // Discarded VAR_DECL on line 23 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 23 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 23 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 23 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 23 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 23 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 26 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    LineEditUrlDropEventFilter(QObject*  parent /TransferThis/ = nullptr);
    virtual ~LineEditUrlDropEventFilter();
    virtual bool eventFilter(QObject*  obj, QEvent*  ev);
    private:
        LineEditUrlDropEventFilter(const LineEditUrlDropEventFilter &); // Generated
};
