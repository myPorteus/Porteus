// Discarded CLASS_DECL on line 15 'KAssistantDialogPrivate' (by default forward declaration handling)
class KAssistantDialog: KPageDialog
{
%TypeHeaderCode
#include <kassistantdialog.h>
%End
    // Discarded VAR_DECL on line 40 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 40 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 40 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 40 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 40 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 40 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 48 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KAssistantDialog(QWidget*  parent /TransferThis/ = nullptr, QFlags<Qt::WindowType> flags = Qt::WindowFlags());
    virtual ~KAssistantDialog();
    void setValid(KPageWidgetItem*  page, bool enable);
    bool isValid(KPageWidgetItem*  page) const;
    void setAppropriate(KPageWidgetItem*  page, bool appropriate);
    bool isAppropriate(KPageWidgetItem*  page) const;
    QPushButton * nextButton() const;
    QPushButton * backButton() const;
    QPushButton * finishButton() const;
public Q_SLOTS:
    virtual void back();
    virtual void next();
protected:
    // Modified PARM_DECL on line 134 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KAssistantDialog(KPageWidget*  widget, QWidget*  parent /TransferThis/ = nullptr, QFlags<Qt::WindowType> flags = Qt::WindowFlags());
    virtual void showEvent(QShowEvent*  event);
private:
    KAssistantDialog(const KAssistantDialog & __0);
};
