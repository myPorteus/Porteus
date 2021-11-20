// Discarded CLASS_DECL on line 24 'KConfigGroup' (by default forward declaration handling)
// Discarded CLASS_DECL on line 25 'KEntryMap' (by default forward declaration handling)
// Discarded CLASS_DECL on line 26 'KConfigPrivate' (by default forward declaration handling)
class KConfig: KConfigBase
{
%TypeHeaderCode
#include <kconfig.h>
%End
public:
    enum OpenFlag {
        IncludeGlobals,
        CascadeConfig,
        SimpleConfig,
        NoCascade,
        NoGlobals,
        FullConfig
    };
    typedef QFlags<KConfig::OpenFlag> OpenFlags;
    KConfig(const QString & file = QString(), QFlags<KConfig::OpenFlag> mode = KConfig::FullConfig, QStandardPaths::StandardLocation type = QStandardPaths::GenericConfigLocation);
    KConfig(const QString & file, const QString & backend, QStandardPaths::StandardLocation type = QStandardPaths::GenericConfigLocation);
    virtual ~KConfig();
    QStandardPaths::StandardLocation locationType() const;
    QString name() const;
    KConfig::OpenFlags openFlags() const;
    virtual bool sync();
    bool isDirty() const;
    virtual void markAsClean();
    virtual KConfigBase::AccessMode accessMode() const;
    bool isConfigWritable(bool warnUser);
    KConfig * copyTo(const QString & file, KConfig*  config = nullptr) const;
    void checkUpdate(const QString & id, const QString & updateFile);
    void reparseConfiguration();
    void addConfigSources(const QStringList & sources);
    QStringList additionalConfigSources() const;
    QString locale() const;
    bool setLocale(const QString & aLocale);
    void setReadDefaults(bool b);
    bool readDefaults() const;
    virtual bool isImmutable() const;
    void setForceGlobal(bool force);
    bool forceGlobal() const;
    virtual QStringList groupList() const;
    QMap<QString, QString> entryMap(const QString & aGroup = QString()) const;
    static void setMainConfigName(const QString & str);
protected:
    virtual bool hasGroupImpl(const QByteArray & group) const;
    virtual KConfigGroup groupImpl(const QByteArray & b);
    // Discarded CXX_METHOD on line 372 'groupImpl' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    virtual void deleteGroupImpl(const QByteArray & group, QFlags<KConfigBase::WriteConfigFlag> flags = KConfigBase::Normal);
    virtual bool isGroupImmutableImpl(const QByteArray & aGroup) const;
    virtual void virtual_hook(int id, void*  data);
    // Discarded FIELD_DECL on line 385 'd_ptr' (by Qt5Ruleset.py:VariableRuleDb[1],variable_discard)
    // Discarded CONSTRUCTOR on line 387 'KConfig' (by rules_PyKF5.py:FunctionRuleDb[31],function_discard)
private:
    KConfig(const KConfig & __0);
};
// Discarded FUNCTION_DECL on line 403 'operator|' (by rules_PyKF5.py:FunctionRuleDb[34],function_discard)
// Discarded FUNCTION_DECL on line 403 'operator|' (by rules_PyKF5.py:FunctionRuleDb[34],function_discard)
// Discarded FUNCTION_DECL on line 403 'operator|' (by rules_PyKF5.py:FunctionRuleDb[34],function_discard)
