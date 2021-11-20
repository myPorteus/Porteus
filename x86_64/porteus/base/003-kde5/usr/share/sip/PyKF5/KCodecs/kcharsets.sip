// Discarded CLASS_DECL on line 16 'KCharsets' (by default forward declaration handling)
// Discarded CLASS_DECL on line 17 'KCharsetsPrivate' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'QChar' (by default forward declaration handling)
// Discarded CLASS_DECL on line 20 'QString' (by default forward declaration handling)
// Discarded CLASS_DECL on line 21 'QStringList' (by default forward declaration handling)
// Discarded CLASS_DECL on line 22 'QTextCodec' (by default forward declaration handling)
class KCharsets
{
%TypeHeaderCode
#include <kcharsets.h>
%End
public:
    // Discarded CXX_METHOD on line 35 'tr' (by rules_PyKF5.py:FunctionRuleDb[11],function_discard)
    // Discarded CXX_METHOD on line 35 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[11],function_discard)
private:
protected:
    KCharsets();
public:
    virtual ~KCharsets();
    QTextCodec * codecForName(const QString & name) const;
    // Discarded CXX_METHOD on line 69 'codecForName' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    static KCharsets * charsets();
    static QChar fromEntity(const QString & str);
    // Discarded CXX_METHOD on line 96 'fromEntity' (by rules_PyKF5.py:FunctionRuleDb[10],function_discard)
    static QString toEntity(const QChar & ch);
    static QString resolveEntities(const QString & text);
    QStringList availableEncodingNames() const;
    QStringList descriptiveEncodingNames() const;
    QList<QStringList> encodingsByScript() const;
    QString descriptionForEncoding(const QString & encoding) const;
    QString encodingForName(const QString & descriptiveName) const;
private:
private:
    private:
        KCharsets(const KCharsets &); // Generated
};
