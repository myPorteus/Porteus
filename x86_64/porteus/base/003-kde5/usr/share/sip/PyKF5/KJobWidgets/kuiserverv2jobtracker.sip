// Discarded CLASS_DECL on line 14 'KJob' (by default forward declaration handling)
// Discarded CLASS_DECL on line 15 'KUiServerV2JobTrackerPrivate' (by default forward declaration handling)
class KUiServerV2JobTracker: KJobTrackerInterface
{
%TypeHeaderCode
#include <kuiserverv2jobtracker.h>
%End
    // Discarded VAR_DECL on line 26 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 26 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 26 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 26 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 26 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 26 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 34 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KUiServerV2JobTracker(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KUiServerV2JobTracker();
    virtual void registerJob(KJob*  job);
    virtual void unregisterJob(KJob*  job);
protected Q_SLOTS:
    virtual void finished(KJob*  job);
    virtual void suspended(KJob*  job);
    virtual void resumed(KJob*  job);
    // Discarded CXX_METHOD on line 62 'description' (by Qt5Ruleset.py:FunctionRuleDb[7],function_discard)
    virtual void infoMessage(KJob*  job, const QString & plain, const QString & rich);
    virtual void totalAmount(KJob*  job, KJob::Unit unit, unsigned long long amount);
    virtual void processedAmount(KJob*  job, KJob::Unit unit, unsigned long long amount);
    virtual void percent(KJob*  job, unsigned long percent);
    virtual void speed(KJob*  job, unsigned long value);
private:
    private:
        KUiServerV2JobTracker(const KUiServerV2JobTracker &); // Generated
};
