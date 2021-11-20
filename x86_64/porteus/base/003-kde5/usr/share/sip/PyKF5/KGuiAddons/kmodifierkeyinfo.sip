// Discarded CLASS_DECL on line 15 'KModifierKeyInfoProvider' (by default forward declaration handling)
class KModifierKeyInfo: QObject
{
%TypeHeaderCode
#include <kmodifierkeyinfo.h>
%End
    // Discarded VAR_DECL on line 37 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 37 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 37 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 37 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 37 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 37 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 43 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KModifierKeyInfo(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KModifierKeyInfo();
    bool knowsKey(Qt::Key key) const;
    const QList<Qt::Key> knownKeys() const;
    bool isKeyPressed(Qt::Key key) const;
    bool isKeyLatched(Qt::Key key) const;
    bool setKeyLatched(Qt::Key key, bool latched);
    bool isKeyLocked(Qt::Key key) const;
    bool setKeyLocked(Qt::Key key, bool locked);
    bool isButtonPressed(Qt::MouseButton button) const;
Q_SIGNALS:
    void keyPressed(Qt::Key key, bool pressed);
    void keyLatched(Qt::Key key, bool latched);
    void keyLocked(Qt::Key key, bool locked);
    void buttonPressed(Qt::MouseButton button, bool pressed);
    void keyAdded(Qt::Key key);
    void keyRemoved(Qt::Key key);
private:
    KModifierKeyInfo(const KModifierKeyInfo & __0);
};
