#!/usr/bin/env lua5.1
require('luaunit')
require('lemock')
require 'ngcp.utils'
require 'tests_v.dp_vars'

if not sr then
    require 'mocks.sr'
    sr = srMock:new()
else
    argv = {}
end
local mc = nil

TestNGCPDomainPrefs = {} --class

    function TestNGCPDomainPrefs:setUp()
        mc = lemock.controller()
        self.config = mc:mock()
        self.mysql = mc:mock()
        self.env = mc:mock()
        self.con = mc:mock()
        self.cur = mc:mock()

        package.loaded.luasql = nil
        package.preload['luasql.mysql'] = function ()
            luasql = {}
            luasql.mysql = mysql
            return mysql
        end

        require 'ngcp.dp'

        self.d = NGCPDomainPrefs:new(self.config)
        self.dp_vars = DPFetch:new()
    end

    function TestNGCPDomainPrefs:tearDown()
        sr.pv.unset("$xavp(caller_dom_prefs)")
        sr.pv.unset("$xavp(callee_dom_prefs)")
        sr.pv.unset("$xavp(caller_peer_prefs)")
        sr.pv.unset("$xavp(callee_peer_prefs)")
        sr.pv.unset("$xavp(caller_usr_prefs)")
        sr.pv.unset("$xavp(callee_usr_prefs)")
        sr.pv.unset("$xavp(caller_real_prefs)")
        sr.pv.unset("$xavp(callee_real_prefs)")
        sr.log("info", "---cleaned---")
    end

    function TestNGCPDomainPrefs:test_init()
        --print("TestNGCPDomainPrefs:test_init")
        assertEquals(self.d.db_table, "dom_preferences")
    end

    function TestNGCPDomainPrefs:test_caller_load_empty()
        assertTrue(self.d.config)
        assertEquals(self.d:caller_load(), {})
    end

    function TestNGCPDomainPrefs:test_callee_load_empty()
        assertTrue(self.d.config)
        assertEquals(self.d:callee_load(), {})
    end

    function TestNGCPDomainPrefs:test_caller_load()
        assertTrue(self.d.config)
        self.config:getDBConnection() ;mc :returns(self.con)
        self.con:execute("SELECT * FROM dom_preferences WHERE domain ='192.168.51.56'")  ;mc :returns(self.cur)
        self.cur:fetch(mc.ANYARGS)    ;mc :returns(self.dp_vars:val("d_192_168_51_56"))
        self.cur:fetch(mc.ANYARGS)    ;mc :returns(self.dp_vars:val("d_192_168_51_56"))
        self.cur:fetch(mc.ANYARGS)    ;mc :returns(nil)
        self.cur:close()
        self.con:close()

        mc:replay()
        local keys = self.d:caller_load("192.168.51.56")
        mc:verify()

        assertEquals(sr.pv.get("$xavp(caller_dom_prefs=>sst_enable)"),"no")
        assertEquals(sr.pv.get("$xavp(caller_dom_prefs=>sst_refresh_method)"), "UPDATE_FALLBACK_INVITE")
        assertItemsEquals(keys, {"sst_enable", "sst_refresh_method"})
    end

    function TestNGCPDomainPrefs:test_callee_load()
        assertTrue(self.d.config)
        self.config:getDBConnection() ;mc :returns(self.con)
        self.con:execute("SELECT * FROM dom_preferences WHERE domain ='192.168.51.56'")  ;mc :returns(self.cur)
        self.cur:fetch(mc.ANYARGS)    ;mc :returns(self.dp_vars:val("d_192_168_51_56"))
        self.cur:fetch(mc.ANYARGS)    ;mc :returns(self.dp_vars:val("d_192_168_51_56"))
        self.cur:fetch(mc.ANYARGS)    ;mc :returns(nil)
        self.cur:close()
        self.con:close()

        mc:replay()
        local keys = self.d:callee_load("192.168.51.56")
        mc:verify()

        assertEquals(sr.pv.get("$xavp(callee_dom_prefs=>sst_enable)"),"no")
        assertEquals(sr.pv.get("$xavp(callee_dom_prefs=>sst_refresh_method)"), "UPDATE_FALLBACK_INVITE")
        assertItemsEquals(keys, {"sst_enable", "sst_refresh_method"})
    end

    function TestNGCPDomainPrefs:test_clean()
        local xavp = NGCPDomainPrefs:xavp('callee')
        xavp("testid",1)
        xavp("foo","foo")
        assertEquals(sr.pv.get("$xavp(callee_dom_prefs=>testid)"),1)
        assertEquals(sr.pv.get("$xavp(callee_dom_prefs=>foo)"),"foo")
        assertEquals(sr.pv.get("$xavp(caller_dom_prefs=>dummy)"),"caller")
        self.d:clean()
        assertEquals(sr.pv.get("$xavp(caller_dom_prefs=>dummy)"),"caller")
        assertEquals(sr.pv.get("$xavp(callee_dom_prefs=>dummy)"),"callee")
        assertFalse(sr.pv.get("$xavp(domain)"))
    end

    function TestNGCPDomainPrefs:test_callee_clean()
        local callee_xavp = NGCPDomainPrefs:xavp('callee')
        callee_xavp("testid",1)
        callee_xavp("foo","foo")
        local caller_xavp = NGCPDomainPrefs:xavp('caller')
        caller_xavp("other",1)
        caller_xavp("otherfoo","foo")
        assertEquals(sr.pv.get("$xavp(callee_dom_prefs=>testid)"),1)
        assertEquals(sr.pv.get("$xavp(callee_dom_prefs=>foo)"),"foo")
        assertEquals(sr.pv.get("$xavp(caller_dom_prefs=>dummy)"),"caller")
        assertEquals(sr.pv.get("$xavp(caller_dom_prefs=>other)"),1)
        assertEquals(sr.pv.get("$xavp(caller_dom_prefs=>otherfoo)"),"foo")
        assertEquals(sr.pv.get("$xavp(callee_dom_prefs=>dummy)"),"callee")
        self.d:clean('callee')
        assertEquals(sr.pv.get("$xavp(caller_dom_prefs=>dummy)"),'caller')
        assertFalse(sr.pv.get("$xavp(callee_dom_prefs=>testid)"))
        assertFalse(sr.pv.get("$xavp(callee_dom_prefs=>foo)"))
        assertEquals(sr.pv.get("$xavp(caller_dom_prefs=>other)"),1)
        assertEquals(sr.pv.get("$xavp(caller_dom_prefs=>otherfoo)"),"foo")
        assertEquals(sr.pv.get("$xavp(callee_dom_prefs=>dummy)"),"callee")
    end

    function TestNGCPDomainPrefs:test_caller_clean()
        local callee_xavp = NGCPDomainPrefs:xavp('callee')
        callee_xavp("testid",1)
        callee_xavp("foo","foo")
        local caller_xavp = NGCPDomainPrefs:xavp('caller')
        caller_xavp("other",1)
        caller_xavp("otherfoo","foo")
        assertEquals(sr.pv.get("$xavp(callee_dom_prefs=>testid)"),1)
        assertEquals(sr.pv.get("$xavp(callee_dom_prefs=>foo)"),"foo")
        assertEquals(sr.pv.get("$xavp(caller_dom_prefs=>dummy)"),"caller")
        assertEquals(sr.pv.get("$xavp(caller_dom_prefs=>other)"),1)
        assertEquals(sr.pv.get("$xavp(caller_dom_prefs=>otherfoo)"),"foo")
        assertEquals(sr.pv.get("$xavp(callee_dom_prefs=>dummy)"),"callee")
        self.d:clean('caller')
        assertEquals(sr.pv.get("$xavp(caller_dom_prefs=>dummy)"),"caller")
        assertFalse(sr.pv.get("$xavp(caller_dom_prefs=>other)"))
        assertFalse(sr.pv.get("$xavp(caller_dom_prefs=>otherfoo)"))
        assertEquals(sr.pv.get("$xavp(callee_dom_prefs=>testid)"),1)
        assertEquals(sr.pv.get("$xavp(callee_dom_prefs=>foo)"),"foo")
        assertEquals(sr.pv.get("$xavp(callee_dom_prefs=>dummy)"),"callee")
    end

    function TestNGCPDomainPrefs:test_tostring()
        local callee_xavp = NGCPDomainPrefs:xavp('callee')
        callee_xavp("testid",1)
        callee_xavp("foo","foo")
        local caller_xavp = NGCPDomainPrefs:xavp('caller')
        caller_xavp("other",1)
        caller_xavp("otherfoo","foo")
        assertEquals(tostring(self.d), 'caller_dom_prefs:{other=1,otherfoo="foo",dummy="caller"}\ncallee_dom_prefs:{dummy="callee",testid=1,foo="foo"}\n')
    end
-- class TestNGCPDomainPrefs
--EOF