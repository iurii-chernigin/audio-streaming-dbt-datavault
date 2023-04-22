{%- set source_model = 'v_stage_listen_events' -%}
{%- set src_pk = 'song_play_pk' -%}
{%- set src_hashdiff = 'song_play_hashdiff' -%}

{%- set src_payload = ["song_played_sec", "play_start_ts", "play_end_ts"] -%}
{%- set src_eff = "effective_from_ts" -%}
{%- set src_ldts = "load_date" -%}
{%- set src_source = "record_source" -%}

{{ 

    dbtvault.sat(
        src_pk=src_pk, 
        src_hashdiff=src_hashdiff,
        src_payload=src_payload,
        src_eff=src_eff,
        src_ldts=src_ldts, src_source=src_source,
        source_model=source_model
    )

}}