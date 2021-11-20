// Discarded CLASS_DECL on line 25 'QMenu' (by default forward declaration handling)
class KToolBarPopupAction: QWidgetAction
{
%TypeHeaderCode
#include <ktoolbarpopupaction.h>
%End
    // Discarded VAR_DECL on line 45 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 45 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 45 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 45 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 45 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 45 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 63 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KToolBarPopupAction(const QIcon & icon, const QString & text, QObject*  parent /TransferThis/);
    virtual ~KToolBarPopupAction();
    QMenu * popupMenu() const;
    bool delayed() const;
    void setDelayed(bool delayed);
    bool stickyMenu() const;
    void setStickyMenu(bool sticky);
    QToolButton::ToolButtonPopupMode popupMode() const;
    void setPopupMode(QToolButton::ToolButtonPopupMode popupMode);
    virtual QWidget * // Modified PARM_DECL on line 158 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    createWidget(QWidget*  parent /TransferThis/);
private:
    // Discarded CLASS_DECL on line 161 'KToolBarPopupActionPrivate' (by default forward declaration handling)
    private:
        KToolBarPopupAction(const KToolBarPopupAction &); // Generated
};
