// Discarded CLASS_DECL on line 18 'KProcessPrivate' (by default forward declaration handling)
class KProcess: QProcess
{
%TypeHeaderCode
#include <kprocess.h>
%End
    // Discarded VAR_DECL on line 35 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 35 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 35 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 35 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 35 'tr' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 35 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
public:
    enum OutputChannelMode {
        SeparateChannels,
        MergedChannels,
        ForwardedChannels,
        OnlyStdoutChannel,
        OnlyStderrChannel
    };
    // Modified PARM_DECL on line 61 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KProcess(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KProcess();
    void setOutputChannelMode(KProcess::OutputChannelMode mode);
    KProcess::OutputChannelMode outputChannelMode() const;
    void setNextOpenMode(QFlags<QIODevice::OpenModeFlag> mode);
    void setEnv(const QString & name, const QString & value, bool overwrite = true);
    void unsetEnv(const QString & name);
    void clearEnvironment();
    void setProgram(const QString & exe, const QStringList & args = QStringList());
    void setProgram(const QStringList & argv);
    KProcess & operator<<(const QString & arg);
    KProcess & operator<<(const QStringList & args);
    void clearProgram();
    void setShellCommand(const QString & cmd);
    QStringList program() const;
    void start();
    int execute(int msecs = -1);
    static int execute(const QString & exe, const QStringList & args = QStringList(), int msecs = -1);
    static int execute(const QStringList & argv, int msecs = -1);
    int startDetached();
    static int startDetached(const QString & exe, const QStringList & args = QStringList());
    static int startDetached(const QStringList & argv);
    int pid() const;
protected:
    // Discarded CONSTRUCTOR on line 315 'KProcess' (by rules_PyKF5.py:FunctionRuleDb[22],function_discard)
    // Discarded FIELD_DECL on line 320 'd_ptr' (by Qt5Ruleset.py:VariableRuleDb[1],variable_discard)
private:
    private:
        KProcess(const KProcess &); // Generated
};
