// Discarded CLASS_DECL on line 25 'QMenu' (by default forward declaration handling)
class KActionMenu: QWidgetAction
{
%TypeHeaderCode
#include <kactionmenu.h>
%End
    // Discarded VAR_DECL on line 40 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 40 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 40 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 40 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 40 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 40 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 48 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KActionMenu(QObject*  parent /TransferThis/);
    // Modified PARM_DECL on line 49 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KActionMenu(const QString & text, QObject*  parent /TransferThis/);
    // Modified PARM_DECL on line 50 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KActionMenu(const QIcon & icon, const QString & text, QObject*  parent /TransferThis/);
    virtual ~KActionMenu();
    void remove(QAction*  __0);
    void addAction(QAction*  action);
    QAction * addSeparator();
    void insertAction(QAction*  before, QAction*  action);
    QAction * insertSeparator(QAction*  before);
    void removeAction(QAction*  action);
    QMenu * popupMenu();
    bool delayed() const;
    void setDelayed(bool delayed);
    bool stickyMenu() const;
    void setStickyMenu(bool sticky);
    QToolButton::ToolButtonPopupMode popupMode() const;
    void setPopupMode(QToolButton::ToolButtonPopupMode popupMode);
    virtual QWidget * // Modified PARM_DECL on line 168 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    createWidget(QWidget*  parent /TransferThis/);
private:
    // Discarded CLASS_DECL on line 171 'KActionMenuPrivate' (by default forward declaration handling)
    private:
        KActionMenu(const KActionMenu &); // Generated
};
