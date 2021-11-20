// Discarded CLASS_DECL on line 23 'QCommandLineParser' (by default forward declaration handling)
// Discarded CLASS_DECL on line 24 'QJsonObject' (by default forward declaration handling)
// Discarded CLASS_DECL on line 25 'KAboutData' (by default forward declaration handling)
// Discarded CLASS_DECL on line 26 'KPluginMetaData' (by default forward declaration handling)
namespace KCrash
{
%TypeHeaderCode
#include <kaboutdata.h>
%End
    // Discarded FUNCTION_DECL on line 29 'defaultCrashHandler' (by rules_PyKF5.py:FunctionRuleDb[2],function_discard)
};
class KAboutPerson
{
%TypeHeaderCode
#include <kaboutdata.h>
%End
public:
    // Discarded VAR_DECL on line 58 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 58 'qt_check_for_QGADGET_macro' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    typedef void QtGadgetHelper;
private:
public:
    KAboutPerson(const QString & name = QString(), const QString & task = QString(), const QString & emailAddress = QString(), const QString & webAddress = QString(), const QString & ocsUsername = QString());
    KAboutPerson(const KAboutPerson & other);
    ~KAboutPerson();
    // Discarded CXX_METHOD on line 101 'operator=' (by rules_PyKF5.py:FunctionRuleDb[10],function_discard)
    QString name() const;
    QString task() const;
    QString emailAddress() const;
    QString webAddress() const;
    QString ocsUsername() const;
    static KAboutPerson fromJSON(const QJsonObject & obj);
private:
private:
    // Discarded CLASS_DECL on line 162 'KAboutPersonPrivate' (by default forward declaration handling)
};
class KAboutLicense
{
%TypeHeaderCode
#include <kaboutdata.h>
%End
public:
    // Discarded VAR_DECL on line 177 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 177 'qt_check_for_QGADGET_macro' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    typedef void QtGadgetHelper;
private:
public:
    enum LicenseKey {
        Custom,
        File,
        Unknown,
        GPL,
        GPL_V2,
        LGPL,
        LGPL_V2,
        BSDL,
        Artistic,
        QPL,
        QPL_V1_0,
        GPL_V3,
        LGPL_V3,
        LGPL_V2_1
    };
    enum NameFormat {
        ShortName,
        FullName
    };
    enum VersionRestriction {
        OnlyThisVersion,
        OrLaterVersions
    };
    KAboutLicense();
    KAboutLicense(const KAboutLicense & other);
    ~KAboutLicense();
    // Discarded CXX_METHOD on line 241 'operator=' (by rules_PyKF5.py:FunctionRuleDb[10],function_discard)
    QString text() const;
    QString name(KAboutLicense::NameFormat formatName = KAboutLicense::ShortName) const;
    KAboutLicense::LicenseKey key() const;
    QString spdx() const;
    static KAboutLicense byKeyword(const QString & keyword);
private:
private:
    // Discarded CLASS_DECL on line 331 'KAboutLicensePrivate' (by default forward declaration handling)
};
class KAboutData
{
%TypeHeaderCode
#include <kaboutdata.h>
%End
public:
    // Discarded VAR_DECL on line 397 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 397 'qt_check_for_QGADGET_macro' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    typedef void QtGadgetHelper;
private:
public:
    static KAboutData applicationData();
    static void setApplicationData(const KAboutData & aboutData);
    static void registerPluginData(const KAboutData & aboutData);
    static KAboutData * pluginData(const QString & componentName);
    static KAboutData fromPluginMetaData(const KPluginMetaData & plugin);
public:
    KAboutData(const QString & componentName, const QString & displayName, const QString & version, const QString & shortDescription, KAboutLicense::LicenseKey licenseType, const QString & copyrightStatement = QString(), const QString & otherText = QString(), const QString & homePageAddress = QString(), const QString & bugAddress = QStringLiteral("submit@bugs.kde.org"));
    KAboutData(const QString & componentName = QString(), const QString & displayName = QString(), const QString & version = QString());
    KAboutData(const KAboutData & other);
    // Discarded CXX_METHOD on line 574 'operator=' (by rules_PyKF5.py:FunctionRuleDb[10],function_discard)
    ~KAboutData();
    KAboutData & addAuthor(const QString & name, const QString & task = QString(), const QString & emailAddress = QString(), const QString & webAddress = QString(), const QString & ocsUsername = QString());
    KAboutData & addCredit(const QString & name, const QString & task = QString(), const QString & emailAddress = QString(), const QString & webAddress = QString(), const QString & ocsUsername = QString());
    KAboutData & setTranslator(const QString & name, const QString & emailAddress);
    KAboutData & setLicenseText(const QString & license);
    KAboutData & addLicenseText(const QString & license);
    KAboutData & setLicenseTextFile(const QString & file);
    KAboutData & addLicenseTextFile(const QString & file);
    KAboutData & setComponentName(const QString & componentName);
    KAboutData & setDisplayName(const QString & displayName);
    KAboutData & setProgramIconName(const QString & iconName);
    KAboutData & setProgramLogo(const QVariant & image);
    KAboutData & setOcsProvider(const QString & providerUrl);
    KAboutData & setVersion(const QByteArray & version);
    KAboutData & setShortDescription(const QString & shortDescription);
    KAboutData & setLicense(KAboutLicense::LicenseKey licenseKey);
    KAboutData & setLicense(KAboutLicense::LicenseKey licenseKey, KAboutLicense::VersionRestriction versionRestriction);
    KAboutData & addLicense(KAboutLicense::LicenseKey licenseKey);
    KAboutData & addLicense(KAboutLicense::LicenseKey licenseKey, KAboutLicense::VersionRestriction versionRestriction);
    KAboutData & setCopyrightStatement(const QString & copyrightStatement);
    KAboutData & setOtherText(const QString & otherText);
    KAboutData & setHomepage(const QString & homepage);
    KAboutData & setBugAddress(const QByteArray & bugAddress);
    KAboutData & setOrganizationDomain(const QByteArray & domain);
    KAboutData & setProductName(const QByteArray & name);
    QString componentName() const;
    QString productName() const;
    const char * internalProductName() const;
    QString displayName() const;
    QString organizationDomain() const;
    const char * internalProgramName() const;
    QString programIconName() const;
    QVariant programLogo() const;
    QString ocsProviderUrl() const;
    QString version() const;
    const char * internalVersion() const;
    QString shortDescription() const;
    QString homepage() const;
    QString bugAddress() const;
    const char * internalBugAddress() const;
    QList<KAboutPerson> authors() const;
    QList<KAboutPerson> credits() const;
    QList<KAboutPerson> translators() const;
    static QString aboutTranslationTeam();
    QString otherText() const;
    QList<KAboutLicense> licenses() const;
    QString copyrightStatement() const;
    QString customAuthorPlainText() const;
    QString customAuthorRichText() const;
    bool customAuthorTextEnabled() const;
    KAboutData & setCustomAuthorText(const QString & plainText, const QString & richText);
    KAboutData & unsetCustomAuthorText();
    bool setupCommandLine(QCommandLineParser*  parser);
    void processCommandLine(QCommandLineParser*  parser);
    KAboutData & setDesktopFileName(const QString & desktopFileName);
    QString desktopFileName() const;
private:
private:
    // Discarded CLASS_DECL on line 1180 'KAboutDataPrivate' (by default forward declaration handling)
};
// Discarded STRUCT_DECL on line 1183 'QMetaTypeId' (by rules_PyKF5.py:ContainerRuleDb[2],container_discard)
// Discarded STRUCT_DECL on line 1184 'QMetaTypeId' (by rules_PyKF5.py:ContainerRuleDb[2],container_discard)
// Discarded STRUCT_DECL on line 1185 'QMetaTypeId' (by rules_PyKF5.py:ContainerRuleDb[2],container_discard)
