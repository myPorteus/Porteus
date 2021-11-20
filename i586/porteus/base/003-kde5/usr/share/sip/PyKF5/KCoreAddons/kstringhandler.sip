// Discarded CLASS_DECL on line 19 'QChar' (by default forward declaration handling)
// Discarded CLASS_DECL on line 20 'QRegExp' (by default forward declaration handling)
// Discarded CLASS_DECL on line 21 'QRegularExpression' (by default forward declaration handling)
// Discarded CLASS_DECL on line 22 'QString' (by default forward declaration handling)
namespace KStringHandler
{
%TypeHeaderCode
#include <kstringhandler.h>
%End
    QString capwords(const QString & text);
    QStringList capwords(const QStringList & list);
    QString lsqueeze(const QString & str, int maxlen = 40);
    QString csqueeze(const QString & str, int maxlen = 40);
    QString rsqueeze(const QString & str, int maxlen = 40);
    QStringList perlSplit(const QString & sep, const QString & s, int max = 0);
    QStringList perlSplit(const QChar & sep, const QString & s, int max = 0);
    QStringList perlSplit(const QRegExp & sep, const QString & s, int max = 0);
    QStringList perlSplit(const QRegularExpression & sep, const QString & s, int max = 0);
    QString tagUrls(const QString & text);
    QString obscure(const QString & str);
    bool isUtf8(const char*  str);
    QString from8Bit(const char*  str);
    QString preProcessWrap(const QString & text);
    int logicalLength(const QString & text);
};
