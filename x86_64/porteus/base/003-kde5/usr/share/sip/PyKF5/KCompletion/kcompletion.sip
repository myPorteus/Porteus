// Discarded CLASS_DECL on line 19 'KCompTreeNode' (by default forward declaration handling)
// Discarded CLASS_DECL on line 20 'KCompletionPrivate' (by default forward declaration handling)
// Discarded CLASS_DECL on line 21 'KCompletionMatchesWrapper' (by default forward declaration handling)
// Discarded CLASS_DECL on line 22 'KCompletionMatches' (by default forward declaration handling)
class KCompletion: QObject
{
%TypeHeaderCode
#include <kcompletion.h>
%End
    // Discarded VAR_DECL on line 121 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 121 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 121 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 121 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 121 'tr' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 121 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
public:
    enum CompletionMode {
        CompletionNone,
        CompletionAuto,
        CompletionMan,
        CompletionShell,
        CompletionPopup,
        CompletionPopupAuto
    };
    enum CompOrder {
        Sorted,
        Insertion,
        Weighted
    };
    KCompletion();
    virtual ~KCompletion();
    QStringList substringCompletion(const QString & string) const;
    virtual const QString & lastMatch() const;
    QStringList items() const;
    bool isEmpty() const;
    virtual void setCompletionMode(KCompletion::CompletionMode mode);
    KCompletion::CompletionMode completionMode() const;
    virtual void setOrder(KCompletion::CompOrder order);
    KCompletion::CompOrder order() const;
    virtual void setIgnoreCase(bool ignoreCase);
    bool ignoreCase() const;
    QStringList allMatches();
    QStringList allMatches(const QString & string);
    KCompletionMatches allWeightedMatches();
    KCompletionMatches allWeightedMatches(const QString & string);
    virtual void setSoundsEnabled(bool enable);
    bool soundsEnabled() const;
    bool hasMultipleMatches() const;
public Q_SLOTS:
    virtual QString makeCompletion(const QString & string);
    QString previousMatch();
    QString nextMatch();
    void slotMakeCompletion(const QString & string);
    void slotPreviousMatch();
    void slotNextMatch();
    void insertItems(const QStringList & items);
    virtual void setItems(const QStringList & itemList);
    void addItem(const QString & item);
    void addItem(const QString & item, unsigned int weight);
    void removeItem(const QString & item);
    virtual void clear();
Q_SIGNALS:
    void match(const QString & item);
    void matches(const QStringList & matchlist);
    void multipleMatches();
protected:
    virtual void postProcessMatch(QString*  match) const;
    virtual void postProcessMatches(QStringList*  matchList) const;
    virtual void postProcessMatches(KCompletionMatches*  matches) const;
private:
    KCompletion(const KCompletion & __0);
};
