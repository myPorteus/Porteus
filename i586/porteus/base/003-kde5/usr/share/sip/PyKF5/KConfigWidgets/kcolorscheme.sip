// Discarded CLASS_DECL on line 18 'QColor' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'QBrush' (by default forward declaration handling)
// Discarded CLASS_DECL on line 21 'KColorSchemePrivate' (by default forward declaration handling)
class KColorScheme
{
%TypeHeaderCode
#include <kcolorscheme.h>
%End
public:
    enum ColorSet {
        View,
        Window,
        Button,
        Selection,
        Tooltip,
        Complementary,
        Header,
        NColorSets
    };
    enum BackgroundRole {
        NormalBackground,
        AlternateBackground,
        ActiveBackground,
        LinkBackground,
        VisitedBackground,
        NegativeBackground,
        NeutralBackground,
        PositiveBackground,
        NBackgroundRoles
    };
    enum ForegroundRole {
        NormalText,
        InactiveText,
        ActiveText,
        LinkText,
        VisitedText,
        NegativeText,
        NeutralText,
        PositiveText,
        NForegroundRoles
    };
    enum DecorationRole {
        FocusColor,
        HoverColor,
        NDecorationRoles
    };
    enum ShadeRole {
        LightShade,
        MidlightShade,
        MidShade,
        DarkShade,
        ShadowShade,
        NShadeRoles
    };
    KColorScheme(const KColorScheme & __0);
    virtual ~KColorScheme();
    // Discarded CXX_METHOD on line 332 'operator=' (by Qt5Ruleset.py:FunctionRuleDb[1],function_discard)
    // Discarded CONSTRUCTOR on line 345 'KColorScheme' (by Qt5Ruleset.py:FunctionRuleDb[11],function_discard)
    QBrush background(KColorScheme::BackgroundRole __0 = KColorScheme::NormalBackground) const;
    QBrush foreground(KColorScheme::ForegroundRole __0 = KColorScheme::NormalText) const;
    QBrush decoration(KColorScheme::DecorationRole __0) const;
    QColor shade(KColorScheme::ShadeRole __0) const;
    static int contrast();
    // Discarded CXX_METHOD on line 391 'contrastF' (by Qt5Ruleset.py:FunctionRuleDb[11],function_discard)
    static QColor shade(const QColor & __0, KColorScheme::ShadeRole __1);
    static QColor shade(const QColor & __0, KColorScheme::ShadeRole __1, double contrast, double chromaAdjust = 0.0);
    // Discarded CXX_METHOD on line 434 'adjustBackground' (by Qt5Ruleset.py:FunctionRuleDb[11],function_discard)
    // Discarded CXX_METHOD on line 449 'adjustForeground' (by Qt5Ruleset.py:FunctionRuleDb[11],function_discard)
    // Discarded CXX_METHOD on line 465 'createApplicationPalette' (by Qt5Ruleset.py:FunctionRuleDb[11],function_discard)
    // Discarded CXX_METHOD on line 478 'isColorSetSupported' (by Qt5Ruleset.py:FunctionRuleDb[11],function_discard)
private:
};
// Discarded STRUCT_DECL on line 484 'QMetaTypeId' (by rules_PyKF5.py:ContainerRuleDb[1],container_discard)
class KStatefulBrush
{
%TypeHeaderCode
#include <kcolorscheme.h>
%End
public:
    KStatefulBrush();
    // Discarded CONSTRUCTOR on line 525 'KStatefulBrush' (by Qt5Ruleset.py:FunctionRuleDb[11],function_discard)
    // Discarded CONSTRUCTOR on line 532 'KStatefulBrush' (by Qt5Ruleset.py:FunctionRuleDb[11],function_discard)
    // Discarded CONSTRUCTOR on line 539 'KStatefulBrush' (by Qt5Ruleset.py:FunctionRuleDb[11],function_discard)
    // Discarded CONSTRUCTOR on line 549 'KStatefulBrush' (by Qt5Ruleset.py:FunctionRuleDb[11],function_discard)
    // Discarded CONSTRUCTOR on line 563 'KStatefulBrush' (by Qt5Ruleset.py:FunctionRuleDb[11],function_discard)
    KStatefulBrush(const KStatefulBrush & __0);
    ~KStatefulBrush();
    // Discarded CXX_METHOD on line 572 'operator=' (by Qt5Ruleset.py:FunctionRuleDb[1],function_discard)
    QBrush brush(QPalette::ColorGroup __0) const;
    QBrush brush(const QPalette & __0) const;
    QBrush brush(const QWidget*  __0) const;
private:
    // Discarded CLASS_DECL on line 600 'KStatefulBrushPrivate' (by default forward declaration handling)
};
// Discarded STRUCT_DECL on line 603 'QMetaTypeId' (by rules_PyKF5.py:ContainerRuleDb[1],container_discard)
