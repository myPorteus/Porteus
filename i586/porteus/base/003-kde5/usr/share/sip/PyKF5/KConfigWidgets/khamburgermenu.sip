// Discarded CLASS_DECL on line 17 'KHamburgerMenuPrivate' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'QMenuBar' (by default forward declaration handling)
class KHamburgerMenu: QWidgetAction
{
%TypeHeaderCode
#include <khamburgermenu.h>
%End
    // Discarded VAR_DECL on line 96 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 96 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 96 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 96 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 96 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 96 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 100 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KHamburgerMenu(QObject*  parent /TransferThis/);
    virtual ~KHamburgerMenu();
    void setMenuBar(QMenuBar*  menuBar);
    QMenuBar * menuBar() const;
    void setMenuBarAdvertised(bool advertise);
    bool menuBarAdvertised() const;
    void setShowMenuBarAction(QAction*  showMenuBarAction);
    void addToMenu(QMenu*  menu);
    void hideActionsOf(QWidget*  widget);
    void showActionsOf(QWidget*  widget);
Q_SIGNALS:
    void aboutToShowMenu();
protected:
    virtual QWidget * // Modified PARM_DECL on line 178 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    createWidget(QWidget*  parent /TransferThis/);
private:
    private:
        KHamburgerMenu(const KHamburgerMenu &); // Generated
};
