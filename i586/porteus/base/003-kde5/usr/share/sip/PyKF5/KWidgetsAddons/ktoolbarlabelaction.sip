class KToolBarLabelAction: QWidgetAction
{
%TypeHeaderCode
#include <ktoolbarlabelaction.h>
%End
    // Discarded VAR_DECL on line 45 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 45 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 45 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 45 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 45 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 45 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 54 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KToolBarLabelAction(const QString & text, QObject*  parent /TransferThis/);
    // Modified PARM_DECL on line 64 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KToolBarLabelAction(QAction*  buddy, const QString & text, QObject*  parent /TransferThis/);
    virtual ~KToolBarLabelAction();
    void setBuddy(QAction*  buddy);
    QAction * buddy() const;
    virtual QWidget * // Modified PARM_DECL on line 88 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    createWidget(QWidget*  parent /TransferThis/);
Q_SIGNALS:
    void textChanged(const QString & newText);
protected:
    virtual bool event(QEvent*  __0);
    virtual bool eventFilter(QObject*  watched, QEvent*  event);
private:
    // Discarded CLASS_DECL on line 102 'KToolBarLabelActionPrivate' (by default forward declaration handling)
    private:
        KToolBarLabelAction(const KToolBarLabelAction &); // Generated
};
