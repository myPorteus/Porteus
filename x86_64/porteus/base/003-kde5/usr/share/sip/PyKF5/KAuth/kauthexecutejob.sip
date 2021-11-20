namespace KAuth
{
%TypeHeaderCode
#include <kauthexecutejob.h>
%End
    class ExecuteJob: KJob
    {
%TypeHeaderCode
#include <kauthexecutejob.h>
%End
        // Discarded VAR_DECL on line 39 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
        // Discarded CXX_METHOD on line 39 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
        // Discarded CXX_METHOD on line 39 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
        // Discarded CXX_METHOD on line 39 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
        // Discarded CXX_METHOD on line 39 'tr' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
        // Discarded CXX_METHOD on line 39 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
    public:
        virtual ~ExecuteJob();
        virtual void start();
        KAuth::Action action() const;
        QVariantMap data() const;
    public Q_SLOTS:
        bool kill(KJob::KillVerbosity verbosity = KJob::Quietly);
    Q_SIGNALS:
        void newData(const QMap<QString, QVariant> & data);
        void statusChanged(KAuth::Action::AuthStatus status);
    private:
        ExecuteJob(const KAuth::ExecuteJob & __0);
    };
};
