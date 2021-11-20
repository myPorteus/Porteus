// Discarded CLASS_DECL on line 18 'ConfigLoaderPrivate' (by default forward declaration handling)
class KConfigLoader: KConfigSkeleton
{
%TypeHeaderCode
#include <kconfigloader.h>
%End
public:
    // Modified PARM_DECL on line 99 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KConfigLoader(const QString & configFile, QIODevice*  xml, QObject*  parent /TransferThis/ = nullptr);
    // Discarded CONSTRUCTOR on line 109 'KConfigLoader' (by rules_PyKF5.py:FunctionRuleDb[29],function_discard)
    // Modified PARM_DECL on line 119 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KConfigLoader(const KConfigGroup & config, QIODevice*  xml, QObject*  parent /TransferThis/ = nullptr);
    virtual ~KConfigLoader();
    KConfigSkeletonItem * findItem(const QString & group, const QString & key) const;
    KConfigSkeletonItem * findItemByName(const QString & name) const;
    QVariant property(const QString & name) const;
    bool hasGroup(const QString & group) const;
    QStringList groupList() const;
protected:
    virtual bool usrWriteConfig();
private:
    private:
        KConfigLoader(const KConfigLoader &); // Generated
};
