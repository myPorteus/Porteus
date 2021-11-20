// Discarded CLASS_TEMPLATE on line 28 'QHash' (by default forward declaration handling)
// Discarded CLASS_DECL on line 31 'QByteArray' (by default forward declaration handling)
// Discarded CLASS_DECL on line 32 'QIODevice' (by default forward declaration handling)
namespace KCodecs
{
%TypeHeaderCode
#include <kcodecs.h>
%End
    QByteArray quotedPrintableEncode(const QByteArray & in, bool useCRLF = true);
    void quotedPrintableEncode(const QByteArray & in, QByteArray & out, bool useCRLF);
    QByteArray quotedPrintableDecode(const QByteArray & in);
    void quotedPrintableDecode(const QByteArray & in, QByteArray & out);
    QByteArray uuencode(const QByteArray & in);
    void uuencode(const QByteArray & in, QByteArray & out);
    QByteArray uudecode(const QByteArray & in);
    void uudecode(const QByteArray & in, QByteArray & out);
    QByteArray base64Encode(const QByteArray & in);
    QByteArray base64Encode(const QByteArray & in, bool insertLFs);
    void base64Encode(const QByteArray & in, QByteArray & out, bool insertLFs = false);
    QByteArray base64Decode(const QByteArray & in);
    void base64Decode(const QByteArray & in, QByteArray & out);
    QString decodeRFC2047String(const QString & text);
    enum CharsetOption {
        NoOption,
        ForceDefaultCharset
    };
    QString decodeRFC2047String(const QByteArray & src, QByteArray*  usedCS, const QByteArray & defaultCS = QByteArray(), KCodecs::CharsetOption option = KCodecs::NoOption);
    QByteArray encodeRFC2047String(const QString & src, const QByteArray & charset);
    // Discarded CLASS_DECL on line 330 'Encoder' (by default forward declaration handling)
    // Discarded CLASS_DECL on line 331 'EncoderPrivate' (by default forward declaration handling)
    // Discarded CLASS_DECL on line 332 'Decoder' (by default forward declaration handling)
    // Discarded CLASS_DECL on line 333 'DecoderPrivate' (by default forward declaration handling)
// Modified CLASS_DECL on line 374 'Codec' (by rules_PyKF5.py:ContainerRuleDb[2],container_mark_abstract):
    class Codec /Abstract/
    {
%TypeHeaderCode
#include <kcodecs.h>
%End
    public:
        enum NewlineType {
            NewlineLF,
            NewlineCRLF
        };
        static KCodecs::Codec * codecForName(const char*  name);
        static KCodecs::Codec * codecForName(const QByteArray & name);
        virtual int maxEncodedSizeFor(int insize, KCodecs::Codec::NewlineType newline = KCodecs::Codec::NewlineLF) const = 0;
        virtual int maxDecodedSizeFor(int insize, KCodecs::Codec::NewlineType newline = KCodecs::Codec::NewlineLF) const = 0;
        virtual KCodecs::Encoder * makeEncoder(KCodecs::Codec::NewlineType newline = KCodecs::Codec::NewlineLF) const = 0;
        virtual KCodecs::Decoder * makeDecoder(KCodecs::Codec::NewlineType newline = KCodecs::Codec::NewlineLF) const = 0;
        // Discarded CXX_METHOD on line 470 'encode' (by rules_PyKF5.py:FunctionRuleDb[0],function_discard)
        // Discarded CXX_METHOD on line 508 'decode' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
        virtual QByteArray encode(const QByteArray & src, KCodecs::Codec::NewlineType newline = KCodecs::Codec::NewlineLF) const;
        virtual QByteArray decode(const QByteArray & src, KCodecs::Codec::NewlineType newline = KCodecs::Codec::NewlineLF) const;
        virtual const char * name() const = 0;
        virtual ~Codec();
    protected:
        Codec();
    };
// Modified CLASS_DECL on line 637 'Decoder' (by rules_PyKF5.py:ContainerRuleDb[1],container_mark_abstract):
    class Decoder /Abstract/
    {
%TypeHeaderCode
#include <kcodecs.h>
%End
    protected:
        Decoder(KCodecs::Codec::NewlineType newline = KCodecs::Codec::NewlineLF);
    public:
        virtual ~Decoder();
        // Discarded CXX_METHOD on line 666 'decode' (by rules_PyKF5.py:FunctionRuleDb[7],function_discard)
        // Discarded CXX_METHOD on line 676 'finish' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    protected:
        // Discarded FIELD_DECL on line 680 'd' (by Qt5Ruleset.py:VariableRuleDb[2],variable_discard)
    private:
        Decoder(const KCodecs::Decoder &); // Generated
    };
// Modified CLASS_DECL on line 693 'Encoder' (by rules_PyKF5.py:ContainerRuleDb[0],container_mark_abstract):
    class Encoder /Abstract/
    {
%TypeHeaderCode
#include <kcodecs.h>
%End
    protected:
        Encoder(KCodecs::Codec::NewlineType newline = KCodecs::Codec::NewlineLF);
    public:
        virtual ~Encoder();
        // Discarded CXX_METHOD on line 721 'encode' (by rules_PyKF5.py:FunctionRuleDb[2],function_discard)
        // Discarded CXX_METHOD on line 730 'finish' (by rules_PyKF5.py:FunctionRuleDb[3],function_discard)
    protected:
        enum  {
            maxBufferedChars
        };
        // Discarded CXX_METHOD on line 750 'write' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
        // Discarded CXX_METHOD on line 762 'flushOutputBuffer' (by rules_PyKF5.py:FunctionRuleDb[6],function_discard)
        // Discarded CXX_METHOD on line 771 'writeCRLF' (by rules_PyKF5.py:FunctionRuleDb[5],function_discard)
    protected:
        // Discarded FIELD_DECL on line 775 'd' (by Qt5Ruleset.py:VariableRuleDb[2],variable_discard)
    private:
        Encoder(const KCodecs::Encoder &); // Generated
    };
};
