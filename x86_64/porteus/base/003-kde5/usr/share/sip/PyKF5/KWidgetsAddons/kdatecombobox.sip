class KDateComboBox: QComboBox
{
%TypeHeaderCode
#include <kdatecombobox.h>
%End
    // Discarded VAR_DECL on line 23 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 23 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 23 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 23 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 23 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 23 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    enum Option {
        EditDate,
        SelectDate,
        DatePicker,
        DateKeywords,
        WarnOnInvalid
    };
    typedef QFlags<KDateComboBox::Option> Options;
    // Modified PARM_DECL on line 57 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KDateComboBox(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KDateComboBox();
    QDate date() const;
    bool isValid() const;
    bool isNull() const;
    KDateComboBox::Options options() const;
    QLocale::FormatType displayFormat() const;
    QDate minimumDate() const;
    QDate maximumDate() const;
    QMap<QDate, QString> dateMap() const;
Q_SIGNALS:
    void dateEntered(const QDate & date);
    void dateChanged(const QDate & date);
    void dateEdited(const QDate & date);
public Q_SLOTS:
    void setDate(const QDate & date);
    void setOptions(QFlags<KDateComboBox::Option> options);
    void setDisplayFormat(QLocale::FormatType format);
    void setDateRange(const QDate & minDate, const QDate & maxDate, const QString & minWarnMsg = QString(), const QString & maxWarnMsg = QString());
    void resetDateRange();
    void setMinimumDate(const QDate & minDate, const QString & minWarnMsg = QString());
    void resetMinimumDate();
    void setMaximumDate(const QDate & maxDate, const QString & maxWarnMsg = QString());
    void resetMaximumDate();
    void setDateMap(QMap<QDate, QString> dateMap);
protected:
    virtual bool eventFilter(QObject*  object, QEvent*  event);
    virtual void showPopup();
    virtual void hidePopup();
    virtual void mousePressEvent(QMouseEvent*  event);
    virtual void wheelEvent(QWheelEvent*  event);
    virtual void keyPressEvent(QKeyEvent*  event);
    virtual void focusInEvent(QFocusEvent*  event);
    virtual void focusOutEvent(QFocusEvent*  event);
    virtual void resizeEvent(QResizeEvent*  event);
    virtual void assignDate(const QDate & date);
private:
    // Discarded CLASS_DECL on line 295 'KDateComboBoxPrivate' (by default forward declaration handling)
    private:
        KDateComboBox(const KDateComboBox &); // Generated
};
// Discarded FUNCTION_DECL on line 298 'operator|' (by rules_PyKF5.py:FunctionRuleDb[24],function_discard)
// Discarded FUNCTION_DECL on line 298 'operator|' (by rules_PyKF5.py:FunctionRuleDb[24],function_discard)
// Discarded FUNCTION_DECL on line 298 'operator|' (by rules_PyKF5.py:FunctionRuleDb[24],function_discard)
