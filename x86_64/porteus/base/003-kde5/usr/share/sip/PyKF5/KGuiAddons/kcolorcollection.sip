class KColorCollection
{
%TypeHeaderCode
#include <kcolorcollection.h>
%End
public:
    static QStringList installedCollections();
    KColorCollection(const QString & name = QString());
    KColorCollection(const KColorCollection & __0);
    ~KColorCollection();
    // Discarded CXX_METHOD on line 61 'operator=' (by Qt5Ruleset.py:FunctionRuleDb[1],function_discard)
    bool save();
    QString description() const;
    void setDescription(const QString & desc);
    QString name() const;
    void setName(const QString & name);
    enum Editable {
        Yes,
        No,
        Ask
    };
    KColorCollection::Editable editable() const;
    void setEditable(KColorCollection::Editable editable);
    int count() const;
    QColor color(int index) const;
    int findColor(const QColor & color) const;
    QString name(int index) const;
    QString name(const QColor & color) const;
    int addColor(const QColor & newColor, const QString & newColorName = QString());
    int changeColor(int index, const QColor & newColor, const QString & newColorName = QString());
    int changeColor(const QColor & oldColor, const QColor & newColor, const QString & newColorName = QString());
private:
    // Discarded CLASS_DECL on line 188 'KColorCollectionPrivate' (by default forward declaration handling)
};
