#ifndef _DATABWLIST_H
#define _DATABWLIST_H

// ROM data include list.
// 1 = start of data address, 2 = end of data address, 3 = data size
u32 dataWhitelist_AZWJ0[3] = {0x000D9B98, 0x00F54000, 0x00E7A468};	// Sawaru - Made in Wario (J)
u32 dataWhitelist_AZWJ2[3] = {0x000D9BB8, 0x00F54400, 0x00E7A848};	// Sawaru - Made in Wario (J) (v02)
u32 dataWhitelist_AZWE0[3] = {0x0011E9F8, 0x00F9B800, 0x00E7CE08};	// WarioWare: Touched (U)
u32 dataWhitelist_AZWP0[3] = {0x00114C78, 0x010C7A00, 0x00FB2D88};	// WarioWare: Touched (E)
u32 dataWhitelist_AZWC0[3] = {0x000E74D8, 0x00FE1C00, 0x00EFA728};	// Momo Waliou Zhizao (C)
u32 dataWhitelist_AZWK0[3] = {0x000D7378, 0x0112DE00, 0x00DA5A90};	// Manjyeora! Made in Wario (KS)
u32 dataWhitelist_ADME0[3] = {0x012E2BFC, 0x01D17A7C, 0x00A34E80};	// Animal Crossing: Wild World (U)
u32 dataWhitelist_ADME1[3] = {0x012E3D14, 0x01D179B4, 0x00A347E0};	// Animal Crossing: Wild World (U) (v01)
u32 dataWhitelist_A2SE0[3] = {0x00103A00, 0x00A17800, 0x00914400};	// Dragon Ball Z: Supersonic Warriors 2 (U)
u32 dataWhitelist_ABHE0[3] = {0x00300E00, 0x00D20E70, 0x00A20070};	// Resident Evil: Deadly Silence (U)
u32 dataWhitelist_ARZE0[3] = {0x0238DC00, 0x02B94600, 0x00806A00};	// MegaMan ZX (U)
u32 dataWhitelist_ARZP0[3] = {0x0287A400, 0x03058F6C, 0x007DEB6C};	// MegaMan ZX (E)
u32 dataWhitelist_AFFE0[3] = {0x012E2600, 0x01AC4A00, 0x007E2400};	// Final Fantasy III (U)
u32 dataWhitelist_AFFP0[3] = {0x01466600, 0x02282200, 0x00E1BC00};	// Final Fantasy III (E)
u32 dataWhitelist_ALKE0[3] = {0x06694E00, 0x073CF444, 0x00D3A644};	// Lunar Knights (U)
u32 dataWhitelist_ALKP0[3] = {0x06697400, 0x073D1A44, 0x00D3A644};	// Lunar Knights (E)
//u32 dataWhitelist_AMQP0[3] = {0x0024EE00, 0x00F2E300, 0x00CDF500};	// Mario Vs Donkey Kong 2: March of the Minis (E)
u32 dataWhitelist_ACBE0[3] = {0x018D6000, 0x02C15200, 0x0133F200};	// Castlevania: Portrait of Ruin (U)
u32 dataWhitelist_ADAE0[3] = {0x00339200, 0x00CBB160, 0x00981F60};	// Pokemon Diamond & Pearl (U)
u32 dataWhitelist_YZXE0[3] = {0x02221600, 0x02DC07A8, 0x00B9F1A8};	// MegaMan ZX Advent (U)
u32 dataWhitelist_YZXP0[3] = {0x02405A00, 0x02FA4BA8, 0x00B9F1A8};	// MegaMan ZX Advent (E)
//u32 dataWhitelist_A5FE0[3] = {0x030B1200, 0x03DB09E0, 0x00D957E0};	// Professor Layton and the Curious Village (U)

// ROM data exclude list.
// 1 = start of data address, 2 = end of data address, 3 = data size
u32 dataBlacklist_ASKE0[3] = {0x01BD0000, 0x024E95E0, 0x009195E0};	// Lost in Blue (U)
u32 dataBlacklist_ACVE0[3] = {0x01AC1600, 0x02F6DA0C, 0x014AC40C};	// Castlevania: Dawn of Sorrow (U)
u32 dataBlacklist_AGYE0[3] = {0x000F8E00, 0x030656A8, 0x02F6C8A8};	// Phoenix Wright: Ace Attorney (U)
u32 dataBlacklist_ASCE0[3] = {0x0171E600, 0x03CA8DE0, 0x0258A7E0};	// Sonic Rush (U)
u32 dataBlacklist_ARME0[3] = {0x00D42600, 0x02879FA8, 0x01B379A8};	// Mario & Luigi: Partners in Time (U)
u32 dataBlacklist_ARMP0[3] = {0x00842E00, 0x0372762C, 0x02EE482C};	// Mario & Luigi: Partners in Time (E)
u32 dataBlacklist_AB3J0[3] = {0x00F77200, 0x03442200, 0x024CB000};	// Mario Basketball: 3 on 3 (J)
u32 dataBlacklist_AB3E0[3] = {0x00F76E00, 0x03222200, 0x022AB400};	// Mario Hoops 3 on 3 (U)
u32 dataBlacklist_AB3P0[3] = {0x01940200, 0x03441E00, 0x01B01C00};	// Mario Slam Basketball (E)
u32 dataBlacklist_APHE0[3] = {0x00399400, 0x0145EC70, 0x010C5870};	// Pokemon Mystery Dungeon: Blue Rescue Team (U)
u32 dataBlacklist_AYWE0[3] = {0x01635E00, 0x01D9F240, 0x00769440};	// Yoshi's Island DS (U)
u32 dataBlacklist_AKWE0[3] = {0x00BEB000, 0x02819A00, 0x01C2EA00};	// Kirby Squeak Squad (U)
u32 dataBlacklist_AKWP0[3] = {0x00D61800, 0x0357D400, 0x0281BC00};	// Kirby Mouse Attack (E)
u32 dataBlacklist_A3YE0[3] = {0x0100A400, 0x02961B20, 0x01957720};	// Sonic Rush Adventure (U)
u32 dataBlacklist_YW2E0[3] = {0x0122EE00, 0x02E5CE40, 0x01C2E040};	// Advance Wars: Days of Ruin (U)
u32 dataBlacklist_YW2P0[3] = {0x011CD400, 0x02DFB440, 0x01C2E040};	// Advance Wars: Dark Conflict (E)
u32 dataBlacklist_YKWE0[3] = {0x00B3A200, 0x04276000, 0x0373BE00};	// Kirby Super Star Ultra (U)
u32 dataBlacklist_CJCE0[3] = {0x01102E00, 0x02E3EE00, 0x01D3C000};	// My Japanese Coach - Learn a New Language (U)
u32 dataBlacklist_CLJE0[3] = {0x01022600, 0x05944A00, 0x04922400};	// Mario & Luigi - Bowser's Inside Story (U)
//u32 dataBlacklist_B6ZE0[3] = {0x0013CE00, 0x03AB6E00, 0x026E8E00};	// MegaMan Zero Collection (U)

#endif // _DATABWLIST_H