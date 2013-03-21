#!/usr/bin/env lua5.1
-- Kamailio Lua Config
require 'kam_utils.lua'

-- ROUTE_CLEAR_PEER_IN_PREF
function clear_peer_in_pref()
    local list = {
        peer_peer_callee_auth_user,
        peer_peer_callee_auth_pass,
        peer_peer_callee_auth_realm,
        caller_use_rtpproxy,
        peer_caller_ipv46_for_rtpproxy,
        caller_force_outbound_calls_to_peer,
        peer_caller_find_subscriber_by_uuid,
        pstn_dp_caller_in_id,
        pstn_dp_callee_in_id,
        pstn_dp_caller_out_id,
        pstn_dp_callee_out_id,
        rewrite_caller_in_dpid,
        rewrite_caller_out_dpid,
        rewrite_callee_in_dpid,
        rewrite_callee_out_dpid,
        caller_peer_concurrent_max,
        peer_caller_sst_enable,
        peer_caller_sst_expires,
        peer_caller_sst_min_timer,
        peer_caller_sst_max_timer,
        peer_caller_sst_refresh_method,
        caller_inbound_upn,
        caller_inbound_npn,
        caller_inbound_uprn
    }

    clean_avps(list)
end

-- ROUTE_CLEAR_PEER_OUT_PREF
function route_clear_peer_out_pref()
    local list = {
        peer_peer_caller_auth_user,
        peer_peer_caller_auth_pass,
        peer_peer_caller_auth_realm,
        callee_use_rtpproxy,
        peer_callee_ipv46_for_rtpproxy,
        peer_callee_concurrent_max,
        peer_callee_concurrent_max_out,
        peer_callee_outbound_socket,
        pstn_dp_caller_in_id,
        pstn_dp_callee_in_id,
        pstn_dp_caller_out_id,
        pstn_dp_callee_out_id,
        rewrite_caller_in_dpid,
        rewrite_caller_out_dpid,
        rewrite_caller_out_dpid,
        rewrite_callee_in_dpid,
        rewrite_callee_out_dpid,
        peer_callee_sst_enable,
        peer_callee_sst_expires,
        peer_callee_sst_min_timer,
        peer_callee_sst_max_timer,
        peer_callee_sst_refresh_method,
        callee_outbound_from_display,
        callee_outbound_from_user,
        callee_outbound_pai_user,
        callee_outbound_ppi_user,
        callee_outbound_diversion,
        concurrent_max,
        concurrent_max_out,
        concurrent_max_per_account,
        concurrent_max_out_per_account
    }

    clean_avps(list)
end

-- ROUTE_CLEAR_CALLER_PREF
function clear_caller_pref()
    local list = {
        caller_account_id,
        caller_lock,
        caller_cli_netprov,
        caller_allowed_clis,
        caller_user_cli,
        caller_cc,
        caller_ac,
        caller_emergency_cli,
        caller_emergency_prefix,
        caller_emergency_suffix,
        caller_block_out_mode,
        caller_block_out_list,
        caller_adm_block_out_mode,
        caller_adm_block_out_list,
        caller_dp_dom_caller_in,
        caller_dp_dom_callee_in,
        caller_dp_dom_caller_out,
        caller_dp_dom_callee_out,
        allowed_ips_grp,
        man_allowed_ips_grp,
        ignore_allowed_ips,
        caller_ncos_id,
        caller_adm_ncos_id,
        caller_dom_ncos_id,
        caller_dom_adm_ncos_id,
        caller_block_override,
        caller_adm_block_override,
        caller_peer_auth_user,
        caller_peer_auth_pass,
        caller_peer_auth_realm,
        caller_ext_subscriber_id,
        caller_ext_contract_id,
        caller_prepaid,
        caller_ipv46_for_rtpproxy,
        caller_dom_ipv46_for_rtpproxy,
        caller_dom_use_rtpproxy,
        caller_use_rtpproxy,
        caller_force_outbound_calls_to_peer,
        caller_dom_force_outbound_calls_to_peer,
        caller_dom_concurrent_max,
        caller_concurrent_max,
        caller_dom_concurrent_max_out,
        caller_concurrent_max_out,
        caller_dom_concurrent_max_per_account,
        caller_concurrent_max_per_account,
        caller_dom_concurrent_max_out_per_account,
        caller_concurrent_max_out_per_account,
        caller_dom_sst_enable,
        caller_dom_sst_expires,
        caller_dom_sst_min_timer,
        caller_dom_sst_max_timer,
        caller_dom_sst_refresh_method,
        caller_sst_enable,
        caller_sst_expires,
        caller_sst_min_timer,
        caller_sst_max_timer,
        caller_sst_refresh_method,
        caller_reject_emergency,
        caller_dom_reject_emergency,
        caller_sound_set,
        caller_dom_sound_set,
        caller_inbound_upn,
        caller_dom_inbound_upn,
        caller_inbound_uprn,
        caller_dom_inbound_uprn,
        caller_dom_extension_in_npn,
        caller_extension_in_npn,
        lock,
        cfu,
        cfb,
        cfna,
        cft,
        cc,
        ac,
        emerg_ac,
        ringtimeout,
        rewrite_caller_in_dpid,
        rewrite_caller_out_dpid,
        rewrite_callee_in_dpid,
        rewrite_callee_out_dpid,
        caller_ip_header,
        caller_ip_val,
    }

    clean_avps(list)
end

-- ROUTE_CLEAR_CALLEE_PREF
function clear_callee_pref()
    local list = {
        callee_account_id,
        callee_lock,
        callee_fr_inv_timer,
        callee_cfu,
        callee_cfb,
        callee_cfna,
        callee_cft,
        callee_cc,
        callee_ac,
        callee_ringtimeout,
        callee_block_in_mode,
        callee_block_in_list,
        callee_block_in_clir,
        callee_adm_block_in_mode,
        callee_adm_block_in_list,
        callee_adm_block_in_clir,
        callee_dp_dom_caller_out,
        callee_dp_dom_callee_out,
        callee_dp_dom_caller_in,
        callee_dp_dom_callee_in,
        callee_ipv46_for_rtpproxy,
        callee_dom_ipv46_for_rtpproxy,
        callee_ext_subscriber_id,
        callee_ext_contract_id,
        callee_dom_use_rtpproxy,
        callee_use_rtpproxy,
        callee_peer_auth_user,
        callee_peer_auth_pass,
        callee_peer_auth_realm,
        callee_dom_concurrent_max,
        callee_concurrent_max,
        callee_dom_concurrent_max_out,
        callee_concurrent_max_out,
        callee_dom_concurrent_max_per_account,
        callee_concurrent_max_per_account,
        callee_dom_concurrent_max_out_per_account,
        callee_concurrent_max_out_per_account,
        callee_dom_force_inbound_calls_to_peer,
        callee_force_inbound_calls_to_peer,
        callee_e164_to_ruri,
        callee_dom_sst_enable,
        callee_dom_sst_expires,
        callee_dom_sst_min_timer,
        callee_dom_sst_max_timer,
        callee_dom_sst_refresh_method,
        callee_sst_enable,
        callee_sst_expires,
        callee_sst_min_timer,
        callee_sst_max_timer,
        callee_sst_refresh_method,
        callee_sound_set,
        callee_dom_sound_set,
        callee_dom_mobile_push_enable,
        callee_mobile_push_enable,
        block_in_mode,
        block_in_list,
        block_in_clir,
        adm_block_in_mode,
        adm_block_in_list,
        adm_block_in_clir,
        lock,
        cfu,
        cfb,
        cfna,
        cft,
        cc,
        ac,
        ringtimeout,
        rewrite_caller_in_dpid,
        rewrite_caller_out_dpid,
        rewrite_callee_in_dpid,
        rewrite_callee_out_dpid,
        callee_outbound_from_display,
        callee_dom_outbound_from_display,
        callee_outbound_from_user,
        callee_dom_outbound_from_user,
        callee_outbound_pai_user,
        callee_dom_outbound_pai_user,
        callee_outbound_ppi_user,
        callee_dom_outbound_ppi_user,
        callee_outbound_diversion,
        callee_dom_outbound_diversion,
    }

    clean_avps(list)
end
#EOF