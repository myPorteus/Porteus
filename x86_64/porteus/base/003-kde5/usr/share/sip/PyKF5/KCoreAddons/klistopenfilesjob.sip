// Discarded CLASS_DECL on line 23 'KListOpenFilesJobPrivate' (by default forward declaration handling)
class KListOpenFilesJob: KJob
{
%TypeHeaderCode
#include <klistopenfilesjob.h>
%End
    // Discarded VAR_DECL on line 39 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 39 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 39 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 39 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 39 'tr' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 39 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
public:
    KListOpenFilesJob(const QString & path);
    virtual ~KListOpenFilesJob();
    virtual void start();
    KProcessList::KProcessInfoList processInfoList() const;
public:
    enum class Error {
        NotSupported,
        InternalError,
        DoesNotExist
    };
private:
    private:
        KListOpenFilesJob(const KListOpenFilesJob &); // Generated
};
