PROJECT = emqttd
PROJECT_DESCRIPTION = Erlang MQTT Broker
PROJECT_VERSION = 2.3

DEPS = goldrush gproc lager esockd ekka mochiweb pbkdf2 lager_syslog bcrypt clique jsx

dep_goldrush     = git https://github.com/basho/goldrush 0.1.9
dep_gproc        = git https://github.com/uwiger/gproc
dep_getopt       = git https://github.com/jcomellas/getopt v0.8.2
dep_lager        = git https://github.com/basho/lager master
dep_esockd       = git https://github.com/emqtt/esockd master
dep_ekka         = git https://github.com/emqtt/ekka master
dep_mochiweb     = git https://github.com/emqtt/mochiweb master
dep_pbkdf2       = git https://github.com/emqtt/pbkdf2 2.0.1
dep_lager_syslog = git https://github.com/basho/lager_syslog
dep_bcrypt       = git https://github.com/smarkets/erlang-bcrypt master
dep_clique       = git https://github.com/emqtt/clique
dep_jsx          = git https://github.com/talentdeficit/jsx

ERLC_OPTS += +debug_info
ERLC_OPTS += +'{parse_transform, lager_transform}'

NO_AUTOPATCH = cuttlefish

BUILD_DEPS = cuttlefish
dep_cuttlefish = git https://github.com/emqtt/cuttlefish

TEST_DEPS = emqttc
dep_emqttc = git https://github.com/emqtt/emqttc

TEST_ERLC_OPTS += +debug_info
TEST_ERLC_OPTS += +'{parse_transform, lager_transform}'

EUNIT_OPTS = verbose
# EUNIT_ERL_OPTS =

CT_SUITES = emqttd emqttd_access emqttd_lib emqttd_inflight emqttd_mod \
            emqttd_net emqttd_mqueue emqttd_protocol emqttd_topic \
            emqttd_trie emqttd_vm emqttd_config

CT_OPTS = -cover test/ct.cover.spec -erl_args -name emqttd_ct@127.0.0.1

COVER = true

PLT_APPS = sasl asn1 ssl syntax_tools runtime_tools crypto xmerl os_mon inets public_key ssl lager compiler mnesia
DIALYZER_DIRS := ebin/
DIALYZER_OPTS := --verbose --statistics -Werror_handling \
                 -Wrace_conditions #-Wunmatched_returns

include erlang.mk

app:: rebar.config

app.config::
	./deps/cuttlefish/cuttlefish -l info -e etc/ -c etc/emq.conf -i priv/emq.schema -d data/

