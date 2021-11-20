// Discarded CLASS_DECL on line 21 'KUserGroup' (by default forward declaration handling)
// Discarded CLASS_DECL on line 22 'QString' (by default forward declaration handling)
typedef unsigned int K_UID;
typedef unsigned int K_GID;
// Discarded STRUCT_DECL on line 32 'passwd' (by default forward declaration handling)
// Discarded STRUCT_DECL on line 33 'group' (by default forward declaration handling)
// Discarded CLASS_TEMPLATE on line 58 'KUserOrGroupId' (by rules_PyKF5.py:ContainerRuleDb[3],container_discard)
// Modified STRUCT_DECL on line 133 'KUserId' (by rules_PyKF5.py:ContainerRuleDb[0],discard_base):
struct KUserId
{
%TypeHeaderCode
#include <kuser.h>
%End
    KUserId();
    KUserId(unsigned int uid);
    KUserId(const KUserId & other);
    ~KUserId();
    static KUserId fromName(const QString & name);
    static KUserId currentUserId();
    static KUserId currentEffectiveUserId();
};
// Modified STRUCT_DECL on line 168 'KGroupId' (by rules_PyKF5.py:ContainerRuleDb[1],discard_base):
struct KGroupId
{
%TypeHeaderCode
#include <kuser.h>
%End
    KGroupId();
    KGroupId(unsigned int gid);
    KGroupId(const KGroupId & other);
    ~KGroupId();
    static KGroupId fromName(const QString & name);
    static KGroupId currentGroupId();
    static KGroupId currentEffectiveGroupId();
};
uint qHash(const KUserId & id, unsigned int seed = 0);
uint qHash(const KGroupId & id, unsigned int seed = 0);
class KUser
{
%TypeHeaderCode
#include <kuser.h>
%End
public:
    enum UIDMode {
        UseEffectiveUID,
        UseRealUserID
    };
    KUser(KUser::UIDMode mode = KUser::UseEffectiveUID);
    KUser(unsigned int uid);
    KUser(KUserId uid);
    KUser(const QString & name);
    KUser(const char*  name);
    // Discarded CONSTRUCTOR on line 285 'KUser' (by rules_PyKF5.py:FunctionRuleDb[0],function_discard)
    KUser(const KUser & user);
    // Discarded CXX_METHOD on line 299 'operator=' (by rules_PyKF5.py:FunctionRuleDb[10],function_discard)
    bool operator==(const KUser & user) const;
    bool operator!=(const KUser & user) const;
    bool isValid() const;
    KUserId userId() const;
    KGroupId groupId() const;
    K_GID gid() const;
    bool isSuperUser() const;
    QString loginName() const;
    QString fullName() const;
    K_UID uid() const;
    QString homeDir() const;
    QString faceIconPath() const;
    QString shell() const;
    QList<KUserGroup> groups(unsigned int maxCount = KCOREADDONS_UINT_MAX) const;
    QStringList groupNames(unsigned int maxCount = KCOREADDONS_UINT_MAX) const;
    enum UserProperty {
        FullName,
        RoomNumber,
        WorkPhone,
        HomePhone
    };
    QVariant property(KUser::UserProperty which) const;
    ~KUser();
    static QList<KUser> allUsers(unsigned int maxCount = KCOREADDONS_UINT_MAX);
    static QStringList allUserNames(unsigned int maxCount = KCOREADDONS_UINT_MAX);
private:
    // Discarded CLASS_DECL on line 442 'KUserPrivate' (by default forward declaration handling)
};
class KUserGroup
{
%TypeHeaderCode
#include <kuser.h>
%End
public:
    KUserGroup(const QString & name);
    KUserGroup(const char*  name);
    KUserGroup(KGroupId gid);
    KUserGroup(KUser::UIDMode mode = KUser::UseEffectiveUID);
    KUserGroup(unsigned int gid);
    // Discarded CONSTRUCTOR on line 506 'KUserGroup' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
    // Discarded CONSTRUCTOR on line 513 'KUserGroup' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
    // Discarded CXX_METHOD on line 520 'operator=' (by rules_PyKF5.py:FunctionRuleDb[10],function_discard)
    bool operator==(const KUserGroup & group) const;
    bool operator!=(const KUserGroup & group) const;
    bool isValid() const;
    K_GID gid() const;
    KGroupId groupId() const;
    QString name() const;
    QList<KUser> users(unsigned int maxCount = KCOREADDONS_UINT_MAX) const;
    QStringList userNames(unsigned int maxCount = KCOREADDONS_UINT_MAX) const;
    ~KUserGroup();
    static QList<KUserGroup> allGroups(unsigned int maxCount = KCOREADDONS_UINT_MAX);
    static QStringList allGroupNames(unsigned int maxCount = KCOREADDONS_UINT_MAX);
private:
    // Discarded CLASS_DECL on line 596 'KUserGroupPrivate' (by default forward declaration handling)
};
// Discarded CXX_METHOD on line 601 'isValid' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
// Discarded CXX_METHOD on line 606 'operator==' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
// Discarded CXX_METHOD on line 611 'operator!=' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
// Discarded CXX_METHOD on line 616 'nativeId' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
// Discarded CXX_METHOD on line 621 'toString' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
// Discarded CONSTRUCTOR on line 626 'KUserOrGroupId<T>' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
// Discarded CONSTRUCTOR on line 631 'KUserOrGroupId<T>' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
// Discarded CONSTRUCTOR on line 636 'KUserOrGroupId<T>' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
// Discarded CXX_METHOD on line 641 'operator=' (by rules_PyKF5.py:FunctionRuleDb[10],function_discard)
// Discarded DESTRUCTOR on line 647 '~KUserOrGroupId<T>' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
