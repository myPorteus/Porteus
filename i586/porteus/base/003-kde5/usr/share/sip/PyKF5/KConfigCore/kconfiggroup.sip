// Discarded CLASS_DECL on line 22 'KConfig' (by default forward declaration handling)
// Discarded CLASS_DECL on line 23 'KConfigGroupPrivate' (by default forward declaration handling)
// Discarded CLASS_DECL on line 24 'KSharedConfig' (by default forward declaration handling)
class KConfigGroup: KConfigBase
{
%TypeHeaderCode
#include <kconfiggroup.h>
%End
public:
    KConfigGroup();
    // Discarded CONSTRUCTOR on line 56 'KConfigGroup' (by rules_PyKF5.py:FunctionRuleDb[7],function_discard)
    // Discarded CONSTRUCTOR on line 62 'KConfigGroup' (by rules_PyKF5.py:FunctionRuleDb[7],function_discard)
    // Discarded CONSTRUCTOR on line 72 'KConfigGroup' (by rules_PyKF5.py:FunctionRuleDb[7],function_discard)
    // Discarded CONSTRUCTOR on line 78 'KConfigGroup' (by rules_PyKF5.py:FunctionRuleDb[7],function_discard)
    // Discarded CONSTRUCTOR on line 81 'KConfigGroup' (by rules_PyKF5.py:FunctionRuleDb[29],function_discard)
    // Discarded CONSTRUCTOR on line 87 'KConfigGroup' (by rules_PyKF5.py:FunctionRuleDb[29],function_discard)
    KConfigGroup(const KConfigGroup & __0);
    // Discarded CXX_METHOD on line 93 'operator=' (by rules_PyKF5.py:FunctionRuleDb[19],function_discard)
    virtual ~KConfigGroup();
    bool isValid() const;
    QString name() const;
    bool exists() const;
    virtual bool sync();
    virtual void markAsClean();
    virtual KConfigBase::AccessMode accessMode() const;
    KConfig * config();
    // Discarded CXX_METHOD on line 141 'config' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    void changeGroup(const QString & group);
    void changeGroup(const char*  group);
    void copyTo(KConfigBase*  other, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal) const;
    void // Modified PARM_DECL on line 195 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    reparent(KConfigBase*  parent /TransferThis/, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    // Discarded CXX_METHOD on line 205 'parent' (by rules_PyKF5.py:FunctionRuleDb[11],function_discard)
    virtual QStringList groupList() const;
    QStringList keyList() const;
    void deleteGroup(QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    // Discarded FUNCTION_TEMPLATE on line 249 'readEntry' (by rules_PyKF5.py:FunctionRuleDb[21],function_discard)
    // Discarded FUNCTION_TEMPLATE on line 258 'readEntry' (by rules_PyKF5.py:FunctionRuleDb[21],function_discard)
    QVariant readEntry(const QString & key, const QVariant & aDefault) const;
    QVariant readEntry(const char*  key, const QVariant & aDefault) const;
    QString readEntry(const QString & key, const QString & aDefault) const;
    QString readEntry(const char*  key, const QString & aDefault) const;
    QString readEntry(const QString & key, const char*  aDefault = nullptr) const;
    QString readEntry(const char*  key, const char*  aDefault = nullptr) const;
    QVariantList readEntry(const QString & key, const QList<QVariant> & aDefault) const;
    QVariantList readEntry(const char*  key, const QList<QVariant> & aDefault) const;
    QStringList readEntry(const QString & key, const QStringList & aDefault) const;
    QStringList readEntry(const char*  key, const QStringList & aDefault) const;
    // Discarded FUNCTION_TEMPLATE on line 343 'readEntry' (by rules_PyKF5.py:FunctionRuleDb[21],function_discard)
    // Discarded FUNCTION_TEMPLATE on line 352 'readEntry' (by rules_PyKF5.py:FunctionRuleDb[21],function_discard)
    QStringList readXdgListEntry(const QString & pKey, const QStringList & aDefault = QStringList()) const;
    QStringList readXdgListEntry(const char*  key, const QStringList & aDefault = QStringList()) const;
    QString readPathEntry(const QString & pKey, const QString & aDefault) const;
    QString readPathEntry(const char*  key, const QString & aDefault) const;
    QStringList readPathEntry(const QString & pKey, const QStringList & aDefault) const;
    QStringList readPathEntry(const char*  key, const QStringList & aDefault) const;
    QString readEntryUntranslated(const QString & pKey, const QString & aDefault = QString()) const;
    QString readEntryUntranslated(const char*  key, const QString & aDefault = QString()) const;
    void writeEntry(const QString & key, const QVariant & value, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    void writeEntry(const char*  key, const QVariant & value, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    void writeEntry(const QString & key, const QString & value, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    void writeEntry(const char*  key, const QString & value, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    void writeEntry(const QString & key, const QByteArray & value, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    void writeEntry(const char*  key, const QByteArray & value, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    void writeEntry(const QString & key, const char*  value, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    void writeEntry(const char*  key, const char*  value, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    // Discarded FUNCTION_TEMPLATE on line 468 'writeEntry' (by rules_PyKF5.py:FunctionRuleDb[21],function_discard)
    // Discarded FUNCTION_TEMPLATE on line 471 'writeEntry' (by rules_PyKF5.py:FunctionRuleDb[21],function_discard)
    void writeEntry(const QString & key, const QStringList & value, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    void writeEntry(const char*  key, const QStringList & value, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    void writeEntry(const QString & key, const QList<QVariant> & value, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    void writeEntry(const char*  key, const QList<QVariant> & value, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    // Discarded FUNCTION_TEMPLATE on line 494 'writeEntry' (by rules_PyKF5.py:FunctionRuleDb[21],function_discard)
    // Discarded FUNCTION_TEMPLATE on line 503 'writeEntry' (by rules_PyKF5.py:FunctionRuleDb[21],function_discard)
    void writeXdgListEntry(const QString & pKey, const QStringList & value, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    void writeXdgListEntry(const char*  key, const QStringList & value, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    void writePathEntry(const QString & pKey, const QString & path, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    void writePathEntry(const char*  Key, const QString & path, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    void writePathEntry(const QString & pKey, const QStringList & value, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    void writePathEntry(const char*  key, const QStringList & value, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    void deleteEntry(const QString & pKey, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    void deleteEntry(const char*  key, QFlags<KConfigBase::WriteConfigFlag> pFlags = KConfigBase::Normal);
    bool hasKey(const QString & key) const;
    bool hasKey(const char*  key) const;
    virtual bool isImmutable() const;
    bool isEntryImmutable(const QString & key) const;
    bool isEntryImmutable(const char*  key) const;
    void revertToDefault(const QString & key);
    void revertToDefault(const QString & key, QFlags<KConfigBase::WriteConfigFlag> pFlag);
    void revertToDefault(const char*  key);
    void revertToDefault(const char*  key, QFlags<KConfigBase::WriteConfigFlag> pFlag);
    bool hasDefault(const QString & key) const;
    bool hasDefault(const char*  key) const;
    QMap<QString, QString> entryMap() const;
protected:
    virtual bool hasGroupImpl(const QByteArray & group) const;
    // Discarded CXX_METHOD on line 704 'groupImpl' (by rules_PyKF5.py:FunctionRuleDb[11],function_discard)
    virtual const KConfigGroup groupImpl(const QByteArray & b) const;
    virtual void deleteGroupImpl(const QByteArray & group, QFlags<KConfigBase::WriteConfigFlag> flags);
    virtual bool isGroupImmutableImpl(const QByteArray & aGroup) const;
private:
};
