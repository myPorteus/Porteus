// Discarded CLASS_DECL on line 19 'Kdelibs4MigrationPrivate' (by default forward declaration handling)
class Kdelibs4Migration
{
%TypeHeaderCode
#include <kdelibs4migration.h>
%End
public:
    Kdelibs4Migration();
    ~Kdelibs4Migration();
    // Discarded CXX_METHOD on line 75 'operator=' (by rules_PyKF5.py:FunctionRuleDb[10],function_discard)
    bool kdeHomeFound() const;
    QString kdeHome() const;
    QString locateLocal(const char*  type, const QString & filename) const;
    QString saveLocation(const char*  type, const QString & suffix = QString()) const;
private:
    private:
        Kdelibs4Migration(const Kdelibs4Migration &); // Generated
};
