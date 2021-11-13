#pragma once

typedef int KrakenStatus;

// Good (Everything's OK)
constexpr KrakenStatus KRAKEN_OK      = 0x00000000;
// Warning (Something went wrong but it is not critical)
constexpr KrakenStatus KRAKEN_WARNING = 0x00000001;
// Fail (Consider throwing exception here)
constexpr KrakenStatus KRAKEN_FAIL    = 0x80000000;
// Fatal (Terminate the process)
constexpr KrakenStatus KRAKEN_FATAL   = 0x80000001;

constexpr bool KrakenGood(KrakenStatus status)
{
    return !(status & 0x80000001);
}

constexpr bool KrakenWarning(KrakenStatus status)
{
    return !(~status & 0x80000000);
}

constexpr bool KrakenFail(KrakenStatus status)
{
    return !(~status & 0x00000001);
}

constexpr bool KrakenFatal(KrakenStatus status)
{
    return !(~status & 0x80000001);
}
