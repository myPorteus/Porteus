class Kdelibs4ConfigMigrator
{
%TypeHeaderCode
#include <kdelibs4configmigrator.h>
%End
public:
    Kdelibs4ConfigMigrator(const QString & appName);
    ~Kdelibs4ConfigMigrator();
    // Discarded CXX_METHOD on line 43 'operator=' (by rules_PyKF5.py:FunctionRuleDb[10],function_discard)
    bool migrate();
    void setConfigFiles(const QStringList & configFileNameList);
    void setUiFiles(const QStringList & uiFileNameList);
private:
    // Discarded CLASS_DECL on line 74 'Kdelibs4ConfigMigratorPrivate' (by default forward declaration handling)
    private:
        Kdelibs4ConfigMigrator(const Kdelibs4ConfigMigrator &); // Generated
};
