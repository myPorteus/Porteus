namespace KEmailAddress
{
%TypeHeaderCode
#include <kemailaddress.h>
%End
    enum EmailParseResult {
        AddressOk,
        AddressEmpty,
        UnexpectedEnd,
        UnbalancedParens,
        MissingDomainPart,
        UnclosedAngleAddr,
        UnopenedAngleAddr,
        TooManyAts,
        UnexpectedComma,
        TooFewAts,
        MissingLocalPart,
        UnbalancedQuote,
        NoAddressSpec,
        DisallowedChar,
        InvalidDisplayName,
        TooFewDots
    };
    QStringList splitAddressList(const QString & aStr);
    KEmailAddress::EmailParseResult splitAddress(const QByteArray & address, QByteArray & displayName, QByteArray & addrSpec, QByteArray & comment);
    KEmailAddress::EmailParseResult splitAddress(const QString & address, QString & displayName, QString & addrSpec, QString & comment);
    KEmailAddress::EmailParseResult isValidAddress(const QString & aStr);
    KEmailAddress::EmailParseResult isValidAddressList(const QString & aStr, QString & badAddr);
    QString emailParseResultToString(KEmailAddress::EmailParseResult errorCode);
    bool isValidSimpleAddress(const QString & aStr);
    QString simpleEmailAddressErrorMsg();
    QByteArray extractEmailAddress(const QByteArray & address);
    QByteArray extractEmailAddress(const QByteArray & address, QString & errorMessage);
    QString extractEmailAddress(const QString & address);
    QString extractEmailAddress(const QString & address, QString & errorMessage);
    QByteArray firstEmailAddress(const QByteArray & addresses);
    QByteArray firstEmailAddress(const QByteArray & addresses, QString & errorMessage);
    QString firstEmailAddress(const QString & addresses);
    QString firstEmailAddress(const QString & addresses, QString & errorMessage);
    bool extractEmailAddressAndName(const QString & aStr, QString & mail, QString & name);
    bool compareEmail(const QString & email1, const QString & email2, bool matchName);
    QString normalizedAddress(const QString & displayName, const QString & addrSpec, const QString & comment = QString());
    QString fromIdn(const QString & addrSpec);
    QString toIdn(const QString & addrSpec);
    QString normalizeAddressesAndDecodeIdn(const QString & addresses);
    QString normalizeAddressesAndEncodeIdn(const QString & str);
    QString quoteNameIfNecessary(const QString & str);
    QUrl encodeMailtoUrl(const QString & mailbox);
    QString decodeMailtoUrl(const QUrl & mailtoUrl);
};
