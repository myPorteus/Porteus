// Discarded CLASS_DECL on line 24 'KEncodingProberPrivate' (by default forward declaration handling)
class KEncodingProber
{
%TypeHeaderCode
#include <kencodingprober.h>
%End
public:
    // Discarded CXX_METHOD on line 61 'tr' (by rules_PyKF5.py:FunctionRuleDb[11],function_discard)
    // Discarded CXX_METHOD on line 61 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[11],function_discard)
private:
public:
    enum ProberState {
        FoundIt,
        NotMe,
        Probing
    };
    enum ProberType {
        None,
        Universal,
        Arabic,
        Baltic,
        CentralEuropean,
        ChineseSimplified,
        ChineseTraditional,
        Cyrillic,
        Greek,
        Hebrew,
        Japanese,
        Korean,
        NorthernSaami,
        Other,
        SouthEasternEurope,
        Thai,
        Turkish,
        Unicode,
        WesternEuropean
    };
    KEncodingProber(KEncodingProber::ProberType proberType = KEncodingProber::Universal);
    ~KEncodingProber();
    // Discarded CXX_METHOD on line 100 'operator=' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
    void reset();
    KEncodingProber::ProberState feed(const QByteArray & data);
    KEncodingProber::ProberState feed(const char*  data, int len);
    KEncodingProber::ProberState state() const;
    QByteArray encoding() const;
    float confidence() const;
    KEncodingProber::ProberType proberType() const;
    void setProberType(KEncodingProber::ProberType proberType);
    static KEncodingProber::ProberType proberTypeForName(const QString & lang);
    static QString nameForProberType(KEncodingProber::ProberType proberType);
private:
    private:
        KEncodingProber(const KEncodingProber &); // Generated
};
