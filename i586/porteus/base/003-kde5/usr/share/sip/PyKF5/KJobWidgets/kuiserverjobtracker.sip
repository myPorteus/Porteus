// Discarded CLASS_DECL on line 14 'KJob' (by default forward declaration handling)
class KUiServerJobTracker: KJobTrackerInterface
{
%TypeHeaderCode
#include <kuiserverjobtracker.h>
%End
    // Discarded VAR_DECL on line 23 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 23 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 23 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 23 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 23 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 23 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 31 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KUiServerJobTracker(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KUiServerJobTracker();
    virtual void registerJob(KJob*  job);
    virtual void unregisterJob(KJob*  job);
protected Q_SLOTS:
    virtual void finished(KJob*  job);
    virtual void suspended(KJob*  job);
    virtual void resumed(KJob*  job);
    // Discarded CXX_METHOD on line 59 'description' (by Qt5Ruleset.py:FunctionRuleDb[7],function_discard)
    virtual void infoMessage(KJob*  job, const QString & plain, const QString & rich);
    virtual void totalAmount(KJob*  job, KJob::Unit unit, unsigned long long amount);
    virtual void processedAmount(KJob*  job, KJob::Unit unit, unsigned long long amount);
    virtual void percent(KJob*  job, unsigned long percent);
    virtual void speed(KJob*  job, unsigned long value);
private:
    private:
        KUiServerJobTracker(const KUiServerJobTracker &); // Generated
};
