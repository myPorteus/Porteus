// Generated (by rules_PyKF5.py:_klocalizedstring_add_template_code): {'usage': 1}
%ModuleCode
QString klocalizedstring_i18n_template(KLocalizedString base, PyObject *list,int *sipIsErr) {
    KLocalizedString result = base;
    QString *arg;
    long long_arg;
    double double_arg;
    int iserr = 0;

    for (int i=0; i < PyTuple_Size(list); i++) {
        PyObject *pyarg = PyTuple_GET_ITEM (list, i);
#if PY_MAJOR_VERSION >= 3
        if (PyLong_Check(pyarg)) {
            long_arg = PyLong_AsLong(pyarg);
#else
        if (PyInt_Check(pyarg)) {
            long_arg = PyInt_AsLong(pyarg);
#endif
            if (long_arg==-1 && PyErr_Occurred()) {
                *sipIsErr = 1;
                return QString();
            }
            result = result.subs(long_arg);

#if PY_MAJOR_VERSION >= 3
        } else if (PyNumber_Check(pyarg)) {
            PyObject *long_py = PyNumber_Long(pyarg);
            long_arg = PyLong_AsLong(long_py);
            Py_DECREF(long_py);
#else
        } else if (PyLong_Check(pyarg)) {
            long_arg = PyLong_AsLong(pyarg);
#endif
            if (long_arg==-1 && PyErr_Occurred()) {
                *sipIsErr = 1;
                return QString();
            }
            result = result.subs(long_arg);

        } else if (PyFloat_Check(pyarg)) {
            double_arg = PyFloat_AsDouble(pyarg);
            result = result.subs(double_arg);

        } else {
          int state = 0;
          arg = (QString *)sipForceConvertToType(pyarg, sipType_QString, NULL, SIP_NOT_NONE, &state, &iserr);
          if (iserr) {
              *sipIsErr = 1;
              return QString();
          }

          result = result.subs(*arg);
          sipReleaseType(arg,sipType_QString,state);
          arg = 0;
          }
    }

    return result.toString();
}
%End
// Discarded CLASS_DECL on line 25 'KLocalizedStringPrivate' (by default forward declaration handling)
class KLocalizedString
{
%TypeHeaderCode
#include <klocalizedstring.h>
%End
public:
    KLocalizedString();
    KLocalizedString(const KLocalizedString & rhs);
    // Discarded CXX_METHOD on line 131 'operator=' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
    ~KLocalizedString();
    bool isEmpty() const;
    QString toString() const;
    QString toString(const QStringList & languages) const;
    QString toString(const char*  domain) const;
    QString toString(Kuit::VisualFormat format) const;
    KLocalizedString withLanguages(const QStringList & languages) const;
    KLocalizedString withDomain(const char*  domain) const;
    KLocalizedString withFormat(Kuit::VisualFormat format) const;
    // Discarded CXX_METHOD on line 263 'subs' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 277 'subs' (by rules_PyKF5.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 291 'subs' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
    // Discarded CXX_METHOD on line 305 'subs' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
    // Discarded CXX_METHOD on line 319 'subs' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
    // Discarded CXX_METHOD on line 333 'subs' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
    // Discarded CXX_METHOD on line 347 'subs' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 359 'subs' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 371 'subs' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 383 'subs' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    KLocalizedString inContext(const QString & key, const QString & value) const;
    KLocalizedString relaxSubs() const;
    KLocalizedString ignoreMarkup() const;
    QByteArray untranslatedText() const;
    static void setApplicationDomain(const char*  domain);
    static QByteArray applicationDomain();
    static QStringList languages();
    static void setLanguages(const QStringList & languages);
    static void clearLanguages();
    static bool isApplicationTranslatedInto(const QString & language);
    static QSet<QString> availableApplicationTranslations();
    static QSet<QString> availableDomainTranslations(const QByteArray & domain);
    static void addDomainLocaleDir(const QByteArray & domain, const QString & path);
    static QString localizedFilePath(const QString & filePath);
    static QString removeAcceleratorMarker(const QString & label);
    static QString translateQt(const char*  context, const char*  text, const char*  comment, int n);
    static void insertQtDomain(const char*  domain);
    static void removeQtDomain(const char*  domain);
private:
private:
};
KLocalizedString ki18n(const char*  text);
KLocalizedString ki18nc(const char*  context, const char*  text);
KLocalizedString ki18np(const char*  singular, const char*  plural);
KLocalizedString ki18ncp(const char*  context, const char*  singular, const char*  plural);
KLocalizedString ki18nd(const char*  domain, const char*  text);
KLocalizedString ki18ndc(const char*  domain, const char*  context, const char*  text);
KLocalizedString ki18ndp(const char*  domain, const char*  singular, const char*  plural);
KLocalizedString ki18ndcp(const char*  domain, const char*  context, const char*  singular, const char*  plural);
KLocalizedString kxi18n(const char*  text);
KLocalizedString kxi18nc(const char*  context, const char*  text);
KLocalizedString kxi18np(const char*  singular, const char*  plural);
KLocalizedString kxi18ncp(const char*  context, const char*  singular, const char*  plural);
KLocalizedString kxi18nd(const char*  domain, const char*  text);
KLocalizedString kxi18ndc(const char*  domain, const char*  context, const char*  text);
KLocalizedString kxi18ndp(const char*  domain, const char*  singular, const char*  plural);
KLocalizedString kxi18ndcp(const char*  domain, const char*  context, const char*  singular, const char*  plural);
QString tr2i18n(const char*  text, const char*  comment = nullptr);
QString tr2i18nd(const char*  domain, const char*  text, const char*  comment = nullptr);
QString tr2xi18n(const char*  text, const char*  comment = nullptr);
QString tr2xi18nd(const char*  domain, const char*  text, const char*  comment = nullptr);
// Discarded CLASS_TEMPLATE on line 1102 'I18nTypeCheck' (by Qt5Ruleset.py:ContainerRuleDb[1],container_discard)
QString // Modified FUNCTION_DECL on line 1121 'i18n' (by rules_PyKF5.py:FunctionRuleDb[7],i18n_ellipsis):
i18n(const char*  text, ...);
// Inserted (by klocalizedstring.h:i18n): {'usage': 1}
%MethodCode
    QString result = klocalizedstring_i18n_template(ki18n(a0),a1,&sipIsErr);
    if (!sipIsErr) {
        sipRes = new QString(result);
    }
%End
// Discarded FUNCTION_TEMPLATE on line 1125 'i18n' (by rules_PyKF5.py:FunctionRuleDb[7],i18n_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1131 'i18n' (by rules_PyKF5.py:FunctionRuleDb[7],i18n_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1137 'i18n' (by rules_PyKF5.py:FunctionRuleDb[7],i18n_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1143 'i18n' (by rules_PyKF5.py:FunctionRuleDb[7],i18n_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1149 'i18n' (by rules_PyKF5.py:FunctionRuleDb[7],i18n_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1155 'i18n' (by rules_PyKF5.py:FunctionRuleDb[7],i18n_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1161 'i18n' (by rules_PyKF5.py:FunctionRuleDb[7],i18n_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1167 'i18n' (by rules_PyKF5.py:FunctionRuleDb[7],i18n_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1173 'i18n' (by rules_PyKF5.py:FunctionRuleDb[7],i18n_ellipsis)
QString // Modified FUNCTION_DECL on line 1184 'i18nc' (by rules_PyKF5.py:FunctionRuleDb[8],i18n_ellipsis):
i18nc(const char*  context, const char*  text, ...);
// Inserted (by klocalizedstring.h:i18nc): {'usage': 1}
%MethodCode
    QString result = klocalizedstring_i18n_template(ki18nc(a0,a1),a2,&sipIsErr);
    if (!sipIsErr) {
        sipRes = new QString(result);
    }
%End
// Discarded FUNCTION_TEMPLATE on line 1188 'i18nc' (by rules_PyKF5.py:FunctionRuleDb[8],i18n_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1193 'i18nc' (by rules_PyKF5.py:FunctionRuleDb[8],i18n_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1198 'i18nc' (by rules_PyKF5.py:FunctionRuleDb[8],i18n_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1203 'i18nc' (by rules_PyKF5.py:FunctionRuleDb[8],i18n_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1208 'i18nc' (by rules_PyKF5.py:FunctionRuleDb[8],i18n_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1213 'i18nc' (by rules_PyKF5.py:FunctionRuleDb[8],i18n_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1218 'i18nc' (by rules_PyKF5.py:FunctionRuleDb[8],i18n_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1223 'i18nc' (by rules_PyKF5.py:FunctionRuleDb[8],i18n_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1229 'i18nc' (by rules_PyKF5.py:FunctionRuleDb[8],i18n_ellipsis)
QString // Modified FUNCTION_TEMPLATE on line 1248 'i18np' (by rules_PyKF5.py:FunctionRuleDb[9],i18np_ellipsis):
i18np(const char*  singular, const char*  plural, ...);
// Inserted (by klocalizedstring.h:i18np): {'usage': 1}
%MethodCode
    QString result = klocalizedstring_i18n_template(ki18np(a0,a1),a2,&sipIsErr);
    if (!sipIsErr) {
        sipRes = new QString(result);
    }
%End
// Discarded FUNCTION_TEMPLATE on line 1253 'i18np' (by rules_PyKF5.py:FunctionRuleDb[9],i18np_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1258 'i18np' (by rules_PyKF5.py:FunctionRuleDb[9],i18np_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1263 'i18np' (by rules_PyKF5.py:FunctionRuleDb[9],i18np_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1268 'i18np' (by rules_PyKF5.py:FunctionRuleDb[9],i18np_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1273 'i18np' (by rules_PyKF5.py:FunctionRuleDb[9],i18np_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1278 'i18np' (by rules_PyKF5.py:FunctionRuleDb[9],i18np_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1283 'i18np' (by rules_PyKF5.py:FunctionRuleDb[9],i18np_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1289 'i18np' (by rules_PyKF5.py:FunctionRuleDb[9],i18np_ellipsis)
QString // Modified FUNCTION_TEMPLATE on line 1308 'i18ncp' (by rules_PyKF5.py:FunctionRuleDb[10],i18np_ellipsis):
i18ncp(const char*  context, const char*  singular, const char*  plural, ...);
// Inserted (by klocalizedstring.h:i18ncp): {'usage': 1}
%MethodCode
    QString result = klocalizedstring_i18n_template(ki18ncp(a0,a1,a2),a3,&sipIsErr);
    if (!sipIsErr) {
        sipRes = new QString(result);
    }
%End
// Discarded FUNCTION_TEMPLATE on line 1313 'i18ncp' (by rules_PyKF5.py:FunctionRuleDb[10],i18np_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1318 'i18ncp' (by rules_PyKF5.py:FunctionRuleDb[10],i18np_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1323 'i18ncp' (by rules_PyKF5.py:FunctionRuleDb[10],i18np_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1328 'i18ncp' (by rules_PyKF5.py:FunctionRuleDb[10],i18np_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1333 'i18ncp' (by rules_PyKF5.py:FunctionRuleDb[10],i18np_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1339 'i18ncp' (by rules_PyKF5.py:FunctionRuleDb[10],i18np_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1353 'i18ncp' (by rules_PyKF5.py:FunctionRuleDb[10],i18np_ellipsis)
// Discarded FUNCTION_TEMPLATE on line 1368 'i18ncp' (by rules_PyKF5.py:FunctionRuleDb[10],i18np_ellipsis)
QString i18nd(const char*  domain, const char*  text);
// Discarded FUNCTION_TEMPLATE on line 1392 'i18nd' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1398 'i18nd' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1404 'i18nd' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1410 'i18nd' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1416 'i18nd' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1422 'i18nd' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1428 'i18nd' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1434 'i18nd' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1441 'i18nd' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
QString i18ndc(const char*  domain, const char*  context, const char*  text);
// Discarded FUNCTION_TEMPLATE on line 1465 'i18ndc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1470 'i18ndc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1475 'i18ndc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1480 'i18ndc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1485 'i18ndc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1490 'i18ndc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1496 'i18ndc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1510 'i18ndc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1525 'i18ndc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1545 'i18ndp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1550 'i18ndp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1555 'i18ndp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1560 'i18ndp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1565 'i18ndp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1570 'i18ndp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1576 'i18ndp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1590 'i18ndp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1605 'i18ndp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1625 'i18ndcp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1630 'i18ndcp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1635 'i18ndcp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1640 'i18ndcp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1646 'i18ndcp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1652 'i18ndcp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1666 'i18ndcp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1681 'i18ndcp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1697 'i18ndcp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
QString xi18n(const char*  text);
// Discarded FUNCTION_TEMPLATE on line 1722 'xi18n' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1728 'xi18n' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1734 'xi18n' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1740 'xi18n' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1746 'xi18n' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1752 'xi18n' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1758 'xi18n' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1764 'xi18n' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1770 'xi18n' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
QString xi18nc(const char*  context, const char*  text);
// Discarded FUNCTION_TEMPLATE on line 1785 'xi18nc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1790 'xi18nc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1795 'xi18nc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1800 'xi18nc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1805 'xi18nc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1810 'xi18nc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1815 'xi18nc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1820 'xi18nc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1826 'xi18nc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1845 'xi18np' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1850 'xi18np' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1855 'xi18np' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1860 'xi18np' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1865 'xi18np' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1870 'xi18np' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1875 'xi18np' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1881 'xi18np' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1887 'xi18np' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1906 'xi18ncp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1911 'xi18ncp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1916 'xi18ncp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1921 'xi18ncp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1926 'xi18ncp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1931 'xi18ncp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1937 'xi18ncp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1951 'xi18ncp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1966 'xi18ncp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
QString xi18nd(const char*  domain, const char*  text);
// Discarded FUNCTION_TEMPLATE on line 1990 'xi18nd' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 1996 'xi18nd' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2002 'xi18nd' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2008 'xi18nd' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2014 'xi18nd' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2020 'xi18nd' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2026 'xi18nd' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2032 'xi18nd' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2039 'xi18nd' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
QString xi18ndc(const char*  domain, const char*  context, const char*  text);
// Discarded FUNCTION_TEMPLATE on line 2063 'xi18ndc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2068 'xi18ndc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2073 'xi18ndc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2078 'xi18ndc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2083 'xi18ndc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2088 'xi18ndc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2094 'xi18ndc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2108 'xi18ndc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2123 'xi18ndc' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2143 'xi18ndp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2148 'xi18ndp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2153 'xi18ndp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2158 'xi18ndp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2163 'xi18ndp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2168 'xi18ndp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2174 'xi18ndp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2188 'xi18ndp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2203 'xi18ndp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2223 'xi18ndcp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2228 'xi18ndcp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2233 'xi18ndcp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2238 'xi18ndcp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2244 'xi18ndcp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2257 'xi18ndcp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2271 'xi18ndcp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2286 'xi18ndcp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
// Discarded FUNCTION_TEMPLATE on line 2302 'xi18ndcp' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
