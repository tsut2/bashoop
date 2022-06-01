class(){
	local -n __class__0_="${1}"
	local    _a

	${2} "${!__class__0_}"
	__class__0_[0]="${__class__0_[0]%:${!__class__0_}}${FUNCNAME[1]}::${!__class__0_}"

	# shellcheck disable=2154
	for _a in "${@:3}";{
		type -t "${FUNCNAME[1]}:${_a}" > /dev/null \
		&& eval "${!__class__0_}:${_a}(){ ${FUNCNAME[1]}:${_a} \"\${@}\" \"${!__class__0_}\";}"
	}
}
Object(){
	local _m=(
		printType
		getType
		typeOf
		unset
	);class "${1}" : "${_m[@]}"
}
Object:typeOf(){
	local -n __Object_typeOf__0_="${*: -1}"
	[[ "${__Object_typeOf__0_[0]%::*}" =~ ^"${1}" ]] || return 1
}
Object:printType(){
	local -n __Object_getType__0_="${*: -1}"
	echo "${__Object_getType__0_[0]%%::*}" > /dev/stdout
}
Object:getType(){
	local -n __Object_getType__0_="REPLY" \
			 __Object_getType__1_="${*: -1}"
	__Object_getType__0_="${__Object_getType__1_[0]%%::*}"
}
Object:unset(){
	local -n __Object_unset__0_="${*: -1}"
	local _a _b IFS=$'\n'

	for _a in $( declare -F );do
		[[ ${_a:11} =~ ^${__Object_unset__0_##*:} ]] && _b+=("${_a:11}")
	done

	unset -v "${__Object_unset__0_##*:}"
	unset -f "${_b[@]}"
}