// Discarded CLASS_DECL on line 17 'KCompositeJobPrivate' (by default forward declaration handling)
class KCompositeJob: KJob
{
%TypeHeaderCode
#include <kcompositejob.h>
%End
    // Discarded VAR_DECL on line 26 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 26 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 26 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 26 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 26 'tr' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 26 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
public:
    // Modified PARM_DECL on line 34 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KCompositeJob(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KCompositeJob();
protected:
    virtual bool addSubjob(KJob*  job);
    virtual bool removeSubjob(KJob*  job);
    bool hasSubjobs() const;
    const QList<KJob *> & subjobs() const;
    void clearSubjobs();
protected Q_SLOTS:
    virtual void slotResult(KJob*  job);
    virtual void slotInfoMessage(KJob*  job, const QString & plain, const QString & rich);
protected:
    // Discarded CONSTRUCTOR on line 107 'KCompositeJob' (by rules_PyKF5.py:FunctionRuleDb[22],function_discard)
private:
    private:
        KCompositeJob(const KCompositeJob &); // Generated
};
