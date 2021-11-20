namespace KBackup
{
%TypeHeaderCode
#include <kbackup.h>
%End
    bool backupFile(const QString & filename, const QString & backupDir = QString());
    bool simpleBackupFile(const QString & filename, const QString & backupDir = QString(), const QString & backupExtension = QStringLiteral("~"));
    bool numberedBackupFile(const QString & filename, const QString & backupDir = QString(), const QString & backupExtension = QStringLiteral("~"), const unsigned int maxBackups = 10);
    bool rcsBackupFile(const QString & filename, const QString & backupDir = QString(), const QString & backupMessage = QString());
};
