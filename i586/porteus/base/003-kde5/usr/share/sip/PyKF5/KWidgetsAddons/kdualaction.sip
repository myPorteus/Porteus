// Discarded CLASS_DECL on line 16 'KGuiItem' (by default forward declaration handling)
class KDualAction: QAction
{
%TypeHeaderCode
#include <kdualaction.h>
%End
    // Discarded VAR_DECL on line 52 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 52 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 52 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 52 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 52 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 52 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 58 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KDualAction(QObject*  parent /TransferThis/);
    // Modified PARM_DECL on line 63 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KDualAction(const QString & inactiveText, const QString & activeText, QObject*  parent /TransferThis/);
    virtual ~KDualAction();
    void setActiveGuiItem(const KGuiItem & __0);
    KGuiItem activeGuiItem() const;
    void setInactiveGuiItem(const KGuiItem & __0);
    KGuiItem inactiveGuiItem() const;
    void setActiveIcon(const QIcon & __0);
    QIcon activeIcon() const;
    void setInactiveIcon(const QIcon & __0);
    QIcon inactiveIcon() const;
    void setActiveText(const QString & __0);
    QString activeText() const;
    void setInactiveText(const QString & __0);
    QString inactiveText() const;
    void setActiveToolTip(const QString & __0);
    QString activeToolTip() const;
    void setInactiveToolTip(const QString & __0);
    QString inactiveToolTip() const;
    void setIconForStates(const QIcon & icon);
    bool isActive() const;
    void setAutoToggle(bool __0);
    bool autoToggle() const;
public Q_SLOTS:
    void setActive(bool state);
Q_SIGNALS:
    void activeChanged(bool __0);
    void activeChangedByUser(bool __0);
private:
    // Discarded CLASS_DECL on line 192 'KDualActionPrivate' (by default forward declaration handling)
    private:
        KDualAction(const KDualAction &); // Generated
};
