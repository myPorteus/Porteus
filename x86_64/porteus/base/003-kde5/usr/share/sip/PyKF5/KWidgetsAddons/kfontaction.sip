// Discarded CLASS_DECL on line 21 'KFontActionPrivate' (by default forward declaration handling)
class KFontAction: KSelectAction
{
%TypeHeaderCode
#include <kfontaction.h>
%End
    // Discarded VAR_DECL on line 31 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 31 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 31 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 31 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 31 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 31 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 35 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KFontAction(unsigned int fontListCriteria, QObject*  parent /TransferThis/);
    // Modified PARM_DECL on line 36 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KFontAction(QObject*  parent /TransferThis/);
    // Modified PARM_DECL on line 37 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KFontAction(const QString & text, QObject*  parent /TransferThis/);
    // Modified PARM_DECL on line 38 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KFontAction(const QIcon & icon, const QString & text, QObject*  parent /TransferThis/);
    virtual ~KFontAction();
    QString font() const;
    void setFont(const QString & family);
    virtual QWidget * // Modified PARM_DECL on line 45 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    createWidget(QWidget*  parent /TransferThis/);
private:
    private:
        KFontAction(const KFontAction &); // Generated
};
