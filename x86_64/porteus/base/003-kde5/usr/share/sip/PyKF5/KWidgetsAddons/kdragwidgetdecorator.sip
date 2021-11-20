// Discarded CLASS_DECL on line 18 'QDrag' (by default forward declaration handling)
class KDragWidgetDecoratorBase: QObject
{
%TypeHeaderCode
#include <kdragwidgetdecorator.h>
%End
    // Discarded VAR_DECL on line 32 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 32 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 32 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 32 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 32 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 32 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 39 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KDragWidgetDecoratorBase(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KDragWidgetDecoratorBase();
    void setDragEnabled(bool enable);
    bool isDragEnabled() const;
protected:
    QWidget * decoratedWidget() const;
    virtual QDrag * dragObject();
    virtual bool eventFilter(QObject*  watched, QEvent*  event);
    virtual void startDrag();
private:
    // Discarded CLASS_DECL on line 81 'KDragWidgetDecoratorBasePrivate' (by default forward declaration handling)
    private:
        KDragWidgetDecoratorBase(const KDragWidgetDecoratorBase &); // Generated
};
// Discarded CLASS_TEMPLATE on line 95 'KDragWidgetDecorator' (by rules_PyKF5.py:ContainerRuleDb[3],container_discard)
