// Discarded CLASS_DECL on line 18 'KCompletionBoxPrivate' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'QEvent' (by default forward declaration handling)
class KCompletionBox: QListWidget
{
%TypeHeaderCode
#include <kcompletionbox.h>
%End
    // Discarded VAR_DECL on line 38 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 38 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 38 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 38 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 38 'tr' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 38 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
public:
    // Modified PARM_DECL on line 51 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KCompletionBox(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KCompletionBox();
    virtual QSize sizeHint() const;
    bool activateOnSelect() const;
    QStringList items() const;
    bool isTabHandling() const;
    QString cancelledText() const;
public Q_SLOTS:
    void insertItems(const QStringList & items, int index = -1);
    void setItems(const QStringList & items);
    virtual void popup();
    void setTabHandling(bool enable);
    void setCancelledText(const QString & text);
    void setActivateOnSelect(bool doEmit);
    void down();
    void up();
    void pageDown();
    void pageUp();
    void home();
    void end();
    virtual void setVisible(bool visible);
Q_SIGNALS:
    void activated(const QString & text);
    void textActivated(const QString & text);
    void userCancelled(const QString & __0);
protected:
    QRect calculateGeometry() const;
    void sizeAndPosition();
    void resizeAndReposition();
    virtual bool eventFilter(QObject*  __0, QEvent*  __1);
    virtual QPoint globalPositionHint() const;
protected Q_SLOTS:
    virtual void slotActivated(QListWidgetItem*  __0);
private:
    private:
        KCompletionBox(const KCompletionBox &); // Generated
};
