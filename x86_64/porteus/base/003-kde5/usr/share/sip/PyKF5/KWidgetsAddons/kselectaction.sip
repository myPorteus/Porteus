// Discarded CLASS_DECL on line 29 'KSelectActionPrivate' (by default forward declaration handling)
class KSelectAction: QWidgetAction
{
%TypeHeaderCode
#include <kselectaction.h>
%End
    // Discarded VAR_DECL on line 46 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 46 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 46 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 46 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 46 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 46 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 62 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KSelectAction(QObject*  parent /TransferThis/);
    // Modified PARM_DECL on line 76 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KSelectAction(const QString & text, QObject*  parent /TransferThis/);
    // Modified PARM_DECL on line 89 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KSelectAction(const QIcon & icon, const QString & text, QObject*  parent /TransferThis/);
    virtual ~KSelectAction();
    enum ToolBarMode {
        MenuMode,
        ComboBoxMode
    };
    KSelectAction::ToolBarMode toolBarMode() const;
    void setToolBarMode(KSelectAction::ToolBarMode mode);
    QToolButton::ToolButtonPopupMode toolButtonPopupMode() const;
    void setToolButtonPopupMode(QToolButton::ToolButtonPopupMode mode);
    QActionGroup * selectableActionGroup() const;
    QAction * currentAction() const;
    int currentItem() const;
    QString currentText() const;
    QList<QAction *> actions() const;
    QAction * action(int index) const;
    QAction * action(const QString & text, Qt::CaseSensitivity cs = Qt::CaseSensitive) const;
    bool setCurrentAction(QAction*  action);
    bool setCurrentItem(int index);
    bool setCurrentAction(const QString & text, Qt::CaseSensitivity cs = Qt::CaseSensitive);
    void addAction(QAction*  action);
    QAction * addAction(const QString & text);
    QAction * addAction(const QIcon & icon, const QString & text);
    virtual QAction * removeAction(QAction*  action);
    virtual void insertAction(QAction*  before, QAction*  action);
    void setItems(const QStringList & lst);
    QStringList items() const;
    bool isEditable() const;
    void setEditable(bool __0);
    int comboWidth() const;
    void setComboWidth(int width);
    void setMaxComboViewCount(int n);
    void clear();
    void removeAllActions();
    void setMenuAccelsEnabled(bool b);
    bool menuAccelsEnabled() const;
    void changeItem(int index, const QString & text);
Q_SIGNALS:
    void triggered(QAction*  action);
    void triggered(int index);
    void indexTriggered(int index);
    void triggered(const QString & text);
    void textTriggered(const QString & text);
protected Q_SLOTS:
    virtual void actionTriggered(QAction*  action);
    void slotToggled(bool __0);
protected:
    virtual QWidget * // Modified PARM_DECL on line 416 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    createWidget(QWidget*  parent /TransferThis/);
    virtual void deleteWidget(QWidget*  widget);
    virtual bool event(QEvent*  event);
    virtual bool eventFilter(QObject*  watched, QEvent*  event);
    // Discarded CONSTRUCTOR on line 434 'KSelectAction' (by rules_PyKF5.py:FunctionRuleDb[21],function_discard)
    // Discarded FIELD_DECL on line 436 'd_ptr' (by Qt5Ruleset.py:VariableRuleDb[1],variable_discard)
private:
    private:
        KSelectAction(const KSelectAction &); // Generated
};
