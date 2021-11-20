// Discarded CLASS_DECL on line 17 'KDirWatchPrivate' (by default forward declaration handling)
class KDirWatch: QObject
{
%TypeHeaderCode
#include <kdirwatch.h>
%End
    // Discarded VAR_DECL on line 58 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 58 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 58 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 58 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 58 'tr' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 58 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
public:
    enum WatchMode {
        WatchDirOnly,
        WatchFiles,
        WatchSubDirs
    };
    typedef QFlags<KDirWatch::WatchMode> WatchModes;
    // Modified PARM_DECL on line 82 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KDirWatch(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KDirWatch();
    void addDir(const QString & path, QFlags<KDirWatch::WatchMode> watchModes = KDirWatch::WatchDirOnly);
    void addFile(const QString & file);
    QDateTime ctime(const QString & path) const;
    void removeDir(const QString & path);
    void removeFile(const QString & file);
    bool stopDirScan(const QString & path);
    bool restartDirScan(const QString & path);
    void startScan(bool notify = false, bool skippedToo = false);
    void stopScan();
    bool isStopped();
    bool contains(const QString & path) const;
    void deleteQFSWatcher();
    static void statistics();
    enum Method {
        FAM,
        INotify,
        Stat,
        QFSWatch
    };
    KDirWatch::Method internalMethod() const;
    static KDirWatch * self();
    static bool exists();
public Q_SLOTS:
    void setCreated(const QString & path);
    void setDirty(const QString & path);
    void setDeleted(const QString & path);
Q_SIGNALS:
    void dirty(const QString & path);
    void created(const QString & path);
    void deleted(const QString & path);
private:
    private:
        KDirWatch(const KDirWatch &); // Generated
};
// Discarded FUNCTION_DECL on line 306 'operator|' (by rules_PyKF5.py:FunctionRuleDb[25],function_discard)
// Discarded FUNCTION_DECL on line 306 'operator|' (by rules_PyKF5.py:FunctionRuleDb[25],function_discard)
// Discarded FUNCTION_DECL on line 306 'operator|' (by rules_PyKF5.py:FunctionRuleDb[25],function_discard)
