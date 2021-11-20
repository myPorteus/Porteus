namespace KProcessList
{
%TypeHeaderCode
#include <kprocesslist.h>
%End
    // Discarded CLASS_DECL on line 20 'KProcessInfoPrivate' (by default forward declaration handling)
    class KProcessInfo
    {
%TypeHeaderCode
#include <kprocesslist.h>
%End
    public:
        KProcessInfo();
        KProcessInfo(long long pid, const QString & command, const QString & user);
        KProcessInfo(long long pid, const QString & command, const QString & name, const QString & user);
        KProcessInfo(const KProcessList::KProcessInfo & other);
        ~KProcessInfo();
        // Discarded CXX_METHOD on line 36 'operator=' (by rules_PyKF5.py:FunctionRuleDb[10],function_discard)
        bool isValid() const;
        qint64 pid() const;
        QString name() const;
        QString user() const;
        QString command() const;
    private:
    };
    typedef QList<KProcessList::KProcessInfo> KProcessInfoList;
    KProcessList::KProcessInfoList processInfoList();
    KProcessList::KProcessInfo processInfo(long long pid);
};
