// Discarded CLASS_DECL on line 15 'QString' (by default forward declaration handling)
namespace KShell
{
%TypeHeaderCode
#include <kshell.h>
%End
    enum Option {
        NoOptions,
        TildeExpand,
        AbortOnMeta
    };
    typedef QFlags<KShell::Option> Options;
    // Discarded FUNCTION_DECL on line 73 'operator|' (by rules_PyKF5.py:FunctionRuleDb[25],function_discard)
    // Discarded FUNCTION_DECL on line 73 'operator|' (by rules_PyKF5.py:FunctionRuleDb[25],function_discard)
    // Discarded FUNCTION_DECL on line 73 'operator|' (by rules_PyKF5.py:FunctionRuleDb[25],function_discard)
    enum Errors {
        NoError,
        BadQuoting,
        FoundMeta
    };
    QStringList splitArgs(const QString & cmd, QFlags<KShell::Option> flags = KShell::NoOptions, KShell::Errors*  err = nullptr);
    QString joinArgs(const QStringList & args);
    QString quoteArg(const QString & arg);
    QString tildeExpand(const QString & path);
    QString tildeCollapse(const QString & path);
};
