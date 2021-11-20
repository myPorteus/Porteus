class KTimeComboBox: QComboBox
{
%TypeHeaderCode
#include <ktimecombobox.h>
%End
    // Discarded VAR_DECL on line 23 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 23 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 23 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 23 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 23 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 23 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    enum Option {
        EditTime,
        SelectTime,
        ForceTime,
        WarnOnInvalid
    };
    typedef QFlags<KTimeComboBox::Option> Options;
    // Modified PARM_DECL on line 53 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KTimeComboBox(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KTimeComboBox();
    QTime time() const;
    bool isValid() const;
    bool isNull() const;
    KTimeComboBox::Options options() const;
    QLocale::FormatType displayFormat() const;
    QTime minimumTime() const;
    void resetMinimumTime();
    QTime maximumTime() const;
    void resetMaximumTime();
    void setTimeRange(const QTime & minTime, const QTime & maxTime, const QString & minWarnMsg = QString(), const QString & maxWarnMsg = QString());
    void resetTimeRange();
    int timeListInterval() const;
    QList<QTime> timeList() const;
Q_SIGNALS:
    void timeEntered(const QTime & time);
    void timeChanged(const QTime & time);
    void timeEdited(const QTime & time);
public Q_SLOTS:
    void setTime(const QTime & time);
    void setOptions(QFlags<KTimeComboBox::Option> options);
    void setDisplayFormat(QLocale::FormatType format);
    void setMinimumTime(const QTime & minTime, const QString & minWarnMsg = QString());
    void setMaximumTime(const QTime & maxTime, const QString & maxWarnMsg = QString());
    void setTimeListInterval(int minutes);
    void setTimeList(QList<QTime> timeList, const QString & minWarnMsg = QString(), const QString & maxWarnMsg = QString());
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
    virtual void assignTime(const QTime & time);
private:
    // Discarded CLASS_DECL on line 320 'KTimeComboBoxPrivate' (by default forward declaration handling)
    private:
        KTimeComboBox(const KTimeComboBox &); // Generated
};
// Discarded FUNCTION_DECL on line 323 'operator|' (by rules_PyKF5.py:FunctionRuleDb[24],function_discard)
// Discarded FUNCTION_DECL on line 323 'operator|' (by rules_PyKF5.py:FunctionRuleDb[24],function_discard)
// Discarded FUNCTION_DECL on line 323 'operator|' (by rules_PyKF5.py:FunctionRuleDb[24],function_discard)
