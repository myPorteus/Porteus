class KOSRelease
{
%TypeHeaderCode
#include <kosrelease.h>
%End
public:
    KOSRelease(const QString & filePath = QString());
    ~KOSRelease();
    QString name() const;
    QString version() const;
    QString id() const;
    QStringList idLike() const;
    QString versionCodename() const;
    QString versionId() const;
    QString prettyName() const;
    QString ansiColor() const;
    QString cpeName() const;
    QString homeUrl() const;
    QString documentationUrl() const;
    QString supportUrl() const;
    QString bugReportUrl() const;
    QString privacyPolicyUrl() const;
    QString buildId() const;
    QString variant() const;
    QString variantId() const;
    QString logo() const;
    QStringList extraKeys() const;
    QString extraValue(const QString & key) const;
private:
    KOSRelease(const KOSRelease & __0);
    // Discarded CLASS_DECL on line 92 'KOSReleasePrivate' (by default forward declaration handling)
};
