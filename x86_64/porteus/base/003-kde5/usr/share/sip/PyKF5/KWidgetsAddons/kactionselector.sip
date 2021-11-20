// Discarded CLASS_DECL on line 15 'QListWidget' (by default forward declaration handling)
// Discarded CLASS_DECL on line 16 'QListWidgetItem' (by default forward declaration handling)
// Discarded CLASS_DECL on line 17 'QKeyEvent' (by default forward declaration handling)
// Discarded CLASS_DECL on line 18 'QEvent' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'QIcon' (by default forward declaration handling)
class KActionSelector: QWidget
{
%TypeHeaderCode
#include <kactionselector.h>
%End
    // Discarded VAR_DECL on line 71 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 71 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 71 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 71 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 71 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 71 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 81 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KActionSelector(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KActionSelector();
    QListWidget * availableListWidget() const;
    QListWidget * selectedListWidget() const;
    enum MoveButton {
        ButtonAdd,
        ButtonRemove,
        ButtonUp,
        ButtonDown
    };
    enum InsertionPolicy {
        BelowCurrent,
        Sorted,
        AtTop,
        AtBottom
    };
    bool moveOnDoubleClick() const;
    void setMoveOnDoubleClick(bool enable);
    bool keyboardEnabled() const;
    void setKeyboardEnabled(bool enable);
    QString availableLabel() const;
    void setAvailableLabel(const QString & text);
    QString selectedLabel() const;
    void setSelectedLabel(const QString & text);
    KActionSelector::InsertionPolicy availableInsertionPolicy() const;
    void setAvailableInsertionPolicy(KActionSelector::InsertionPolicy policy);
    KActionSelector::InsertionPolicy selectedInsertionPolicy() const;
    void setSelectedInsertionPolicy(KActionSelector::InsertionPolicy policy);
    bool showUpDownButtons() const;
    void setShowUpDownButtons(bool show);
    void setButtonIcon(const QString & icon, KActionSelector::MoveButton button);
    void setButtonIconSet(const QIcon & iconset, KActionSelector::MoveButton button);
    void setButtonTooltip(const QString & tip, KActionSelector::MoveButton button);
    void setButtonWhatsThis(const QString & text, KActionSelector::MoveButton button);
Q_SIGNALS:
    void added(QListWidgetItem*  item);
    void removed(QListWidgetItem*  item);
    void movedUp(QListWidgetItem*  item);
    void movedDown(QListWidgetItem*  item);
public Q_SLOTS:
    void setButtonsEnabled();
protected:
    virtual void keyPressEvent(QKeyEvent*  __0);
    virtual bool eventFilter(QObject*  __0, QEvent*  __1);
private:
    // Discarded CLASS_DECL on line 301 'KActionSelectorPrivate' (by default forward declaration handling)
    KActionSelector(const KActionSelector & __0);
};
