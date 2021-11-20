class KBusyIndicatorWidget: QWidget
{
%TypeHeaderCode
#include <kbusyindicatorwidget.h>
%End
    // Discarded VAR_DECL on line 44 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 44 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 44 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 44 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 44 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 44 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 46 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KBusyIndicatorWidget(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KBusyIndicatorWidget();
    virtual QSize minimumSizeHint() const;
protected:
    virtual void showEvent(QShowEvent*  event);
    virtual void hideEvent(QHideEvent*  event);
    virtual void resizeEvent(QResizeEvent*  event);
    virtual void paintEvent(QPaintEvent*  __0);
    virtual bool event(QEvent*  event);
private:
    // Discarded CLASS_DECL on line 59 'KBusyIndicatorWidgetPrivate' (by default forward declaration handling)
    private:
        KBusyIndicatorWidget(const KBusyIndicatorWidget &); // Generated
};
