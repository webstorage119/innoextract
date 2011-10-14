
#ifndef INNOEXTRACT_SETUP_REGISTRYENTRY_HPP
#define INNOEXTRACT_SETUP_REGISTRYENTRY_HPP

#include <iostream>

#include "setup/SetupItem.hpp"
#include "setup/Version.hpp"
#include "setup/WindowsVersion.hpp"
#include "util/Enum.hpp"
#include "util/Flags.hpp"
#include "util/Types.hpp"

struct RegistryEntry : public SetupItem {
	
	FLAGS(Options,
		CreateValueIfDoesntExist,
		UninsDeleteValue,
		UninsClearValue,
		UninsDeleteEntireKey,
		UninsDeleteEntireKeyIfEmpty,
		PreserveStringType,
		DeleteKey,
		DeleteValue,
		NoError,
		DontCreateKey,
		Bits32,
		Bits64
	);
	
	enum Hive {
		HKCR,
		HKCU,
		HKLM,
		HKU,
		HKPD,
		HKCC,
		HKDD,
		Unset,
	};
	
	enum Type {
		None,
		String,
		ExpandString,
		DWord,
		Binary,
		MultiString,
		QWord,
	};
	
	std::string key;
	std::string name; // empty string means (Default) key
	std::string value;
	
	std::string permissions;
	
	Hive hive;
	
	int permission; //!< index into the permission entry list
	
	Type type;
	
	Options options;
	
	void load(std::istream & is, const InnoVersion & version);
	
};

FLAGS_OVERLOADS(RegistryEntry::Options)
NAMED_ENUM(RegistryEntry::Options)

NAMED_ENUM(RegistryEntry::Hive)

NAMED_ENUM(RegistryEntry::Type)

#endif // INNOEXTRACT_SETUP_REGISTRYENTRY_HPP