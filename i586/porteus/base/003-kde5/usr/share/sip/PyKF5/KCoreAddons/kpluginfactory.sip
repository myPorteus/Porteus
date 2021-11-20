// Discarded CLASS_DECL on line 23 'QWidget' (by default forward declaration handling)
// Discarded CLASS_DECL on line 25 'KPluginFactoryPrivate' (by default forward declaration handling)
namespace KParts
{
%TypeHeaderCode
#include <kpluginfactory.h>
%End
    // Discarded CLASS_DECL on line 28 'Part' (by default forward declaration handling)
};
// Discarded CLASS_DECL on line 30 'KPluginMetaData' (by default forward declaration handling)
class KPluginFactory: QObject
{
%TypeHeaderCode
#include <kpluginfactory.h>
%End
    // Discarded VAR_DECL on line 405 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 405 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 405 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 405 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 405 'tr' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 405 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
public:
    KPluginFactory();
    virtual ~KPluginFactory();
    // Discarded FUNCTION_TEMPLATE on line 429 'create' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
    // Discarded FUNCTION_TEMPLATE on line 443 'create' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
    // Discarded FUNCTION_TEMPLATE on line 459 'create' (by rules_PyKF5.py:FunctionRuleDb[3],function_discard)
    // Discarded FUNCTION_TEMPLATE on line 466 'create' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
    QObject * // Modified PARM_DECL on line 477 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    create(QObject*  parent /TransferThis/ = nullptr, const char*  classname = "QObject", const QStringList & args = QStringList());
    KPluginMetaData metaData() const;
    void setMetaData(const KPluginMetaData & metaData);
    static QVariantList stringListToVariantList(const QStringList & list);
    static QStringList variantListToStringList(const QList<QVariant> & list);
Q_SIGNALS:
    void objectCreated(QObject*  object);
protected:
    // Discarded TYPEDEF_DECL on line 518 'CreateInstanceFunction'
    // Discarded CLASS_TEMPLATE on line 524 'InheritanceChecker' (by rules_PyKF5.py:ContainerRuleDb[3],container_discard)
    // Discarded CLASS_TEMPLATE on line 554 'InheritanceWithMetaDataChecker' (by rules_PyKF5.py:ContainerRuleDb[3],container_discard)
    // Discarded CONSTRUCTOR on line 575 'KPluginFactory' (by rules_PyKF5.py:FunctionRuleDb[22],function_discard)
    // Discarded FUNCTION_TEMPLATE on line 599 'registerPlugin' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
    // Discarded FUNCTION_TEMPLATE on line 625 'registerPlugin' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
    // Discarded FUNCTION_TEMPLATE on line 650 'registerPlugin' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
    // Discarded FUNCTION_TEMPLATE on line 676 'registerPlugin' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
    // Discarded FIELD_DECL on line 683 'd_ptr' (by Qt5Ruleset.py:VariableRuleDb[1],variable_discard)
    virtual QObject * // Modified PARM_DECL on line 690 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    createObject(QObject*  parent /TransferThis/, const char*  className, const QStringList & args);
    // Discarded CXX_METHOD on line 698 'createPartObject' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 715 'create' (by rules_PyKF5.py:FunctionRuleDb[3],function_discard)
    // Discarded FUNCTION_TEMPLATE on line 717 'createInstance' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
    // Discarded FUNCTION_TEMPLATE on line 729 'createPartInstance' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
    // Discarded FUNCTION_TEMPLATE on line 735 'createWithMetaDataInstance' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
    // Discarded FUNCTION_TEMPLATE on line 747 'createPartWithMetaDataInstance' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
private:
    private:
        KPluginFactory(const KPluginFactory &); // Generated
};
typedef KPluginFactory KLibFactory;
// Discarded FUNCTION_DECL on line 805 'qobject_interface_iid' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
// Discarded FUNCTION_DECL on line 805 'qobject_cast' (by rules_PyKF5.py:FunctionRuleDb[7],function_discard)
// Discarded FUNCTION_DECL on line 805 'qobject_cast' (by rules_PyKF5.py:FunctionRuleDb[7],function_discard)
