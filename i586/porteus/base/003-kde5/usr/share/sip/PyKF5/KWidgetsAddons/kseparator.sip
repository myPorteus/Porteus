class KSeparator: QFrame
{
%TypeHeaderCode
#include <kseparator.h>
%End
    // Discarded VAR_DECL on line 26 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 26 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 26 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 26 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 26 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 26 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 35 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KSeparator(QWidget*  parent /TransferThis/ = nullptr, QFlags<Qt::WindowType> f = Qt::WindowFlags());
    // Modified PARM_DECL on line 44 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KSeparator(Qt::Orientation orientation, QWidget*  parent /TransferThis/ = nullptr, QFlags<Qt::WindowType> f = Qt::WindowFlags());
    virtual ~KSeparator();
    Qt::Orientation orientation() const;
    void setOrientation(Qt::Orientation orientation);
private:
    // Discarded CLASS_DECL on line 62 'KSeparatorPrivate' (by default forward declaration handling)
    private:
        KSeparator(const KSeparator &); // Generated
};
