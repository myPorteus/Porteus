// Discarded CLASS_DECL on line 17 'QEvent' (by default forward declaration handling)
// Discarded CLASS_DECL on line 18 'QGridLayout' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'QLayout' (by default forward declaration handling)
// Discarded CLASS_DECL on line 20 'QWidget' (by default forward declaration handling)
class KColumnResizer: QObject
{
%TypeHeaderCode
#include <kcolumnresizer.h>
%End
    // Discarded VAR_DECL on line 67 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 67 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 67 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 67 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 67 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 67 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 72 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KColumnResizer(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KColumnResizer();
    void addWidgetsFromLayout(QLayout*  layout, int column = 0);
    void addWidget(QWidget*  widget);
    void removeWidget(QWidget*  widget);
protected:
    virtual bool eventFilter(QObject*  __0, QEvent*  event);
private:
    // Discarded CLASS_DECL on line 109 'KColumnResizerPrivate' (by default forward declaration handling)
    KColumnResizer(const KColumnResizer & __0);
};
