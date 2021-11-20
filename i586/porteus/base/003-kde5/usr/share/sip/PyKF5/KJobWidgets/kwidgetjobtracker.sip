// Discarded CLASS_DECL on line 16 'KWidgetJobTrackerPrivate' (by default forward declaration handling)
class KWidgetJobTracker: KAbstractWidgetJobTracker
{
%TypeHeaderCode
#include <kwidgetjobtracker.h>
%End
    // Discarded VAR_DECL on line 26 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 26 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 26 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 26 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 26 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 26 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 34 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KWidgetJobTracker(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KWidgetJobTracker();
    virtual QWidget * widget(KJob*  job);
public Q_SLOTS:
    virtual void registerJob(KJob*  job);
    virtual void unregisterJob(KJob*  job);
public:
    bool keepOpen(KJob*  job) const;
protected Q_SLOTS:
    virtual void infoMessage(KJob*  job, const QString & plain, const QString & rich);
    // Discarded CXX_METHOD on line 73 'description' (by Qt5Ruleset.py:FunctionRuleDb[7],function_discard)
    virtual void totalAmount(KJob*  job, KJob::Unit unit, unsigned long long amount);
    virtual void processedAmount(KJob*  job, KJob::Unit unit, unsigned long long amount);
    virtual void percent(KJob*  job, unsigned long percent);
    virtual void speed(KJob*  job, unsigned long value);
    virtual void slotClean(KJob*  job);
    virtual void suspended(KJob*  job);
    virtual void resumed(KJob*  job);
private:
    private:
        KWidgetJobTracker(const KWidgetJobTracker &); // Generated
};
