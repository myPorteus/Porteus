// Discarded CLASS_DECL on line 17 'QItemSelectionModel' (by default forward declaration handling)
// Discarded CLASS_DECL on line 18 'QAbstractItemView' (by default forward declaration handling)
// Discarded CLASS_DECL on line 20 'KViewStateMaintainerBasePrivate' (by default forward declaration handling)
class KViewStateMaintainerBase: QObject
{
%TypeHeaderCode
#include <kviewstatemaintainerbase.h>
%End
    // Discarded VAR_DECL on line 24 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 24 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 24 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 24 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 24 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 24 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 26 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KViewStateMaintainerBase(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KViewStateMaintainerBase();
    void setSelectionModel(QItemSelectionModel*  selectionModel);
    QItemSelectionModel * selectionModel() const;
    void setView(QAbstractItemView*  view);
    QAbstractItemView * view() const;
    virtual void saveState() = 0;
    virtual void restoreState() = 0;
private:
    private:
        KViewStateMaintainerBase(const KViewStateMaintainerBase &); // Generated
};
