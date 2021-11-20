// Discarded CLASS_DECL on line 15 'KEMailSettingsPrivate' (by default forward declaration handling)
class KEMailSettings
{
%TypeHeaderCode
#include <kemailsettings.h>
%End
public:
    // Discarded CXX_METHOD on line 30 'tr' (by rules_PyKF5.py:FunctionRuleDb[18],function_discard)
    // Discarded CXX_METHOD on line 30 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[18],function_discard)
private:
public:
    enum Setting {
        ClientProgram,
        ClientTerminal,
        RealName,
        EmailAddress,
        ReplyToAddress,
        Organization,
        OutServer,
        OutServerLogin,
        OutServerPass,
        OutServerType,
        OutServerCommand,
        OutServerTLS,
        InServer,
        InServerLogin,
        InServerPass,
        InServerType,
        InServerMBXType,
        InServerTLS
    };
    enum Extension {
        POP3,
        SMTP,
        OTHER
    };
    KEMailSettings();
    // Discarded CXX_METHOD on line 104 'operator=' (by rules_PyKF5.py:FunctionRuleDb[19],function_discard)
    ~KEMailSettings();
    QStringList profiles() const;
    QString currentProfileName() const;
    void setProfile(const QString & s);
    QString defaultProfileName() const;
    void setDefault(const QString & def);
    QString getSetting(KEMailSettings::Setting s) const;
    void setSetting(KEMailSettings::Setting s, const QString & v);
private:
    private:
        KEMailSettings(const KEMailSettings &); // Generated
};
