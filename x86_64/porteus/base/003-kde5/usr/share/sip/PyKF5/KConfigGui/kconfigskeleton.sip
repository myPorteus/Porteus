class KConfigSkeleton: KCoreConfigSkeleton
{
%TypeHeaderCode
#include <kconfigskeleton.h>
%End
    // Discarded VAR_DECL on line 30 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 30 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[18],function_discard)
    // Discarded CXX_METHOD on line 30 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[18],function_discard)
    // Discarded CXX_METHOD on line 30 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[18],function_discard)
    // Discarded CXX_METHOD on line 30 'tr' (by rules_PyKF5.py:FunctionRuleDb[18],function_discard)
    // Discarded CXX_METHOD on line 30 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[18],function_discard)
public:
// Modified CLASS_DECL on line 35 'ItemColor' (by rules_PyKF5.py:ContainerRuleDb[17],set_skeleton_item_base_gui):
    class ItemColor: KConfigSkeletonItem
    {
%TypeHeaderCode
#include <kconfigskeleton.h>
%End
    public:
        ItemColor(const QString & _group, const QString & _key, QColor & reference, const QColor & defaultValue = QColor(128,128,128));
        virtual void readConfig(KConfig*  config);
        virtual void setProperty(const QVariant & p);
        virtual bool isEqual(const QVariant & p) const;
        virtual QVariant property() const;
    };
// Modified CLASS_DECL on line 57 'ItemFont' (by rules_PyKF5.py:ContainerRuleDb[18],set_skeleton_item_base_gui):
    class ItemFont: KConfigSkeletonItem
    {
%TypeHeaderCode
#include <kconfigskeleton.h>
%End
    public:
        ItemFont(const QString & _group, const QString & _key, QFont & reference, const QFont & defaultValue = QFont());
        virtual void readConfig(KConfig*  config);
        virtual void setProperty(const QVariant & p);
        virtual bool isEqual(const QVariant & p) const;
        virtual QVariant property() const;
    };
public:
    // Modified PARM_DECL on line 83 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KConfigSkeleton(const QString & configname = QString(), QObject*  parent /TransferThis/ = nullptr);
    // Discarded CONSTRUCTOR on line 90 'KConfigSkeleton' (by rules_PyKF5.py:FunctionRuleDb[29],function_discard)
    KConfigSkeleton::ItemColor * addItemColor(const QString & name, QColor & reference, const QColor & defaultValue = QColor(128,128,128), const QString & key = QString());
    KConfigSkeleton::ItemFont * addItemFont(const QString & name, QFont & reference, const QFont & defaultValue = QFont(), const QString & key = QString());
    private:
        KConfigSkeleton(const KConfigSkeleton &); // Generated
};
