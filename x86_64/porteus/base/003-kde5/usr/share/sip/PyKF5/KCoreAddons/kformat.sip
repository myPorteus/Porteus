// Discarded CLASS_DECL on line 22 'QDate' (by default forward declaration handling)
// Discarded CLASS_DECL on line 23 'QDateTime' (by default forward declaration handling)
// Discarded CLASS_DECL on line 25 'KFormatPrivate' (by default forward declaration handling)
class KFormat
{
%TypeHeaderCode
#include <kformat.h>
%End
public:
    // Discarded VAR_DECL on line 60 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 60 'qt_check_for_QGADGET_macro' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    typedef void QtGadgetHelper;
private:
public:
    enum BinarySizeUnits {
        DefaultBinaryUnits,
        UnitByte,
        UnitKiloByte,
        UnitMegaByte,
        UnitGigaByte,
        UnitTeraByte,
        UnitPetaByte,
        UnitExaByte,
        UnitZettaByte,
        UnitYottaByte,
        UnitLastUnit
    };
    enum class Unit {
        Other,
        Bit,
        Byte,
        Meter,
        Hertz
    };
    enum class UnitPrefix {
        AutoAdjust,
        Yocto,
        Zepto,
        Atto,
        Femto,
        Pico,
        Nano,
        Micro,
        Milli,
        Centi,
        Deci,
        Unity,
        Deca,
        Hecto,
        Kilo,
        Mega,
        Giga,
        Tera,
        Peta,
        Exa,
        Zetta,
        Yotta
    };
    enum BinaryUnitDialect {
        DefaultBinaryDialect,
        IECBinaryDialect,
        JEDECBinaryDialect,
        MetricBinaryDialect,
        LastBinaryDialect
    };
    enum DurationFormatOption {
        DefaultDuration,
        InitialDuration,
        ShowMilliseconds,
        HideSeconds,
        FoldHours
    };
    typedef QFlags<KFormat::DurationFormatOption> DurationFormatOptions;
    KFormat(const QLocale & locale = QLocale());
    KFormat(const KFormat & other);
    // Discarded CXX_METHOD on line 208 'operator=' (by rules_PyKF5.py:FunctionRuleDb[10],function_discard)
    ~KFormat();
    QString formatByteSize(double size, int precision = 1, KFormat::BinaryUnitDialect dialect = KFormat::DefaultBinaryDialect, KFormat::BinarySizeUnits units = KFormat::DefaultBinaryUnits) const;
    QString formatDuration(unsigned long long msecs, QFlags<KFormat::DurationFormatOption> options = KFormat::DefaultDuration) const;
    QString formatDecimalDuration(unsigned long long msecs, int decimalPlaces = 2) const;
    QString formatSpelloutDuration(unsigned long long msecs) const;
    QString formatRelativeDate(const QDate & date, QLocale::FormatType format) const;
    QString formatRelativeDateTime(const QDateTime & dateTime, QLocale::FormatType format) const;
    QString formatValue(double value, KFormat::Unit unit, int precision = 1, KFormat::UnitPrefix prefix = KFormat::UnitPrefix::AutoAdjust, KFormat::BinaryUnitDialect dialect = KFormat::DefaultBinaryDialect) const;
    QString formatValue(double value, const QString & unit, int precision = 1, KFormat::UnitPrefix prefix = KFormat::UnitPrefix::AutoAdjust) const;
    QString formatValue(double value, const QString & unit, int precision, KFormat::UnitPrefix prefix, KFormat::BinaryUnitDialect dialect) const;
private:
};
