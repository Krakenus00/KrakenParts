#pragma once

#include "KrakenPreset.h"
#include "KrakenStatus.h"

class IKrakenCore
{
protected:
    virtual KrakenStatus SetUpPreset(KrakenPreset preset) = 0;

public:

};