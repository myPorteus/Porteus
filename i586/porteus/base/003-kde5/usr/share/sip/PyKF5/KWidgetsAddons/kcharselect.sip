// Discarded CLASS_DECL on line 16 'QFont' (by default forward declaration handling)
// Discarded CLASS_DECL on line 17 'QUrl' (by default forward declaration handling)
class KCharSelect: QWidget
{
%TypeHeaderCode
#include <kcharselect.h>
%End
    // Discarded VAR_DECL on line 63 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 63 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 63 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 63 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 63 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 63 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    enum Control {
        SearchLine,
        FontCombo,
        FontSize,
        BlockCombos,
        CharacterTable,
        DetailBrowser,
        HistoryButtons,
        AllGuiElements
    };
    typedef QFlags<KCharSelect::Control> Controls;
    // Modified PARM_DECL on line 123 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KCharSelect(QWidget*  parent /TransferThis/, const QFlags<KCharSelect::Control> controls = KCharSelect::AllGuiElements);
    // Modified PARM_DECL on line 143 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KCharSelect(QWidget*  parent /TransferThis/, QObject*  actionParent, const QFlags<KCharSelect::Control> controls = KCharSelect::AllGuiElements);
    virtual ~KCharSelect();
    virtual QSize sizeHint() const;
    void setAllPlanesEnabled(bool all);
    bool allPlanesEnabled() const;
    QChar currentChar() const;
    uint currentCodePoint() const;
    QFont currentFont() const;
    QList<QChar> displayedChars() const;
    QVector<uint> displayedCodePoints() const;
public Q_SLOTS:
    void setCurrentChar(const QChar & c);
    void setCurrentCodePoint(unsigned int codePoint);
    void setCurrentFont(const QFont & font);
Q_SIGNALS:
    void currentFontChanged(const QFont & font);
    void currentCharChanged(const QChar & c);
    void currentCodePointChanged(unsigned int codePoint);
    void displayedCharsChanged();
    void charSelected(const QChar & c);
    void codePointSelected(unsigned int codePoint);
private:
private:
    // Discarded CLASS_DECL on line 279 'KCharSelectPrivate' (by default forward declaration handling)
    private:
        KCharSelect(const KCharSelect &); // Generated
};
// Discarded FUNCTION_DECL on line 282 'operator|' (by rules_PyKF5.py:FunctionRuleDb[24],function_discard)
// Discarded FUNCTION_DECL on line 282 'operator|' (by rules_PyKF5.py:FunctionRuleDb[24],function_discard)
// Discarded FUNCTION_DECL on line 282 'operator|' (by rules_PyKF5.py:FunctionRuleDb[24],function_discard)
