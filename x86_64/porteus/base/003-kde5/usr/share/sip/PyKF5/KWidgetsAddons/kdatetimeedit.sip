class KDateTimeEdit: QWidget
{
%TypeHeaderCode
#include <kdatetimeedit.h>
%End
    // Discarded VAR_DECL on line 24 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 24 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 24 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 24 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 24 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 24 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    enum Option {
        ShowCalendar,
        ShowDate,
        ShowTime,
        ShowTimeZone,
        EditDate,
        EditTime,
        SelectCalendar,
        SelectDate,
        SelectTime,
        SelectTimeZone,
        DatePicker,
        DateKeywords,
        ForceTime,
        WarnOnInvalid
    };
    typedef QFlags<KDateTimeEdit::Option> Options;
    // Modified PARM_DECL on line 65 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KDateTimeEdit(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KDateTimeEdit();
    KDateTimeEdit::Options options() const;
    QDateTime dateTime() const;
    QDate date() const;
    QTime time() const;
    QTimeZone timeZone() const;
    QList<QLocale> calendarLocalesList() const;
    QDateTime minimumDateTime() const;
    QDateTime maximumDateTime() const;
    QLocale::FormatType dateDisplayFormat() const;
    QMap<QDate, QString> dateMap() const;
    QLocale::FormatType timeDisplayFormat() const;
    int timeListInterval() const;
    QList<QTime> timeList() const;
    QList<QTimeZone> timeZones() const;
    bool isValid() const;
    bool isNull() const;
    bool isValidDate() const;
    bool isNullDate() const;
    bool isValidTime() const;
    bool isNullTime() const;
Q_SIGNALS:
    void dateTimeEntered(const QDateTime & dateTime);
    void dateTimeChanged(const QDateTime & dateTime);
    void dateTimeEdited(const QDateTime & dateTime);
    void calendarEntered(const QLocale & calendarLocale);
    void calendarChanged(const QLocale & calendarLocale);
    void dateEntered(const QDate & date);
    void dateChanged(const QDate & date);
    void dateEdited(const QDate & date);
    void timeEntered(const QTime & time);
    void timeChanged(const QTime & time);
    void timeEdited(const QTime & time);
    void timeZoneEntered(const QTimeZone & zone);
    void timeZoneChanged(const QTimeZone & zone);
public Q_SLOTS:
    void setOptions(QFlags<KDateTimeEdit::Option> options);
    void setDateTime(const QDateTime & dateTime);
    void setDate(const QDate & date);
    void setTime(const QTime & time);
    void setTimeZone(const QTimeZone & zone);
    void setDateTimeRange(const QDateTime & minDateTime, const QDateTime & maxDateTime, const QString & minWarnMsg = QString(), const QString & maxWarnMsg = QString());
    void resetDateTimeRange();
    void setMinimumDateTime(const QDateTime & minDateTime, const QString & minWarnMsg = QString());
    void resetMinimumDateTime();
    void setMaximumDateTime(const QDateTime & maxDateTime, const QString & maxWarnMsg = QString());
    void resetMaximumDateTime();
    void setDateDisplayFormat(QLocale::FormatType format);
    void setCalendarLocalesList(const QList<QLocale> & calendarLocales);
    void setDateMap(QMap<QDate, QString> dateMap);
    void setTimeDisplayFormat(QLocale::FormatType format);
    void setTimeListInterval(int minutes);
    void setTimeList(QList<QTime> timeList, const QString & minWarnMsg = QString(), const QString & maxWarnMsg = QString());
    void setTimeZones(const QList<QTimeZone> & zones);
protected:
    virtual bool eventFilter(QObject*  object, QEvent*  event);
    virtual void focusInEvent(QFocusEvent*  event);
    virtual void focusOutEvent(QFocusEvent*  event);
    virtual void resizeEvent(QResizeEvent*  event);
    virtual void assignDateTime(const QDateTime & dateTime);
    virtual void assignDate(const QDate & date);
    virtual void assignTime(const QTime & time);
    void assignTimeZone(const QTimeZone & zone);
private:
    // Discarded CLASS_DECL on line 591 'KDateTimeEditPrivate' (by default forward declaration handling)
    private:
        KDateTimeEdit(const KDateTimeEdit &); // Generated
};
// Discarded FUNCTION_DECL on line 594 'operator|' (by rules_PyKF5.py:FunctionRuleDb[24],function_discard)
// Discarded FUNCTION_DECL on line 594 'operator|' (by rules_PyKF5.py:FunctionRuleDb[24],function_discard)
// Discarded FUNCTION_DECL on line 594 'operator|' (by rules_PyKF5.py:FunctionRuleDb[24],function_discard)
