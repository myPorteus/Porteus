// Discarded CLASS_DECL on line 16 'QTextCodec' (by default forward declaration handling)
class KCodecAction: KSelectAction
{
%TypeHeaderCode
#include <kcodecaction.h>
%End
    // Discarded VAR_DECL on line 27 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 27 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 27 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 27 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 27 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 27 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 33 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KCodecAction(QObject*  parent /TransferThis/, bool showAutoOptions = false);
    // Modified PARM_DECL on line 35 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KCodecAction(const QString & text, QObject*  parent /TransferThis/, bool showAutoOptions = false);
    // Modified PARM_DECL on line 37 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KCodecAction(const QIcon & icon, const QString & text, QObject*  parent /TransferThis/, bool showAutoOptions = false);
    virtual ~KCodecAction();
public:
    int mibForName(const QString & codecName, bool*  ok = nullptr) const;
    QTextCodec * codecForMib(int mib) const;
    QTextCodec * currentCodec() const;
    bool setCurrentCodec(QTextCodec*  codec);
    QString currentCodecName() const;
    bool setCurrentCodec(const QString & codecName);
    int currentCodecMib() const;
    bool setCurrentCodec(int mib);
    KEncodingProber::ProberType currentProberType() const;
    bool setCurrentProberType(KEncodingProber::ProberType __0);
Q_SIGNALS:
    void triggered(QTextCodec*  codec);
    void codecTriggered(QTextCodec*  codec);
    void triggered(KEncodingProber::ProberType __0);
    void encodingProberTriggered(KEncodingProber::ProberType __0);
    void defaultItemTriggered();
protected Q_SLOTS:
    virtual void actionTriggered(QAction*  __0);
protected:
private:
    // Discarded CLASS_DECL on line 156 'KCodecActionPrivate' (by default forward declaration handling)
    private:
        KCodecAction(const KCodecAction &); // Generated
};
