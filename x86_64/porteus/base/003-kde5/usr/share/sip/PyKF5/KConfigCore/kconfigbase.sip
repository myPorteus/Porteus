// Discarded CLASS_DECL on line 19 'KConfigGroup' (by default forward declaration handling)
// Discarded CLASS_DECL on line 20 'KConfigBasePrivate' (by default forward declaration handling)
// Modified CLASS_DECL on line 30 'KConfigBase' (by rules_PyKF5.py:ContainerRuleDb[0],container_mark_abstract):
class KConfigBase /Abstract/
{
%TypeHeaderCode
#include <kconfigbase.h>
%End
public:
    enum WriteConfigFlag {
        Persistent,
        Global,
        Localized,
        Notify,
        Normal
    };
    typedef QFlags<KConfigBase::WriteConfigFlag> WriteConfigFlags;
    virtual ~KConfigBase();
    virtual QStringList groupList() const = 0;
    bool hasGroup(const QString & group) const;
    bool hasGroup(const char*  group) const;
    bool hasGroup(const QByteArray & group) const;
    KConfigGroup group(const QString & group);
    // Discarded CXX_METHOD on line 114 'group' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
    // Discarded CXX_METHOD on line 120 'group' (by rules_PyKF5.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 125 'group' (by rules_PyKF5.py:FunctionRuleDb[2],function_discard)
    // Discarded CXX_METHOD on line 131 'group' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
    // Discarded CXX_METHOD on line 137 'group' (by rules_PyKF5.py:FunctionRuleDb[0],function_discard)
    void deleteGroup(const QString & group, QFlags<KConfigBase::WriteConfigFlag> flags = KConfigBase::Normal);
    void deleteGroup(const QByteArray & group, QFlags<KConfigBase::WriteConfigFlag> flags = KConfigBase::Normal);
    void deleteGroup(const char*  group, QFlags<KConfigBase::WriteConfigFlag> flags = KConfigBase::Normal);
    virtual bool sync() = 0;
    virtual void markAsClean() = 0;
    enum AccessMode {
        NoAccess,
        ReadOnly,
        ReadWrite
    };
    virtual KConfigBase::AccessMode accessMode() const = 0;
    virtual bool isImmutable() const = 0;
    bool isGroupImmutable(const QString & group) const;
    bool isGroupImmutable(const QByteArray & group) const;
    bool isGroupImmutable(const char*  group) const;
protected:
    KConfigBase();
    virtual bool hasGroupImpl(const QByteArray & group) const = 0;
    virtual KConfigGroup groupImpl(const QByteArray & group) = 0;
    // Discarded CXX_METHOD on line 229 'groupImpl' (by rules_PyKF5.py:FunctionRuleDb[3],function_discard)
    virtual void deleteGroupImpl(const QByteArray & group, QFlags<KConfigBase::WriteConfigFlag> flags = KConfigBase::Normal) = 0;
    virtual bool isGroupImmutableImpl(const QByteArray & group) const = 0;
    virtual void virtual_hook(int id, void*  data);
};
// Discarded FUNCTION_DECL on line 241 'operator|' (by rules_PyKF5.py:FunctionRuleDb[34],function_discard)
// Discarded FUNCTION_DECL on line 241 'operator|' (by rules_PyKF5.py:FunctionRuleDb[34],function_discard)
// Discarded FUNCTION_DECL on line 241 'operator|' (by rules_PyKF5.py:FunctionRuleDb[34],function_discard)
