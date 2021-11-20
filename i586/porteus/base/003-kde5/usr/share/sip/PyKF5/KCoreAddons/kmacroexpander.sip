// Discarded CLASS_DECL on line 18 'QString' (by default forward declaration handling)
// Discarded CLASS_TEMPLATE on line 19 'QHash' (by default forward declaration handling)
// Discarded CLASS_DECL on line 21 'KMacroExpanderBasePrivate' (by default forward declaration handling)
class KMacroExpanderBase
{
%TypeHeaderCode
#include <kmacroexpander.h>
%End
public:
    KMacroExpanderBase(QChar c = QLatin1Char('%'));
    virtual ~KMacroExpanderBase();
    void expandMacros(QString & str);
    // Discarded CXX_METHOD on line 100 'expandMacrosShellQuote' (by rules_PyKF5.py:FunctionRuleDb[5],function_discard)
    bool expandMacrosShellQuote(QString & str);
    void setEscapeChar(QChar c);
    QChar escapeChar() const;
protected:
    virtual int expandPlainMacro(const QString & str, int pos, QStringList & ret);
    virtual int expandEscapedMacro(const QString & str, int pos, QStringList & ret);
private:
    private:
        KMacroExpanderBase(const KMacroExpanderBase &); // Generated
};
class KWordMacroExpander: KMacroExpanderBase
{
%TypeHeaderCode
#include <kmacroexpander.h>
%End
public:
    KWordMacroExpander(QChar c = QLatin1Char('%'));
protected:
    virtual int expandPlainMacro(const QString & str, int pos, QStringList & ret);
    virtual int expandEscapedMacro(const QString & str, int pos, QStringList & ret);
    virtual bool expandMacro(const QString & str, QStringList & ret) = 0;
};
class KCharMacroExpander: KMacroExpanderBase
{
%TypeHeaderCode
#include <kmacroexpander.h>
%End
public:
    KCharMacroExpander(QChar c = QLatin1Char('%'));
protected:
    virtual int expandPlainMacro(const QString & str, int pos, QStringList & ret);
    virtual int expandEscapedMacro(const QString & str, int pos, QStringList & ret);
    virtual bool expandMacro(QChar chr, QStringList & ret) = 0;
};
namespace KMacroExpander
{
%TypeHeaderCode
#include <kmacroexpander.h>
%End
    QString expandMacros(const QString & str, const QHash<QChar, QString> & map, QChar c = QLatin1Char('%'));
    QString expandMacrosShellQuote(const QString & str, const QHash<QChar, QString> & map, QChar c = QLatin1Char('%'));
    QString expandMacros(const QString & str, const QHash<QString, QString> & map, QChar c = QLatin1Char('%'));
    QString expandMacrosShellQuote(const QString & str, const QHash<QString, QString> & map, QChar c = QLatin1Char('%'));
    QString expandMacros(const QString & str, const QHash<QChar, QStringList> & map, QChar c = QLatin1Char('%'));
    QString expandMacros(const QString & str, const QHash<QString, QStringList> & map, QChar c = QLatin1Char('%'));
    QString expandMacrosShellQuote(const QString & str, const QHash<QChar, QStringList> & map, QChar c = QLatin1Char('%'));
    QString expandMacrosShellQuote(const QString & str, const QHash<QString, QStringList> & map, QChar c = QLatin1Char('%'));
};
