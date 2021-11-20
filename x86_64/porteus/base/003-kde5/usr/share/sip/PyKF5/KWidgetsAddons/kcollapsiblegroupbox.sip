class KCollapsibleGroupBox: QWidget
{
%TypeHeaderCode
#include <kcollapsiblegroupbox.h>
%End
    // Discarded VAR_DECL on line 27 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 27 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 27 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 27 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 27 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 27 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 32 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KCollapsibleGroupBox(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KCollapsibleGroupBox();
    void setTitle(const QString & title);
    QString title() const;
    void setExpanded(bool expanded);
    bool isExpanded() const;
    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;
public Q_SLOTS:
    void toggle();
    void expand();
    void collapse();
Q_SIGNALS:
    void titleChanged();
    void expandedChanged();
protected:
    virtual void paintEvent(QPaintEvent*  __0);
    virtual bool event(QEvent*  __0);
    virtual void mousePressEvent(QMouseEvent*  __0);
    virtual void mouseMoveEvent(QMouseEvent*  __0);
    virtual void leaveEvent(QEvent*  __0);
    virtual void keyPressEvent(QKeyEvent*  __0);
    virtual void resizeEvent(QResizeEvent*  __0);
private:
private:
    // Discarded CLASS_DECL on line 103 'KCollapsibleGroupBoxPrivate' (by default forward declaration handling)
    KCollapsibleGroupBox(const KCollapsibleGroupBox & __0);
};
