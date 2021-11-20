class KPopupFrame: QFrame
{
%TypeHeaderCode
#include <kpopupframe.h>
%End
    // Discarded VAR_DECL on line 26 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 26 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 26 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 26 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 26 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 26 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
protected:
    virtual void keyPressEvent(QKeyEvent*  e);
    virtual void hideEvent(QHideEvent*  e);
public Q_SLOTS:
    void close(int r);
public:
    // Modified PARM_DECL on line 50 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KPopupFrame(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KPopupFrame();
    void setMainWidget(QWidget*  m);
    virtual void resizeEvent(QResizeEvent*  resize);
    void popup(const QPoint & pos);
    int exec(const QPoint & p);
    int exec(int x, int y);
Q_SIGNALS:
    void leaveModality();
private:
    // Discarded CLASS_DECL on line 92 'KPopupFramePrivate' (by default forward declaration handling)
    KPopupFrame(const KPopupFrame & __0);
};
