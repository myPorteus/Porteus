// Discarded CLASS_DECL on line 18 'QLineEdit' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'KDateTable' (by default forward declaration handling)
class KDatePicker: QFrame
{
%TypeHeaderCode
#include <kdatepicker.h>
%End
    // Discarded VAR_DECL on line 41 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 41 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 41 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 41 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 41 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 41 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 50 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KDatePicker(QWidget*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 55 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KDatePicker(const QDate & dt, QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KDatePicker();
    virtual QSize sizeHint() const;
    bool setDate(const QDate & date);
    const QDate & date() const;
    void setFontSize(int __0);
    int fontSize() const;
    void setCloseButton(bool enable);
    bool hasCloseButton() const;
protected:
    virtual bool eventFilter(QObject*  o, QEvent*  e);
    virtual void resizeEvent(QResizeEvent*  __0);
    virtual void changeEvent(QEvent*  event);
protected Q_SLOTS:
    void dateChangedSlot(const QDate & date);
    void tableClickedSlot();
    void monthForwardClicked();
    void monthBackwardClicked();
    void yearForwardClicked();
    void yearBackwardClicked();
    void selectMonthClicked();
    void selectYearClicked();
    void uncheckYearSelector();
    void lineEnterPressed();
    void todayButtonClicked();
    void weekSelected(int __0);
Q_SIGNALS:
    void dateChanged(const QDate & date);
    void dateSelected(const QDate & date);
    void dateEntered(const QDate & date);
    void tableClicked();
private:
private:
    // Discarded CLASS_DECL on line 168 'KDatePickerPrivate' (by default forward declaration handling)
    private:
        KDatePicker(const KDatePicker &); // Generated
};
