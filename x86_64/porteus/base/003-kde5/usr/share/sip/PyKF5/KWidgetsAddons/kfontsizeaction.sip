// Discarded CLASS_DECL on line 21 'KFontSizeActionPrivate' (by default forward declaration handling)
class KFontSizeAction: KSelectAction
{
%TypeHeaderCode
#include <kfontsizeaction.h>
%End
    // Discarded VAR_DECL on line 31 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 31 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 31 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 31 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 31 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 31 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 35 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KFontSizeAction(QObject*  parent /TransferThis/);
    // Modified PARM_DECL on line 36 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KFontSizeAction(const QString & text, QObject*  parent /TransferThis/);
    // Modified PARM_DECL on line 37 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KFontSizeAction(const QIcon & icon, const QString & text, QObject*  parent /TransferThis/);
    virtual ~KFontSizeAction();
    int fontSize() const;
    void setFontSize(int size);
Q_SIGNALS:
    void fontSizeChanged(int __0);
protected Q_SLOTS:
    virtual void actionTriggered(QAction*  action);
private:
    private:
        KFontSizeAction(const KFontSizeAction &); // Generated
};
