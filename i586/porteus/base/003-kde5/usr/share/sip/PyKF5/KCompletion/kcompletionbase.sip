// Discarded CLASS_DECL on line 17 'KCompletionBasePrivate' (by default forward declaration handling)
class KCompletionBase
{
%TypeHeaderCode
#include <kcompletionbase.h>
%End
public:
    // Discarded CXX_METHOD on line 39 'd_func' (by rules_PyKF5.py:FunctionRuleDb[19],function_discard)
    // Discarded CXX_METHOD on line 39 'd_func' (by rules_PyKF5.py:FunctionRuleDb[19],function_discard)
    enum KeyBindingType {
        TextCompletion,
        PrevCompletionMatch,
        NextCompletionMatch,
        SubstringCompletion
    };
    typedef QMap<KCompletionBase::KeyBindingType, QList<QKeySequence>> KeyBindingMap;
    KCompletionBase();
    virtual ~KCompletionBase();
    KCompletion * completionObject(bool handleSignals = true);
    virtual void setCompletionObject(KCompletion*  completionObject, bool handleSignals = true);
    virtual void setHandleSignals(bool handle);
    bool isCompletionObjectAutoDeleted() const;
    void setAutoDeleteCompletionObject(bool autoDelete);
    void setEnableSignals(bool enable);
    bool handleSignals() const;
    bool emitSignals() const;
    void setEmitSignals(bool emitRotationSignals);
    virtual void setCompletionMode(KCompletion::CompletionMode mode);
    KCompletion::CompletionMode completionMode() const;
    bool setKeyBinding(KCompletionBase::KeyBindingType item, const QList<QKeySequence> & key);
    QList<QKeySequence> keyBinding(KCompletionBase::KeyBindingType item) const;
    QList<QKeySequence> getKeyBinding(KCompletionBase::KeyBindingType item) const;
    void useGlobalKeyBindings();
    virtual void setCompletedText(const QString & text) = 0;
    virtual void setCompletedItems(const QStringList & items, bool autoSuggest = true) = 0;
    KCompletion * compObj() const;
protected:
    // Discarded CXX_METHOD on line 325 'keyBindingMap' (by rules_PyKF5.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 332 'getKeyBindings' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
    // Discarded CXX_METHOD on line 343 'setKeyBindingMap' (by rules_PyKF5.py:FunctionRuleDb[2],function_discard)
    void setDelegate(KCompletionBase*  delegate);
    KCompletionBase * delegate() const;
    virtual void virtual_hook(int id, void*  data);
private:
    KCompletionBase(const KCompletionBase & __0);
};
