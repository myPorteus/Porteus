// Discarded CLASS_DECL on line 16 'QFont' (by default forward declaration handling)
class KFontChooser: QWidget
{
%TypeHeaderCode
#include <kfontchooser.h>
%End
    // Discarded VAR_DECL on line 36 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 36 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 36 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 36 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 36 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 36 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    enum FontColumn {
        FamilyList,
        StyleList,
        SizeList
    };
    enum FontDiff {
        NoFontDiffFlags,
        FontDiffFamily,
        FontDiffStyle,
        FontDiffSize,
        AllFontDiffs
    };
    typedef QFlags<KFontChooser::FontDiff> FontDiffFlags;
    enum DisplayFlag {
        NoDisplayFlags,
        FixedFontsOnly,
        DisplayFrame,
        ShowDifferences
    };
    typedef QFlags<KFontChooser::DisplayFlag> DisplayFlags;
    // Discarded CONSTRUCTOR on line 114 'KFontChooser' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
    virtual ~KFontChooser();
    void enableColumn(int column, bool state);
    void setFont(const QFont & font, bool onlyFixed = false);
    KFontChooser::FontDiffFlags fontDiffFlags() const;
    QFont font() const;
    void setColor(const QColor & col);
    QColor color() const;
    void setBackgroundColor(const QColor & col);
    QColor backgroundColor() const;
    void setSizeIsRelative(Qt::CheckState relative);
    Qt::CheckState sizeIsRelative() const;
    QString sampleText() const;
    void setSampleText(const QString & text);
    void setSampleBoxVisible(bool visible);
    enum FontListCriteria {
        FixedWidthFonts,
        ScalableFonts,
        SmoothScalableFonts
    };
    static void getFontList(QStringList & list, unsigned int fontListCriteria);
    virtual QSize sizeHint() const;
Q_SIGNALS:
    void fontSelected(const QFont & font);
private:
    // Discarded CLASS_DECL on line 262 'KFontChooserPrivate' (by default forward declaration handling)
    // Discarded CONSTRUCTOR on line 264 'KFontChooser' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
};
// Discarded FUNCTION_DECL on line 267 'operator|' (by rules_PyKF5.py:FunctionRuleDb[24],function_discard)
// Discarded FUNCTION_DECL on line 267 'operator|' (by rules_PyKF5.py:FunctionRuleDb[24],function_discard)
// Discarded FUNCTION_DECL on line 267 'operator|' (by rules_PyKF5.py:FunctionRuleDb[24],function_discard)
