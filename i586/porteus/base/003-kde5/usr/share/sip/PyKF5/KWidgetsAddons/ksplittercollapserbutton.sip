// Discarded CLASS_DECL on line 16 'QSplitter' (by default forward declaration handling)
class KSplitterCollapserButton: QToolButton
{
%TypeHeaderCode
#include <ksplittercollapserbutton.h>
%End
    // Discarded VAR_DECL on line 27 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 27 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 27 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 27 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 27 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 27 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    KSplitterCollapserButton(QWidget*  childWidget, QSplitter*  splitter);
    virtual ~KSplitterCollapserButton();
    bool isWidgetCollapsed() const;
    virtual QSize sizeHint() const;
public Q_SLOTS:
    void collapse();
    void restore();
    void setCollapsed(bool collapsed);
private:
protected:
    virtual bool eventFilter(QObject*  __0, QEvent*  __1);
    virtual void paintEvent(QPaintEvent*  __0);
    virtual void enterEvent(QEvent*  event);
    virtual void leaveEvent(QEvent*  event);
    virtual void showEvent(QShowEvent*  event);
private:
    // Discarded CLASS_DECL on line 76 'KSplitterCollapserButtonPrivate' (by default forward declaration handling)
    private:
        KSplitterCollapserButton(const KSplitterCollapserButton &); // Generated
};
