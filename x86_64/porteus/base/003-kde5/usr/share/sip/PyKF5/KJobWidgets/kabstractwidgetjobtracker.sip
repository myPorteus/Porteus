// Discarded CLASS_DECL on line 18 'KJob' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'QWidget' (by default forward declaration handling)
// Discarded CLASS_DECL on line 20 'KAbstractWidgetJobTrackerPrivate' (by default forward declaration handling)
class KAbstractWidgetJobTracker: KJobTrackerInterface
{
%TypeHeaderCode
#include <kabstractwidgetjobtracker.h>
%End
    // Discarded VAR_DECL on line 29 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 29 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 29 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 29 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 29 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 29 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 37 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KAbstractWidgetJobTracker(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KAbstractWidgetJobTracker();
public Q_SLOTS:
    virtual void registerJob(KJob*  job);
    virtual void unregisterJob(KJob*  job);
public:
    virtual QWidget * widget(KJob*  job) = 0;
    void setStopOnClose(KJob*  job, bool stopOnClose);
    bool stopOnClose(KJob*  job) const;
    void setAutoDelete(KJob*  job, bool autoDelete);
    bool autoDelete(KJob*  job) const;
protected Q_SLOTS:
    virtual void finished(KJob*  job);
    virtual void slotStop(KJob*  job);
    virtual void slotSuspend(KJob*  job);
    virtual void slotResume(KJob*  job);
    virtual void slotClean(KJob*  job);
Q_SIGNALS:
    void stopped(KJob*  job);
    void suspend(KJob*  job);
    void resume(KJob*  job);
protected:
    // Discarded CONSTRUCTOR on line 178 'KAbstractWidgetJobTracker' (by Qt5Ruleset.py:FunctionRuleDb[13],function_discard)
protected:
    // Discarded FIELD_DECL on line 183 'd' (by Qt5Ruleset.py:VariableRuleDb[2],variable_discard)
private:
    private:
        KAbstractWidgetJobTracker(const KAbstractWidgetJobTracker &); // Generated
};
