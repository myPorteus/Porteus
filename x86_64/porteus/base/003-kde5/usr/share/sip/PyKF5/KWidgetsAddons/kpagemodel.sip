// Discarded CLASS_DECL on line 16 'KPageModelPrivate' (by default forward declaration handling)
class KPageModel: QAbstractItemModel
{
%TypeHeaderCode
#include <kpagemodel.h>
%End
    // Discarded VAR_DECL on line 48 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 48 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 48 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 48 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 48 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 48 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    enum Role {
        HeaderRole,
        WidgetRole,
        HeaderVisibleRole
    };
    // Modified PARM_DECL on line 81 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KPageModel(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KPageModel();
protected:
    // Discarded CONSTRUCTOR on line 89 'KPageModel' (by rules_PyKF5.py:FunctionRuleDb[21],function_discard)
    // Discarded FIELD_DECL on line 90 'd_ptr' (by Qt5Ruleset.py:VariableRuleDb[1],variable_discard)
    private:
        KPageModel(const KPageModel &); // Generated
};
