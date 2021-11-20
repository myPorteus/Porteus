// Discarded CLASS_DECL on line 19 'KJobUiDelegate' (by default forward declaration handling)
// Discarded CLASS_DECL on line 21 'KJobPrivate' (by default forward declaration handling)
class KJob: QObject
{
%TypeHeaderCode
#include <kjob.h>
%End
    // Discarded VAR_DECL on line 78 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 78 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 78 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 78 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 78 'tr' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 78 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
public:
    enum Unit {
        Bytes,
        Files,
        Directories,
        Items
    };
    enum Capability {
        NoCapabilities,
        Killable,
        Suspendable
    };
    typedef QFlags<KJob::Capability> Capabilities;
    // Modified PARM_DECL on line 120 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KJob(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KJob();
    void setUiDelegate(KJobUiDelegate*  delegate);
    KJobUiDelegate * uiDelegate() const;
    KJob::Capabilities capabilities() const;
    bool isSuspended() const;
    virtual void start() = 0;
    enum KillVerbosity {
        Quietly,
        EmitResult
    };
public Q_SLOTS:
    bool kill(KJob::KillVerbosity verbosity = KJob::Quietly);
    bool suspend();
    bool resume();
protected:
    virtual bool doKill();
    virtual bool doSuspend();
    virtual bool doResume();
    void setCapabilities(QFlags<KJob::Capability> capabilities);
public:
    bool exec();
    enum  {
        NoError,
        KilledJobError,
        UserDefinedError
    };
    int error() const;
    QString errorText() const;
    virtual QString errorString() const;
    qulonglong processedAmount(KJob::Unit unit) const;
    qulonglong totalAmount(KJob::Unit unit) const;
    unsigned long percent() const;
    void setAutoDelete(bool autodelete);
    bool isAutoDelete() const;
Q_SIGNALS:
    // Discarded CXX_METHOD on line 388 'finished' (by rules_PyKF5.py:FunctionRuleDb[11],function_discard)
    // Discarded CXX_METHOD on line 403 'suspended' (by rules_PyKF5.py:FunctionRuleDb[11],function_discard)
    // Discarded CXX_METHOD on line 418 'resumed' (by rules_PyKF5.py:FunctionRuleDb[11],function_discard)
    // Discarded CXX_METHOD on line 441 'result' (by rules_PyKF5.py:FunctionRuleDb[11],function_discard)
    // Discarded CXX_METHOD on line 461 'description' (by rules_PyKF5.py:FunctionRuleDb[16],function_discard)
    void infoMessage(KJob*  job, const QString & plain, const QString & rich = QString());
    void warning(KJob*  job, const QString & plain, const QString & rich = QString());
Q_SIGNALS:
    void totalAmount(KJob*  job, KJob::Unit unit, unsigned long long amount);
    // Discarded CXX_METHOD on line 521 'totalAmountChanged' (by rules_PyKF5.py:FunctionRuleDb[11],function_discard)
    void processedAmount(KJob*  job, KJob::Unit unit, unsigned long long amount);
    // Discarded CXX_METHOD on line 561 'processedAmountChanged' (by rules_PyKF5.py:FunctionRuleDb[11],function_discard)
    void totalSize(KJob*  job, unsigned long long size);
    void processedSize(KJob*  job, unsigned long long size);
    void percent(KJob*  job, unsigned long percent);
    // Discarded CXX_METHOD on line 628 'percentChanged' (by rules_PyKF5.py:FunctionRuleDb[11],function_discard)
    void speed(KJob*  job, unsigned long speed);
protected:
    bool isFinished() const;
    void setError(int errorCode);
    void setErrorText(const QString & errorText);
    void setProcessedAmount(KJob::Unit unit, unsigned long long amount);
    void setTotalAmount(KJob::Unit unit, unsigned long long amount);
    void setProgressUnit(KJob::Unit unit);
    void setPercent(unsigned long percentage);
    void emitResult();
    void emitPercent(unsigned long long processedAmount, unsigned long long totalAmount);
    void emitSpeed(unsigned long speed);
protected:
    // Discarded FIELD_DECL on line 763 'd_ptr' (by Qt5Ruleset.py:VariableRuleDb[1],variable_discard)
    // Discarded CONSTRUCTOR on line 764 'KJob' (by rules_PyKF5.py:FunctionRuleDb[22],function_discard)
private:
    private:
        KJob(const KJob &); // Generated
};
// Discarded STRUCT_DECL on line 773 'QMetaTypeId' (by rules_PyKF5.py:ContainerRuleDb[2],container_discard)
// Discarded FUNCTION_DECL on line 774 'operator|' (by rules_PyKF5.py:FunctionRuleDb[25],function_discard)
// Discarded FUNCTION_DECL on line 774 'operator|' (by rules_PyKF5.py:FunctionRuleDb[25],function_discard)
// Discarded FUNCTION_DECL on line 774 'operator|' (by rules_PyKF5.py:FunctionRuleDb[25],function_discard)
