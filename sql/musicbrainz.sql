--
-- PostgreSQL database dump
--

\restrict BnLCtHjd3NbgaeEfrgfAKWoOjK8g5e66EtnYKoPaLUky1DBHMMTxZgM6AezDzak

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 18.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY "musicbrainz"."dbmirror_pendingdata" DROP CONSTRAINT IF EXISTS "dbmirror_pendingdata_seqid_fkey";
DROP TRIGGER IF EXISTS "apply_artist_release_pending_updates_mirror" ON "musicbrainz"."track";
DROP TRIGGER IF EXISTS "apply_artist_release_pending_updates_mirror" ON "musicbrainz"."release_label";
DROP TRIGGER IF EXISTS "apply_artist_release_pending_updates_mirror" ON "musicbrainz"."release_first_release_date";
DROP TRIGGER IF EXISTS "apply_artist_release_pending_updates_mirror" ON "musicbrainz"."release_country";
DROP TRIGGER IF EXISTS "apply_artist_release_pending_updates_mirror" ON "musicbrainz"."release";
DROP TRIGGER IF EXISTS "apply_artist_release_group_pending_updates_mirror" ON "musicbrainz"."track";
DROP TRIGGER IF EXISTS "apply_artist_release_group_pending_updates_mirror" ON "musicbrainz"."release_group_secondary_type_join";
DROP TRIGGER IF EXISTS "apply_artist_release_group_pending_updates_mirror" ON "musicbrainz"."release_group_secondary_type";
DROP TRIGGER IF EXISTS "apply_artist_release_group_pending_updates_mirror" ON "musicbrainz"."release_group_primary_type";
DROP TRIGGER IF EXISTS "apply_artist_release_group_pending_updates_mirror" ON "musicbrainz"."release_group_meta";
DROP TRIGGER IF EXISTS "apply_artist_release_group_pending_updates_mirror" ON "musicbrainz"."release_group";
DROP TRIGGER IF EXISTS "apply_artist_release_group_pending_updates_mirror" ON "musicbrainz"."release";
DROP TRIGGER IF EXISTS "a_upd_track_mirror" ON "musicbrainz"."track";
DROP TRIGGER IF EXISTS "a_upd_release_mirror" ON "musicbrainz"."release";
DROP TRIGGER IF EXISTS "a_upd_release_label_mirror" ON "musicbrainz"."release_label";
DROP TRIGGER IF EXISTS "a_upd_release_group_secondary_type_mirror" ON "musicbrainz"."release_group_secondary_type";
DROP TRIGGER IF EXISTS "a_upd_release_group_primary_type_mirror" ON "musicbrainz"."release_group_primary_type";
DROP TRIGGER IF EXISTS "a_upd_release_group_mirror" ON "musicbrainz"."release_group";
DROP TRIGGER IF EXISTS "a_upd_release_group_meta_mirror" ON "musicbrainz"."release_group_meta";
DROP TRIGGER IF EXISTS "a_upd_release_event_mirror" ON "musicbrainz"."release_unknown_country";
DROP TRIGGER IF EXISTS "a_upd_release_event_mirror" ON "musicbrainz"."release_country";
DROP TRIGGER IF EXISTS "a_upd_medium" ON "musicbrainz"."medium";
DROP TRIGGER IF EXISTS "a_upd_l_area_area_mirror" ON "musicbrainz"."l_area_area";
DROP TRIGGER IF EXISTS "a_ins_track_mirror" ON "musicbrainz"."track";
DROP TRIGGER IF EXISTS "a_ins_release_mirror" ON "musicbrainz"."release";
DROP TRIGGER IF EXISTS "a_ins_release_label_mirror" ON "musicbrainz"."release_label";
DROP TRIGGER IF EXISTS "a_ins_release_group_secondary_type_join_mirror" ON "musicbrainz"."release_group_secondary_type_join";
DROP TRIGGER IF EXISTS "a_ins_release_group_mirror" ON "musicbrainz"."release_group";
DROP TRIGGER IF EXISTS "a_ins_release_event_mirror" ON "musicbrainz"."release_unknown_country";
DROP TRIGGER IF EXISTS "a_ins_release_event_mirror" ON "musicbrainz"."release_country";
DROP TRIGGER IF EXISTS "a_ins_l_area_area_mirror" ON "musicbrainz"."l_area_area";
DROP TRIGGER IF EXISTS "a_del_track_mirror" ON "musicbrainz"."track";
DROP TRIGGER IF EXISTS "a_del_release_mirror" ON "musicbrainz"."release";
DROP TRIGGER IF EXISTS "a_del_release_label_mirror" ON "musicbrainz"."release_label";
DROP TRIGGER IF EXISTS "a_del_release_group_secondary_type_join_mirror" ON "musicbrainz"."release_group_secondary_type_join";
DROP TRIGGER IF EXISTS "a_del_release_group_mirror" ON "musicbrainz"."release_group";
DROP TRIGGER IF EXISTS "a_del_release_event_mirror" ON "musicbrainz"."release_unknown_country";
DROP TRIGGER IF EXISTS "a_del_release_event_mirror" ON "musicbrainz"."release_country";
DROP TRIGGER IF EXISTS "a_del_l_area_area_mirror" ON "musicbrainz"."l_area_area";
DROP INDEX IF EXISTS "statistics"."statistic_name_date_collected";
DROP INDEX IF EXISTS "statistics"."statistic_name";
DROP INDEX IF EXISTS "sitemaps"."work_lastmod_idx_url";
DROP INDEX IF EXISTS "sitemaps"."tmp_checked_entities_idx_uniq";
DROP INDEX IF EXISTS "sitemaps"."release_lastmod_idx_url";
DROP INDEX IF EXISTS "sitemaps"."release_group_lastmod_idx_url";
DROP INDEX IF EXISTS "sitemaps"."recording_lastmod_idx_url";
DROP INDEX IF EXISTS "sitemaps"."place_lastmod_idx_url";
DROP INDEX IF EXISTS "sitemaps"."label_lastmod_idx_url";
DROP INDEX IF EXISTS "sitemaps"."artist_lastmod_idx_url";
DROP INDEX IF EXISTS "musicbrainz"."work_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."work_tag_raw_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."work_tag_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."work_idx_txt";
DROP INDEX IF EXISTS "musicbrainz"."work_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."work_idx_musicbrainz_collate";
DROP INDEX IF EXISTS "musicbrainz"."work_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."work_gid_redirect_idx_new_id";
DROP INDEX IF EXISTS "musicbrainz"."work_attribute_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."work_attribute_type_allowed_value_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."work_attribute_type_allowed_value_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."work_attribute_idx_work";
DROP INDEX IF EXISTS "musicbrainz"."work_alias_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."work_alias_idx_work";
DROP INDEX IF EXISTS "musicbrainz"."work_alias_idx_txt_sort";
DROP INDEX IF EXISTS "musicbrainz"."work_alias_idx_txt";
DROP INDEX IF EXISTS "musicbrainz"."work_alias_idx_primary";
DROP INDEX IF EXISTS "musicbrainz"."vote_idx_editor_vote_time";
DROP INDEX IF EXISTS "musicbrainz"."vote_idx_editor_edit";
DROP INDEX IF EXISTS "musicbrainz"."vote_idx_edit";
DROP INDEX IF EXISTS "musicbrainz"."url_idx_url";
DROP INDEX IF EXISTS "musicbrainz"."url_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."url_gid_redirect_idx_new_id";
DROP INDEX IF EXISTS "musicbrainz"."unreferenced_row_log_idx_inserted";
DROP INDEX IF EXISTS "musicbrainz"."track_raw_idx_release";
DROP INDEX IF EXISTS "musicbrainz"."track_idx_recording";
DROP INDEX IF EXISTS "musicbrainz"."track_idx_medium_position";
DROP INDEX IF EXISTS "musicbrainz"."track_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."track_idx_artist_credit";
DROP INDEX IF EXISTS "musicbrainz"."track_gid_redirect_idx_new_id";
DROP INDEX IF EXISTS "musicbrainz"."tag_idx_name_txt";
DROP INDEX IF EXISTS "musicbrainz"."tag_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."series_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."series_tag_raw_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."series_tag_raw_idx_series";
DROP INDEX IF EXISTS "musicbrainz"."series_tag_raw_idx_editor";
DROP INDEX IF EXISTS "musicbrainz"."series_tag_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."series_ordering_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."series_idx_txt";
DROP INDEX IF EXISTS "musicbrainz"."series_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."series_idx_lower_unaccent_name_comment";
DROP INDEX IF EXISTS "musicbrainz"."series_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."series_gid_redirect_idx_new_id";
DROP INDEX IF EXISTS "musicbrainz"."series_attribute_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."series_attribute_type_allowed_value_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."series_attribute_type_allowed_value_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."series_attribute_idx_series";
DROP INDEX IF EXISTS "musicbrainz"."series_alias_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."series_alias_idx_txt_sort";
DROP INDEX IF EXISTS "musicbrainz"."series_alias_idx_txt";
DROP INDEX IF EXISTS "musicbrainz"."series_alias_idx_series";
DROP INDEX IF EXISTS "musicbrainz"."series_alias_idx_primary";
DROP INDEX IF EXISTS "musicbrainz"."series_alias_idx_lower_unaccent_name";
DROP INDEX IF EXISTS "musicbrainz"."script_idx_iso_code";
DROP INDEX IF EXISTS "musicbrainz"."release_tag_raw_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."release_tag_raw_idx_editor";
DROP INDEX IF EXISTS "musicbrainz"."release_tag_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."release_status_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."release_packaging_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."release_label_idx_release";
DROP INDEX IF EXISTS "musicbrainz"."release_label_idx_label";
DROP INDEX IF EXISTS "musicbrainz"."release_idx_txt";
DROP INDEX IF EXISTS "musicbrainz"."release_idx_release_group";
DROP INDEX IF EXISTS "musicbrainz"."release_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."release_idx_musicbrainz_collate";
DROP INDEX IF EXISTS "musicbrainz"."release_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."release_idx_artist_credit";
DROP INDEX IF EXISTS "musicbrainz"."release_group_tag_raw_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."release_group_tag_raw_idx_editor";
DROP INDEX IF EXISTS "musicbrainz"."release_group_tag_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."release_group_secondary_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."release_group_rating_raw_idx_editor";
DROP INDEX IF EXISTS "musicbrainz"."release_group_primary_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."release_group_idx_txt";
DROP INDEX IF EXISTS "musicbrainz"."release_group_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."release_group_idx_musicbrainz_collate";
DROP INDEX IF EXISTS "musicbrainz"."release_group_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."release_group_idx_artist_credit";
DROP INDEX IF EXISTS "musicbrainz"."release_group_gid_redirect_idx_new_id";
DROP INDEX IF EXISTS "musicbrainz"."release_group_attribute_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."release_group_attribute_type_allowed_value_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."release_group_attribute_type_allowed_value_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."release_group_attribute_idx_release_group";
DROP INDEX IF EXISTS "musicbrainz"."release_group_alias_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."release_group_alias_idx_txt_sort";
DROP INDEX IF EXISTS "musicbrainz"."release_group_alias_idx_txt";
DROP INDEX IF EXISTS "musicbrainz"."release_group_alias_idx_release_group";
DROP INDEX IF EXISTS "musicbrainz"."release_group_alias_idx_primary";
DROP INDEX IF EXISTS "musicbrainz"."release_gid_redirect_idx_new_id";
DROP INDEX IF EXISTS "musicbrainz"."release_country_idx_country";
DROP INDEX IF EXISTS "musicbrainz"."release_attribute_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."release_attribute_type_allowed_value_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."release_attribute_type_allowed_value_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."release_attribute_idx_release";
DROP INDEX IF EXISTS "musicbrainz"."release_alias_idx_txt_sort";
DROP INDEX IF EXISTS "musicbrainz"."release_alias_idx_txt";
DROP INDEX IF EXISTS "musicbrainz"."release_alias_idx_release";
DROP INDEX IF EXISTS "musicbrainz"."release_alias_idx_primary";
DROP INDEX IF EXISTS "musicbrainz"."recording_tag_raw_idx_track";
DROP INDEX IF EXISTS "musicbrainz"."recording_tag_raw_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."recording_tag_raw_idx_editor";
DROP INDEX IF EXISTS "musicbrainz"."recording_tag_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."recording_rating_raw_idx_editor";
DROP INDEX IF EXISTS "musicbrainz"."recording_idx_txt";
DROP INDEX IF EXISTS "musicbrainz"."recording_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."recording_idx_musicbrainz_collate";
DROP INDEX IF EXISTS "musicbrainz"."recording_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."recording_idx_artist_credit";
DROP INDEX IF EXISTS "musicbrainz"."recording_gid_redirect_idx_new_id";
DROP INDEX IF EXISTS "musicbrainz"."recording_attribute_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."recording_attribute_type_allowed_value_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."recording_attribute_type_allowed_value_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."recording_attribute_idx_recording";
DROP INDEX IF EXISTS "musicbrainz"."recording_alias_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."recording_alias_idx_txt_sort";
DROP INDEX IF EXISTS "musicbrainz"."recording_alias_idx_txt";
DROP INDEX IF EXISTS "musicbrainz"."recording_alias_idx_recording";
DROP INDEX IF EXISTS "musicbrainz"."recording_alias_idx_primary";
DROP INDEX IF EXISTS "musicbrainz"."place_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."place_tag_raw_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."place_tag_raw_idx_editor";
DROP INDEX IF EXISTS "musicbrainz"."place_tag_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."place_rating_raw_idx_editor";
DROP INDEX IF EXISTS "musicbrainz"."place_idx_name_txt";
DROP INDEX IF EXISTS "musicbrainz"."place_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."place_idx_lower_unaccent_name_comment";
DROP INDEX IF EXISTS "musicbrainz"."place_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."place_idx_geo";
DROP INDEX IF EXISTS "musicbrainz"."place_idx_area";
DROP INDEX IF EXISTS "musicbrainz"."place_gid_redirect_idx_new_id";
DROP INDEX IF EXISTS "musicbrainz"."place_attribute_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."place_attribute_type_allowed_value_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."place_attribute_type_allowed_value_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."place_attribute_idx_place";
DROP INDEX IF EXISTS "musicbrainz"."place_alias_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."place_alias_idx_txt_sort";
DROP INDEX IF EXISTS "musicbrainz"."place_alias_idx_txt";
DROP INDEX IF EXISTS "musicbrainz"."place_alias_idx_primary";
DROP INDEX IF EXISTS "musicbrainz"."place_alias_idx_place";
DROP INDEX IF EXISTS "musicbrainz"."place_alias_idx_lower_unaccent_name";
DROP INDEX IF EXISTS "musicbrainz"."old_editor_name_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."mood_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."mood_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."mood_alias_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."mood_alias_idx_primary";
DROP INDEX IF EXISTS "musicbrainz"."mood_alias_idx_mood";
DROP INDEX IF EXISTS "musicbrainz"."medium_index_idx";
DROP INDEX IF EXISTS "musicbrainz"."medium_idx_track_count";
DROP INDEX IF EXISTS "musicbrainz"."medium_idx_release_position";
DROP INDEX IF EXISTS "musicbrainz"."medium_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."medium_gid_redirect_idx_new_id";
DROP INDEX IF EXISTS "musicbrainz"."medium_format_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."medium_cdtoc_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."medium_cdtoc_idx_medium";
DROP INDEX IF EXISTS "musicbrainz"."medium_cdtoc_idx_cdtoc";
DROP INDEX IF EXISTS "musicbrainz"."medium_attribute_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."medium_attribute_type_allowed_value_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."medium_attribute_type_allowed_value_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."medium_attribute_idx_medium";
DROP INDEX IF EXISTS "musicbrainz"."link_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."link_idx_type_attr";
DROP INDEX IF EXISTS "musicbrainz"."link_attribute_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."language_idx_iso_code_3";
DROP INDEX IF EXISTS "musicbrainz"."language_idx_iso_code_2t";
DROP INDEX IF EXISTS "musicbrainz"."language_idx_iso_code_2b";
DROP INDEX IF EXISTS "musicbrainz"."language_idx_iso_code_1";
DROP INDEX IF EXISTS "musicbrainz"."label_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."label_tag_raw_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."label_tag_raw_idx_editor";
DROP INDEX IF EXISTS "musicbrainz"."label_tag_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."label_rating_raw_idx_editor";
DROP INDEX IF EXISTS "musicbrainz"."label_idx_uniq_name_comment";
DROP INDEX IF EXISTS "musicbrainz"."label_idx_txt";
DROP INDEX IF EXISTS "musicbrainz"."label_idx_null_comment";
DROP INDEX IF EXISTS "musicbrainz"."label_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."label_idx_musicbrainz_collate";
DROP INDEX IF EXISTS "musicbrainz"."label_idx_lower_unaccent_name_comment";
DROP INDEX IF EXISTS "musicbrainz"."label_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."label_idx_area";
DROP INDEX IF EXISTS "musicbrainz"."label_gid_redirect_idx_new_id";
DROP INDEX IF EXISTS "musicbrainz"."label_attribute_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."label_attribute_type_allowed_value_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."label_attribute_type_allowed_value_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."label_attribute_idx_label";
DROP INDEX IF EXISTS "musicbrainz"."label_alias_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."label_alias_idx_txt_sort";
DROP INDEX IF EXISTS "musicbrainz"."label_alias_idx_txt";
DROP INDEX IF EXISTS "musicbrainz"."label_alias_idx_primary";
DROP INDEX IF EXISTS "musicbrainz"."label_alias_idx_lower_unaccent_name";
DROP INDEX IF EXISTS "musicbrainz"."label_alias_idx_label";
DROP INDEX IF EXISTS "musicbrainz"."l_work_work_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_work_work_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_url_work_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_url_work_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_url_url_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_url_url_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_series_work_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_series_work_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_series_url_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_series_url_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_series_series_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_series_series_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_release_work_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_release_work_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_release_url_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_release_url_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_release_series_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_release_series_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_release_release_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_release_release_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_release_release_group_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_release_release_group_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_release_group_work_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_release_group_work_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_release_group_url_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_release_group_url_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_release_group_series_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_release_group_series_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_release_group_release_group_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_release_group_release_group_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_recording_work_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_recording_work_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_recording_url_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_recording_url_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_recording_series_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_recording_series_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_recording_release_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_recording_release_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_recording_release_group_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_recording_release_group_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_recording_recording_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_recording_recording_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_place_work_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_place_work_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_place_url_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_place_url_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_place_series_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_place_series_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_place_release_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_place_release_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_place_release_group_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_place_release_group_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_place_recording_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_place_recording_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_place_place_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_place_place_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_mood_work_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_mood_work_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_mood_url_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_mood_url_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_mood_series_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_mood_series_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_mood_release_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_mood_release_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_mood_release_group_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_mood_release_group_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_mood_recording_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_mood_recording_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_mood_place_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_mood_place_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_mood_mood_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_mood_mood_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_label_work_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_label_work_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_label_url_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_label_url_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_label_series_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_label_series_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_label_release_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_label_release_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_label_release_group_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_label_release_group_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_label_recording_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_label_recording_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_label_place_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_label_place_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_label_mood_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_label_mood_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_label_label_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_label_label_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_instrument_work_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_instrument_work_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_instrument_url_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_instrument_url_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_instrument_series_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_instrument_series_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_instrument_release_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_instrument_release_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_instrument_release_group_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_instrument_release_group_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_instrument_recording_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_instrument_recording_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_instrument_place_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_instrument_place_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_instrument_mood_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_instrument_mood_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_instrument_label_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_instrument_label_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_instrument_instrument_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_instrument_instrument_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_work_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_work_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_url_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_url_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_series_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_series_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_release_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_release_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_release_group_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_release_group_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_recording_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_recording_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_place_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_place_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_mood_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_mood_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_label_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_label_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_instrument_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_instrument_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_genre_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_genre_genre_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_event_work_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_event_work_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_event_url_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_event_url_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_event_series_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_event_series_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_event_release_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_event_release_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_event_release_group_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_event_release_group_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_event_recording_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_event_recording_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_event_place_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_event_place_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_event_mood_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_event_mood_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_event_label_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_event_label_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_event_instrument_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_event_instrument_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_event_genre_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_event_genre_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_event_event_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_event_event_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_work_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_work_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_url_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_url_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_series_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_series_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_release_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_release_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_release_group_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_release_group_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_recording_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_recording_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_place_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_place_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_mood_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_mood_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_label_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_label_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_instrument_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_instrument_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_genre_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_genre_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_event_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_event_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_artist_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_artist_artist_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_area_work_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_area_work_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_area_url_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_area_url_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_area_series_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_area_series_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_area_release_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_area_release_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_area_release_group_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_area_release_group_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_area_recording_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_area_recording_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_area_place_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_area_place_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_area_mood_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_area_mood_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_area_label_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_area_label_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_area_instrument_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_area_instrument_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_area_genre_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_area_genre_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_area_event_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_area_event_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_area_artist_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_area_artist_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."l_area_area_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."l_area_area_idx_entity1";
DROP INDEX IF EXISTS "musicbrainz"."iswc_idx_work";
DROP INDEX IF EXISTS "musicbrainz"."iswc_idx_iswc";
DROP INDEX IF EXISTS "musicbrainz"."isrc_idx_recording";
DROP INDEX IF EXISTS "musicbrainz"."isrc_idx_isrc_recording";
DROP INDEX IF EXISTS "musicbrainz"."isrc_idx_isrc";
DROP INDEX IF EXISTS "musicbrainz"."iso_3166_3_idx_area";
DROP INDEX IF EXISTS "musicbrainz"."iso_3166_2_idx_area";
DROP INDEX IF EXISTS "musicbrainz"."iso_3166_1_idx_area";
DROP INDEX IF EXISTS "musicbrainz"."instrument_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."instrument_tag_raw_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."instrument_tag_raw_idx_instrument";
DROP INDEX IF EXISTS "musicbrainz"."instrument_tag_raw_idx_editor";
DROP INDEX IF EXISTS "musicbrainz"."instrument_tag_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."instrument_idx_txt";
DROP INDEX IF EXISTS "musicbrainz"."instrument_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."instrument_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."instrument_gid_redirect_idx_new_id";
DROP INDEX IF EXISTS "musicbrainz"."instrument_attribute_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."instrument_attribute_type_allowed_value_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."instrument_attribute_type_allowed_value_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."instrument_attribute_idx_instrument";
DROP INDEX IF EXISTS "musicbrainz"."instrument_alias_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."instrument_alias_idx_primary";
DROP INDEX IF EXISTS "musicbrainz"."instrument_alias_idx_instrument";
DROP INDEX IF EXISTS "musicbrainz"."genre_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."genre_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."genre_alias_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."genre_alias_idx_primary";
DROP INDEX IF EXISTS "musicbrainz"."genre_alias_idx_genre";
DROP INDEX IF EXISTS "musicbrainz"."gender_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."event_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."event_tag_raw_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."event_tag_raw_idx_editor";
DROP INDEX IF EXISTS "musicbrainz"."event_tag_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."event_rating_raw_idx_editor";
DROP INDEX IF EXISTS "musicbrainz"."event_idx_txt";
DROP INDEX IF EXISTS "musicbrainz"."event_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."event_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."event_gid_redirect_idx_new_id";
DROP INDEX IF EXISTS "musicbrainz"."event_attribute_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."event_attribute_type_allowed_value_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."event_attribute_type_allowed_value_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."event_attribute_idx_event";
DROP INDEX IF EXISTS "musicbrainz"."event_alias_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."event_alias_idx_txt_sort";
DROP INDEX IF EXISTS "musicbrainz"."event_alias_idx_txt";
DROP INDEX IF EXISTS "musicbrainz"."event_alias_idx_primary";
DROP INDEX IF EXISTS "musicbrainz"."event_alias_idx_event";
DROP INDEX IF EXISTS "musicbrainz"."editor_subscribe_series_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."editor_subscribe_series_idx_series";
DROP INDEX IF EXISTS "musicbrainz"."editor_subscribe_label_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."editor_subscribe_label_idx_label";
DROP INDEX IF EXISTS "musicbrainz"."editor_subscribe_editor_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."editor_subscribe_collection_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."editor_subscribe_collection_idx_collection";
DROP INDEX IF EXISTS "musicbrainz"."editor_subscribe_artist_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."editor_subscribe_artist_idx_artist";
DROP INDEX IF EXISTS "musicbrainz"."editor_preference_idx_editor_name";
DROP INDEX IF EXISTS "musicbrainz"."editor_oauth_token_idx_refresh_token";
DROP INDEX IF EXISTS "musicbrainz"."editor_oauth_token_idx_editor";
DROP INDEX IF EXISTS "musicbrainz"."editor_oauth_token_idx_access_token";
DROP INDEX IF EXISTS "musicbrainz"."editor_language_idx_language";
DROP INDEX IF EXISTS "musicbrainz"."editor_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."editor_collection_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."editor_collection_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."editor_collection_idx_editor";
DROP INDEX IF EXISTS "musicbrainz"."editor_collection_gid_redirect_idx_new_id";
DROP INDEX IF EXISTS "musicbrainz"."edit_work_idx";
DROP INDEX IF EXISTS "musicbrainz"."edit_url_idx";
DROP INDEX IF EXISTS "musicbrainz"."edit_series_idx";
DROP INDEX IF EXISTS "musicbrainz"."edit_release_idx";
DROP INDEX IF EXISTS "musicbrainz"."edit_release_group_idx";
DROP INDEX IF EXISTS "musicbrainz"."edit_recording_idx";
DROP INDEX IF EXISTS "musicbrainz"."edit_place_idx";
DROP INDEX IF EXISTS "musicbrainz"."edit_note_recipient_idx_recipient";
DROP INDEX IF EXISTS "musicbrainz"."edit_note_idx_editor";
DROP INDEX IF EXISTS "musicbrainz"."edit_note_idx_edit";
DROP INDEX IF EXISTS "musicbrainz"."edit_note_change_idx_edit_note";
DROP INDEX IF EXISTS "musicbrainz"."edit_mood_idx";
DROP INDEX IF EXISTS "musicbrainz"."edit_label_idx_status";
DROP INDEX IF EXISTS "musicbrainz"."edit_label_idx";
DROP INDEX IF EXISTS "musicbrainz"."edit_instrument_idx";
DROP INDEX IF EXISTS "musicbrainz"."edit_idx_type_id";
DROP INDEX IF EXISTS "musicbrainz"."edit_idx_status_id";
DROP INDEX IF EXISTS "musicbrainz"."edit_idx_open_time";
DROP INDEX IF EXISTS "musicbrainz"."edit_idx_expire_time";
DROP INDEX IF EXISTS "musicbrainz"."edit_idx_editor_open_time";
DROP INDEX IF EXISTS "musicbrainz"."edit_idx_editor_id_desc";
DROP INDEX IF EXISTS "musicbrainz"."edit_idx_close_time";
DROP INDEX IF EXISTS "musicbrainz"."edit_genre_idx";
DROP INDEX IF EXISTS "musicbrainz"."edit_event_idx";
DROP INDEX IF EXISTS "musicbrainz"."edit_data_idx_link_type";
DROP INDEX IF EXISTS "musicbrainz"."edit_artist_idx_status";
DROP INDEX IF EXISTS "musicbrainz"."edit_artist_idx";
DROP INDEX IF EXISTS "musicbrainz"."edit_area_idx";
DROP INDEX IF EXISTS "musicbrainz"."dbmirror_pending_xid_index";
DROP INDEX IF EXISTS "musicbrainz"."cdtoc_raw_toc";
DROP INDEX IF EXISTS "musicbrainz"."cdtoc_raw_discid";
DROP INDEX IF EXISTS "musicbrainz"."cdtoc_idx_freedb_id";
DROP INDEX IF EXISTS "musicbrainz"."cdtoc_idx_discid";
DROP INDEX IF EXISTS "musicbrainz"."artist_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."artist_tag_raw_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."artist_tag_raw_idx_editor";
DROP INDEX IF EXISTS "musicbrainz"."artist_tag_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."artist_release_va_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."artist_release_va_idx_sort";
DROP INDEX IF EXISTS "musicbrainz"."artist_release_pending_update_idx_release";
DROP INDEX IF EXISTS "musicbrainz"."artist_release_nonva_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."artist_release_nonva_idx_sort";
DROP INDEX IF EXISTS "musicbrainz"."artist_release_group_va_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."artist_release_group_va_idx_sort";
DROP INDEX IF EXISTS "musicbrainz"."artist_release_group_pending_update_idx_release_group";
DROP INDEX IF EXISTS "musicbrainz"."artist_release_group_nonva_idx_uniq";
DROP INDEX IF EXISTS "musicbrainz"."artist_release_group_nonva_idx_sort";
DROP INDEX IF EXISTS "musicbrainz"."artist_rating_raw_idx_editor";
DROP INDEX IF EXISTS "musicbrainz"."artist_idx_uniq_name_comment";
DROP INDEX IF EXISTS "musicbrainz"."artist_idx_txt_sort";
DROP INDEX IF EXISTS "musicbrainz"."artist_idx_txt";
DROP INDEX IF EXISTS "musicbrainz"."artist_idx_sort_name";
DROP INDEX IF EXISTS "musicbrainz"."artist_idx_null_comment";
DROP INDEX IF EXISTS "musicbrainz"."artist_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."artist_idx_musicbrainz_collate";
DROP INDEX IF EXISTS "musicbrainz"."artist_idx_lower_unaccent_name_comment";
DROP INDEX IF EXISTS "musicbrainz"."artist_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."artist_idx_end_area";
DROP INDEX IF EXISTS "musicbrainz"."artist_idx_begin_area";
DROP INDEX IF EXISTS "musicbrainz"."artist_idx_area";
DROP INDEX IF EXISTS "musicbrainz"."artist_gid_redirect_idx_new_id";
DROP INDEX IF EXISTS "musicbrainz"."artist_credit_name_idx_txt";
DROP INDEX IF EXISTS "musicbrainz"."artist_credit_name_idx_musicbrainz_collate";
DROP INDEX IF EXISTS "musicbrainz"."artist_credit_name_idx_artist";
DROP INDEX IF EXISTS "musicbrainz"."artist_credit_idx_txt";
DROP INDEX IF EXISTS "musicbrainz"."artist_credit_idx_musicbrainz_collate";
DROP INDEX IF EXISTS "musicbrainz"."artist_credit_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."artist_credit_gid_redirect_idx_new_id";
DROP INDEX IF EXISTS "musicbrainz"."artist_attribute_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."artist_attribute_type_allowed_value_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."artist_attribute_type_allowed_value_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."artist_attribute_idx_artist";
DROP INDEX IF EXISTS "musicbrainz"."artist_alias_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."artist_alias_idx_txt_sort";
DROP INDEX IF EXISTS "musicbrainz"."artist_alias_idx_txt";
DROP INDEX IF EXISTS "musicbrainz"."artist_alias_idx_primary";
DROP INDEX IF EXISTS "musicbrainz"."artist_alias_idx_lower_unaccent_name";
DROP INDEX IF EXISTS "musicbrainz"."artist_alias_idx_artist";
DROP INDEX IF EXISTS "musicbrainz"."area_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."area_tag_raw_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."area_tag_raw_idx_editor";
DROP INDEX IF EXISTS "musicbrainz"."area_tag_raw_idx_area";
DROP INDEX IF EXISTS "musicbrainz"."area_tag_idx_tag";
DROP INDEX IF EXISTS "musicbrainz"."area_idx_name_txt";
DROP INDEX IF EXISTS "musicbrainz"."area_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."area_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."area_gid_redirect_idx_new_id";
DROP INDEX IF EXISTS "musicbrainz"."area_containment_idx_parent";
DROP INDEX IF EXISTS "musicbrainz"."area_attribute_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."area_attribute_type_allowed_value_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."area_attribute_type_allowed_value_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."area_attribute_idx_area";
DROP INDEX IF EXISTS "musicbrainz"."area_alias_type_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."area_alias_idx_txt_sort";
DROP INDEX IF EXISTS "musicbrainz"."area_alias_idx_txt";
DROP INDEX IF EXISTS "musicbrainz"."area_alias_idx_primary";
DROP INDEX IF EXISTS "musicbrainz"."area_alias_idx_area";
DROP INDEX IF EXISTS "musicbrainz"."application_idx_owner";
DROP INDEX IF EXISTS "musicbrainz"."application_idx_oauth_id";
DROP INDEX IF EXISTS "musicbrainz"."alternative_track_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."alternative_track_idx_artist_credit";
DROP INDEX IF EXISTS "musicbrainz"."alternative_release_idx_release";
DROP INDEX IF EXISTS "musicbrainz"."alternative_release_idx_name";
DROP INDEX IF EXISTS "musicbrainz"."alternative_release_idx_language_script";
DROP INDEX IF EXISTS "musicbrainz"."alternative_release_idx_gid";
DROP INDEX IF EXISTS "musicbrainz"."alternative_release_idx_artist_credit";
DROP INDEX IF EXISTS "musicbrainz"."alternative_medium_idx_alternative_release";
DROP INDEX IF EXISTS "json_dump"."tmp_checked_entities_idx_uniq";
DROP INDEX IF EXISTS "json_dump"."deleted_entities_idx_replication_sequence";
DROP INDEX IF EXISTS "event_art_archive"."event_art_idx_event";
DROP INDEX IF EXISTS "event_art_archive"."art_type_idx_gid";
DROP INDEX IF EXISTS "dbmirror2"."pending_data_idx_xid_seqid";
DROP INDEX IF EXISTS "dbmirror2"."pending_data_idx_oldctid_xid";
DROP INDEX IF EXISTS "cover_art_archive"."cover_art_idx_release";
DROP INDEX IF EXISTS "cover_art_archive"."art_type_idx_gid";
ALTER TABLE IF EXISTS ONLY "wikidocs"."wikidocs_index" DROP CONSTRAINT IF EXISTS "wikidocs_index_pkey";
ALTER TABLE IF EXISTS ONLY "statistics"."statistic" DROP CONSTRAINT IF EXISTS "statistic_pkey";
ALTER TABLE IF EXISTS ONLY "statistics"."statistic_event" DROP CONSTRAINT IF EXISTS "statistic_event_pkey";
ALTER TABLE IF EXISTS ONLY "report"."index" DROP CONSTRAINT IF EXISTS "index_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."work_type" DROP CONSTRAINT IF EXISTS "work_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."work_tag_raw" DROP CONSTRAINT IF EXISTS "work_tag_raw_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."work_tag" DROP CONSTRAINT IF EXISTS "work_tag_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."work_rating_raw" DROP CONSTRAINT IF EXISTS "work_rating_raw_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."work" DROP CONSTRAINT IF EXISTS "work_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."work_meta" DROP CONSTRAINT IF EXISTS "work_meta_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."work_language" DROP CONSTRAINT IF EXISTS "work_language_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."work_gid_redirect" DROP CONSTRAINT IF EXISTS "work_gid_redirect_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."work_attribute_type" DROP CONSTRAINT IF EXISTS "work_attribute_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."work_attribute_type_allowed_value" DROP CONSTRAINT IF EXISTS "work_attribute_type_allowed_value_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."work_attribute" DROP CONSTRAINT IF EXISTS "work_attribute_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."work_annotation" DROP CONSTRAINT IF EXISTS "work_annotation_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."work_alias_type" DROP CONSTRAINT IF EXISTS "work_alias_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."work_alias" DROP CONSTRAINT IF EXISTS "work_alias_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."vote" DROP CONSTRAINT IF EXISTS "vote_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."url" DROP CONSTRAINT IF EXISTS "url_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."url_gid_redirect" DROP CONSTRAINT IF EXISTS "url_gid_redirect_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."unreferenced_row_log" DROP CONSTRAINT IF EXISTS "unreferenced_row_log_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."track_raw" DROP CONSTRAINT IF EXISTS "track_raw_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."track" DROP CONSTRAINT IF EXISTS "track_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."track_gid_redirect" DROP CONSTRAINT IF EXISTS "track_gid_redirect_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."tag_relation" DROP CONSTRAINT IF EXISTS "tag_relation_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."tag" DROP CONSTRAINT IF EXISTS "tag_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."series_type" DROP CONSTRAINT IF EXISTS "series_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."series_tag_raw" DROP CONSTRAINT IF EXISTS "series_tag_raw_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."series_tag" DROP CONSTRAINT IF EXISTS "series_tag_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."series" DROP CONSTRAINT IF EXISTS "series_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."series_ordering_type" DROP CONSTRAINT IF EXISTS "series_ordering_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."series_gid_redirect" DROP CONSTRAINT IF EXISTS "series_gid_redirect_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."series_attribute_type" DROP CONSTRAINT IF EXISTS "series_attribute_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."series_attribute_type_allowed_value" DROP CONSTRAINT IF EXISTS "series_attribute_type_allowed_value_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."series_attribute" DROP CONSTRAINT IF EXISTS "series_attribute_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."series_annotation" DROP CONSTRAINT IF EXISTS "series_annotation_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."series_alias_type" DROP CONSTRAINT IF EXISTS "series_alias_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."series_alias" DROP CONSTRAINT IF EXISTS "series_alias_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."script" DROP CONSTRAINT IF EXISTS "script_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."replication_control" DROP CONSTRAINT IF EXISTS "replication_control_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_unknown_country" DROP CONSTRAINT IF EXISTS "release_unknown_country_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_tag_raw" DROP CONSTRAINT IF EXISTS "release_tag_raw_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_tag" DROP CONSTRAINT IF EXISTS "release_tag_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_status" DROP CONSTRAINT IF EXISTS "release_status_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_raw" DROP CONSTRAINT IF EXISTS "release_raw_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release" DROP CONSTRAINT IF EXISTS "release_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_packaging" DROP CONSTRAINT IF EXISTS "release_packaging_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_meta" DROP CONSTRAINT IF EXISTS "release_meta_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_label" DROP CONSTRAINT IF EXISTS "release_label_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_group_tag_raw" DROP CONSTRAINT IF EXISTS "release_group_tag_raw_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_group_tag" DROP CONSTRAINT IF EXISTS "release_group_tag_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_group_secondary_type" DROP CONSTRAINT IF EXISTS "release_group_secondary_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_group_secondary_type_join" DROP CONSTRAINT IF EXISTS "release_group_secondary_type_join_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_group_rating_raw" DROP CONSTRAINT IF EXISTS "release_group_rating_raw_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_group_primary_type" DROP CONSTRAINT IF EXISTS "release_group_primary_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_group" DROP CONSTRAINT IF EXISTS "release_group_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_group_meta" DROP CONSTRAINT IF EXISTS "release_group_meta_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_group_gid_redirect" DROP CONSTRAINT IF EXISTS "release_group_gid_redirect_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_group_attribute_type" DROP CONSTRAINT IF EXISTS "release_group_attribute_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_group_attribute_type_allowed_value" DROP CONSTRAINT IF EXISTS "release_group_attribute_type_allowed_value_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_group_attribute" DROP CONSTRAINT IF EXISTS "release_group_attribute_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_group_annotation" DROP CONSTRAINT IF EXISTS "release_group_annotation_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_group_alias_type" DROP CONSTRAINT IF EXISTS "release_group_alias_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_group_alias" DROP CONSTRAINT IF EXISTS "release_group_alias_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_gid_redirect" DROP CONSTRAINT IF EXISTS "release_gid_redirect_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_first_release_date" DROP CONSTRAINT IF EXISTS "release_first_release_date_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_country" DROP CONSTRAINT IF EXISTS "release_country_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_attribute_type" DROP CONSTRAINT IF EXISTS "release_attribute_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_attribute_type_allowed_value" DROP CONSTRAINT IF EXISTS "release_attribute_type_allowed_value_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_attribute" DROP CONSTRAINT IF EXISTS "release_attribute_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_annotation" DROP CONSTRAINT IF EXISTS "release_annotation_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_alias_type" DROP CONSTRAINT IF EXISTS "release_alias_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."release_alias" DROP CONSTRAINT IF EXISTS "release_alias_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."recording_tag_raw" DROP CONSTRAINT IF EXISTS "recording_tag_raw_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."recording_tag" DROP CONSTRAINT IF EXISTS "recording_tag_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."recording_rating_raw" DROP CONSTRAINT IF EXISTS "recording_rating_raw_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."recording" DROP CONSTRAINT IF EXISTS "recording_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."recording_meta" DROP CONSTRAINT IF EXISTS "recording_meta_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."recording_gid_redirect" DROP CONSTRAINT IF EXISTS "recording_gid_redirect_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."recording_first_release_date" DROP CONSTRAINT IF EXISTS "recording_first_release_date_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."recording_attribute_type" DROP CONSTRAINT IF EXISTS "recording_attribute_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."recording_attribute_type_allowed_value" DROP CONSTRAINT IF EXISTS "recording_attribute_type_allowed_value_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."recording_attribute" DROP CONSTRAINT IF EXISTS "recording_attribute_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."recording_annotation" DROP CONSTRAINT IF EXISTS "recording_annotation_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."recording_alias_type" DROP CONSTRAINT IF EXISTS "recording_alias_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."recording_alias" DROP CONSTRAINT IF EXISTS "recording_alias_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."place_type" DROP CONSTRAINT IF EXISTS "place_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."place_tag_raw" DROP CONSTRAINT IF EXISTS "place_tag_raw_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."place_tag" DROP CONSTRAINT IF EXISTS "place_tag_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."place_rating_raw" DROP CONSTRAINT IF EXISTS "place_rating_raw_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."place" DROP CONSTRAINT IF EXISTS "place_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."place_meta" DROP CONSTRAINT IF EXISTS "place_meta_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."place_gid_redirect" DROP CONSTRAINT IF EXISTS "place_gid_redirect_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."place_attribute_type" DROP CONSTRAINT IF EXISTS "place_attribute_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."place_attribute_type_allowed_value" DROP CONSTRAINT IF EXISTS "place_attribute_type_allowed_value_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."place_attribute" DROP CONSTRAINT IF EXISTS "place_attribute_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."place_annotation" DROP CONSTRAINT IF EXISTS "place_annotation_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."place_alias_type" DROP CONSTRAINT IF EXISTS "place_alias_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."place_alias" DROP CONSTRAINT IF EXISTS "place_alias_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."orderable_link_type" DROP CONSTRAINT IF EXISTS "orderable_link_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."mood" DROP CONSTRAINT IF EXISTS "mood_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."mood_annotation" DROP CONSTRAINT IF EXISTS "mood_annotation_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."mood_alias_type" DROP CONSTRAINT IF EXISTS "mood_alias_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."mood_alias" DROP CONSTRAINT IF EXISTS "mood_alias_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."medium" DROP CONSTRAINT IF EXISTS "medium_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."medium_index" DROP CONSTRAINT IF EXISTS "medium_index_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."medium_gid_redirect" DROP CONSTRAINT IF EXISTS "medium_gid_redirect_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."medium_format" DROP CONSTRAINT IF EXISTS "medium_format_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."medium_cdtoc" DROP CONSTRAINT IF EXISTS "medium_cdtoc_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."medium_attribute_type" DROP CONSTRAINT IF EXISTS "medium_attribute_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."medium_attribute_type_allowed_value" DROP CONSTRAINT IF EXISTS "medium_attribute_type_allowed_value_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."medium_attribute_type_allowed_value_allowed_format" DROP CONSTRAINT IF EXISTS "medium_attribute_type_allowed_value_allowed_format_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."medium_attribute_type_allowed_format" DROP CONSTRAINT IF EXISTS "medium_attribute_type_allowed_format_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."medium_attribute" DROP CONSTRAINT IF EXISTS "medium_attribute_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."link_type" DROP CONSTRAINT IF EXISTS "link_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."link_type_attribute_type" DROP CONSTRAINT IF EXISTS "link_type_attribute_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."link_text_attribute_type" DROP CONSTRAINT IF EXISTS "link_text_attribute_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."link" DROP CONSTRAINT IF EXISTS "link_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."link_creditable_attribute_type" DROP CONSTRAINT IF EXISTS "link_creditable_attribute_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."link_attribute_type" DROP CONSTRAINT IF EXISTS "link_attribute_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."link_attribute_text_value" DROP CONSTRAINT IF EXISTS "link_attribute_text_value_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."link_attribute" DROP CONSTRAINT IF EXISTS "link_attribute_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."link_attribute_credit" DROP CONSTRAINT IF EXISTS "link_attribute_credit_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."language" DROP CONSTRAINT IF EXISTS "language_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."label_type" DROP CONSTRAINT IF EXISTS "label_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."label_tag_raw" DROP CONSTRAINT IF EXISTS "label_tag_raw_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."label_tag" DROP CONSTRAINT IF EXISTS "label_tag_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."label_rating_raw" DROP CONSTRAINT IF EXISTS "label_rating_raw_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."label" DROP CONSTRAINT IF EXISTS "label_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."label_meta" DROP CONSTRAINT IF EXISTS "label_meta_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."label_isni" DROP CONSTRAINT IF EXISTS "label_isni_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."label_ipi" DROP CONSTRAINT IF EXISTS "label_ipi_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."label_gid_redirect" DROP CONSTRAINT IF EXISTS "label_gid_redirect_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."label_attribute_type" DROP CONSTRAINT IF EXISTS "label_attribute_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."label_attribute_type_allowed_value" DROP CONSTRAINT IF EXISTS "label_attribute_type_allowed_value_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."label_attribute" DROP CONSTRAINT IF EXISTS "label_attribute_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."label_annotation" DROP CONSTRAINT IF EXISTS "label_annotation_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."label_alias_type" DROP CONSTRAINT IF EXISTS "label_alias_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."label_alias" DROP CONSTRAINT IF EXISTS "label_alias_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_work_work" DROP CONSTRAINT IF EXISTS "l_work_work_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_url_work" DROP CONSTRAINT IF EXISTS "l_url_work_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_url_url" DROP CONSTRAINT IF EXISTS "l_url_url_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_series_work" DROP CONSTRAINT IF EXISTS "l_series_work_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_series_url" DROP CONSTRAINT IF EXISTS "l_series_url_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_series_series" DROP CONSTRAINT IF EXISTS "l_series_series_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_release_work" DROP CONSTRAINT IF EXISTS "l_release_work_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_release_url" DROP CONSTRAINT IF EXISTS "l_release_url_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_release_series" DROP CONSTRAINT IF EXISTS "l_release_series_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_release_release" DROP CONSTRAINT IF EXISTS "l_release_release_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_release_release_group" DROP CONSTRAINT IF EXISTS "l_release_release_group_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_release_group_work" DROP CONSTRAINT IF EXISTS "l_release_group_work_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_release_group_url" DROP CONSTRAINT IF EXISTS "l_release_group_url_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_release_group_series" DROP CONSTRAINT IF EXISTS "l_release_group_series_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_release_group_release_group" DROP CONSTRAINT IF EXISTS "l_release_group_release_group_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_recording_work" DROP CONSTRAINT IF EXISTS "l_recording_work_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_recording_url" DROP CONSTRAINT IF EXISTS "l_recording_url_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_recording_series" DROP CONSTRAINT IF EXISTS "l_recording_series_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_recording_release" DROP CONSTRAINT IF EXISTS "l_recording_release_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_recording_release_group" DROP CONSTRAINT IF EXISTS "l_recording_release_group_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_recording_recording" DROP CONSTRAINT IF EXISTS "l_recording_recording_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_place_work" DROP CONSTRAINT IF EXISTS "l_place_work_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_place_url" DROP CONSTRAINT IF EXISTS "l_place_url_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_place_series" DROP CONSTRAINT IF EXISTS "l_place_series_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_place_release" DROP CONSTRAINT IF EXISTS "l_place_release_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_place_release_group" DROP CONSTRAINT IF EXISTS "l_place_release_group_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_place_recording" DROP CONSTRAINT IF EXISTS "l_place_recording_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_place_place" DROP CONSTRAINT IF EXISTS "l_place_place_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_mood_work" DROP CONSTRAINT IF EXISTS "l_mood_work_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_mood_url" DROP CONSTRAINT IF EXISTS "l_mood_url_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_mood_series" DROP CONSTRAINT IF EXISTS "l_mood_series_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_mood_release" DROP CONSTRAINT IF EXISTS "l_mood_release_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_mood_release_group" DROP CONSTRAINT IF EXISTS "l_mood_release_group_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_mood_recording" DROP CONSTRAINT IF EXISTS "l_mood_recording_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_mood_place" DROP CONSTRAINT IF EXISTS "l_mood_place_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_mood_mood" DROP CONSTRAINT IF EXISTS "l_mood_mood_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_label_work" DROP CONSTRAINT IF EXISTS "l_label_work_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_label_url" DROP CONSTRAINT IF EXISTS "l_label_url_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_label_series" DROP CONSTRAINT IF EXISTS "l_label_series_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_label_release" DROP CONSTRAINT IF EXISTS "l_label_release_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_label_release_group" DROP CONSTRAINT IF EXISTS "l_label_release_group_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_label_recording" DROP CONSTRAINT IF EXISTS "l_label_recording_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_label_place" DROP CONSTRAINT IF EXISTS "l_label_place_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_label_mood" DROP CONSTRAINT IF EXISTS "l_label_mood_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_label_label" DROP CONSTRAINT IF EXISTS "l_label_label_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_instrument_work" DROP CONSTRAINT IF EXISTS "l_instrument_work_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_instrument_url" DROP CONSTRAINT IF EXISTS "l_instrument_url_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_instrument_series" DROP CONSTRAINT IF EXISTS "l_instrument_series_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_instrument_release" DROP CONSTRAINT IF EXISTS "l_instrument_release_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_instrument_release_group" DROP CONSTRAINT IF EXISTS "l_instrument_release_group_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_instrument_recording" DROP CONSTRAINT IF EXISTS "l_instrument_recording_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_instrument_place" DROP CONSTRAINT IF EXISTS "l_instrument_place_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_instrument_mood" DROP CONSTRAINT IF EXISTS "l_instrument_mood_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_instrument_label" DROP CONSTRAINT IF EXISTS "l_instrument_label_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_instrument_instrument" DROP CONSTRAINT IF EXISTS "l_instrument_instrument_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_genre_work" DROP CONSTRAINT IF EXISTS "l_genre_work_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_genre_url" DROP CONSTRAINT IF EXISTS "l_genre_url_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_genre_series" DROP CONSTRAINT IF EXISTS "l_genre_series_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_genre_release" DROP CONSTRAINT IF EXISTS "l_genre_release_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_genre_release_group" DROP CONSTRAINT IF EXISTS "l_genre_release_group_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_genre_recording" DROP CONSTRAINT IF EXISTS "l_genre_recording_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_genre_place" DROP CONSTRAINT IF EXISTS "l_genre_place_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_genre_mood" DROP CONSTRAINT IF EXISTS "l_genre_mood_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_genre_label" DROP CONSTRAINT IF EXISTS "l_genre_label_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_genre_instrument" DROP CONSTRAINT IF EXISTS "l_genre_instrument_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_genre_genre" DROP CONSTRAINT IF EXISTS "l_genre_genre_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_event_work" DROP CONSTRAINT IF EXISTS "l_event_work_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_event_url" DROP CONSTRAINT IF EXISTS "l_event_url_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_event_series" DROP CONSTRAINT IF EXISTS "l_event_series_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_event_release" DROP CONSTRAINT IF EXISTS "l_event_release_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_event_release_group" DROP CONSTRAINT IF EXISTS "l_event_release_group_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_event_recording" DROP CONSTRAINT IF EXISTS "l_event_recording_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_event_place" DROP CONSTRAINT IF EXISTS "l_event_place_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_event_mood" DROP CONSTRAINT IF EXISTS "l_event_mood_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_event_label" DROP CONSTRAINT IF EXISTS "l_event_label_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_event_instrument" DROP CONSTRAINT IF EXISTS "l_event_instrument_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_event_genre" DROP CONSTRAINT IF EXISTS "l_event_genre_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_event_event" DROP CONSTRAINT IF EXISTS "l_event_event_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_artist_work" DROP CONSTRAINT IF EXISTS "l_artist_work_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_artist_url" DROP CONSTRAINT IF EXISTS "l_artist_url_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_artist_series" DROP CONSTRAINT IF EXISTS "l_artist_series_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_artist_release" DROP CONSTRAINT IF EXISTS "l_artist_release_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_artist_release_group" DROP CONSTRAINT IF EXISTS "l_artist_release_group_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_artist_recording" DROP CONSTRAINT IF EXISTS "l_artist_recording_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_artist_place" DROP CONSTRAINT IF EXISTS "l_artist_place_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_artist_mood" DROP CONSTRAINT IF EXISTS "l_artist_mood_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_artist_label" DROP CONSTRAINT IF EXISTS "l_artist_label_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_artist_instrument" DROP CONSTRAINT IF EXISTS "l_artist_instrument_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_artist_genre" DROP CONSTRAINT IF EXISTS "l_artist_genre_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_artist_event" DROP CONSTRAINT IF EXISTS "l_artist_event_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_artist_artist" DROP CONSTRAINT IF EXISTS "l_artist_artist_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_area_work" DROP CONSTRAINT IF EXISTS "l_area_work_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_area_url" DROP CONSTRAINT IF EXISTS "l_area_url_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_area_series" DROP CONSTRAINT IF EXISTS "l_area_series_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_area_release" DROP CONSTRAINT IF EXISTS "l_area_release_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_area_release_group" DROP CONSTRAINT IF EXISTS "l_area_release_group_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_area_recording" DROP CONSTRAINT IF EXISTS "l_area_recording_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_area_place" DROP CONSTRAINT IF EXISTS "l_area_place_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_area_mood" DROP CONSTRAINT IF EXISTS "l_area_mood_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_area_label" DROP CONSTRAINT IF EXISTS "l_area_label_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_area_instrument" DROP CONSTRAINT IF EXISTS "l_area_instrument_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_area_genre" DROP CONSTRAINT IF EXISTS "l_area_genre_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_area_event" DROP CONSTRAINT IF EXISTS "l_area_event_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_area_artist" DROP CONSTRAINT IF EXISTS "l_area_artist_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."l_area_area" DROP CONSTRAINT IF EXISTS "l_area_area_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."iswc" DROP CONSTRAINT IF EXISTS "iswc_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."isrc" DROP CONSTRAINT IF EXISTS "isrc_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."iso_3166_3" DROP CONSTRAINT IF EXISTS "iso_3166_3_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."iso_3166_2" DROP CONSTRAINT IF EXISTS "iso_3166_2_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."iso_3166_1" DROP CONSTRAINT IF EXISTS "iso_3166_1_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."instrument_type" DROP CONSTRAINT IF EXISTS "instrument_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."instrument_tag_raw" DROP CONSTRAINT IF EXISTS "instrument_tag_raw_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."instrument_tag" DROP CONSTRAINT IF EXISTS "instrument_tag_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."instrument" DROP CONSTRAINT IF EXISTS "instrument_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."instrument_gid_redirect" DROP CONSTRAINT IF EXISTS "instrument_gid_redirect_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."instrument_attribute_type" DROP CONSTRAINT IF EXISTS "instrument_attribute_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."instrument_attribute_type_allowed_value" DROP CONSTRAINT IF EXISTS "instrument_attribute_type_allowed_value_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."instrument_attribute" DROP CONSTRAINT IF EXISTS "instrument_attribute_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."instrument_annotation" DROP CONSTRAINT IF EXISTS "instrument_annotation_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."instrument_alias_type" DROP CONSTRAINT IF EXISTS "instrument_alias_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."instrument_alias" DROP CONSTRAINT IF EXISTS "instrument_alias_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."genre" DROP CONSTRAINT IF EXISTS "genre_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."genre_annotation" DROP CONSTRAINT IF EXISTS "genre_annotation_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."genre_alias_type" DROP CONSTRAINT IF EXISTS "genre_alias_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."genre_alias" DROP CONSTRAINT IF EXISTS "genre_alias_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."gender" DROP CONSTRAINT IF EXISTS "gender_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."event_type" DROP CONSTRAINT IF EXISTS "event_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."event_tag_raw" DROP CONSTRAINT IF EXISTS "event_tag_raw_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."event_tag" DROP CONSTRAINT IF EXISTS "event_tag_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."event_rating_raw" DROP CONSTRAINT IF EXISTS "event_rating_raw_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."event" DROP CONSTRAINT IF EXISTS "event_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."event_meta" DROP CONSTRAINT IF EXISTS "event_meta_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."event_gid_redirect" DROP CONSTRAINT IF EXISTS "event_gid_redirect_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."event_attribute_type" DROP CONSTRAINT IF EXISTS "event_attribute_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."event_attribute_type_allowed_value" DROP CONSTRAINT IF EXISTS "event_attribute_type_allowed_value_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."event_attribute" DROP CONSTRAINT IF EXISTS "event_attribute_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."event_annotation" DROP CONSTRAINT IF EXISTS "event_annotation_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."event_alias_type" DROP CONSTRAINT IF EXISTS "event_alias_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."event_alias" DROP CONSTRAINT IF EXISTS "event_alias_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_subscribe_series" DROP CONSTRAINT IF EXISTS "editor_subscribe_series_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_subscribe_series_deleted" DROP CONSTRAINT IF EXISTS "editor_subscribe_series_deleted_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_subscribe_label" DROP CONSTRAINT IF EXISTS "editor_subscribe_label_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_subscribe_label_deleted" DROP CONSTRAINT IF EXISTS "editor_subscribe_label_deleted_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_subscribe_editor" DROP CONSTRAINT IF EXISTS "editor_subscribe_editor_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_subscribe_collection" DROP CONSTRAINT IF EXISTS "editor_subscribe_collection_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_subscribe_artist" DROP CONSTRAINT IF EXISTS "editor_subscribe_artist_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_subscribe_artist_deleted" DROP CONSTRAINT IF EXISTS "editor_subscribe_artist_deleted_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_preference" DROP CONSTRAINT IF EXISTS "editor_preference_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor" DROP CONSTRAINT IF EXISTS "editor_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_oauth_token" DROP CONSTRAINT IF EXISTS "editor_oauth_token_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_language" DROP CONSTRAINT IF EXISTS "editor_language_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_collection_work" DROP CONSTRAINT IF EXISTS "editor_collection_work_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_collection_type" DROP CONSTRAINT IF EXISTS "editor_collection_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_collection_series" DROP CONSTRAINT IF EXISTS "editor_collection_series_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_collection_release" DROP CONSTRAINT IF EXISTS "editor_collection_release_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_collection_release_group" DROP CONSTRAINT IF EXISTS "editor_collection_release_group_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_collection_recording" DROP CONSTRAINT IF EXISTS "editor_collection_recording_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_collection_place" DROP CONSTRAINT IF EXISTS "editor_collection_place_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_collection" DROP CONSTRAINT IF EXISTS "editor_collection_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_collection_label" DROP CONSTRAINT IF EXISTS "editor_collection_label_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_collection_instrument" DROP CONSTRAINT IF EXISTS "editor_collection_instrument_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_collection_gid_redirect" DROP CONSTRAINT IF EXISTS "editor_collection_gid_redirect_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_collection_genre" DROP CONSTRAINT IF EXISTS "editor_collection_genre_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_collection_event" DROP CONSTRAINT IF EXISTS "editor_collection_event_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_collection_deleted_entity" DROP CONSTRAINT IF EXISTS "editor_collection_deleted_entity_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_collection_collaborator" DROP CONSTRAINT IF EXISTS "editor_collection_collaborator_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_collection_artist" DROP CONSTRAINT IF EXISTS "editor_collection_artist_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."editor_collection_area" DROP CONSTRAINT IF EXISTS "editor_collection_area_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."edit_work" DROP CONSTRAINT IF EXISTS "edit_work_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."edit_url" DROP CONSTRAINT IF EXISTS "edit_url_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."edit_series" DROP CONSTRAINT IF EXISTS "edit_series_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."edit_release" DROP CONSTRAINT IF EXISTS "edit_release_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."edit_release_group" DROP CONSTRAINT IF EXISTS "edit_release_group_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."edit_recording" DROP CONSTRAINT IF EXISTS "edit_recording_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."edit_place" DROP CONSTRAINT IF EXISTS "edit_place_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."edit" DROP CONSTRAINT IF EXISTS "edit_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."edit_note_recipient" DROP CONSTRAINT IF EXISTS "edit_note_recipient_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."edit_note" DROP CONSTRAINT IF EXISTS "edit_note_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."edit_note_change" DROP CONSTRAINT IF EXISTS "edit_note_change_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."edit_mood" DROP CONSTRAINT IF EXISTS "edit_mood_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."edit_label" DROP CONSTRAINT IF EXISTS "edit_label_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."edit_instrument" DROP CONSTRAINT IF EXISTS "edit_instrument_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."edit_genre" DROP CONSTRAINT IF EXISTS "edit_genre_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."edit_event" DROP CONSTRAINT IF EXISTS "edit_event_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."edit_data" DROP CONSTRAINT IF EXISTS "edit_data_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."edit_artist" DROP CONSTRAINT IF EXISTS "edit_artist_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."edit_area" DROP CONSTRAINT IF EXISTS "edit_area_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."deleted_entity" DROP CONSTRAINT IF EXISTS "deleted_entity_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."dbmirror_pendingdata" DROP CONSTRAINT IF EXISTS "dbmirror_pendingdata_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."dbmirror_pending" DROP CONSTRAINT IF EXISTS "dbmirror_pending_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."country_area" DROP CONSTRAINT IF EXISTS "country_area_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."cdtoc_raw" DROP CONSTRAINT IF EXISTS "cdtoc_raw_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."cdtoc" DROP CONSTRAINT IF EXISTS "cdtoc_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."autoeditor_election_vote" DROP CONSTRAINT IF EXISTS "autoeditor_election_vote_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."autoeditor_election" DROP CONSTRAINT IF EXISTS "autoeditor_election_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."artist_type" DROP CONSTRAINT IF EXISTS "artist_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."artist_tag_raw" DROP CONSTRAINT IF EXISTS "artist_tag_raw_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."artist_tag" DROP CONSTRAINT IF EXISTS "artist_tag_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."artist_rating_raw" DROP CONSTRAINT IF EXISTS "artist_rating_raw_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."artist" DROP CONSTRAINT IF EXISTS "artist_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."artist_meta" DROP CONSTRAINT IF EXISTS "artist_meta_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."artist_isni" DROP CONSTRAINT IF EXISTS "artist_isni_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."artist_ipi" DROP CONSTRAINT IF EXISTS "artist_ipi_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."artist_gid_redirect" DROP CONSTRAINT IF EXISTS "artist_gid_redirect_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."artist_credit" DROP CONSTRAINT IF EXISTS "artist_credit_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."artist_credit_name" DROP CONSTRAINT IF EXISTS "artist_credit_name_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."artist_credit_gid_redirect" DROP CONSTRAINT IF EXISTS "artist_credit_gid_redirect_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."artist_attribute_type" DROP CONSTRAINT IF EXISTS "artist_attribute_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."artist_attribute_type_allowed_value" DROP CONSTRAINT IF EXISTS "artist_attribute_type_allowed_value_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."artist_attribute" DROP CONSTRAINT IF EXISTS "artist_attribute_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."artist_annotation" DROP CONSTRAINT IF EXISTS "artist_annotation_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."artist_alias_type" DROP CONSTRAINT IF EXISTS "artist_alias_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."artist_alias" DROP CONSTRAINT IF EXISTS "artist_alias_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."area_type" DROP CONSTRAINT IF EXISTS "area_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."area_tag_raw" DROP CONSTRAINT IF EXISTS "area_tag_raw_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."area_tag" DROP CONSTRAINT IF EXISTS "area_tag_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."area" DROP CONSTRAINT IF EXISTS "area_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."area_gid_redirect" DROP CONSTRAINT IF EXISTS "area_gid_redirect_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."area_containment" DROP CONSTRAINT IF EXISTS "area_containment_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."area_attribute_type" DROP CONSTRAINT IF EXISTS "area_attribute_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."area_attribute_type_allowed_value" DROP CONSTRAINT IF EXISTS "area_attribute_type_allowed_value_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."area_attribute" DROP CONSTRAINT IF EXISTS "area_attribute_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."area_annotation" DROP CONSTRAINT IF EXISTS "area_annotation_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."area_alias_type" DROP CONSTRAINT IF EXISTS "area_alias_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."area_alias" DROP CONSTRAINT IF EXISTS "area_alias_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."application" DROP CONSTRAINT IF EXISTS "application_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."annotation" DROP CONSTRAINT IF EXISTS "annotation_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."alternative_track" DROP CONSTRAINT IF EXISTS "alternative_track_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."alternative_release_type" DROP CONSTRAINT IF EXISTS "alternative_release_type_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."alternative_release" DROP CONSTRAINT IF EXISTS "alternative_release_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."alternative_medium_track" DROP CONSTRAINT IF EXISTS "alternative_medium_track_pkey";
ALTER TABLE IF EXISTS ONLY "musicbrainz"."alternative_medium" DROP CONSTRAINT IF EXISTS "alternative_medium_pkey";
ALTER TABLE IF EXISTS ONLY "json_dump"."work_json" DROP CONSTRAINT IF EXISTS "work_json_pkey";
ALTER TABLE IF EXISTS ONLY "json_dump"."series_json" DROP CONSTRAINT IF EXISTS "series_json_pkey";
ALTER TABLE IF EXISTS ONLY "json_dump"."release_json" DROP CONSTRAINT IF EXISTS "release_json_pkey";
ALTER TABLE IF EXISTS ONLY "json_dump"."release_group_json" DROP CONSTRAINT IF EXISTS "release_group_json_pkey";
ALTER TABLE IF EXISTS ONLY "json_dump"."recording_json" DROP CONSTRAINT IF EXISTS "recording_json_pkey";
ALTER TABLE IF EXISTS ONLY "json_dump"."place_json" DROP CONSTRAINT IF EXISTS "place_json_pkey";
ALTER TABLE IF EXISTS ONLY "json_dump"."label_json" DROP CONSTRAINT IF EXISTS "label_json_pkey";
ALTER TABLE IF EXISTS ONLY "json_dump"."instrument_json" DROP CONSTRAINT IF EXISTS "instrument_json_pkey";
ALTER TABLE IF EXISTS ONLY "json_dump"."event_json" DROP CONSTRAINT IF EXISTS "event_json_pkey";
ALTER TABLE IF EXISTS ONLY "json_dump"."deleted_entities" DROP CONSTRAINT IF EXISTS "deleted_entities_pkey";
ALTER TABLE IF EXISTS ONLY "json_dump"."artist_json" DROP CONSTRAINT IF EXISTS "artist_json_pkey";
ALTER TABLE IF EXISTS ONLY "json_dump"."area_json" DROP CONSTRAINT IF EXISTS "area_json_pkey";
ALTER TABLE IF EXISTS ONLY "event_art_archive"."event_art_type" DROP CONSTRAINT IF EXISTS "event_art_type_pkey";
ALTER TABLE IF EXISTS ONLY "event_art_archive"."event_art" DROP CONSTRAINT IF EXISTS "event_art_pkey";
ALTER TABLE IF EXISTS ONLY "event_art_archive"."art_type" DROP CONSTRAINT IF EXISTS "art_type_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."link_type_documentation" DROP CONSTRAINT IF EXISTS "link_type_documentation_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_work_work_example" DROP CONSTRAINT IF EXISTS "l_work_work_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_url_work_example" DROP CONSTRAINT IF EXISTS "l_url_work_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_url_url_example" DROP CONSTRAINT IF EXISTS "l_url_url_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_series_work_example" DROP CONSTRAINT IF EXISTS "l_series_work_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_series_url_example" DROP CONSTRAINT IF EXISTS "l_series_url_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_series_series_example" DROP CONSTRAINT IF EXISTS "l_series_series_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_release_work_example" DROP CONSTRAINT IF EXISTS "l_release_work_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_release_url_example" DROP CONSTRAINT IF EXISTS "l_release_url_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_release_series_example" DROP CONSTRAINT IF EXISTS "l_release_series_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_release_release_group_example" DROP CONSTRAINT IF EXISTS "l_release_release_group_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_release_release_example" DROP CONSTRAINT IF EXISTS "l_release_release_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_release_group_work_example" DROP CONSTRAINT IF EXISTS "l_release_group_work_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_release_group_url_example" DROP CONSTRAINT IF EXISTS "l_release_group_url_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_release_group_series_example" DROP CONSTRAINT IF EXISTS "l_release_group_series_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_release_group_release_group_example" DROP CONSTRAINT IF EXISTS "l_release_group_release_group_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_recording_work_example" DROP CONSTRAINT IF EXISTS "l_recording_work_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_recording_url_example" DROP CONSTRAINT IF EXISTS "l_recording_url_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_recording_series_example" DROP CONSTRAINT IF EXISTS "l_recording_series_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_recording_release_group_example" DROP CONSTRAINT IF EXISTS "l_recording_release_group_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_recording_release_example" DROP CONSTRAINT IF EXISTS "l_recording_release_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_recording_recording_example" DROP CONSTRAINT IF EXISTS "l_recording_recording_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_place_work_example" DROP CONSTRAINT IF EXISTS "l_place_work_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_place_url_example" DROP CONSTRAINT IF EXISTS "l_place_url_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_place_series_example" DROP CONSTRAINT IF EXISTS "l_place_series_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_place_release_group_example" DROP CONSTRAINT IF EXISTS "l_place_release_group_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_place_release_example" DROP CONSTRAINT IF EXISTS "l_place_release_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_place_recording_example" DROP CONSTRAINT IF EXISTS "l_place_recording_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_place_place_example" DROP CONSTRAINT IF EXISTS "l_place_place_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_mood_work_example" DROP CONSTRAINT IF EXISTS "l_mood_work_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_mood_url_example" DROP CONSTRAINT IF EXISTS "l_mood_url_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_mood_series_example" DROP CONSTRAINT IF EXISTS "l_mood_series_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_mood_release_group_example" DROP CONSTRAINT IF EXISTS "l_mood_release_group_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_mood_release_example" DROP CONSTRAINT IF EXISTS "l_mood_release_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_mood_recording_example" DROP CONSTRAINT IF EXISTS "l_mood_recording_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_mood_place_example" DROP CONSTRAINT IF EXISTS "l_mood_place_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_mood_mood_example" DROP CONSTRAINT IF EXISTS "l_mood_mood_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_label_work_example" DROP CONSTRAINT IF EXISTS "l_label_work_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_label_url_example" DROP CONSTRAINT IF EXISTS "l_label_url_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_label_series_example" DROP CONSTRAINT IF EXISTS "l_label_series_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_label_release_group_example" DROP CONSTRAINT IF EXISTS "l_label_release_group_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_label_release_example" DROP CONSTRAINT IF EXISTS "l_label_release_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_label_recording_example" DROP CONSTRAINT IF EXISTS "l_label_recording_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_label_place_example" DROP CONSTRAINT IF EXISTS "l_label_place_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_label_mood_example" DROP CONSTRAINT IF EXISTS "l_label_mood_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_label_label_example" DROP CONSTRAINT IF EXISTS "l_label_label_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_instrument_work_example" DROP CONSTRAINT IF EXISTS "l_instrument_work_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_instrument_url_example" DROP CONSTRAINT IF EXISTS "l_instrument_url_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_instrument_series_example" DROP CONSTRAINT IF EXISTS "l_instrument_series_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_instrument_release_group_example" DROP CONSTRAINT IF EXISTS "l_instrument_release_group_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_instrument_release_example" DROP CONSTRAINT IF EXISTS "l_instrument_release_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_instrument_recording_example" DROP CONSTRAINT IF EXISTS "l_instrument_recording_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_instrument_place_example" DROP CONSTRAINT IF EXISTS "l_instrument_place_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_instrument_mood_example" DROP CONSTRAINT IF EXISTS "l_instrument_mood_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_instrument_label_example" DROP CONSTRAINT IF EXISTS "l_instrument_label_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_instrument_instrument_example" DROP CONSTRAINT IF EXISTS "l_instrument_instrument_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_genre_work_example" DROP CONSTRAINT IF EXISTS "l_genre_work_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_genre_url_example" DROP CONSTRAINT IF EXISTS "l_genre_url_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_genre_series_example" DROP CONSTRAINT IF EXISTS "l_genre_series_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_genre_release_group_example" DROP CONSTRAINT IF EXISTS "l_genre_release_group_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_genre_release_example" DROP CONSTRAINT IF EXISTS "l_genre_release_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_genre_recording_example" DROP CONSTRAINT IF EXISTS "l_genre_recording_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_genre_place_example" DROP CONSTRAINT IF EXISTS "l_genre_place_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_genre_mood_example" DROP CONSTRAINT IF EXISTS "l_genre_mood_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_genre_label_example" DROP CONSTRAINT IF EXISTS "l_genre_label_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_genre_instrument_example" DROP CONSTRAINT IF EXISTS "l_genre_instrument_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_genre_genre_example" DROP CONSTRAINT IF EXISTS "l_genre_genre_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_event_work_example" DROP CONSTRAINT IF EXISTS "l_event_work_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_event_url_example" DROP CONSTRAINT IF EXISTS "l_event_url_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_event_series_example" DROP CONSTRAINT IF EXISTS "l_event_series_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_event_release_group_example" DROP CONSTRAINT IF EXISTS "l_event_release_group_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_event_release_example" DROP CONSTRAINT IF EXISTS "l_event_release_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_event_recording_example" DROP CONSTRAINT IF EXISTS "l_event_recording_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_event_place_example" DROP CONSTRAINT IF EXISTS "l_event_place_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_event_mood_example" DROP CONSTRAINT IF EXISTS "l_event_mood_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_event_label_example" DROP CONSTRAINT IF EXISTS "l_event_label_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_event_instrument_example" DROP CONSTRAINT IF EXISTS "l_event_instrument_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_event_genre_example" DROP CONSTRAINT IF EXISTS "l_event_genre_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_event_event_example" DROP CONSTRAINT IF EXISTS "l_event_event_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_artist_work_example" DROP CONSTRAINT IF EXISTS "l_artist_work_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_artist_url_example" DROP CONSTRAINT IF EXISTS "l_artist_url_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_artist_series_example" DROP CONSTRAINT IF EXISTS "l_artist_series_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_artist_release_group_example" DROP CONSTRAINT IF EXISTS "l_artist_release_group_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_artist_release_example" DROP CONSTRAINT IF EXISTS "l_artist_release_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_artist_recording_example" DROP CONSTRAINT IF EXISTS "l_artist_recording_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_artist_place_example" DROP CONSTRAINT IF EXISTS "l_artist_place_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_artist_mood_example" DROP CONSTRAINT IF EXISTS "l_artist_mood_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_artist_label_example" DROP CONSTRAINT IF EXISTS "l_artist_label_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_artist_instrument_example" DROP CONSTRAINT IF EXISTS "l_artist_instrument_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_artist_genre_example" DROP CONSTRAINT IF EXISTS "l_artist_genre_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_artist_event_example" DROP CONSTRAINT IF EXISTS "l_artist_event_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_artist_artist_example" DROP CONSTRAINT IF EXISTS "l_artist_artist_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_area_work_example" DROP CONSTRAINT IF EXISTS "l_area_work_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_area_url_example" DROP CONSTRAINT IF EXISTS "l_area_url_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_area_series_example" DROP CONSTRAINT IF EXISTS "l_area_series_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_area_release_group_example" DROP CONSTRAINT IF EXISTS "l_area_release_group_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_area_release_example" DROP CONSTRAINT IF EXISTS "l_area_release_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_area_recording_example" DROP CONSTRAINT IF EXISTS "l_area_recording_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_area_place_example" DROP CONSTRAINT IF EXISTS "l_area_place_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_area_mood_example" DROP CONSTRAINT IF EXISTS "l_area_mood_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_area_label_example" DROP CONSTRAINT IF EXISTS "l_area_label_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_area_instrument_example" DROP CONSTRAINT IF EXISTS "l_area_instrument_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_area_genre_example" DROP CONSTRAINT IF EXISTS "l_area_genre_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_area_event_example" DROP CONSTRAINT IF EXISTS "l_area_event_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_area_artist_example" DROP CONSTRAINT IF EXISTS "l_area_artist_example_pkey";
ALTER TABLE IF EXISTS ONLY "documentation"."l_area_area_example" DROP CONSTRAINT IF EXISTS "l_area_area_example_pkey";
ALTER TABLE IF EXISTS ONLY "dbmirror2"."pending_ts" DROP CONSTRAINT IF EXISTS "pending_ts_pkey";
ALTER TABLE IF EXISTS ONLY "dbmirror2"."pending_keys" DROP CONSTRAINT IF EXISTS "pending_keys_pkey";
ALTER TABLE IF EXISTS ONLY "dbmirror2"."pending_data" DROP CONSTRAINT IF EXISTS "pending_data_pkey";
ALTER TABLE IF EXISTS ONLY "cover_art_archive"."release_group_cover_art" DROP CONSTRAINT IF EXISTS "release_group_cover_art_pkey";
ALTER TABLE IF EXISTS ONLY "cover_art_archive"."image_type" DROP CONSTRAINT IF EXISTS "image_type_pkey";
ALTER TABLE IF EXISTS ONLY "cover_art_archive"."cover_art_type" DROP CONSTRAINT IF EXISTS "cover_art_type_pkey";
ALTER TABLE IF EXISTS ONLY "cover_art_archive"."cover_art" DROP CONSTRAINT IF EXISTS "cover_art_pkey";
ALTER TABLE IF EXISTS ONLY "cover_art_archive"."art_type" DROP CONSTRAINT IF EXISTS "art_type_pkey";
ALTER TABLE IF EXISTS "statistics"."statistic" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."work_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."work_attribute_type_allowed_value" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."work_attribute_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."work_attribute" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."work_alias_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."work_alias" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."work" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."vote" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."url" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."track_raw" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."track" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."tag" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."series_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."series_ordering_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."series_attribute_type_allowed_value" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."series_attribute_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."series_attribute" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."series_alias_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."series_alias" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."series" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."script" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."replication_control" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."release_status" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."release_raw" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."release_packaging" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."release_label" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."release_group_secondary_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."release_group_primary_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."release_group_attribute_type_allowed_value" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."release_group_attribute_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."release_group_attribute" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."release_group_alias_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."release_group_alias" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."release_group" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."release_attribute_type_allowed_value" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."release_attribute_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."release_attribute" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."release_alias_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."release_alias" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."release" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."recording_attribute_type_allowed_value" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."recording_attribute_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."recording_attribute" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."recording_alias_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."recording_alias" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."recording" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."place_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."place_attribute_type_allowed_value" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."place_attribute_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."place_attribute" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."place_alias_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."place_alias" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."place" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."mood_alias_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."mood_alias" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."mood" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."medium_format" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."medium_cdtoc" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."medium_attribute_type_allowed_value" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."medium_attribute_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."medium_attribute" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."medium" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."link_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."link_attribute_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."link" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."language" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."label_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."label_attribute_type_allowed_value" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."label_attribute_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."label_attribute" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."label_alias_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."label_alias" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."label" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_work_work" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_url_work" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_url_url" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_series_work" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_series_url" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_series_series" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_release_work" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_release_url" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_release_series" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_release_release_group" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_release_release" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_release_group_work" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_release_group_url" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_release_group_series" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_release_group_release_group" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_recording_work" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_recording_url" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_recording_series" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_recording_release_group" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_recording_release" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_recording_recording" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_place_work" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_place_url" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_place_series" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_place_release_group" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_place_release" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_place_recording" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_place_place" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_mood_work" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_mood_url" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_mood_series" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_mood_release_group" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_mood_release" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_mood_recording" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_mood_place" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_mood_mood" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_label_work" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_label_url" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_label_series" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_label_release_group" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_label_release" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_label_recording" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_label_place" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_label_mood" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_label_label" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_instrument_work" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_instrument_url" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_instrument_series" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_instrument_release_group" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_instrument_release" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_instrument_recording" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_instrument_place" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_instrument_mood" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_instrument_label" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_instrument_instrument" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_genre_work" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_genre_url" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_genre_series" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_genre_release_group" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_genre_release" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_genre_recording" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_genre_place" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_genre_mood" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_genre_label" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_genre_instrument" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_genre_genre" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_event_work" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_event_url" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_event_series" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_event_release_group" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_event_release" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_event_recording" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_event_place" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_event_mood" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_event_label" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_event_instrument" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_event_genre" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_event_event" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_artist_work" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_artist_url" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_artist_series" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_artist_release_group" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_artist_release" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_artist_recording" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_artist_place" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_artist_mood" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_artist_label" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_artist_instrument" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_artist_genre" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_artist_event" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_artist_artist" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_area_work" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_area_url" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_area_series" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_area_release_group" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_area_release" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_area_recording" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_area_place" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_area_mood" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_area_label" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_area_instrument" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_area_genre" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_area_event" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_area_artist" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."l_area_area" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."iswc" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."isrc" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."instrument_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."instrument_attribute_type_allowed_value" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."instrument_attribute_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."instrument_attribute" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."instrument_alias_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."instrument_alias" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."instrument" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."genre_alias_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."genre_alias" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."genre" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."gender" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."event_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."event_attribute_type_allowed_value" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."event_attribute_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."event_attribute" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."event_alias_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."event_alias" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."event" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."editor_subscribe_series" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."editor_subscribe_label" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."editor_subscribe_editor" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."editor_subscribe_collection" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."editor_subscribe_artist" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."editor_preference" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."editor_oauth_token" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."editor_collection_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."editor_collection" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."editor" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."edit_note_change" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."edit_note" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."edit" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."dbmirror_pending" ALTER COLUMN "seqid" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."cdtoc_raw" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."cdtoc" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."autoeditor_election_vote" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."autoeditor_election" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."artist_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."artist_credit" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."artist_attribute_type_allowed_value" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."artist_attribute_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."artist_attribute" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."artist_alias_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."artist_alias" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."artist" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."area_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."area_attribute_type_allowed_value" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."area_attribute_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."area_attribute" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."area_alias_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."area_alias" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."area" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."application" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."annotation" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."alternative_track" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."alternative_release_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."alternative_release" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "musicbrainz"."alternative_medium" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "event_art_archive"."art_type" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "dbmirror2"."pending_data" ALTER COLUMN "seqid" DROP DEFAULT;
ALTER TABLE IF EXISTS "cover_art_archive"."art_type" ALTER COLUMN "id" DROP DEFAULT;
DROP TABLE IF EXISTS "wikidocs"."wikidocs_index";
DROP SEQUENCE IF EXISTS "statistics"."statistic_id_seq";
DROP TABLE IF EXISTS "statistics"."statistic_event";
DROP TABLE IF EXISTS "statistics"."statistic";
DROP TABLE IF EXISTS "sitemaps"."work_lastmod";
DROP TABLE IF EXISTS "sitemaps"."tmp_checked_entities";
DROP TABLE IF EXISTS "sitemaps"."release_lastmod";
DROP TABLE IF EXISTS "sitemaps"."release_group_lastmod";
DROP TABLE IF EXISTS "sitemaps"."recording_lastmod";
DROP TABLE IF EXISTS "sitemaps"."place_lastmod";
DROP TABLE IF EXISTS "sitemaps"."label_lastmod";
DROP TABLE IF EXISTS "sitemaps"."control";
DROP TABLE IF EXISTS "sitemaps"."artist_lastmod";
DROP TABLE IF EXISTS "report"."index";
DROP SEQUENCE IF EXISTS "musicbrainz"."work_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."work_type";
DROP TABLE IF EXISTS "musicbrainz"."work_tag_raw";
DROP TABLE IF EXISTS "musicbrainz"."work_tag";
DROP VIEW IF EXISTS "musicbrainz"."work_series";
DROP TABLE IF EXISTS "musicbrainz"."work_rating_raw";
DROP TABLE IF EXISTS "musicbrainz"."work_meta";
DROP TABLE IF EXISTS "musicbrainz"."work_language";
DROP SEQUENCE IF EXISTS "musicbrainz"."work_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."work_gid_redirect";
DROP SEQUENCE IF EXISTS "musicbrainz"."work_attribute_type_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."work_attribute_type_allowed_value_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."work_attribute_type_allowed_value";
DROP TABLE IF EXISTS "musicbrainz"."work_attribute_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."work_attribute_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."work_attribute";
DROP TABLE IF EXISTS "musicbrainz"."work_annotation";
DROP SEQUENCE IF EXISTS "musicbrainz"."work_alias_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."work_alias_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."work_alias_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."work_alias";
DROP TABLE IF EXISTS "musicbrainz"."work";
DROP SEQUENCE IF EXISTS "musicbrainz"."vote_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."vote";
DROP SEQUENCE IF EXISTS "musicbrainz"."url_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."url_gid_redirect";
DROP TABLE IF EXISTS "musicbrainz"."url";
DROP TABLE IF EXISTS "musicbrainz"."unreferenced_row_log";
DROP SEQUENCE IF EXISTS "musicbrainz"."track_raw_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."track_raw";
DROP SEQUENCE IF EXISTS "musicbrainz"."track_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."track_gid_redirect";
DROP TABLE IF EXISTS "musicbrainz"."tag_relation";
DROP SEQUENCE IF EXISTS "musicbrainz"."tag_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."tag";
DROP SEQUENCE IF EXISTS "musicbrainz"."series_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."series_type";
DROP TABLE IF EXISTS "musicbrainz"."series_tag_raw";
DROP TABLE IF EXISTS "musicbrainz"."series_tag";
DROP SEQUENCE IF EXISTS "musicbrainz"."series_ordering_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."series_ordering_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."series_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."series_gid_redirect";
DROP SEQUENCE IF EXISTS "musicbrainz"."series_attribute_type_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."series_attribute_type_allowed_value_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."series_attribute_type_allowed_value";
DROP TABLE IF EXISTS "musicbrainz"."series_attribute_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."series_attribute_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."series_attribute";
DROP TABLE IF EXISTS "musicbrainz"."series_annotation";
DROP SEQUENCE IF EXISTS "musicbrainz"."series_alias_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."series_alias_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."series_alias_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."series_alias";
DROP SEQUENCE IF EXISTS "musicbrainz"."script_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."script";
DROP SEQUENCE IF EXISTS "musicbrainz"."replication_control_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."replication_control";
DROP TABLE IF EXISTS "musicbrainz"."release_tag_raw";
DROP TABLE IF EXISTS "musicbrainz"."release_tag";
DROP SEQUENCE IF EXISTS "musicbrainz"."release_status_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."release_status";
DROP VIEW IF EXISTS "musicbrainz"."release_series";
DROP SEQUENCE IF EXISTS "musicbrainz"."release_raw_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."release_raw";
DROP SEQUENCE IF EXISTS "musicbrainz"."release_packaging_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."release_packaging";
DROP TABLE IF EXISTS "musicbrainz"."release_meta";
DROP SEQUENCE IF EXISTS "musicbrainz"."release_label_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."release_label";
DROP SEQUENCE IF EXISTS "musicbrainz"."release_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."release_group_tag_raw";
DROP TABLE IF EXISTS "musicbrainz"."release_group_tag";
DROP VIEW IF EXISTS "musicbrainz"."release_group_series";
DROP TABLE IF EXISTS "musicbrainz"."release_group_secondary_type_join";
DROP SEQUENCE IF EXISTS "musicbrainz"."release_group_secondary_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."release_group_secondary_type";
DROP TABLE IF EXISTS "musicbrainz"."release_group_rating_raw";
DROP SEQUENCE IF EXISTS "musicbrainz"."release_group_primary_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."release_group_primary_type";
DROP TABLE IF EXISTS "musicbrainz"."release_group_meta";
DROP SEQUENCE IF EXISTS "musicbrainz"."release_group_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."release_group_gid_redirect";
DROP SEQUENCE IF EXISTS "musicbrainz"."release_group_attribute_type_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."release_group_attribute_type_allowed_value_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."release_group_attribute_type_allowed_value";
DROP TABLE IF EXISTS "musicbrainz"."release_group_attribute_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."release_group_attribute_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."release_group_attribute";
DROP TABLE IF EXISTS "musicbrainz"."release_group_annotation";
DROP SEQUENCE IF EXISTS "musicbrainz"."release_group_alias_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."release_group_alias_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."release_group_alias_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."release_group_alias";
DROP TABLE IF EXISTS "musicbrainz"."release_group";
DROP TABLE IF EXISTS "musicbrainz"."release_gid_redirect";
DROP VIEW IF EXISTS "musicbrainz"."release_event";
DROP TABLE IF EXISTS "musicbrainz"."release_unknown_country";
DROP TABLE IF EXISTS "musicbrainz"."release_country";
DROP SEQUENCE IF EXISTS "musicbrainz"."release_attribute_type_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."release_attribute_type_allowed_value_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."release_attribute_type_allowed_value";
DROP TABLE IF EXISTS "musicbrainz"."release_attribute_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."release_attribute_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."release_attribute";
DROP TABLE IF EXISTS "musicbrainz"."release_annotation";
DROP SEQUENCE IF EXISTS "musicbrainz"."release_alias_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."release_alias_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."release_alias_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."release_alias";
DROP TABLE IF EXISTS "musicbrainz"."release";
DROP TABLE IF EXISTS "musicbrainz"."recording_tag_raw";
DROP TABLE IF EXISTS "musicbrainz"."recording_tag";
DROP VIEW IF EXISTS "musicbrainz"."recording_series";
DROP TABLE IF EXISTS "musicbrainz"."recording_rating_raw";
DROP TABLE IF EXISTS "musicbrainz"."recording_meta";
DROP SEQUENCE IF EXISTS "musicbrainz"."recording_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."recording_gid_redirect";
DROP SEQUENCE IF EXISTS "musicbrainz"."recording_attribute_type_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."recording_attribute_type_allowed_value_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."recording_attribute_type_allowed_value";
DROP TABLE IF EXISTS "musicbrainz"."recording_attribute_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."recording_attribute_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."recording_attribute";
DROP TABLE IF EXISTS "musicbrainz"."recording_annotation";
DROP SEQUENCE IF EXISTS "musicbrainz"."recording_alias_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."recording_alias_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."recording_alias_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."recording_alias";
DROP TABLE IF EXISTS "musicbrainz"."recording";
DROP SEQUENCE IF EXISTS "musicbrainz"."place_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."place_type";
DROP TABLE IF EXISTS "musicbrainz"."place_tag_raw";
DROP TABLE IF EXISTS "musicbrainz"."place_tag";
DROP TABLE IF EXISTS "musicbrainz"."place_rating_raw";
DROP TABLE IF EXISTS "musicbrainz"."place_meta";
DROP SEQUENCE IF EXISTS "musicbrainz"."place_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."place_gid_redirect";
DROP SEQUENCE IF EXISTS "musicbrainz"."place_attribute_type_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."place_attribute_type_allowed_value_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."place_attribute_type_allowed_value";
DROP TABLE IF EXISTS "musicbrainz"."place_attribute_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."place_attribute_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."place_attribute";
DROP TABLE IF EXISTS "musicbrainz"."place_annotation";
DROP SEQUENCE IF EXISTS "musicbrainz"."place_alias_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."place_alias_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."place_alias_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."place_alias";
DROP TABLE IF EXISTS "musicbrainz"."place";
DROP TABLE IF EXISTS "musicbrainz"."orderable_link_type";
DROP TABLE IF EXISTS "musicbrainz"."old_editor_name";
DROP SEQUENCE IF EXISTS "musicbrainz"."mood_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."mood_annotation";
DROP SEQUENCE IF EXISTS "musicbrainz"."mood_alias_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."mood_alias_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."mood_alias_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."mood_alias";
DROP TABLE IF EXISTS "musicbrainz"."mood";
DROP VIEW IF EXISTS "musicbrainz"."medium_track_durations";
DROP TABLE IF EXISTS "musicbrainz"."track";
DROP TABLE IF EXISTS "musicbrainz"."medium_index";
DROP SEQUENCE IF EXISTS "musicbrainz"."medium_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."medium_gid_redirect";
DROP SEQUENCE IF EXISTS "musicbrainz"."medium_format_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."medium_format";
DROP SEQUENCE IF EXISTS "musicbrainz"."medium_cdtoc_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."medium_cdtoc";
DROP SEQUENCE IF EXISTS "musicbrainz"."medium_attribute_type_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."medium_attribute_type_allowed_value_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."medium_attribute_type_allowed_value_allowed_format";
DROP TABLE IF EXISTS "musicbrainz"."medium_attribute_type_allowed_value";
DROP TABLE IF EXISTS "musicbrainz"."medium_attribute_type_allowed_format";
DROP TABLE IF EXISTS "musicbrainz"."medium_attribute_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."medium_attribute_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."medium_attribute";
DROP SEQUENCE IF EXISTS "musicbrainz"."link_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."link_type_attribute_type";
DROP TABLE IF EXISTS "musicbrainz"."link_text_attribute_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."link_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."link_creditable_attribute_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."link_attribute_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."link_attribute_type";
DROP TABLE IF EXISTS "musicbrainz"."link_attribute_credit";
DROP TABLE IF EXISTS "musicbrainz"."link_attribute";
DROP SEQUENCE IF EXISTS "musicbrainz"."language_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."language";
DROP SEQUENCE IF EXISTS "musicbrainz"."label_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."label_type";
DROP TABLE IF EXISTS "musicbrainz"."label_tag_raw";
DROP TABLE IF EXISTS "musicbrainz"."label_tag";
DROP TABLE IF EXISTS "musicbrainz"."label_rating_raw";
DROP TABLE IF EXISTS "musicbrainz"."label_meta";
DROP TABLE IF EXISTS "musicbrainz"."label_isni";
DROP TABLE IF EXISTS "musicbrainz"."label_ipi";
DROP SEQUENCE IF EXISTS "musicbrainz"."label_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."label_gid_redirect";
DROP SEQUENCE IF EXISTS "musicbrainz"."label_attribute_type_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."label_attribute_type_allowed_value_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."label_attribute_type_allowed_value";
DROP TABLE IF EXISTS "musicbrainz"."label_attribute_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."label_attribute_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."label_attribute";
DROP TABLE IF EXISTS "musicbrainz"."label_annotation";
DROP SEQUENCE IF EXISTS "musicbrainz"."label_alias_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."label_alias_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."label_alias_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."label_alias";
DROP TABLE IF EXISTS "musicbrainz"."label";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_work_work_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_work_work";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_url_work_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_url_work";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_url_url_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_url_url";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_series_work_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_series_work";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_series_url_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_series_url";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_series_series_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_series_series";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_release_work_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_release_work";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_release_url_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_release_url";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_release_series_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_release_series";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_release_release_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_release_release_group_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_release_release_group";
DROP TABLE IF EXISTS "musicbrainz"."l_release_release";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_release_group_work_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_release_group_work";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_release_group_url_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_release_group_url";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_release_group_series_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_release_group_series";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_release_group_release_group_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_release_group_release_group";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_recording_work_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_recording_work";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_recording_url_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_recording_url";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_recording_series_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_recording_series";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_recording_release_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_recording_release_group_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_recording_release_group";
DROP TABLE IF EXISTS "musicbrainz"."l_recording_release";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_recording_recording_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_recording_recording";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_place_work_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_place_work";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_place_url_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_place_url";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_place_series_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_place_series";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_place_release_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_place_release_group_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_place_release_group";
DROP TABLE IF EXISTS "musicbrainz"."l_place_release";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_place_recording_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_place_recording";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_place_place_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_place_place";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_mood_work_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_mood_work";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_mood_url_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_mood_url";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_mood_series_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_mood_series";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_mood_release_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_mood_release_group_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_mood_release_group";
DROP TABLE IF EXISTS "musicbrainz"."l_mood_release";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_mood_recording_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_mood_recording";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_mood_place_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_mood_place";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_mood_mood_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_mood_mood";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_label_work_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_label_work";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_label_url_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_label_url";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_label_series_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_label_series";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_label_release_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_label_release_group_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_label_release_group";
DROP TABLE IF EXISTS "musicbrainz"."l_label_release";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_label_recording_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_label_recording";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_label_place_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_label_place";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_label_mood_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_label_mood";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_label_label_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_label_label";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_instrument_work_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_instrument_work";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_instrument_url_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_instrument_url";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_instrument_series_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_instrument_series";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_instrument_release_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_instrument_release_group_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_instrument_release_group";
DROP TABLE IF EXISTS "musicbrainz"."l_instrument_release";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_instrument_recording_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_instrument_recording";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_instrument_place_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_instrument_place";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_instrument_mood_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_instrument_mood";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_instrument_label_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_instrument_label";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_instrument_instrument_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_instrument_instrument";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_genre_work_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_genre_work";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_genre_url_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_genre_url";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_genre_series_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_genre_series";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_genre_release_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_genre_release_group_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_genre_release_group";
DROP TABLE IF EXISTS "musicbrainz"."l_genre_release";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_genre_recording_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_genre_recording";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_genre_place_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_genre_place";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_genre_mood_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_genre_mood";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_genre_label_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_genre_label";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_genre_instrument_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_genre_instrument";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_genre_genre_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_genre_genre";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_event_work_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_event_work";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_event_url_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_event_url";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_event_series_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_event_release_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_event_release_group_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_event_release_group";
DROP TABLE IF EXISTS "musicbrainz"."l_event_release";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_event_recording_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_event_recording";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_event_place_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_event_place";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_event_mood_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_event_mood";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_event_label_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_event_label";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_event_instrument_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_event_instrument";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_event_genre_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_event_genre";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_event_event_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_event_event";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_artist_work_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_artist_work";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_artist_url_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_artist_url";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_artist_series_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_artist_release_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_artist_release_group_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_artist_release_group";
DROP TABLE IF EXISTS "musicbrainz"."l_artist_release";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_artist_recording_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_artist_recording";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_artist_place_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_artist_place";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_artist_mood_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_artist_mood";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_artist_label_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_artist_label";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_artist_instrument_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_artist_instrument";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_artist_genre_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_artist_genre";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_artist_event_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_artist_event";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_artist_artist_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_artist_artist";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_area_work_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_area_work";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_area_url_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_area_url";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_area_series_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_area_series";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_area_release_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_area_release_group_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_area_release_group";
DROP TABLE IF EXISTS "musicbrainz"."l_area_release";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_area_recording_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_area_recording";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_area_place_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_area_place";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_area_mood_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_area_mood";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_area_label_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_area_label";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_area_instrument_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_area_instrument";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_area_genre_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_area_genre";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_area_event_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_area_event";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_area_artist_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_area_artist";
DROP SEQUENCE IF EXISTS "musicbrainz"."l_area_area_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."l_area_area";
DROP SEQUENCE IF EXISTS "musicbrainz"."iswc_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."iswc";
DROP SEQUENCE IF EXISTS "musicbrainz"."isrc_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."isrc";
DROP TABLE IF EXISTS "musicbrainz"."iso_3166_3";
DROP TABLE IF EXISTS "musicbrainz"."iso_3166_2";
DROP TABLE IF EXISTS "musicbrainz"."iso_3166_1";
DROP SEQUENCE IF EXISTS "musicbrainz"."instrument_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."instrument_type";
DROP TABLE IF EXISTS "musicbrainz"."instrument_tag_raw";
DROP TABLE IF EXISTS "musicbrainz"."instrument_tag";
DROP SEQUENCE IF EXISTS "musicbrainz"."instrument_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."instrument_gid_redirect";
DROP SEQUENCE IF EXISTS "musicbrainz"."instrument_attribute_type_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."instrument_attribute_type_allowed_value_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."instrument_attribute_type_allowed_value";
DROP TABLE IF EXISTS "musicbrainz"."instrument_attribute_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."instrument_attribute_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."instrument_attribute";
DROP TABLE IF EXISTS "musicbrainz"."instrument_annotation";
DROP SEQUENCE IF EXISTS "musicbrainz"."instrument_alias_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."instrument_alias_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."instrument_alias_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."instrument_alias";
DROP TABLE IF EXISTS "musicbrainz"."instrument";
DROP SEQUENCE IF EXISTS "musicbrainz"."genre_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."genre_annotation";
DROP SEQUENCE IF EXISTS "musicbrainz"."genre_alias_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."genre_alias_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."genre_alias_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."genre_alias";
DROP TABLE IF EXISTS "musicbrainz"."genre";
DROP SEQUENCE IF EXISTS "musicbrainz"."gender_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."gender";
DROP SEQUENCE IF EXISTS "musicbrainz"."event_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."event_type";
DROP TABLE IF EXISTS "musicbrainz"."event_tag_raw";
DROP TABLE IF EXISTS "musicbrainz"."event_tag";
DROP VIEW IF EXISTS "musicbrainz"."event_series";
DROP TABLE IF EXISTS "musicbrainz"."l_event_series";
DROP TABLE IF EXISTS "musicbrainz"."event_rating_raw";
DROP TABLE IF EXISTS "musicbrainz"."event_meta";
DROP SEQUENCE IF EXISTS "musicbrainz"."event_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."event_gid_redirect";
DROP SEQUENCE IF EXISTS "musicbrainz"."event_attribute_type_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."event_attribute_type_allowed_value_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."event_attribute_type_allowed_value";
DROP TABLE IF EXISTS "musicbrainz"."event_attribute_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."event_attribute_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."event_attribute";
DROP TABLE IF EXISTS "musicbrainz"."event_annotation";
DROP SEQUENCE IF EXISTS "musicbrainz"."event_alias_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."event_alias_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."event_alias_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."event_alias";
DROP TABLE IF EXISTS "musicbrainz"."event";
DROP SEQUENCE IF EXISTS "musicbrainz"."editor_subscribe_series_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."editor_subscribe_series_deleted";
DROP TABLE IF EXISTS "musicbrainz"."editor_subscribe_series";
DROP SEQUENCE IF EXISTS "musicbrainz"."editor_subscribe_label_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."editor_subscribe_label_deleted";
DROP TABLE IF EXISTS "musicbrainz"."editor_subscribe_label";
DROP SEQUENCE IF EXISTS "musicbrainz"."editor_subscribe_editor_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."editor_subscribe_editor";
DROP SEQUENCE IF EXISTS "musicbrainz"."editor_subscribe_collection_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."editor_subscribe_collection";
DROP SEQUENCE IF EXISTS "musicbrainz"."editor_subscribe_artist_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."editor_subscribe_artist_deleted";
DROP TABLE IF EXISTS "musicbrainz"."editor_subscribe_artist";
DROP SEQUENCE IF EXISTS "musicbrainz"."editor_preference_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."editor_preference";
DROP SEQUENCE IF EXISTS "musicbrainz"."editor_oauth_token_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."editor_oauth_token";
DROP TABLE IF EXISTS "musicbrainz"."editor_language";
DROP SEQUENCE IF EXISTS "musicbrainz"."editor_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."editor_collection_work";
DROP SEQUENCE IF EXISTS "musicbrainz"."editor_collection_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."editor_collection_type";
DROP TABLE IF EXISTS "musicbrainz"."editor_collection_series";
DROP TABLE IF EXISTS "musicbrainz"."editor_collection_release_group";
DROP TABLE IF EXISTS "musicbrainz"."editor_collection_release";
DROP TABLE IF EXISTS "musicbrainz"."editor_collection_recording";
DROP TABLE IF EXISTS "musicbrainz"."editor_collection_place";
DROP TABLE IF EXISTS "musicbrainz"."editor_collection_label";
DROP TABLE IF EXISTS "musicbrainz"."editor_collection_instrument";
DROP SEQUENCE IF EXISTS "musicbrainz"."editor_collection_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."editor_collection_gid_redirect";
DROP TABLE IF EXISTS "musicbrainz"."editor_collection_genre";
DROP TABLE IF EXISTS "musicbrainz"."editor_collection_event";
DROP TABLE IF EXISTS "musicbrainz"."editor_collection_deleted_entity";
DROP TABLE IF EXISTS "musicbrainz"."editor_collection_collaborator";
DROP TABLE IF EXISTS "musicbrainz"."editor_collection_artist";
DROP TABLE IF EXISTS "musicbrainz"."editor_collection_area";
DROP TABLE IF EXISTS "musicbrainz"."editor_collection";
DROP TABLE IF EXISTS "musicbrainz"."editor";
DROP TABLE IF EXISTS "musicbrainz"."edit_work";
DROP TABLE IF EXISTS "musicbrainz"."edit_url";
DROP TABLE IF EXISTS "musicbrainz"."edit_series";
DROP TABLE IF EXISTS "musicbrainz"."edit_release_group";
DROP TABLE IF EXISTS "musicbrainz"."edit_release";
DROP TABLE IF EXISTS "musicbrainz"."edit_recording";
DROP TABLE IF EXISTS "musicbrainz"."edit_place";
DROP TABLE IF EXISTS "musicbrainz"."edit_note_recipient";
DROP SEQUENCE IF EXISTS "musicbrainz"."edit_note_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."edit_note_change_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."edit_note_change";
DROP TABLE IF EXISTS "musicbrainz"."edit_note";
DROP TABLE IF EXISTS "musicbrainz"."edit_mood";
DROP TABLE IF EXISTS "musicbrainz"."edit_label";
DROP TABLE IF EXISTS "musicbrainz"."edit_instrument";
DROP SEQUENCE IF EXISTS "musicbrainz"."edit_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."edit_genre";
DROP TABLE IF EXISTS "musicbrainz"."edit_event";
DROP TABLE IF EXISTS "musicbrainz"."edit_data";
DROP TABLE IF EXISTS "musicbrainz"."edit_artist";
DROP TABLE IF EXISTS "musicbrainz"."edit_area";
DROP TABLE IF EXISTS "musicbrainz"."deleted_entity";
DROP TABLE IF EXISTS "musicbrainz"."dbmirror_pendingdata";
DROP SEQUENCE IF EXISTS "musicbrainz"."dbmirror_pending_seqid_seq";
DROP TABLE IF EXISTS "musicbrainz"."dbmirror_pending";
DROP TABLE IF EXISTS "musicbrainz"."country_area";
DROP SEQUENCE IF EXISTS "musicbrainz"."cdtoc_raw_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."cdtoc_raw";
DROP SEQUENCE IF EXISTS "musicbrainz"."cdtoc_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."cdtoc";
DROP SEQUENCE IF EXISTS "musicbrainz"."autoeditor_election_vote_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."autoeditor_election_vote";
DROP SEQUENCE IF EXISTS "musicbrainz"."autoeditor_election_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."autoeditor_election";
DROP SEQUENCE IF EXISTS "musicbrainz"."artist_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."artist_type";
DROP TABLE IF EXISTS "musicbrainz"."artist_tag_raw";
DROP TABLE IF EXISTS "musicbrainz"."artist_tag";
DROP VIEW IF EXISTS "musicbrainz"."artist_series";
DROP TABLE IF EXISTS "musicbrainz"."series";
DROP TABLE IF EXISTS "musicbrainz"."link_type";
DROP TABLE IF EXISTS "musicbrainz"."link_attribute_text_value";
DROP TABLE IF EXISTS "musicbrainz"."link";
DROP TABLE IF EXISTS "musicbrainz"."l_artist_series";
DROP TABLE IF EXISTS "musicbrainz"."artist_release_va";
DROP TABLE IF EXISTS "musicbrainz"."artist_release_pending_update";
DROP TABLE IF EXISTS "musicbrainz"."artist_release_nonva";
DROP TABLE IF EXISTS "musicbrainz"."artist_release_group_va";
DROP TABLE IF EXISTS "musicbrainz"."artist_release_group_pending_update";
DROP TABLE IF EXISTS "musicbrainz"."artist_release_group_nonva";
DROP TABLE IF EXISTS "musicbrainz"."artist_rating_raw";
DROP TABLE IF EXISTS "musicbrainz"."artist_meta";
DROP TABLE IF EXISTS "musicbrainz"."artist_isni";
DROP TABLE IF EXISTS "musicbrainz"."artist_ipi";
DROP SEQUENCE IF EXISTS "musicbrainz"."artist_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."artist_gid_redirect";
DROP TABLE IF EXISTS "musicbrainz"."artist_credit_name";
DROP SEQUENCE IF EXISTS "musicbrainz"."artist_credit_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."artist_credit_gid_redirect";
DROP TABLE IF EXISTS "musicbrainz"."artist_credit";
DROP SEQUENCE IF EXISTS "musicbrainz"."artist_attribute_type_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."artist_attribute_type_allowed_value_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."artist_attribute_type_allowed_value";
DROP TABLE IF EXISTS "musicbrainz"."artist_attribute_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."artist_attribute_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."artist_attribute";
DROP TABLE IF EXISTS "musicbrainz"."artist_annotation";
DROP SEQUENCE IF EXISTS "musicbrainz"."artist_alias_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."artist_alias_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."artist_alias_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."artist_alias";
DROP TABLE IF EXISTS "musicbrainz"."artist";
DROP SEQUENCE IF EXISTS "musicbrainz"."area_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."area_type";
DROP TABLE IF EXISTS "musicbrainz"."area_tag_raw";
DROP TABLE IF EXISTS "musicbrainz"."area_tag";
DROP SEQUENCE IF EXISTS "musicbrainz"."area_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."area_gid_redirect";
DROP SEQUENCE IF EXISTS "musicbrainz"."area_attribute_type_id_seq";
DROP SEQUENCE IF EXISTS "musicbrainz"."area_attribute_type_allowed_value_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."area_attribute_type_allowed_value";
DROP TABLE IF EXISTS "musicbrainz"."area_attribute_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."area_attribute_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."area_attribute";
DROP TABLE IF EXISTS "musicbrainz"."area_annotation";
DROP SEQUENCE IF EXISTS "musicbrainz"."area_alias_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."area_alias_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."area_alias_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."area_alias";
DROP TABLE IF EXISTS "musicbrainz"."area";
DROP SEQUENCE IF EXISTS "musicbrainz"."application_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."application";
DROP SEQUENCE IF EXISTS "musicbrainz"."annotation_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."annotation";
DROP SEQUENCE IF EXISTS "musicbrainz"."alternative_track_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."alternative_track";
DROP SEQUENCE IF EXISTS "musicbrainz"."alternative_release_type_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."alternative_release_type";
DROP SEQUENCE IF EXISTS "musicbrainz"."alternative_release_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."alternative_release";
DROP TABLE IF EXISTS "musicbrainz"."alternative_medium_track";
DROP SEQUENCE IF EXISTS "musicbrainz"."alternative_medium_id_seq";
DROP TABLE IF EXISTS "musicbrainz"."alternative_medium";
DROP TABLE IF EXISTS "json_dump"."work_json";
DROP TABLE IF EXISTS "json_dump"."tmp_checked_entities";
DROP TABLE IF EXISTS "json_dump"."series_json";
DROP TABLE IF EXISTS "json_dump"."release_json";
DROP TABLE IF EXISTS "json_dump"."release_group_json";
DROP TABLE IF EXISTS "json_dump"."recording_json";
DROP TABLE IF EXISTS "json_dump"."place_json";
DROP TABLE IF EXISTS "json_dump"."label_json";
DROP TABLE IF EXISTS "json_dump"."instrument_json";
DROP TABLE IF EXISTS "json_dump"."event_json";
DROP TABLE IF EXISTS "json_dump"."deleted_entities";
DROP TABLE IF EXISTS "json_dump"."control";
DROP TABLE IF EXISTS "json_dump"."artist_json";
DROP TABLE IF EXISTS "json_dump"."area_json";
DROP VIEW IF EXISTS "event_art_archive"."index_listing";
DROP TABLE IF EXISTS "event_art_archive"."event_art_type";
DROP TABLE IF EXISTS "event_art_archive"."event_art";
DROP SEQUENCE IF EXISTS "event_art_archive"."art_type_id_seq";
DROP TABLE IF EXISTS "event_art_archive"."art_type";
DROP TABLE IF EXISTS "documentation"."link_type_documentation";
DROP TABLE IF EXISTS "documentation"."l_work_work_example";
DROP TABLE IF EXISTS "documentation"."l_url_work_example";
DROP TABLE IF EXISTS "documentation"."l_url_url_example";
DROP TABLE IF EXISTS "documentation"."l_series_work_example";
DROP TABLE IF EXISTS "documentation"."l_series_url_example";
DROP TABLE IF EXISTS "documentation"."l_series_series_example";
DROP TABLE IF EXISTS "documentation"."l_release_work_example";
DROP TABLE IF EXISTS "documentation"."l_release_url_example";
DROP TABLE IF EXISTS "documentation"."l_release_series_example";
DROP TABLE IF EXISTS "documentation"."l_release_release_group_example";
DROP TABLE IF EXISTS "documentation"."l_release_release_example";
DROP TABLE IF EXISTS "documentation"."l_release_group_work_example";
DROP TABLE IF EXISTS "documentation"."l_release_group_url_example";
DROP TABLE IF EXISTS "documentation"."l_release_group_series_example";
DROP TABLE IF EXISTS "documentation"."l_release_group_release_group_example";
DROP TABLE IF EXISTS "documentation"."l_recording_work_example";
DROP TABLE IF EXISTS "documentation"."l_recording_url_example";
DROP TABLE IF EXISTS "documentation"."l_recording_series_example";
DROP TABLE IF EXISTS "documentation"."l_recording_release_group_example";
DROP TABLE IF EXISTS "documentation"."l_recording_release_example";
DROP TABLE IF EXISTS "documentation"."l_recording_recording_example";
DROP TABLE IF EXISTS "documentation"."l_place_work_example";
DROP TABLE IF EXISTS "documentation"."l_place_url_example";
DROP TABLE IF EXISTS "documentation"."l_place_series_example";
DROP TABLE IF EXISTS "documentation"."l_place_release_group_example";
DROP TABLE IF EXISTS "documentation"."l_place_release_example";
DROP TABLE IF EXISTS "documentation"."l_place_recording_example";
DROP TABLE IF EXISTS "documentation"."l_place_place_example";
DROP TABLE IF EXISTS "documentation"."l_mood_work_example";
DROP TABLE IF EXISTS "documentation"."l_mood_url_example";
DROP TABLE IF EXISTS "documentation"."l_mood_series_example";
DROP TABLE IF EXISTS "documentation"."l_mood_release_group_example";
DROP TABLE IF EXISTS "documentation"."l_mood_release_example";
DROP TABLE IF EXISTS "documentation"."l_mood_recording_example";
DROP TABLE IF EXISTS "documentation"."l_mood_place_example";
DROP TABLE IF EXISTS "documentation"."l_mood_mood_example";
DROP TABLE IF EXISTS "documentation"."l_label_work_example";
DROP TABLE IF EXISTS "documentation"."l_label_url_example";
DROP TABLE IF EXISTS "documentation"."l_label_series_example";
DROP TABLE IF EXISTS "documentation"."l_label_release_group_example";
DROP TABLE IF EXISTS "documentation"."l_label_release_example";
DROP TABLE IF EXISTS "documentation"."l_label_recording_example";
DROP TABLE IF EXISTS "documentation"."l_label_place_example";
DROP TABLE IF EXISTS "documentation"."l_label_mood_example";
DROP TABLE IF EXISTS "documentation"."l_label_label_example";
DROP TABLE IF EXISTS "documentation"."l_instrument_work_example";
DROP TABLE IF EXISTS "documentation"."l_instrument_url_example";
DROP TABLE IF EXISTS "documentation"."l_instrument_series_example";
DROP TABLE IF EXISTS "documentation"."l_instrument_release_group_example";
DROP TABLE IF EXISTS "documentation"."l_instrument_release_example";
DROP TABLE IF EXISTS "documentation"."l_instrument_recording_example";
DROP TABLE IF EXISTS "documentation"."l_instrument_place_example";
DROP TABLE IF EXISTS "documentation"."l_instrument_mood_example";
DROP TABLE IF EXISTS "documentation"."l_instrument_label_example";
DROP TABLE IF EXISTS "documentation"."l_instrument_instrument_example";
DROP TABLE IF EXISTS "documentation"."l_genre_work_example";
DROP TABLE IF EXISTS "documentation"."l_genre_url_example";
DROP TABLE IF EXISTS "documentation"."l_genre_series_example";
DROP TABLE IF EXISTS "documentation"."l_genre_release_group_example";
DROP TABLE IF EXISTS "documentation"."l_genre_release_example";
DROP TABLE IF EXISTS "documentation"."l_genre_recording_example";
DROP TABLE IF EXISTS "documentation"."l_genre_place_example";
DROP TABLE IF EXISTS "documentation"."l_genre_mood_example";
DROP TABLE IF EXISTS "documentation"."l_genre_label_example";
DROP TABLE IF EXISTS "documentation"."l_genre_instrument_example";
DROP TABLE IF EXISTS "documentation"."l_genre_genre_example";
DROP TABLE IF EXISTS "documentation"."l_event_work_example";
DROP TABLE IF EXISTS "documentation"."l_event_url_example";
DROP TABLE IF EXISTS "documentation"."l_event_series_example";
DROP TABLE IF EXISTS "documentation"."l_event_release_group_example";
DROP TABLE IF EXISTS "documentation"."l_event_release_example";
DROP TABLE IF EXISTS "documentation"."l_event_recording_example";
DROP TABLE IF EXISTS "documentation"."l_event_place_example";
DROP TABLE IF EXISTS "documentation"."l_event_mood_example";
DROP TABLE IF EXISTS "documentation"."l_event_label_example";
DROP TABLE IF EXISTS "documentation"."l_event_instrument_example";
DROP TABLE IF EXISTS "documentation"."l_event_genre_example";
DROP TABLE IF EXISTS "documentation"."l_event_event_example";
DROP TABLE IF EXISTS "documentation"."l_artist_work_example";
DROP TABLE IF EXISTS "documentation"."l_artist_url_example";
DROP TABLE IF EXISTS "documentation"."l_artist_series_example";
DROP TABLE IF EXISTS "documentation"."l_artist_release_group_example";
DROP TABLE IF EXISTS "documentation"."l_artist_release_example";
DROP TABLE IF EXISTS "documentation"."l_artist_recording_example";
DROP TABLE IF EXISTS "documentation"."l_artist_place_example";
DROP TABLE IF EXISTS "documentation"."l_artist_mood_example";
DROP TABLE IF EXISTS "documentation"."l_artist_label_example";
DROP TABLE IF EXISTS "documentation"."l_artist_instrument_example";
DROP TABLE IF EXISTS "documentation"."l_artist_genre_example";
DROP TABLE IF EXISTS "documentation"."l_artist_event_example";
DROP TABLE IF EXISTS "documentation"."l_artist_artist_example";
DROP TABLE IF EXISTS "documentation"."l_area_work_example";
DROP TABLE IF EXISTS "documentation"."l_area_url_example";
DROP TABLE IF EXISTS "documentation"."l_area_series_example";
DROP TABLE IF EXISTS "documentation"."l_area_release_group_example";
DROP TABLE IF EXISTS "documentation"."l_area_release_example";
DROP TABLE IF EXISTS "documentation"."l_area_recording_example";
DROP TABLE IF EXISTS "documentation"."l_area_place_example";
DROP TABLE IF EXISTS "documentation"."l_area_mood_example";
DROP TABLE IF EXISTS "documentation"."l_area_label_example";
DROP TABLE IF EXISTS "documentation"."l_area_instrument_example";
DROP TABLE IF EXISTS "documentation"."l_area_genre_example";
DROP TABLE IF EXISTS "documentation"."l_area_event_example";
DROP TABLE IF EXISTS "documentation"."l_area_artist_example";
DROP TABLE IF EXISTS "documentation"."l_area_area_example";
DROP TABLE IF EXISTS "dbmirror2"."pending_ts";
DROP TABLE IF EXISTS "dbmirror2"."pending_keys";
DROP SEQUENCE IF EXISTS "dbmirror2"."pending_data_seqid_seq";
DROP TABLE IF EXISTS "dbmirror2"."pending_data";
DROP TABLE IF EXISTS "cover_art_archive"."release_group_cover_art";
DROP VIEW IF EXISTS "cover_art_archive"."index_listing";
DROP TABLE IF EXISTS "musicbrainz"."edit";
DROP TABLE IF EXISTS "cover_art_archive"."image_type";
DROP TABLE IF EXISTS "cover_art_archive"."cover_art_type";
DROP TABLE IF EXISTS "cover_art_archive"."cover_art";
DROP SEQUENCE IF EXISTS "cover_art_archive"."art_type_id_seq";
DROP TABLE IF EXISTS "cover_art_archive"."art_type";
DROP TEXT SEARCH CONFIGURATION IF EXISTS "musicbrainz"."mb_simple";
DROP AGGREGATE IF EXISTS "musicbrainz"."median"(integer);
DROP AGGREGATE IF EXISTS "musicbrainz"."array_cat_agg"(smallint[]);
DROP FUNCTION IF EXISTS "public"."immutable_unaccent"("regdictionary", "text");
DROP FUNCTION IF EXISTS "musicbrainz"."update_tag_counts_for_raw_update"();
DROP FUNCTION IF EXISTS "musicbrainz"."update_tag_counts_for_raw_insert"();
DROP FUNCTION IF EXISTS "musicbrainz"."update_tag_counts_for_raw_delete"();
DROP FUNCTION IF EXISTS "musicbrainz"."update_area_containment_mirror"("parent_ids" integer[], "descendant_ids" integer[]);
DROP FUNCTION IF EXISTS "musicbrainz"."update_aggregate_tag_count"("entity_type" "musicbrainz"."taggable_entity_type", "entity_id" integer, "tag_id" integer, "count_change" smallint);
DROP FUNCTION IF EXISTS "musicbrainz"."update_aggregate_rating_for_raw_update"();
DROP FUNCTION IF EXISTS "musicbrainz"."update_aggregate_rating_for_raw_insert"();
DROP FUNCTION IF EXISTS "musicbrainz"."update_aggregate_rating_for_raw_delete"();
DROP FUNCTION IF EXISTS "musicbrainz"."update_aggregate_rating"("entity_type" "musicbrainz"."ratable_entity_type", "entity_id" integer);
DROP FUNCTION IF EXISTS "musicbrainz"."trg_delete_unused_tag_ref"();
DROP FUNCTION IF EXISTS "musicbrainz"."trg_delete_unused_tag"();
DROP FUNCTION IF EXISTS "musicbrainz"."track_count_matches_cdtoc"("musicbrainz"."medium", integer);
DROP TABLE IF EXISTS "musicbrainz"."medium";
DROP FUNCTION IF EXISTS "musicbrainz"."simplify_search_hints"();
DROP FUNCTION IF EXISTS "musicbrainz"."set_releases_recordings_first_release_dates"("release_ids" integer[]);
DROP FUNCTION IF EXISTS "musicbrainz"."set_release_group_first_release_date"("release_group_id" integer);
DROP FUNCTION IF EXISTS "musicbrainz"."set_release_first_release_date"("release_id" integer);
DROP FUNCTION IF EXISTS "musicbrainz"."set_recordings_first_release_dates"("recording_ids" integer[]);
DROP FUNCTION IF EXISTS "musicbrainz"."set_mediums_recordings_first_release_dates"("medium_ids" integer[]);
DROP FUNCTION IF EXISTS "musicbrainz"."restore_collection_sub_on_public"();
DROP FUNCTION IF EXISTS "musicbrainz"."replace_old_sub_on_add"();
DROP FUNCTION IF EXISTS "musicbrainz"."remove_unused_url"();
DROP FUNCTION IF EXISTS "musicbrainz"."remove_unused_links"();
DROP FUNCTION IF EXISTS "musicbrainz"."prevent_invalid_attributes"();
DROP FUNCTION IF EXISTS "musicbrainz"."padded_by_whitespace"("text");
DROP FUNCTION IF EXISTS "musicbrainz"."musicbrainz_unaccent"("text");
DROP FUNCTION IF EXISTS "musicbrainz"."median_track_length"("recording_id" integer);
DROP FUNCTION IF EXISTS "musicbrainz"."mb_simple_tsvector"("input" "text");
DROP FUNCTION IF EXISTS "musicbrainz"."mb_lower"("input" "text");
DROP FUNCTION IF EXISTS "musicbrainz"."materialise_recording_length"("recording_id" integer);
DROP FUNCTION IF EXISTS "musicbrainz"."ll_to_earth"(double precision, double precision);
DROP FUNCTION IF EXISTS "musicbrainz"."integer_date"("year" smallint, "month" smallint, "day" smallint);
DROP FUNCTION IF EXISTS "musicbrainz"."inserting_edits_requires_confirmed_email_address"();
DROP FUNCTION IF EXISTS "musicbrainz"."inc_ref_count"("tbl" character varying, "row_id" integer, "val" integer);
DROP FUNCTION IF EXISTS "musicbrainz"."inc_nullable_artist_credit"("row_id" integer);
DROP FUNCTION IF EXISTS "musicbrainz"."get_release_first_release_date_rows"("condition" "text");
DROP TABLE IF EXISTS "musicbrainz"."release_first_release_date";
DROP FUNCTION IF EXISTS "musicbrainz"."get_recording_first_release_date_rows"("condition" "text");
DROP TABLE IF EXISTS "musicbrainz"."recording_first_release_date";
DROP FUNCTION IF EXISTS "musicbrainz"."get_artist_release_rows"("release_id" integer);
DROP TABLE IF EXISTS "musicbrainz"."artist_release";
DROP FUNCTION IF EXISTS "musicbrainz"."get_artist_release_group_rows"("release_group_id" integer);
DROP TABLE IF EXISTS "musicbrainz"."artist_release_group";
DROP FUNCTION IF EXISTS "musicbrainz"."get_area_parent_hierarchy_rows"("descendant_area_ids" integer[]);
DROP FUNCTION IF EXISTS "musicbrainz"."get_area_descendant_hierarchy_rows"("parent_area_ids" integer[]);
DROP TABLE IF EXISTS "musicbrainz"."area_containment";
DROP FUNCTION IF EXISTS "musicbrainz"."generate_uuid_v4"();
DROP FUNCTION IF EXISTS "musicbrainz"."generate_uuid_v3"("namespace" character varying, "name" character varying);
DROP FUNCTION IF EXISTS "musicbrainz"."from_hex"("t" "text");
DROP FUNCTION IF EXISTS "musicbrainz"."ensure_work_attribute_type_allows_text"();
DROP FUNCTION IF EXISTS "musicbrainz"."ensure_series_attribute_type_allows_text"();
DROP FUNCTION IF EXISTS "musicbrainz"."ensure_release_group_attribute_type_allows_text"();
DROP FUNCTION IF EXISTS "musicbrainz"."ensure_release_attribute_type_allows_text"();
DROP FUNCTION IF EXISTS "musicbrainz"."ensure_recording_attribute_type_allows_text"();
DROP FUNCTION IF EXISTS "musicbrainz"."ensure_place_attribute_type_allows_text"();
DROP FUNCTION IF EXISTS "musicbrainz"."ensure_medium_attribute_type_allows_text"();
DROP FUNCTION IF EXISTS "musicbrainz"."ensure_label_attribute_type_allows_text"();
DROP FUNCTION IF EXISTS "musicbrainz"."ensure_instrument_attribute_type_allows_text"();
DROP FUNCTION IF EXISTS "musicbrainz"."ensure_event_attribute_type_allows_text"();
DROP FUNCTION IF EXISTS "musicbrainz"."ensure_artist_attribute_type_allows_text"();
DROP FUNCTION IF EXISTS "musicbrainz"."ensure_area_attribute_type_allows_text"();
DROP FUNCTION IF EXISTS "musicbrainz"."end_date_implies_ended"();
DROP FUNCTION IF EXISTS "musicbrainz"."end_area_implies_ended"();
DROP FUNCTION IF EXISTS "musicbrainz"."edit_data_type_info"("data" "jsonb");
DROP FUNCTION IF EXISTS "musicbrainz"."deny_special_purpose_deletion"();
DROP FUNCTION IF EXISTS "musicbrainz"."deny_deprecated_links"();
DROP FUNCTION IF EXISTS "musicbrainz"."delete_unused_url"("ids" integer[]);
DROP FUNCTION IF EXISTS "musicbrainz"."delete_unused_tag"("tag_id" integer);
DROP FUNCTION IF EXISTS "musicbrainz"."delete_unused_aggregate_tag"("entity_type" "musicbrainz"."taggable_entity_type", "entity_id" integer, "tag_id" integer);
DROP FUNCTION IF EXISTS "musicbrainz"."delete_ratings"("enttype" "text", "ids" integer[]);
DROP FUNCTION IF EXISTS "musicbrainz"."delete_orphaned_recordings"();
DROP FUNCTION IF EXISTS "musicbrainz"."del_collection_sub_on_private"();
DROP FUNCTION IF EXISTS "musicbrainz"."del_collection_sub_on_delete"();
DROP FUNCTION IF EXISTS "musicbrainz"."dec_ref_count"("tbl" character varying, "row_id" integer, "val" integer);
DROP FUNCTION IF EXISTS "musicbrainz"."dec_nullable_artist_credit"("row_id" integer);
DROP FUNCTION IF EXISTS "musicbrainz"."create_cube_from_durations"("durations" integer[]);
DROP FUNCTION IF EXISTS "musicbrainz"."create_bounding_cube"("durations" integer[], "fuzzy" integer);
DROP FUNCTION IF EXISTS "musicbrainz"."controlled_for_whitespace"("text");
DROP FUNCTION IF EXISTS "musicbrainz"."check_has_dates"();
DROP FUNCTION IF EXISTS "musicbrainz"."check_editor_name"();
DROP FUNCTION IF EXISTS "musicbrainz"."b_upd_release_group_secondary_type_join"();
DROP FUNCTION IF EXISTS "musicbrainz"."b_upd_recording"();
DROP FUNCTION IF EXISTS "musicbrainz"."b_upd_link_attribute_text_value"();
DROP FUNCTION IF EXISTS "musicbrainz"."b_upd_link_attribute_credit"();
DROP FUNCTION IF EXISTS "musicbrainz"."b_upd_link_attribute"();
DROP FUNCTION IF EXISTS "musicbrainz"."b_upd_link"();
DROP FUNCTION IF EXISTS "musicbrainz"."b_upd_last_updated_table"();
DROP FUNCTION IF EXISTS "musicbrainz"."b_upd_artist_credit_name"();
DROP FUNCTION IF EXISTS "musicbrainz"."b_ins_edit_materialize_status"();
DROP FUNCTION IF EXISTS "musicbrainz"."apply_artist_release_pending_updates"();
DROP FUNCTION IF EXISTS "musicbrainz"."apply_artist_release_group_pending_updates"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_upd_track_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_upd_track"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_upd_release_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_upd_release_label_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_upd_release_label"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_upd_release_group_secondary_type_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_upd_release_group_primary_type_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_upd_release_group_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_upd_release_group_meta_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_upd_release_group"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_upd_release_event_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_upd_release_event"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_upd_release"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_upd_recording"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_upd_medium_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_upd_l_area_area_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_upd_instrument"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_upd_edit"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_upd_alternative_release_or_track"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_upd_alternative_medium_track"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_work"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_track_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_track"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_release_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_release_label_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_release_label"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_release_group_secondary_type_join_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_release_group_secondary_type_join"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_release_group_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_release_group"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_release_event_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_release_event"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_release"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_recording"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_place"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_label"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_l_area_area_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_instrument"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_event"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_edit_note"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_artist"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_alternative_release_or_track"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_ins_alternative_medium_track"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_del_track_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_del_track"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_del_release_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_del_release_label_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_del_release_label"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_del_release_group_secondary_type_join_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_del_release_group_secondary_type_join"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_del_release_group_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_del_release_group"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_del_release_event_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_del_release_event"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_del_release"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_del_recording"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_del_l_area_area_mirror"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_del_instrument"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_del_alternative_release_or_track"();
DROP FUNCTION IF EXISTS "musicbrainz"."a_del_alternative_medium_track"();
DROP FUNCTION IF EXISTS "musicbrainz"."_median"(integer[]);
DROP FUNCTION IF EXISTS "event_art_archive"."resequence_positions"("event_id" integer);
DROP FUNCTION IF EXISTS "event_art_archive"."resequence_event_art_trigger"();
DROP FUNCTION IF EXISTS "event_art_archive"."materialize_eaa_presence"();
DROP FUNCTION IF EXISTS "cover_art_archive"."resequence_positions"("release_id" integer);
DROP FUNCTION IF EXISTS "cover_art_archive"."resequence_cover_art_trigger"();
DROP FUNCTION IF EXISTS "cover_art_archive"."materialize_caa_presence"();
DROP TYPE IF EXISTS "musicbrainz"."taggable_entity_type";
DROP TYPE IF EXISTS "musicbrainz"."ratable_entity_type";
DROP TYPE IF EXISTS "musicbrainz"."oauth_code_challenge_method";
DROP TYPE IF EXISTS "musicbrainz"."fluency";
DROP TYPE IF EXISTS "musicbrainz"."event_art_presence";
DROP TYPE IF EXISTS "musicbrainz"."edit_note_status";
DROP TYPE IF EXISTS "musicbrainz"."cover_art_presence";
DROP EXTENSION IF EXISTS "unaccent";
DROP EXTENSION IF EXISTS "earthdistance";
DROP EXTENSION IF EXISTS "cube";
DROP COLLATION IF EXISTS "musicbrainz"."musicbrainz";
DROP SCHEMA IF EXISTS "wikidocs";
DROP SCHEMA IF EXISTS "statistics";
DROP SCHEMA IF EXISTS "sitemaps";
DROP SCHEMA IF EXISTS "report";
DROP SCHEMA IF EXISTS "musicbrainz";
DROP SCHEMA IF EXISTS "json_dump";
DROP SCHEMA IF EXISTS "event_art_archive";
DROP SCHEMA IF EXISTS "documentation";
DROP SCHEMA IF EXISTS "dbmirror2";
DROP SCHEMA IF EXISTS "cover_art_archive";
--
-- Name: cover_art_archive; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "cover_art_archive";


--
-- Name: dbmirror2; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "dbmirror2";


--
-- Name: documentation; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "documentation";


--
-- Name: event_art_archive; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "event_art_archive";


--
-- Name: json_dump; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "json_dump";


--
-- Name: musicbrainz; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "musicbrainz";


--
-- Name: SCHEMA "public"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA "public" IS 'standard public schema';


--
-- Name: report; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "report";


--
-- Name: sitemaps; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "sitemaps";


--
-- Name: statistics; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "statistics";


--
-- Name: wikidocs; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "wikidocs";


--
-- Name: musicbrainz; Type: COLLATION; Schema: musicbrainz; Owner: -
--

CREATE COLLATION "musicbrainz"."musicbrainz" (provider = icu, locale = 'und-u-kf-lower-kn');


--
-- Name: cube; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "cube" WITH SCHEMA "public";


--
-- Name: EXTENSION "cube"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "cube" IS 'data type for multidimensional cubes';


--
-- Name: earthdistance; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "earthdistance" WITH SCHEMA "public";


--
-- Name: EXTENSION "earthdistance"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "earthdistance" IS 'calculate great-circle distances on the surface of the Earth';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "unaccent" WITH SCHEMA "public";


--
-- Name: EXTENSION "unaccent"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "unaccent" IS 'text search dictionary that removes accents';


--
-- Name: cover_art_presence; Type: TYPE; Schema: musicbrainz; Owner: -
--

CREATE TYPE "musicbrainz"."cover_art_presence" AS ENUM (
    'absent',
    'present',
    'darkened'
);


--
-- Name: edit_note_status; Type: TYPE; Schema: musicbrainz; Owner: -
--

CREATE TYPE "musicbrainz"."edit_note_status" AS ENUM (
    'deleted',
    'edited'
);


--
-- Name: event_art_presence; Type: TYPE; Schema: musicbrainz; Owner: -
--

CREATE TYPE "musicbrainz"."event_art_presence" AS ENUM (
    'absent',
    'present',
    'darkened'
);


--
-- Name: fluency; Type: TYPE; Schema: musicbrainz; Owner: -
--

CREATE TYPE "musicbrainz"."fluency" AS ENUM (
    'basic',
    'intermediate',
    'advanced',
    'native'
);


--
-- Name: oauth_code_challenge_method; Type: TYPE; Schema: musicbrainz; Owner: -
--

CREATE TYPE "musicbrainz"."oauth_code_challenge_method" AS ENUM (
    'plain',
    'S256'
);


--
-- Name: ratable_entity_type; Type: TYPE; Schema: musicbrainz; Owner: -
--

CREATE TYPE "musicbrainz"."ratable_entity_type" AS ENUM (
    'artist',
    'event',
    'label',
    'place',
    'recording',
    'release_group',
    'work'
);


--
-- Name: taggable_entity_type; Type: TYPE; Schema: musicbrainz; Owner: -
--

CREATE TYPE "musicbrainz"."taggable_entity_type" AS ENUM (
    'area',
    'artist',
    'event',
    'instrument',
    'label',
    'place',
    'recording',
    'release',
    'release_group',
    'series',
    'work'
);


--
-- Name: materialize_caa_presence(); Type: FUNCTION; Schema: cover_art_archive; Owner: -
--

CREATE FUNCTION "cover_art_archive"."materialize_caa_presence"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
    BEGIN
        -- On delete, set the presence flag to 'absent' if there's no more
        -- cover art
        IF TG_OP = 'DELETE' THEN
            IF NOT EXISTS (
                SELECT TRUE FROM cover_art_archive.cover_art
                WHERE release = OLD.release
            ) THEN
                UPDATE musicbrainz.release_meta
                SET cover_art_presence = 'absent'
                WHERE id = OLD.release;
            END IF;
        END IF;

        -- On insert, set the presence flag to 'present' if it was previously
        -- 'absent'
        IF TG_OP = 'INSERT' THEN
            CASE (
                SELECT cover_art_presence FROM musicbrainz.release_meta
                WHERE id = NEW.release
            )
                WHEN 'absent' THEN
                    UPDATE musicbrainz.release_meta
                    SET cover_art_presence = 'present'
                    WHERE id = NEW.release;
                WHEN 'darkened' THEN
                    RAISE EXCEPTION 'This release has been darkened and cannot have new cover art';
                ELSE
            END CASE;
        END IF;

        RETURN NULL;
    END;
$$;


--
-- Name: resequence_cover_art_trigger(); Type: FUNCTION; Schema: cover_art_archive; Owner: -
--

CREATE FUNCTION "cover_art_archive"."resequence_cover_art_trigger"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
    BEGIN
        IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
            PERFORM cover_art_archive.resequence_positions(NEW.release);
        END IF;

        IF (TG_OP = 'DELETE') OR
           (TG_OP = 'UPDATE' AND NEW.release != OLD.release)
        THEN
            PERFORM cover_art_archive.resequence_positions(OLD.release);
        END IF;

        RETURN NULL;
    END;
$$;


--
-- Name: resequence_positions(integer); Type: FUNCTION; Schema: cover_art_archive; Owner: -
--

CREATE FUNCTION "cover_art_archive"."resequence_positions"("release_id" integer) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
    BEGIN
        UPDATE cover_art_archive.cover_art
        SET ordering = recalculated.row_number
        FROM (
            SELECT *,
              row_number() OVER (PARTITION BY release ORDER BY ordering ASC)
            FROM cover_art_archive.cover_art
            WHERE cover_art.release = release_id
        ) recalculated
        WHERE recalculated.id = cover_art.id AND
          recalculated.row_number != cover_art.ordering;
   END;
$$;


--
-- Name: materialize_eaa_presence(); Type: FUNCTION; Schema: event_art_archive; Owner: -
--

CREATE FUNCTION "event_art_archive"."materialize_eaa_presence"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
    BEGIN
        -- On delete, set the presence flag to 'absent' if there's no more
        -- event art
        IF TG_OP = 'DELETE' THEN
            IF NOT EXISTS (
                SELECT TRUE FROM event_art_archive.event_art
                WHERE event = OLD.event
            ) THEN
                UPDATE musicbrainz.event_meta
                SET event_art_presence = 'absent'
                WHERE id = OLD.event;
            END IF;
        END IF;

        -- On insert, set the presence flag to 'present' if it was previously
        -- 'absent'
        IF TG_OP = 'INSERT' THEN
            CASE (
                SELECT event_art_presence FROM musicbrainz.event_meta
                WHERE id = NEW.event
            )
                WHEN 'absent' THEN
                    UPDATE musicbrainz.event_meta
                    SET event_art_presence = 'present'
                    WHERE id = NEW.event;
                WHEN 'darkened' THEN
                    RAISE EXCEPTION 'This event has been darkened and cannot have new event art';
                ELSE
            END CASE;
        END IF;

        RETURN NULL;
    END;
$$;


--
-- Name: resequence_event_art_trigger(); Type: FUNCTION; Schema: event_art_archive; Owner: -
--

CREATE FUNCTION "event_art_archive"."resequence_event_art_trigger"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
    BEGIN
        IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
            PERFORM event_art_archive.resequence_positions(NEW.event);
        END IF;

        IF (TG_OP = 'DELETE') OR
           (TG_OP = 'UPDATE' AND NEW.event != OLD.event)
        THEN
            PERFORM event_art_archive.resequence_positions(OLD.event);
        END IF;

        RETURN NULL;
    END;
$$;


--
-- Name: resequence_positions(integer); Type: FUNCTION; Schema: event_art_archive; Owner: -
--

CREATE FUNCTION "event_art_archive"."resequence_positions"("event_id" integer) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
    BEGIN
        UPDATE event_art_archive.event_art
        SET ordering = recalculated.row_number
        FROM (
            SELECT *,
              row_number() OVER (PARTITION BY event ORDER BY ordering ASC)
            FROM event_art_archive.event_art
            WHERE event_art.event = event_id
        ) recalculated
        WHERE recalculated.id = event_art.id AND
          recalculated.row_number != event_art.ordering;
   END;
$$;


--
-- Name: _median(integer[]); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."_median"(integer[]) RETURNS integer
    LANGUAGE "sql" IMMUTABLE
    AS $_$
  WITH q AS (
      SELECT val
      FROM unnest($1) val
      WHERE VAL IS NOT NULL
      ORDER BY val
  )
  SELECT val
  FROM q
  LIMIT 1
  -- Subtracting (n + 1) % 2 creates a left bias
  OFFSET greatest(0, floor((select count(*) FROM q) / 2.0) - ((select count(*) + 1 FROM q) % 2));
$_$;


--
-- Name: a_del_alternative_medium_track(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_del_alternative_medium_track"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    PERFORM dec_ref_count('alternative_track', OLD.alternative_track, 1);
    RETURN NULL;
END;
$$;


--
-- Name: a_del_alternative_release_or_track(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_del_alternative_release_or_track"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    PERFORM dec_nullable_artist_credit(OLD.artist_credit);
    RETURN NULL;
END;
$$;


--
-- Name: a_del_instrument(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_del_instrument"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    DELETE FROM link_attribute_type WHERE gid = OLD.gid;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'no link_attribute_type found for instrument %', NEW.gid;
    ELSE
        RETURN NEW;
    END IF;
END;
$$;


--
-- Name: a_del_l_area_area_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_del_l_area_area_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    part_of_area_link_type_id CONSTANT SMALLINT := 356;
BEGIN
    -- DO NOT modify any replicated tables in this function; it's used
    -- by a trigger on mirrors.
    IF (SELECT link_type FROM link WHERE id = OLD.link) = part_of_area_link_type_id THEN
        PERFORM update_area_containment_mirror(ARRAY[OLD.entity0], ARRAY[OLD.entity1]);
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: a_del_recording(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_del_recording"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    PERFORM dec_ref_count('artist_credit', OLD.artist_credit, 1);
    RETURN NULL;
END;
$$;


--
-- Name: a_del_release(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_del_release"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- decrement ref_count of the name
    PERFORM dec_ref_count('artist_credit', OLD.artist_credit, 1);
    -- decrement release_count of the parent release group
    UPDATE release_group_meta SET release_count = release_count - 1 WHERE id = OLD.release_group;
    INSERT INTO artist_release_pending_update VALUES (OLD.id);
    INSERT INTO artist_release_group_pending_update VALUES (OLD.release_group);
    RETURN NULL;
END;
$$;


--
-- Name: a_del_release_event(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_del_release_event"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  PERFORM set_release_first_release_date(OLD.release);

  PERFORM set_release_group_first_release_date(release_group)
  FROM release
  WHERE release.id = OLD.release;

  PERFORM set_releases_recordings_first_release_dates(ARRAY[OLD.release]);

  IF TG_TABLE_NAME = 'release_country' THEN
    INSERT INTO artist_release_pending_update VALUES (OLD.release);
  END IF;

  RETURN NULL;
END;
$$;


--
-- Name: a_del_release_event_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_del_release_event_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    PERFORM set_release_first_release_date(OLD.release);
    PERFORM set_releases_recordings_first_release_dates(ARRAY[OLD.release]);
    IF TG_TABLE_NAME = 'release_country' THEN
        INSERT INTO artist_release_pending_update VALUES (OLD.release);
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: a_del_release_group(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_del_release_group"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    PERFORM dec_ref_count('artist_credit', OLD.artist_credit, 1);
    INSERT INTO artist_release_group_pending_update VALUES (OLD.id);
    RETURN NULL;
END;
$$;


--
-- Name: a_del_release_group_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_del_release_group_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    INSERT INTO artist_release_group_pending_update VALUES (OLD.id);
    RETURN NULL;
END;
$$;


--
-- Name: a_del_release_group_secondary_type_join(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_del_release_group_secondary_type_join"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    INSERT INTO artist_release_group_pending_update VALUES (OLD.release_group);
    RETURN NULL;
END;
$$;


--
-- Name: a_del_release_group_secondary_type_join_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_del_release_group_secondary_type_join_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    INSERT INTO artist_release_group_pending_update VALUES (OLD.release_group);
    RETURN NULL;
END;
$$;


--
-- Name: a_del_release_label(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_del_release_label"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    INSERT INTO artist_release_pending_update VALUES (OLD.release);
    RETURN NULL;
END;
$$;


--
-- Name: a_del_release_label_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_del_release_label_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    INSERT INTO artist_release_pending_update VALUES (OLD.release);
    RETURN NULL;
END;
$$;


--
-- Name: a_del_release_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_del_release_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    INSERT INTO artist_release_pending_update VALUES (OLD.id);
    INSERT INTO artist_release_group_pending_update VALUES (OLD.release_group);
    RETURN NULL;
END;
$$;


--
-- Name: a_del_track(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_del_track"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    PERFORM dec_ref_count('artist_credit', OLD.artist_credit, 1);
    -- decrement track_count in the parent medium
    UPDATE medium SET track_count = track_count - 1 WHERE id = OLD.medium;
    PERFORM materialise_recording_length(OLD.recording);
    PERFORM set_recordings_first_release_dates(ARRAY[OLD.recording]);
    INSERT INTO artist_release_pending_update (
        SELECT release FROM medium
        WHERE id = OLD.medium
    );
    INSERT INTO artist_release_group_pending_update (
        SELECT release_group FROM release
        JOIN medium ON medium.release = release.id
        WHERE medium.id = OLD.medium
    );
    RETURN NULL;
END;
$$;


--
-- Name: a_del_track_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_del_track_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    PERFORM set_recordings_first_release_dates(ARRAY[OLD.recording]);
    INSERT INTO artist_release_pending_update (
        SELECT release FROM medium
        WHERE id = OLD.medium
    );
    INSERT INTO artist_release_group_pending_update (
        SELECT release_group FROM release
        JOIN medium ON medium.release = release.id
        WHERE medium.id = OLD.medium
    );
    RETURN NULL;
END;
$$;


--
-- Name: a_ins_alternative_medium_track(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_alternative_medium_track"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    PERFORM inc_ref_count('alternative_track', NEW.alternative_track, 1);
    RETURN NULL;
END;
$$;


--
-- Name: a_ins_alternative_release_or_track(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_alternative_release_or_track"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    PERFORM inc_nullable_artist_credit(NEW.artist_credit);
    RETURN NULL;
END;
$$;


--
-- Name: a_ins_artist(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_artist"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- add a new entry to the artist_meta table
    INSERT INTO artist_meta (id) VALUES (NEW.id);
    RETURN NULL;
END;
$$;


--
-- Name: a_ins_edit_note(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_edit_note"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    INSERT INTO edit_note_recipient (recipient, edit_note) (
        SELECT edit.editor, NEW.id
          FROM edit
         WHERE edit.id = NEW.edit
           AND edit.editor != NEW.editor
    );
    RETURN NULL;
END;
$$;


--
-- Name: a_ins_event(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_event"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- add a new entry to the event_meta table
    INSERT INTO event_meta (id) VALUES (NEW.id);
    RETURN NULL;
END;
$$;


--
-- Name: a_ins_instrument(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_instrument"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    WITH inserted_rows (id) AS (
        INSERT INTO link_attribute_type (parent, root, child_order, gid, name, description)
        VALUES (14, 14, 0, NEW.gid, NEW.name, NEW.description)
        RETURNING id
    ) INSERT INTO link_creditable_attribute_type (attribute_type) SELECT id FROM inserted_rows;
    RETURN NEW;
END;
$$;


--
-- Name: a_ins_l_area_area_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_l_area_area_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    part_of_area_link_type_id CONSTANT SMALLINT := 356;
BEGIN
    -- DO NOT modify any replicated tables in this function; it's used
    -- by a trigger on mirrors.
    IF (SELECT link_type FROM link WHERE id = NEW.link) = part_of_area_link_type_id THEN
        PERFORM update_area_containment_mirror(ARRAY[NEW.entity0], ARRAY[NEW.entity1]);
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: a_ins_label(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_label"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    INSERT INTO label_meta (id) VALUES (NEW.id);
    RETURN NULL;
END;
$$;


--
-- Name: a_ins_place(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_place"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- add a new entry to the place_meta table
    INSERT INTO place_meta (id) VALUES (NEW.id);
    RETURN NULL;
END;
$$;


--
-- Name: a_ins_recording(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_recording"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    PERFORM inc_ref_count('artist_credit', NEW.artist_credit, 1);
    INSERT INTO recording_meta (id) VALUES (NEW.id);
    RETURN NULL;
END;
$$;


--
-- Name: a_ins_release(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_release"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- increment ref_count of the name
    PERFORM inc_ref_count('artist_credit', NEW.artist_credit, 1);
    -- increment release_count of the parent release group
    UPDATE release_group_meta SET release_count = release_count + 1 WHERE id = NEW.release_group;
    -- add new release_meta
    INSERT INTO release_meta (id) VALUES (NEW.id);
    INSERT INTO artist_release_pending_update VALUES (NEW.id);
    INSERT INTO artist_release_group_pending_update VALUES (NEW.release_group);
    RETURN NULL;
END;
$$;


--
-- Name: a_ins_release_event(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_release_event"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  PERFORM set_release_first_release_date(NEW.release);

  PERFORM set_release_group_first_release_date(release_group)
  FROM release
  WHERE release.id = NEW.release;

  PERFORM set_releases_recordings_first_release_dates(ARRAY[NEW.release]);

  IF TG_TABLE_NAME = 'release_country' THEN
    INSERT INTO artist_release_pending_update VALUES (NEW.release);
  END IF;

  RETURN NULL;
END;
$$;


--
-- Name: a_ins_release_event_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_release_event_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    PERFORM set_release_first_release_date(NEW.release);
    PERFORM set_releases_recordings_first_release_dates(ARRAY[NEW.release]);
    IF TG_TABLE_NAME = 'release_country' THEN
        INSERT INTO artist_release_pending_update VALUES (NEW.release);
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: a_ins_release_group(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_release_group"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    PERFORM inc_ref_count('artist_credit', NEW.artist_credit, 1);
    INSERT INTO release_group_meta (id) VALUES (NEW.id);
    INSERT INTO artist_release_group_pending_update VALUES (NEW.id);
    RETURN NULL;
END;
$$;


--
-- Name: a_ins_release_group_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_release_group_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    INSERT INTO artist_release_group_pending_update VALUES (NEW.id);
    RETURN NULL;
END;
$$;


--
-- Name: a_ins_release_group_secondary_type_join(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_release_group_secondary_type_join"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    INSERT INTO artist_release_group_pending_update VALUES (NEW.release_group);
    RETURN NULL;
END;
$$;


--
-- Name: a_ins_release_group_secondary_type_join_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_release_group_secondary_type_join_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    INSERT INTO artist_release_group_pending_update VALUES (NEW.release_group);
    RETURN NULL;
END;
$$;


--
-- Name: a_ins_release_label(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_release_label"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    INSERT INTO artist_release_pending_update VALUES (NEW.release);
    RETURN NULL;
END;
$$;


--
-- Name: a_ins_release_label_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_release_label_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    INSERT INTO artist_release_pending_update VALUES (NEW.release);
    RETURN NULL;
END;
$$;


--
-- Name: a_ins_release_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_release_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    INSERT INTO artist_release_pending_update VALUES (NEW.id);
    INSERT INTO artist_release_group_pending_update VALUES (NEW.release_group);
    RETURN NULL;
END;
$$;


--
-- Name: a_ins_track(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_track"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    PERFORM inc_ref_count('artist_credit', NEW.artist_credit, 1);
    -- increment track_count in the parent medium
    UPDATE medium SET track_count = track_count + 1 WHERE id = NEW.medium;
    PERFORM materialise_recording_length(NEW.recording);
    PERFORM set_recordings_first_release_dates(ARRAY[NEW.recording]);
    INSERT INTO artist_release_pending_update (
        SELECT release FROM medium
        WHERE id = NEW.medium
    );
    INSERT INTO artist_release_group_pending_update (
        SELECT release_group FROM release
        JOIN medium ON medium.release = release.id
        WHERE medium.id = NEW.medium
    );
    RETURN NULL;
END;
$$;


--
-- Name: a_ins_track_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_track_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    PERFORM set_recordings_first_release_dates(ARRAY[NEW.recording]);
    INSERT INTO artist_release_pending_update (
        SELECT release FROM medium
        WHERE id = NEW.medium
    );
    INSERT INTO artist_release_group_pending_update (
        SELECT release_group FROM release
        JOIN medium ON medium.release = release.id
        WHERE medium.id = NEW.medium
    );
    RETURN NULL;
END;
$$;


--
-- Name: a_ins_work(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_ins_work"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    INSERT INTO work_meta (id) VALUES (NEW.id);
    RETURN NULL;
END;
$$;


--
-- Name: a_upd_alternative_medium_track(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_upd_alternative_medium_track"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.alternative_track IS DISTINCT FROM OLD.alternative_track THEN
        PERFORM inc_ref_count('alternative_track', NEW.alternative_track, 1);
        PERFORM dec_ref_count('alternative_track', OLD.alternative_track, 1);
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: a_upd_alternative_release_or_track(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_upd_alternative_release_or_track"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.artist_credit IS DISTINCT FROM OLD.artist_credit THEN
        PERFORM inc_nullable_artist_credit(NEW.artist_credit);
        PERFORM dec_nullable_artist_credit(OLD.artist_credit);
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: a_upd_edit(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_upd_edit"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.status != OLD.status THEN
       UPDATE edit_artist SET status = NEW.status WHERE edit = NEW.id;
       UPDATE edit_label  SET status = NEW.status WHERE edit = NEW.id;
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: a_upd_instrument(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_upd_instrument"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    UPDATE link_attribute_type SET name = NEW.name, description = NEW.description WHERE gid = NEW.gid;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'no link_attribute_type found for instrument %', NEW.gid;
    ELSE
        RETURN NEW;
    END IF;
END;
$$;


--
-- Name: a_upd_l_area_area_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_upd_l_area_area_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    part_of_area_link_type_id CONSTANT SMALLINT := 356;
    old_lt_id INTEGER;
    new_lt_id INTEGER;
BEGIN
    -- DO NOT modify any replicated tables in this function; it's used
    -- by a trigger on mirrors.
    SELECT link_type INTO old_lt_id FROM link WHERE id = OLD.link;
    SELECT link_type INTO new_lt_id FROM link WHERE id = NEW.link;
    IF (
        (
            old_lt_id = part_of_area_link_type_id AND
            new_lt_id = part_of_area_link_type_id AND
            (OLD.entity0 != NEW.entity0 OR OLD.entity1 != NEW.entity1)
        ) OR
        (old_lt_id = part_of_area_link_type_id) != (new_lt_id = part_of_area_link_type_id)
    ) THEN
        PERFORM update_area_containment_mirror(ARRAY[OLD.entity0, NEW.entity0], ARRAY[OLD.entity1, NEW.entity1]);
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: a_upd_medium_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_upd_medium_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- DO NOT modify any replicated tables in this function; it's used
    -- by a trigger on mirrors.
    IF NEW.release IS DISTINCT FROM OLD.release THEN
        PERFORM set_mediums_recordings_first_release_dates(ARRAY[OLD.id]);
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: a_upd_recording(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_upd_recording"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.artist_credit != OLD.artist_credit THEN
        PERFORM dec_ref_count('artist_credit', OLD.artist_credit, 1);
        PERFORM inc_ref_count('artist_credit', NEW.artist_credit, 1);
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: a_upd_release(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_upd_release"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.artist_credit != OLD.artist_credit THEN
        PERFORM dec_ref_count('artist_credit', OLD.artist_credit, 1);
        PERFORM inc_ref_count('artist_credit', NEW.artist_credit, 1);
    END IF;
    IF (
        NEW.status IS DISTINCT FROM OLD.status AND
        (NEW.status = 6 OR OLD.status = 6)
    ) THEN
        PERFORM set_release_first_release_date(NEW.id);

        -- avoid executing it twice as this will be executed a few lines below if RG changes
        IF NEW.release_group = OLD.release_group THEN
            PERFORM set_release_group_first_release_date(NEW.release_group);
        END IF;

        PERFORM set_releases_recordings_first_release_dates(ARRAY[NEW.id]);
    END IF;
    IF NEW.release_group != OLD.release_group THEN
        -- release group is changed, decrement release_count in the original RG, increment in the new one
        UPDATE release_group_meta SET release_count = release_count - 1 WHERE id = OLD.release_group;
        UPDATE release_group_meta SET release_count = release_count + 1 WHERE id = NEW.release_group;
        PERFORM set_release_group_first_release_date(OLD.release_group);
        PERFORM set_release_group_first_release_date(NEW.release_group);
    END IF;
    IF (
        NEW.status IS DISTINCT FROM OLD.status OR
        NEW.release_group != OLD.release_group OR
        NEW.artist_credit != OLD.artist_credit
    ) THEN
        INSERT INTO artist_release_group_pending_update
        VALUES (NEW.release_group), (OLD.release_group);
    END IF;
    IF (
        NEW.barcode IS DISTINCT FROM OLD.barcode OR
        NEW.name != OLD.name OR
        NEW.artist_credit != OLD.artist_credit
    ) THEN
        INSERT INTO artist_release_pending_update VALUES (OLD.id);
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: a_upd_release_event(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_upd_release_event"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  IF (
    NEW.release != OLD.release OR
    NEW.date_year IS DISTINCT FROM OLD.date_year OR
    NEW.date_month IS DISTINCT FROM OLD.date_month OR
    NEW.date_day IS DISTINCT FROM OLD.date_day
  ) THEN
    PERFORM set_release_first_release_date(OLD.release);
    IF NEW.release != OLD.release THEN
        PERFORM set_release_first_release_date(NEW.release);
    END IF;

    PERFORM set_release_group_first_release_date(release_group)
    FROM release
    WHERE release.id IN (NEW.release, OLD.release);

    PERFORM set_releases_recordings_first_release_dates(ARRAY[NEW.release, OLD.release]);
  END IF;

  IF TG_TABLE_NAME = 'release_country' THEN
    IF NEW.country != OLD.country THEN
      INSERT INTO artist_release_pending_update VALUES (OLD.release);
    END IF;
  END IF;

  RETURN NULL;
END;
$$;


--
-- Name: a_upd_release_event_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_upd_release_event_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    PERFORM set_release_first_release_date(OLD.release);
    PERFORM set_release_first_release_date(NEW.release);
    PERFORM set_releases_recordings_first_release_dates(ARRAY[NEW.release, OLD.release]);
    IF TG_TABLE_NAME = 'release_country' THEN
        IF NEW.country != OLD.country THEN
            INSERT INTO artist_release_pending_update VALUES (OLD.release);
        END IF;
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: a_upd_release_group(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_upd_release_group"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.artist_credit != OLD.artist_credit THEN
        PERFORM dec_ref_count('artist_credit', OLD.artist_credit, 1);
        PERFORM inc_ref_count('artist_credit', NEW.artist_credit, 1);
    END IF;
    IF (
        NEW.name != OLD.name OR
        NEW.artist_credit != OLD.artist_credit OR
        NEW.type IS DISTINCT FROM OLD.type
     ) THEN
        INSERT INTO artist_release_group_pending_update VALUES (OLD.id);
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: a_upd_release_group_meta_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_upd_release_group_meta_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF (
        (NEW.first_release_date_year IS DISTINCT FROM OLD.first_release_date_year) OR
        (NEW.first_release_date_month IS DISTINCT FROM OLD.first_release_date_month) OR
        (NEW.first_release_date_day IS DISTINCT FROM OLD.first_release_date_day)
    ) THEN
        INSERT INTO artist_release_group_pending_update VALUES (OLD.id);
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: a_upd_release_group_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_upd_release_group_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF (
        NEW.name != OLD.name OR
        NEW.artist_credit != OLD.artist_credit OR
        NEW.type IS DISTINCT FROM OLD.type
     ) THEN
        INSERT INTO artist_release_group_pending_update VALUES (OLD.id);
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: a_upd_release_group_primary_type_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_upd_release_group_primary_type_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- DO NOT modify any replicated tables in this function; it's used
    -- by a trigger on mirrors.
    IF (NEW.child_order IS DISTINCT FROM OLD.child_order)
    THEN
        INSERT INTO artist_release_group_pending_update (
            SELECT id FROM release_group
            WHERE release_group.type = OLD.id
        );
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: a_upd_release_group_secondary_type_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_upd_release_group_secondary_type_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- DO NOT modify any replicated tables in this function; it's used
    -- by a trigger on mirrors.
    IF (NEW.child_order IS DISTINCT FROM OLD.child_order)
    THEN
        INSERT INTO artist_release_group_pending_update (
            SELECT release_group
            FROM release_group_secondary_type_join
            WHERE secondary_type = OLD.id
        );
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: a_upd_release_label(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_upd_release_label"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.catalog_number IS DISTINCT FROM OLD.catalog_number THEN
        INSERT INTO artist_release_pending_update VALUES (OLD.release);
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: a_upd_release_label_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_upd_release_label_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.catalog_number IS DISTINCT FROM OLD.catalog_number THEN
        INSERT INTO artist_release_pending_update VALUES (OLD.release);
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: a_upd_release_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_upd_release_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF (
        NEW.status IS DISTINCT FROM OLD.status OR
        NEW.release_group != OLD.release_group OR
        NEW.artist_credit != OLD.artist_credit
    ) THEN
        INSERT INTO artist_release_group_pending_update
        VALUES (NEW.release_group), (OLD.release_group);
    END IF;
    IF (
        NEW.barcode IS DISTINCT FROM OLD.barcode OR
        NEW.name != OLD.name OR
        NEW.artist_credit != OLD.artist_credit
    ) THEN
        INSERT INTO artist_release_pending_update VALUES (OLD.id);
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: a_upd_track(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_upd_track"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.artist_credit != OLD.artist_credit THEN
        PERFORM dec_ref_count('artist_credit', OLD.artist_credit, 1);
        PERFORM inc_ref_count('artist_credit', NEW.artist_credit, 1);
        INSERT INTO artist_release_pending_update (
            SELECT release FROM medium
            WHERE id = OLD.medium
        );
        INSERT INTO artist_release_group_pending_update (
            SELECT release_group FROM release
            JOIN medium ON medium.release = release.id
            WHERE medium.id = OLD.medium
        );
    END IF;
    IF NEW.medium != OLD.medium THEN
        IF (
            SELECT count(DISTINCT release)
              FROM medium
             WHERE id IN (NEW.medium, OLD.medium)
        ) = 2
        THEN
            -- I don't believe this code path should ever be hit.
            -- We have no functionality to move tracks between
            -- mediums. If this is ever allowed, however, we should
            -- ensure that both old and new mediums share the same
            -- release, otherwise we'd have to carefully handle this
            -- case when when updating materialized tables for
            -- recordings' first release dates and artists' release
            -- groups. -mwiencek, 2021-03-14
            RAISE EXCEPTION 'Cannot move a track between releases';
        END IF;

        -- medium is changed, decrement track_count in the original medium, increment in the new one
        UPDATE medium SET track_count = track_count - 1 WHERE id = OLD.medium;
        UPDATE medium SET track_count = track_count + 1 WHERE id = NEW.medium;
    END IF;
    IF OLD.recording <> NEW.recording THEN
      PERFORM materialise_recording_length(OLD.recording);
      PERFORM set_recordings_first_release_dates(ARRAY[OLD.recording, NEW.recording]);
    END IF;
    PERFORM materialise_recording_length(NEW.recording);
    RETURN NULL;
END;
$$;


--
-- Name: a_upd_track_mirror(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."a_upd_track_mirror"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.artist_credit != OLD.artist_credit THEN
        INSERT INTO artist_release_pending_update (
            SELECT release FROM medium
            WHERE id = OLD.medium
        );
        INSERT INTO artist_release_group_pending_update (
            SELECT release_group FROM release
            JOIN medium ON medium.release = release.id
            WHERE medium.id = OLD.medium
        );
    END IF;
    IF OLD.recording <> NEW.recording THEN
        PERFORM set_recordings_first_release_dates(ARRAY[OLD.recording, NEW.recording]);
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: apply_artist_release_group_pending_updates(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."apply_artist_release_group_pending_updates"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    release_group_ids INTEGER[];
    release_group_id INTEGER;
BEGIN
    -- DO NOT modify any replicated tables in this function; it's used
    -- by a trigger on mirrors.
    WITH pending AS (
        DELETE FROM artist_release_group_pending_update
        RETURNING release_group
    )
    SELECT array_agg(DISTINCT release_group)
    INTO release_group_ids
    FROM pending;

    IF coalesce(array_length(release_group_ids, 1), 0) > 0 THEN
        -- If the user hasn't generated `artist_release_group`, then we
        -- shouldn't update or insert to it. MBS determines whether to
        -- use this table based on it being non-empty, so a partial
        -- table would manifest as partial data on the website and
        -- webservice.
        PERFORM 1 FROM artist_release_group LIMIT 1;
        IF FOUND THEN
            DELETE FROM artist_release_group WHERE release_group = any(release_group_ids);

            FOREACH release_group_id IN ARRAY release_group_ids LOOP
                -- We handle each release group ID separately because
                -- the `get_artist_release_group_rows` query can be
                -- planned much more efficiently that way.
                INSERT INTO artist_release_group
                SELECT * FROM get_artist_release_group_rows(release_group_id);
            END LOOP;
        END IF;
    END IF;

    RETURN NULL;
END;
$$;


--
-- Name: apply_artist_release_pending_updates(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."apply_artist_release_pending_updates"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    release_ids INTEGER[];
    release_id INTEGER;
BEGIN
    -- DO NOT modify any replicated tables in this function; it's used
    -- by a trigger on mirrors.
    WITH pending AS (
        DELETE FROM artist_release_pending_update
        RETURNING release
    )
    SELECT array_agg(DISTINCT release)
    INTO release_ids
    FROM pending;

    IF coalesce(array_length(release_ids, 1), 0) > 0 THEN
        -- If the user hasn't generated `artist_release`, then we
        -- shouldn't update or insert to it. MBS determines whether to
        -- use this table based on it being non-empty, so a partial
        -- table would manifest as partial data on the website and
        -- webservice.
        PERFORM 1 FROM artist_release LIMIT 1;
        IF FOUND THEN
            DELETE FROM artist_release WHERE release = any(release_ids);

            FOREACH release_id IN ARRAY release_ids LOOP
                -- We handle each release ID separately because the
                -- `get_artist_release_rows` query can be planned much
                -- more efficiently that way.
                INSERT INTO artist_release
                SELECT * FROM get_artist_release_rows(release_id);
            END LOOP;
        END IF;
    END IF;

    RETURN NULL;
END;
$$;


--
-- Name: b_ins_edit_materialize_status(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."b_ins_edit_materialize_status"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    NEW.status = (SELECT status FROM edit WHERE id = NEW.edit);
    RETURN NEW;
END;
$$;


--
-- Name: b_upd_artist_credit_name(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."b_upd_artist_credit_name"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- Artist credits are assumed to be immutable. When changes need to
    -- be made, we `find_or_insert` the new artist credits and swap
    -- them with the old ones rather than mutate existing entries.
    --
    -- This simplifies a lot of assumptions we can make about their
    -- cacheability, and the consistency of materialized tables like
    -- artist_release_group.
    RAISE EXCEPTION 'Cannot update artist_credit_name';
END;
$$;


--
-- Name: b_upd_last_updated_table(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."b_upd_last_updated_table"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    NEW.last_updated = NOW();
    RETURN NEW;
END;
$$;


--
-- Name: b_upd_link(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."b_upd_link"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- Like artist credits, links are shared across many entities
    -- (relationships) and so are immutable: they can only be inserted
    -- or deleted.
    --
    -- This helps ensure the data integrity of relationships and other
    -- materialized tables that rely on their immutability, like
    -- area_containment.
    RAISE EXCEPTION 'link rows are immutable';
END;
$$;


--
-- Name: b_upd_link_attribute(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."b_upd_link_attribute"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- Refer to b_upd_link.
    RAISE EXCEPTION 'link_attribute rows are immutable';
END;
$$;


--
-- Name: b_upd_link_attribute_credit(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."b_upd_link_attribute_credit"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- Refer to b_upd_link.
    RAISE EXCEPTION 'link_attribute_credit rows are immutable';
END;
$$;


--
-- Name: b_upd_link_attribute_text_value(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."b_upd_link_attribute_text_value"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- Refer to b_upd_link.
    RAISE EXCEPTION 'link_attribute_text_value rows are immutable';
END;
$$;


--
-- Name: b_upd_recording(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."b_upd_recording"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  IF OLD.length IS DISTINCT FROM NEW.length
    AND EXISTS (SELECT TRUE FROM track WHERE recording = NEW.id)
    AND NEW.length IS DISTINCT FROM median_track_length(NEW.id)
  THEN
    NEW.length = median_track_length(NEW.id);
  END IF;

  NEW.last_updated = now();
  RETURN NEW;
END;
$$;


--
-- Name: b_upd_release_group_secondary_type_join(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."b_upd_release_group_secondary_type_join"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- Like artist credits, rows in release_group_secondary_type_join
    -- are immutable. When updates need to be made for a particular
    -- release group, they're deleted and re-inserted.
    --
    -- A benefit of this is that we don't need UPDATE triggers to keep
    -- artist_release_group up-to-date.
    RAISE EXCEPTION 'Cannot update release_group_secondary_type_join';
END;
$$;


--
-- Name: check_editor_name(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."check_editor_name"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF (SELECT 1 FROM old_editor_name WHERE lower(name) = lower(NEW.name))
    THEN
        RAISE EXCEPTION 'Attempt to use a previously-used editor name.';
    END IF;
    RETURN NEW;
END;
$$;


--
-- Name: check_has_dates(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."check_has_dates"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF (NEW.begin_date_year IS NOT NULL OR
       NEW.begin_date_month IS NOT NULL OR
       NEW.begin_date_day IS NOT NULL OR
       NEW.end_date_year IS NOT NULL OR
       NEW.end_date_month IS NOT NULL OR
       NEW.end_date_day IS NOT NULL OR
       NEW.ended = TRUE)
       AND NOT (SELECT has_dates FROM link_type WHERE id = NEW.link_type)
  THEN
    RAISE EXCEPTION 'Attempt to add dates to a relationship type that does not support dates.';
  END IF;
  RETURN NEW;
END;
$$;


--
-- Name: controlled_for_whitespace("text"); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."controlled_for_whitespace"("text") RETURNS boolean
    LANGUAGE "sql" IMMUTABLE
    SET "search_path" TO 'musicbrainz', 'public'
    AS $_$
  SELECT NOT padded_by_whitespace($1);
$_$;


--
-- Name: create_bounding_cube(integer[], integer); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."create_bounding_cube"("durations" integer[], "fuzzy" integer) RETURNS "public"."cube"
    LANGUAGE "plpgsql" IMMUTABLE
    AS $$
DECLARE
    point    cube;
    str      VARCHAR;
    i        INTEGER;
    dest     INTEGER;
    count    INTEGER;
    dim      CONSTANT INTEGER = 6;
    selected INTEGER[];
    scalers  INTEGER[];
BEGIN

    count = array_upper(durations, 1);
    IF count < dim THEN
        FOR i IN 1..dim LOOP
            selected[i] = 0;
            scalers[i] = 0;
        END LOOP;
        FOR i IN 1..count LOOP
            selected[i] = durations[i];
            scalers[i] = 1;
        END LOOP;
    ELSE
        FOR i IN 1..dim LOOP
            selected[i] = 0;
            scalers[i] = 0;
        END LOOP;
        FOR i IN 1..count LOOP
            dest = (dim * (i-1) / count) + 1;
            selected[dest] = selected[dest] + durations[i];
            scalers[dest] = scalers[dest] + 1;
        END LOOP;
    END IF;

    str = '(';
    FOR i IN 1..dim LOOP
        IF i > 1 THEN
            str = str || ',';
        END IF;
        str = str || cast((selected[i] - (fuzzy * scalers[i])) as text);
    END LOOP;
    str = str || '),(';
    FOR i IN 1..dim LOOP
        IF i > 1 THEN
            str = str || ',';
        END IF;
        str = str || cast((selected[i] + (fuzzy * scalers[i])) as text);
    END LOOP;
    str = str || ')';

    RETURN str::cube;
END;
$$;


--
-- Name: create_cube_from_durations(integer[]); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."create_cube_from_durations"("durations" integer[]) RETURNS "public"."cube"
    LANGUAGE "plpgsql" IMMUTABLE
    AS $$
DECLARE
    point    cube;
    str      VARCHAR;
    i        INTEGER;
    count    INTEGER;
    dest     INTEGER;
    dim      CONSTANT INTEGER = 6;
    selected INTEGER[];
BEGIN

    count = array_upper(durations, 1);
    FOR i IN 0..dim LOOP
        selected[i] = 0;
    END LOOP;

    IF count < dim THEN
        FOR i IN 1..count LOOP
            selected[i] = durations[i];
        END LOOP;
    ELSE
        FOR i IN 1..count LOOP
            dest = (dim * (i-1) / count) + 1;
            selected[dest] = selected[dest] + durations[i];
        END LOOP;
    END IF;

    str = '(';
    FOR i IN 1..dim LOOP
        IF i > 1 THEN
            str = str || ',';
        END IF;
        str = str || cast(selected[i] as text);
    END LOOP;
    str = str || ')';

    RETURN str::cube;
END;
$$;


--
-- Name: dec_nullable_artist_credit(integer); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."dec_nullable_artist_credit"("row_id" integer) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF row_id IS NOT NULL THEN
        PERFORM dec_ref_count('artist_credit', row_id, 1);
    END IF;
    RETURN;
END;
$$;


--
-- Name: dec_ref_count(character varying, integer, integer); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."dec_ref_count"("tbl" character varying, "row_id" integer, "val" integer) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $_$
DECLARE
    ref_count integer;
BEGIN
    -- decrement ref_count for the old name,
    -- or prepare it for deletion if ref_count would drop to 0
    EXECUTE 'SELECT ref_count FROM ' || tbl || ' WHERE id = ' || row_id || ' FOR UPDATE' INTO ref_count;
    IF ref_count <= val THEN
        EXECUTE 'INSERT INTO unreferenced_row_log (table_name, row_id) VALUES ($1, $2)' USING tbl, row_id;
    END IF;
    EXECUTE 'UPDATE ' || tbl || ' SET ref_count = ref_count - ' || val || ' WHERE id = ' || row_id;
    RETURN;
END;
$_$;


--
-- Name: del_collection_sub_on_delete(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."del_collection_sub_on_delete"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
  BEGIN
    UPDATE editor_subscribe_collection sub
     SET available = FALSE, last_seen_name = OLD.name
     FROM editor_collection coll
     WHERE sub.collection = OLD.id AND sub.collection = coll.id;

    RETURN OLD;
  END;
$$;


--
-- Name: del_collection_sub_on_private(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."del_collection_sub_on_private"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
  BEGIN
    IF NEW.public = FALSE AND OLD.public = TRUE THEN
      UPDATE editor_subscribe_collection sub
         SET available = FALSE,
             last_seen_name = OLD.name
       WHERE sub.collection = OLD.id
         AND sub.editor != NEW.editor
         AND sub.editor NOT IN (SELECT ecc.editor
                                  FROM editor_collection_collaborator ecc
                                 WHERE ecc.collection = sub.collection);
    END IF;

    RETURN NEW;
  END;
$$;


--
-- Name: delete_orphaned_recordings(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."delete_orphaned_recordings"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
  BEGIN
    PERFORM TRUE
    FROM recording outer_r
    WHERE id = OLD.recording
      AND edits_pending = 0
      AND NOT EXISTS (
        SELECT TRUE
        FROM edit JOIN edit_recording er ON edit.id = er.edit
        WHERE er.recording = outer_r.id
          AND type IN (71, 207, 218)
          LIMIT 1
      ) AND NOT EXISTS (
        SELECT TRUE FROM track WHERE track.recording = outer_r.id LIMIT 1
      ) AND NOT EXISTS (
        SELECT TRUE FROM l_area_recording WHERE entity1 = outer_r.id
          UNION ALL
        SELECT TRUE FROM l_artist_recording WHERE entity1 = outer_r.id
          UNION ALL
        SELECT TRUE FROM l_event_recording WHERE entity1 = outer_r.id
          UNION ALL
        SELECT TRUE FROM l_instrument_recording WHERE entity1 = outer_r.id
          UNION ALL
        SELECT TRUE FROM l_label_recording WHERE entity1 = outer_r.id
          UNION ALL
        SELECT TRUE FROM l_place_recording WHERE entity1 = outer_r.id
          UNION ALL
        SELECT TRUE FROM l_recording_recording WHERE entity1 = outer_r.id OR entity0 = outer_r.id
          UNION ALL
        SELECT TRUE FROM l_recording_release WHERE entity0 = outer_r.id
          UNION ALL
        SELECT TRUE FROM l_recording_release_group WHERE entity0 = outer_r.id
          UNION ALL
        SELECT TRUE FROM l_recording_series WHERE entity0 = outer_r.id
          UNION ALL
        SELECT TRUE FROM l_recording_work WHERE entity0 = outer_r.id
          UNION ALL
         SELECT TRUE FROM l_recording_url WHERE entity0 = outer_r.id
      );

    IF FOUND THEN
      -- Remove references from tables that don't change whether or not this recording
      -- is orphaned.
      DELETE FROM isrc WHERE recording = OLD.recording;
      DELETE FROM recording_alias WHERE recording = OLD.recording;
      DELETE FROM recording_annotation WHERE recording = OLD.recording;
      DELETE FROM recording_gid_redirect WHERE new_id = OLD.recording;
      DELETE FROM recording_rating_raw WHERE recording = OLD.recording;
      DELETE FROM recording_tag WHERE recording = OLD.recording;
      DELETE FROM recording_tag_raw WHERE recording = OLD.recording;
      DELETE FROM editor_collection_recording WHERE recording = OLD.recording;

      DELETE FROM recording WHERE id = OLD.recording;
    END IF;

    RETURN NULL;
  END;
$$;


--
-- Name: delete_ratings("text", integer[]); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."delete_ratings"("enttype" "text", "ids" integer[]) RETURNS TABLE("editor" integer, "rating" smallint)
    LANGUAGE "plpgsql"
    AS $_$
DECLARE
    tablename TEXT;
BEGIN
    tablename = enttype || '_rating_raw';
    RETURN QUERY
       EXECUTE 'DELETE FROM ' || tablename || ' WHERE ' || enttype || ' = any($1)
                RETURNING editor, rating'
         USING ids;
    RETURN;
END;
$_$;


--
-- Name: delete_unused_aggregate_tag("musicbrainz"."taggable_entity_type", integer, integer); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."delete_unused_aggregate_tag"("entity_type" "musicbrainz"."taggable_entity_type", "entity_id" integer, "tag_id" integer) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $_$
BEGIN
  -- Delete the aggregate tag row for (entity_id, tag_id) if no raw tag pair
  -- exists for the same.
  --
  -- Note that an aggregate vote count of 0 doesn't imply there are no raw
  -- tags; it's a sum of all the votes, so it can also mean that there's a
  -- downvote for every upvote.
  EXECUTE format(
    $SQL$
      DELETE FROM %1$I
            WHERE %2$I = $1
              AND tag = $2
              AND NOT EXISTS (SELECT 1 FROM %3$I WHERE %2$I = $1 AND tag = $2)
    $SQL$,
    entity_type::TEXT || '_tag',
    entity_type::TEXT,
    entity_type::TEXT || '_tag_raw'
  ) USING entity_id, tag_id;
END;
$_$;


--
-- Name: delete_unused_tag(integer); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."delete_unused_tag"("tag_id" integer) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
  BEGIN
    DELETE FROM tag WHERE id = tag_id;
  EXCEPTION
    WHEN foreign_key_violation THEN RETURN;
  END;
$$;


--
-- Name: delete_unused_url(integer[]); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."delete_unused_url"("ids" integer[]) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  DELETE FROM url_gid_redirect WHERE new_id = any(ids);
  DELETE FROM url WHERE id = any(ids);
EXCEPTION
  WHEN foreign_key_violation THEN RETURN;
END;
$$;


--
-- Name: deny_deprecated_links(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."deny_deprecated_links"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  IF (SELECT is_deprecated FROM link_type WHERE id = NEW.link_type)
  THEN
    RAISE EXCEPTION 'Attempt to create a relationship with a deprecated type';
  END IF;
  RETURN NEW;
END;
$$;


--
-- Name: deny_special_purpose_deletion(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."deny_special_purpose_deletion"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RAISE EXCEPTION 'Attempted to delete a special purpose row';
END;
$$;


--
-- Name: edit_data_type_info("jsonb"); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."edit_data_type_info"("data" "jsonb") RETURNS "text"
    LANGUAGE "plpgsql" IMMUTABLE STRICT PARALLEL SAFE
    AS $$
BEGIN
    CASE jsonb_typeof(data)
    WHEN 'object' THEN
        RETURN '{' ||
            (SELECT string_agg(
                to_json(key) || ':' ||
                edit_data_type_info(jsonb_extract_path(data, key)),
                ',' ORDER BY key)
               FROM jsonb_object_keys(data) AS key) ||
            '}';
    WHEN 'array' THEN
        RETURN '[' ||
            (SELECT string_agg(
                DISTINCT edit_data_type_info(item),
                ',' ORDER BY edit_data_type_info(item))
               FROM jsonb_array_elements(data) AS item) ||
            ']';
    WHEN 'string' THEN
        RETURN '1';
    WHEN 'number' THEN
        RETURN '2';
    WHEN 'boolean' THEN
        RETURN '4';
    WHEN 'null' THEN
        RETURN '8';
    END CASE;
    RETURN '';
END;
$$;


--
-- Name: end_area_implies_ended(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."end_area_implies_ended"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.end_area IS NOT NULL
    THEN
        NEW.ended = TRUE;
    END IF;
    RETURN NEW;
END;
$$;


--
-- Name: end_date_implies_ended(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."end_date_implies_ended"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.end_date_year IS NOT NULL OR
       NEW.end_date_month IS NOT NULL OR
       NEW.end_date_day IS NOT NULL
    THEN
        NEW.ended = TRUE;
    END IF;
    RETURN NEW;
END;
$$;


--
-- Name: ensure_area_attribute_type_allows_text(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."ensure_area_attribute_type_allows_text"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.area_attribute_text IS NOT NULL
        AND NOT EXISTS (
            SELECT TRUE
              FROM area_attribute_type
             WHERE area_attribute_type.id = NEW.area_attribute_type
               AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE
        RETURN NEW;
    END IF;
END;
$$;


--
-- Name: ensure_artist_attribute_type_allows_text(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."ensure_artist_attribute_type_allows_text"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.artist_attribute_text IS NOT NULL
        AND NOT EXISTS (
            SELECT TRUE
              FROM artist_attribute_type
             WHERE artist_attribute_type.id = NEW.artist_attribute_type
               AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE
        RETURN NEW;
    END IF;
END;
$$;


--
-- Name: ensure_event_attribute_type_allows_text(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."ensure_event_attribute_type_allows_text"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.event_attribute_text IS NOT NULL
        AND NOT EXISTS (
            SELECT TRUE
              FROM event_attribute_type
             WHERE event_attribute_type.id = NEW.event_attribute_type
               AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE
        RETURN NEW;
    END IF;
END;
$$;


--
-- Name: ensure_instrument_attribute_type_allows_text(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."ensure_instrument_attribute_type_allows_text"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.instrument_attribute_text IS NOT NULL
        AND NOT EXISTS (
            SELECT TRUE
              FROM instrument_attribute_type
             WHERE instrument_attribute_type.id = NEW.instrument_attribute_type
               AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE
        RETURN NEW;
    END IF;
END;
$$;


--
-- Name: ensure_label_attribute_type_allows_text(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."ensure_label_attribute_type_allows_text"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.label_attribute_text IS NOT NULL
        AND NOT EXISTS (
            SELECT TRUE
              FROM label_attribute_type
             WHERE label_attribute_type.id = NEW.label_attribute_type
               AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE
        RETURN NEW;
    END IF;
END;
$$;


--
-- Name: ensure_medium_attribute_type_allows_text(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."ensure_medium_attribute_type_allows_text"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.medium_attribute_text IS NOT NULL
        AND NOT EXISTS (
            SELECT TRUE
              FROM medium_attribute_type
             WHERE medium_attribute_type.id = NEW.medium_attribute_type
               AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE
        RETURN NEW;
    END IF;
END;
$$;


--
-- Name: ensure_place_attribute_type_allows_text(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."ensure_place_attribute_type_allows_text"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.place_attribute_text IS NOT NULL
        AND NOT EXISTS (
            SELECT TRUE
              FROM place_attribute_type
             WHERE place_attribute_type.id = NEW.place_attribute_type
               AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE
        RETURN NEW;
    END IF;
END;
$$;


--
-- Name: ensure_recording_attribute_type_allows_text(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."ensure_recording_attribute_type_allows_text"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.recording_attribute_text IS NOT NULL
        AND NOT EXISTS (
            SELECT TRUE
              FROM recording_attribute_type
             WHERE recording_attribute_type.id = NEW.recording_attribute_type
               AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE
        RETURN NEW;
    END IF;
END;
$$;


--
-- Name: ensure_release_attribute_type_allows_text(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."ensure_release_attribute_type_allows_text"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.release_attribute_text IS NOT NULL
        AND NOT EXISTS (
            SELECT TRUE
              FROM release_attribute_type
             WHERE release_attribute_type.id = NEW.release_attribute_type
               AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE
        RETURN NEW;
    END IF;
END;
$$;


--
-- Name: ensure_release_group_attribute_type_allows_text(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."ensure_release_group_attribute_type_allows_text"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
  BEGIN
    IF NEW.release_group_attribute_text IS NOT NULL
        AND NOT EXISTS (
           SELECT TRUE FROM release_group_attribute_type
        WHERE release_group_attribute_type.id = NEW.release_group_attribute_type
        AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE RETURN NEW;
    END IF;
  END;
$$;


--
-- Name: ensure_series_attribute_type_allows_text(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."ensure_series_attribute_type_allows_text"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.series_attribute_text IS NOT NULL
        AND NOT EXISTS (
            SELECT TRUE
              FROM series_attribute_type
             WHERE series_attribute_type.id = NEW.series_attribute_type
               AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE
        RETURN NEW;
    END IF;
END;
$$;


--
-- Name: ensure_work_attribute_type_allows_text(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."ensure_work_attribute_type_allows_text"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.work_attribute_text IS NOT NULL
        AND NOT EXISTS (
            SELECT TRUE FROM work_attribute_type
             WHERE work_attribute_type.id = NEW.work_attribute_type
               AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE
        RETURN NEW;
    END IF;
END;
$$;


--
-- Name: from_hex("text"); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."from_hex"("t" "text") RETURNS integer
    LANGUAGE "plpgsql" IMMUTABLE STRICT
    AS $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN EXECUTE 'SELECT x'''||t||'''::integer AS hex' LOOP
        RETURN r.hex;
    END LOOP;
END
$$;


--
-- Name: generate_uuid_v3(character varying, character varying); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."generate_uuid_v3"("namespace" character varying, "name" character varying) RETURNS "uuid"
    LANGUAGE "plpgsql" IMMUTABLE STRICT
    AS $$
DECLARE
    value varchar(36);
    bytes varchar;
BEGIN
    bytes = md5(decode(namespace, 'hex') || decode(name, 'escape'));
    value = substr(bytes, 1+0, 8);
    value = value || '-';
    value = value || substr(bytes, 1+2*4, 4);
    value = value || '-';
    value = value || lpad(to_hex((from_hex(substr(bytes, 1+2*6, 2)) & 15) | 48), 2, '0');
    value = value || substr(bytes, 1+2*7, 2);
    value = value || '-';
    value = value || lpad(to_hex((from_hex(substr(bytes, 1+2*8, 2)) & 63) | 128), 2, '0');
    value = value || substr(bytes, 1+2*9, 2);
    value = value || '-';
    value = value || substr(bytes, 1+2*10, 12);
    return value::uuid;
END;
$$;


--
-- Name: generate_uuid_v4(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."generate_uuid_v4"() RETURNS "uuid"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    value VARCHAR(36);
BEGIN
    value =          lpad(to_hex(ceil(random() * 255)::int), 2, '0');
    value = value || lpad(to_hex(ceil(random() * 255)::int), 2, '0');
    value = value || lpad(to_hex(ceil(random() * 255)::int), 2, '0');
    value = value || lpad(to_hex(ceil(random() * 255)::int), 2, '0');
    value = value || '-';
    value = value || lpad(to_hex(ceil(random() * 255)::int), 2, '0');
    value = value || lpad(to_hex(ceil(random() * 255)::int), 2, '0');
    value = value || '-';
    value = value || lpad((to_hex((ceil(random() * 255)::int & 15) | 64)), 2, '0');
    value = value || lpad(to_hex(ceil(random() * 255)::int), 2, '0');
    value = value || '-';
    value = value || lpad((to_hex((ceil(random() * 255)::int & 63) | 128)), 2, '0');
    value = value || lpad(to_hex(ceil(random() * 255)::int), 2, '0');
    value = value || '-';
    value = value || lpad(to_hex(ceil(random() * 255)::int), 2, '0');
    value = value || lpad(to_hex(ceil(random() * 255)::int), 2, '0');
    value = value || lpad(to_hex(ceil(random() * 255)::int), 2, '0');
    value = value || lpad(to_hex(ceil(random() * 255)::int), 2, '0');
    value = value || lpad(to_hex(ceil(random() * 255)::int), 2, '0');
    value = value || lpad(to_hex(ceil(random() * 255)::int), 2, '0');
    RETURN value::uuid;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = "heap";

--
-- Name: area_containment; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."area_containment" (
    "descendant" integer NOT NULL,
    "parent" integer NOT NULL,
    "depth" smallint NOT NULL
);


--
-- Name: get_area_descendant_hierarchy_rows(integer[]); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."get_area_descendant_hierarchy_rows"("parent_area_ids" integer[]) RETURNS SETOF "musicbrainz"."area_containment"
    LANGUAGE "plpgsql"
    AS $_$
DECLARE
    part_of_area_link_type_id CONSTANT SMALLINT := 356;
BEGIN
    RETURN QUERY EXECUTE $SQL$
        WITH RECURSIVE area_descendant_hierarchy(descendant, parent, path, cycle) AS (
            SELECT entity1, entity0, ARRAY[ROW(entity1, entity0)], FALSE
              FROM l_area_area laa
              JOIN link ON laa.link = link.id
             WHERE link.link_type = $1
    $SQL$ || (CASE WHEN parent_area_ids IS NULL THEN '' ELSE 'AND entity0 = any($2)' END) ||
    $SQL$
             UNION ALL
            SELECT entity1, parent, path || ROW(entity1, parent), ROW(entity1, parent) = any(path)
              FROM l_area_area laa
              JOIN link ON laa.link = link.id
              JOIN area_descendant_hierarchy ON area_descendant_hierarchy.descendant = laa.entity0
             WHERE link.link_type = $1
               AND parent != entity1
               AND NOT cycle
        )
        SELECT descendant, parent, array_length(path, 1)::SMALLINT
          FROM area_descendant_hierarchy
    $SQL$
    USING part_of_area_link_type_id, parent_area_ids;
END;
$_$;


--
-- Name: get_area_parent_hierarchy_rows(integer[]); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."get_area_parent_hierarchy_rows"("descendant_area_ids" integer[]) RETURNS SETOF "musicbrainz"."area_containment"
    LANGUAGE "plpgsql"
    AS $_$
DECLARE
    part_of_area_link_type_id CONSTANT SMALLINT := 356;
BEGIN
    RETURN QUERY EXECUTE $SQL$
        WITH RECURSIVE area_parent_hierarchy(descendant, parent, path, cycle) AS (
            SELECT entity1, entity0, ARRAY[ROW(entity1, entity0)], FALSE
              FROM l_area_area laa
              JOIN link ON laa.link = link.id
             WHERE link.link_type = $1
    $SQL$ || (CASE WHEN descendant_area_ids IS NULL THEN '' ELSE 'AND entity1 = any($2)' END) ||
    $SQL$
             UNION ALL
            SELECT descendant, entity0, path || ROW(descendant, entity0), ROW(descendant, entity0) = any(path)
              FROM l_area_area laa
              JOIN link ON laa.link = link.id
              JOIN area_parent_hierarchy ON area_parent_hierarchy.parent = laa.entity1
             WHERE link.link_type = $1
               AND descendant != entity0
               AND NOT cycle
        )
        SELECT descendant, parent, array_length(path, 1)::SMALLINT
          FROM area_parent_hierarchy
    $SQL$
    USING part_of_area_link_type_id, descendant_area_ids;
END;
$_$;


--
-- Name: artist_release_group; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_release_group" (
    "is_track_artist" boolean NOT NULL,
    "artist" integer NOT NULL,
    "unofficial" boolean NOT NULL,
    "primary_type_child_order" smallint,
    "primary_type" smallint,
    "secondary_type_child_orders" smallint[],
    "secondary_types" smallint[],
    "first_release_date" integer,
    "name" character varying NOT NULL COLLATE "musicbrainz"."musicbrainz",
    "release_group" integer NOT NULL
)
PARTITION BY LIST ("is_track_artist");


--
-- Name: get_artist_release_group_rows(integer); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."get_artist_release_group_rows"("release_group_id" integer) RETURNS SETOF "musicbrainz"."artist_release_group"
    LANGUAGE "plpgsql"
    AS $_$
BEGIN
    -- PostgreSQL 12 generates a vastly more efficient plan when only
    -- one release group ID is passed. A condition like
    -- `rg.id = any(...)` can be over 200x slower, even with only one
    -- release group ID in the array.
    RETURN QUERY EXECUTE $SQL$
        SELECT DISTINCT ON (a_rg.artist, rg.id)
            a_rg.is_track_artist,
            a_rg.artist,
            -- Withdrawn releases were once official by definition
            bool_and(r.status IS NOT NULL AND r.status != 1 AND r.status != 5),
            rgpt.child_order::SMALLINT,
            rg.type::SMALLINT,
            array_agg(
                DISTINCT rgst.child_order ORDER BY rgst.child_order)
                FILTER (WHERE rgst.child_order IS NOT NULL
            )::SMALLINT[],
            array_agg(
                DISTINCT st.secondary_type ORDER BY st.secondary_type)
                FILTER (WHERE st.secondary_type IS NOT NULL
            )::SMALLINT[],
            integer_date(
                rgm.first_release_date_year,
                rgm.first_release_date_month,
                rgm.first_release_date_day
            ),
            rg.name,
            rg.id
        FROM (
            SELECT FALSE AS is_track_artist, rgacn.artist, rg.id AS release_group
            FROM release_group rg
            JOIN artist_credit_name rgacn ON rgacn.artist_credit = rg.artist_credit
            UNION ALL
            SELECT TRUE AS is_track_artist, tacn.artist, r.release_group
            FROM release r
            JOIN medium m ON m.release = r.id
            JOIN track t ON t.medium = m.id
            JOIN artist_credit_name tacn ON tacn.artist_credit = t.artist_credit
        ) a_rg
        JOIN release_group rg ON rg.id = a_rg.release_group
        LEFT JOIN release r ON r.release_group = rg.id
        JOIN release_group_meta rgm ON rgm.id = rg.id
        LEFT JOIN release_group_primary_type rgpt ON rgpt.id = rg.type
        LEFT JOIN release_group_secondary_type_join st ON st.release_group = rg.id
        LEFT JOIN release_group_secondary_type rgst ON rgst.id = st.secondary_type
    $SQL$ || (CASE WHEN release_group_id IS NULL THEN '' ELSE 'WHERE rg.id = $1' END) ||
    $SQL$
        GROUP BY a_rg.is_track_artist, a_rg.artist, rgm.id, rg.id, rgpt.child_order
        ORDER BY a_rg.artist, rg.id, a_rg.is_track_artist
    $SQL$
    USING release_group_id;
END;
$_$;


--
-- Name: artist_release; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_release" (
    "is_track_artist" boolean NOT NULL,
    "artist" integer NOT NULL,
    "first_release_date" integer,
    "catalog_numbers" "text"[],
    "country_code" character(2),
    "barcode" bigint,
    "name" character varying NOT NULL COLLATE "musicbrainz"."musicbrainz",
    "release" integer NOT NULL
)
PARTITION BY LIST ("is_track_artist");


--
-- Name: get_artist_release_rows(integer); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."get_artist_release_rows"("release_id" integer) RETURNS SETOF "musicbrainz"."artist_release"
    LANGUAGE "plpgsql"
    AS $_$
BEGIN
    -- PostgreSQL 12 generates a vastly more efficient plan when only
    -- one release ID is passed. A condition like `r.id = any(...)`
    -- can be over 200x slower, even with only one release ID in the
    -- array.
    RETURN QUERY EXECUTE $SQL$
        SELECT DISTINCT ON (ar.artist, r.id)
            ar.is_track_artist,
            ar.artist,
            integer_date(rfrd.year, rfrd.month, rfrd.day) AS first_release_date,
            array_agg(
                DISTINCT rl.catalog_number ORDER BY rl.catalog_number
            ) FILTER (WHERE rl.catalog_number IS NOT NULL)::TEXT[] AS catalog_numbers,
            min(iso.code ORDER BY iso.code)::CHAR(2) AS country_code,
            left(regexp_replace(
                (CASE r.barcode WHEN '' THEN '0' ELSE r.barcode END),
                '[^0-9]+', '', 'g'
            ), 18)::BIGINT AS barcode,
            r.name,
            r.id
        FROM (
            SELECT FALSE AS is_track_artist, racn.artist, r.id AS release
            FROM release r
            JOIN artist_credit_name racn ON racn.artist_credit = r.artist_credit
            UNION ALL
            SELECT TRUE AS is_track_artist, tacn.artist, m.release
            FROM medium m
            JOIN track t ON t.medium = m.id
            JOIN artist_credit_name tacn ON tacn.artist_credit = t.artist_credit
        ) ar
        JOIN release r ON r.id = ar.release
        LEFT JOIN release_first_release_date rfrd ON rfrd.release = r.id
        LEFT JOIN release_label rl ON rl.release = r.id
        LEFT JOIN release_country rc ON rc.release = r.id
        LEFT JOIN iso_3166_1 iso ON iso.area = rc.country
    $SQL$ || (CASE WHEN release_id IS NULL THEN '' ELSE 'WHERE r.id = $1' END) ||
    $SQL$
        GROUP BY ar.is_track_artist, ar.artist, rfrd.release, r.id
        ORDER BY ar.artist, r.id, ar.is_track_artist
    $SQL$
    USING release_id;
END;
$_$;


--
-- Name: recording_first_release_date; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."recording_first_release_date" (
    "recording" integer NOT NULL,
    "year" smallint,
    "month" smallint,
    "day" smallint
);


--
-- Name: get_recording_first_release_date_rows("text"); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."get_recording_first_release_date_rows"("condition" "text") RETURNS SETOF "musicbrainz"."recording_first_release_date"
    LANGUAGE "plpgsql" STRICT
    AS $$
BEGIN
    RETURN QUERY EXECUTE '
        SELECT DISTINCT ON (track.recording)
            track.recording, rd.year, rd.month, rd.day
        FROM track
        JOIN medium ON medium.id = track.medium
        JOIN release_first_release_date rd ON rd.release = medium.release
        WHERE ' || condition || '
        ORDER BY track.recording,
            rd.year NULLS LAST,
            rd.month NULLS LAST,
            rd.day NULLS LAST';
END;
$$;


--
-- Name: release_first_release_date; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_first_release_date" (
    "release" integer NOT NULL,
    "year" smallint,
    "month" smallint,
    "day" smallint
);


--
-- Name: get_release_first_release_date_rows("text"); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."get_release_first_release_date_rows"("condition" "text") RETURNS SETOF "musicbrainz"."release_first_release_date"
    LANGUAGE "plpgsql" STRICT
    AS $$
BEGIN
    RETURN QUERY EXECUTE '
        SELECT DISTINCT ON (release) release,
            date_year AS year,
            date_month AS month,
            date_day AS day
        FROM (
            SELECT release, date_year, date_month, date_day FROM release_country
            WHERE (date_year IS NOT NULL OR date_month IS NOT NULL OR date_day IS NOT NULL)
            UNION ALL
            SELECT release, date_year, date_month, date_day FROM release_unknown_country
        ) all_dates
        WHERE ' || condition ||
        ' AND NOT EXISTS (
          SELECT TRUE
            FROM release
           WHERE release.id = all_dates.release
             AND status = 6
        )
        ORDER BY release, year NULLS LAST, month NULLS LAST, day NULLS LAST';
END;
$$;


--
-- Name: inc_nullable_artist_credit(integer); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."inc_nullable_artist_credit"("row_id" integer) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF row_id IS NOT NULL THEN
        PERFORM inc_ref_count('artist_credit', row_id, 1);
    END IF;
    RETURN;
END;
$$;


--
-- Name: inc_ref_count(character varying, integer, integer); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."inc_ref_count"("tbl" character varying, "row_id" integer, "val" integer) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- increment ref_count for the new name
    EXECUTE 'SELECT ref_count FROM ' || tbl || ' WHERE id = ' || row_id || ' FOR UPDATE';
    EXECUTE 'UPDATE ' || tbl || ' SET ref_count = ref_count + ' || val || ' WHERE id = ' || row_id;
    RETURN;
END;
$$;


--
-- Name: inserting_edits_requires_confirmed_email_address(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."inserting_edits_requires_confirmed_email_address"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  IF NOT (
    SELECT email_confirm_date IS NOT NULL AND email_confirm_date <= now()
    FROM editor
    WHERE editor.id = NEW.editor
  ) THEN
    RAISE EXCEPTION 'Editor tried to create edit without a confirmed email address';
  ELSE
    RETURN NEW;
  END IF;
END;
$$;


--
-- Name: integer_date(smallint, smallint, smallint); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."integer_date"("year" smallint, "month" smallint, "day" smallint) RETURNS integer
    LANGUAGE "sql" IMMUTABLE PARALLEL SAFE
    AS $$
    -- Returns an integer representation of the given date, keeping
    -- NULL values sorted last.
    SELECT (
        CASE
            WHEN year IS NULL AND month IS NULL AND day IS NULL
            THEN NULL
            ELSE (
                coalesce(year::TEXT, '9999') ||
                lpad(coalesce(month::TEXT, '99'), 2, '0') ||
                lpad(coalesce(day::TEXT, '99'), 2, '0')
            )::INTEGER
        END
    )
$$;


--
-- Name: ll_to_earth(double precision, double precision); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."ll_to_earth"(double precision, double precision) RETURNS "public"."earth"
    LANGUAGE "sql" IMMUTABLE STRICT PARALLEL SAFE
    AS $_$SELECT public.cube(public.cube(public.cube(public.earth()*cos(radians($1))*cos(radians($2))),public.earth()*cos(radians($1))*sin(radians($2))),public.earth()*sin(radians($1)))::public.earth$_$;


--
-- Name: materialise_recording_length(integer); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."materialise_recording_length"("recording_id" integer) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  UPDATE recording SET length = median
   FROM (SELECT median_track_length(recording_id) median) track
  WHERE recording.id = recording_id
    AND recording.length IS DISTINCT FROM track.median;
END;
$$;


--
-- Name: mb_lower("text"); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."mb_lower"("input" "text") RETURNS "text"
    LANGUAGE "sql" IMMUTABLE STRICT PARALLEL SAFE
    AS $$
  SELECT lower(input COLLATE musicbrainz.musicbrainz);
$$;


--
-- Name: mb_simple_tsvector("text"); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."mb_simple_tsvector"("input" "text") RETURNS "tsvector"
    LANGUAGE "sql" IMMUTABLE STRICT PARALLEL SAFE
    AS $$
  -- The builtin 'simple' dictionary, which the mb_simple text search
  -- configuration makes use of, would normally lowercase the input string
  -- for us, but internally it hardcodes DEFAULT_COLLATION_OID; therefore
  -- we first lowercase the input string ourselves using mb_lower.
  SELECT to_tsvector('musicbrainz.mb_simple', musicbrainz.mb_lower(input));
$$;


--
-- Name: median_track_length(integer); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."median_track_length"("recording_id" integer) RETURNS integer
    LANGUAGE "sql"
    AS $_$
  SELECT median(track.length) FROM track WHERE recording = $1;
$_$;


--
-- Name: musicbrainz_unaccent("text"); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."musicbrainz_unaccent"("text") RETURNS "text"
    LANGUAGE "sql" IMMUTABLE STRICT PARALLEL SAFE
    AS $_$
    SELECT public.immutable_unaccent(regdictionary 'public.unaccent', $1)
  $_$;


--
-- Name: padded_by_whitespace("text"); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."padded_by_whitespace"("text") RETURNS boolean
    LANGUAGE "sql" IMMUTABLE
    AS $_$
  SELECT btrim($1) <> $1;
$_$;


--
-- Name: prevent_invalid_attributes(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."prevent_invalid_attributes"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NOT EXISTS (
        SELECT TRUE
        FROM (VALUES (NEW.link, NEW.attribute_type)) la (link, attribute_type)
        JOIN link l ON l.id = la.link
        JOIN link_type lt ON l.link_type = lt.id
        JOIN link_attribute_type lat ON lat.id = la.attribute_type
        JOIN link_type_attribute_type ltat ON ltat.attribute_type = lat.root AND ltat.link_type = lt.id
    ) THEN
        RAISE EXCEPTION 'Attribute type % is invalid for link %', NEW.attribute_type, NEW.link;
    END IF;
    RETURN NEW;
END;
$$;


--
-- Name: remove_unused_links(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."remove_unused_links"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $_$
DECLARE
    other_ars_exist BOOLEAN;
BEGIN
    EXECUTE 'SELECT EXISTS (SELECT TRUE FROM ' || quote_ident(TG_TABLE_NAME) ||
            ' WHERE link = $1)'
    INTO other_ars_exist
    USING OLD.link;

    IF NOT other_ars_exist THEN
       DELETE FROM link_attribute WHERE link = OLD.link;
       DELETE FROM link_attribute_credit WHERE link = OLD.link;
       DELETE FROM link_attribute_text_value WHERE link = OLD.link;
       DELETE FROM link WHERE id = OLD.link;
    END IF;

    RETURN NULL;
END;
$_$;


--
-- Name: remove_unused_url(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."remove_unused_url"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF TG_TABLE_NAME LIKE 'l_url_%' THEN
      EXECUTE delete_unused_url(ARRAY[OLD.entity0]);
    END IF;

    IF TG_TABLE_NAME LIKE 'l_%_url' THEN
      EXECUTE delete_unused_url(ARRAY[OLD.entity1]);
    END IF;

    IF TG_TABLE_NAME LIKE 'url' THEN
      EXECUTE delete_unused_url(ARRAY[OLD.id, NEW.id]);
    END IF;

    RETURN NULL;
END;
$$;


--
-- Name: replace_old_sub_on_add(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."replace_old_sub_on_add"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
  BEGIN
    UPDATE editor_subscribe_collection
     SET available = TRUE, last_seen_name = NULL,
      last_edit_sent = NEW.last_edit_sent
     WHERE editor = NEW.editor AND collection = NEW.collection;

    IF FOUND THEN
      RETURN NULL;
    ELSE
      RETURN NEW;
    END IF;
  END;
$$;


--
-- Name: restore_collection_sub_on_public(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."restore_collection_sub_on_public"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
  BEGIN
    IF NEW.public = TRUE AND OLD.public = FALSE THEN
      UPDATE editor_subscribe_collection sub
         SET available = TRUE,
             last_seen_name = NEW.name
       WHERE sub.collection = OLD.id
         AND sub.available = FALSE;
    END IF;

    RETURN NULL;
  END;
$$;


--
-- Name: set_mediums_recordings_first_release_dates(integer[]); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."set_mediums_recordings_first_release_dates"("medium_ids" integer[]) RETURNS "void"
    LANGUAGE "plpgsql" STRICT
    AS $$
BEGIN
  PERFORM set_recordings_first_release_dates((
    SELECT array_agg(recording)
      FROM track
     WHERE track.medium = any(medium_ids)
  ));
  RETURN;
END;
$$;


--
-- Name: set_recordings_first_release_dates(integer[]); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."set_recordings_first_release_dates"("recording_ids" integer[]) RETURNS "void"
    LANGUAGE "plpgsql" STRICT
    AS $$
BEGIN
  -- DO NOT modify any replicated tables in this function; it's used
  -- by a trigger on mirrors.
  DELETE FROM recording_first_release_date
  WHERE recording = ANY(recording_ids);

  INSERT INTO recording_first_release_date
  SELECT * FROM get_recording_first_release_date_rows(
    format('track.recording = any(%L)', recording_ids)
  );
END;
$$;


--
-- Name: set_release_first_release_date(integer); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."set_release_first_release_date"("release_id" integer) RETURNS "void"
    LANGUAGE "plpgsql" STRICT
    AS $$
BEGIN
  -- DO NOT modify any replicated tables in this function; it's used
  -- by a trigger on mirrors.
  DELETE FROM release_first_release_date
  WHERE release = release_id;

  INSERT INTO release_first_release_date
  SELECT * FROM get_release_first_release_date_rows(
    format('release = %L', release_id)
  );

  INSERT INTO artist_release_pending_update VALUES (release_id);
END;
$$;


--
-- Name: set_release_group_first_release_date(integer); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."set_release_group_first_release_date"("release_group_id" integer) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    UPDATE release_group_meta SET first_release_date_year = first.year,
                                  first_release_date_month = first.month,
                                  first_release_date_day = first.day
      FROM (
        SELECT rd.year, rd.month, rd.day
        FROM release_group
        LEFT JOIN release ON release.release_group = release_group.id
        LEFT JOIN release_first_release_date rd ON (rd.release = release.id)
        WHERE release_group.id = release_group_id
        ORDER BY
          rd.year NULLS LAST,
          rd.month NULLS LAST,
          rd.day NULLS LAST
        LIMIT 1
      ) AS first
    WHERE id = release_group_id;
    INSERT INTO artist_release_group_pending_update VALUES (release_group_id);
END;
$$;


--
-- Name: set_releases_recordings_first_release_dates(integer[]); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."set_releases_recordings_first_release_dates"("release_ids" integer[]) RETURNS "void"
    LANGUAGE "plpgsql" STRICT
    AS $$
BEGIN
  PERFORM set_recordings_first_release_dates((
    SELECT array_agg(recording)
      FROM track
      JOIN medium ON medium.id = track.medium
     WHERE medium.release = any(release_ids)
  ));
  RETURN;
END;
$$;


--
-- Name: simplify_search_hints(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."simplify_search_hints"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.type::int = TG_ARGV[0]::int THEN
        NEW.sort_name := NEW.name;
        NEW.begin_date_year := NULL;
        NEW.begin_date_month := NULL;
        NEW.begin_date_day := NULL;
        NEW.end_date_year := NULL;
        NEW.end_date_month := NULL;
        NEW.end_date_day := NULL;
        NEW.end_date_day := NULL;
        NEW.ended := FALSE;
        NEW.locale := NULL;
    END IF;
    RETURN NEW;
END;
$$;


--
-- Name: medium; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."medium" (
    "id" integer NOT NULL,
    "release" integer NOT NULL,
    "position" integer NOT NULL,
    "format" integer,
    "name" character varying DEFAULT ''::character varying NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "track_count" integer DEFAULT 0 NOT NULL,
    "gid" "uuid" NOT NULL,
    CONSTRAINT "medium_edits_pending_check" CHECK (("edits_pending" >= 0))
);


--
-- Name: track_count_matches_cdtoc("musicbrainz"."medium", integer); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."track_count_matches_cdtoc"("musicbrainz"."medium", integer) RETURNS boolean
    LANGUAGE "sql" IMMUTABLE
    AS $_$
    SELECT $1.track_count = $2 + COALESCE(
        (SELECT count(*) FROM track
         WHERE medium = $1.id AND (position = 0 OR is_data_track = true)
    ), 0);
$_$;


--
-- Name: trg_delete_unused_tag(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."trg_delete_unused_tag"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
  BEGIN
    PERFORM delete_unused_tag(NEW.id);
    RETURN NULL;
  END;
$$;


--
-- Name: trg_delete_unused_tag_ref(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."trg_delete_unused_tag_ref"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
  BEGIN
    PERFORM delete_unused_tag(OLD.tag);
    RETURN NULL;
  END;
$$;


--
-- Name: update_aggregate_rating("musicbrainz"."ratable_entity_type", integer); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."update_aggregate_rating"("entity_type" "musicbrainz"."ratable_entity_type", "entity_id" integer) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $_$
BEGIN
  -- update the aggregate rating for the given entity_id.
  EXECUTE format(
    $SQL$
      UPDATE %2$I
         SET rating = agg.rating,
             rating_count = nullif(agg.rating_count, 0)
        FROM (
          SELECT count(rating)::INTEGER AS rating_count,
                 -- trunc(x + 0.5) is used because round() on REAL values
                 -- rounds to the nearest even number.
                 trunc((sum(rating)::REAL /
                        count(rating)::REAL) +
                       0.5::REAL)::SMALLINT AS rating
            FROM %3$I
           WHERE %1$I = $1
        ) agg
       WHERE id = $1
    $SQL$,
    entity_type::TEXT,
    entity_type::TEXT || '_meta',
    entity_type::TEXT || '_rating_raw'
  ) USING entity_id;
END;
$_$;


--
-- Name: update_aggregate_rating_for_raw_delete(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."update_aggregate_rating_for_raw_delete"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $_$
DECLARE
  entity_type ratable_entity_type;
  old_entity_id INTEGER;
BEGIN
  entity_type := TG_ARGV[0]::ratable_entity_type;
  EXECUTE format('SELECT ($1).%s', entity_type::TEXT) INTO old_entity_id USING OLD;
  PERFORM update_aggregate_rating(entity_type, old_entity_id);
  RETURN NULL;
END;
$_$;


--
-- Name: update_aggregate_rating_for_raw_insert(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."update_aggregate_rating_for_raw_insert"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $_$
DECLARE
  entity_type ratable_entity_type;
  new_entity_id INTEGER;
BEGIN
  entity_type := TG_ARGV[0]::ratable_entity_type;
  EXECUTE format('SELECT ($1).%s', entity_type::TEXT) INTO new_entity_id USING NEW;
  PERFORM update_aggregate_rating(entity_type, new_entity_id);
  RETURN NULL;
END;
$_$;


--
-- Name: update_aggregate_rating_for_raw_update(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."update_aggregate_rating_for_raw_update"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $_$
DECLARE
  entity_type ratable_entity_type;
  new_entity_id INTEGER;
  old_entity_id INTEGER;
BEGIN
  entity_type := TG_ARGV[0]::ratable_entity_type;
  EXECUTE format('SELECT ($1).%s', entity_type) INTO new_entity_id USING NEW;
  EXECUTE format('SELECT ($1).%s', entity_type) INTO old_entity_id USING OLD;
  IF (old_entity_id = new_entity_id AND OLD.rating != NEW.rating) THEN
    -- Case 1: only the rating changed.
    PERFORM update_aggregate_rating(entity_type, old_entity_id);
  ELSIF (old_entity_id != new_entity_id OR OLD.rating != NEW.rating) THEN
    -- Case 2: the entity or rating changed.
    PERFORM update_aggregate_rating(entity_type, old_entity_id);
    PERFORM update_aggregate_rating(entity_type, new_entity_id);
  END IF;
  RETURN NULL;
END;
$_$;


--
-- Name: update_aggregate_tag_count("musicbrainz"."taggable_entity_type", integer, integer, smallint); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."update_aggregate_tag_count"("entity_type" "musicbrainz"."taggable_entity_type", "entity_id" integer, "tag_id" integer, "count_change" smallint) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $_$
BEGIN
  -- Insert-or-update the aggregate vote count for the given (entity_id, tag_id).
  EXECUTE format(
    $SQL$
      INSERT INTO %1$I AS agg (%2$I, tag, count)
           VALUES ($1, $2, $3)
      ON CONFLICT (%2$I, tag) DO UPDATE SET count = agg.count + $3
    $SQL$,
    entity_type::TEXT || '_tag',
    entity_type::TEXT
  ) USING entity_id, tag_id, count_change;
END;
$_$;


--
-- Name: update_area_containment_mirror(integer[], integer[]); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."update_area_containment_mirror"("parent_ids" integer[], "descendant_ids" integer[]) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    part_of_area_link_type_id CONSTANT SMALLINT := 356;
    descendant_ids_to_update INTEGER[];
    parent_ids_to_update INTEGER[];
BEGIN
    -- DO NOT modify any replicated tables in this function; it's used
    -- by a trigger on mirrors.

    SELECT array_agg(descendant)
      INTO descendant_ids_to_update
      FROM area_containment
     WHERE parent = any(parent_ids);

    SELECT array_agg(parent)
      INTO parent_ids_to_update
      FROM area_containment
     WHERE descendant = any(descendant_ids);

    -- For INSERTS/UPDATES, include the new IDs that aren't present in
    -- area_containment yet.
    descendant_ids_to_update := descendant_ids_to_update || descendant_ids;
    parent_ids_to_update := parent_ids_to_update || parent_ids;

    DELETE FROM area_containment
     WHERE descendant = any(descendant_ids_to_update);

    DELETE FROM area_containment
     WHERE parent = any(parent_ids_to_update);

    -- Update the parents of all descendants of parent_ids.
    -- Update the descendants of all parents of descendant_ids.

    INSERT INTO area_containment
    SELECT DISTINCT ON (descendant, parent)
        descendant, parent, depth
      FROM (
          SELECT * FROM get_area_parent_hierarchy_rows(descendant_ids_to_update)
          UNION ALL
          SELECT * FROM get_area_descendant_hierarchy_rows(parent_ids_to_update)
      ) area_hierarchy
     ORDER BY descendant, parent, depth;
END;
$$;


--
-- Name: update_tag_counts_for_raw_delete(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."update_tag_counts_for_raw_delete"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $_$
DECLARE
  entity_type taggable_entity_type;
  old_entity_id INTEGER;
BEGIN
  entity_type := TG_ARGV[0]::taggable_entity_type;
  EXECUTE format('SELECT ($1).%s', entity_type::TEXT) INTO old_entity_id USING OLD;
  PERFORM update_aggregate_tag_count(entity_type, old_entity_id, OLD.tag, (CASE WHEN OLD.is_upvote THEN -1 ELSE 1 END)::SMALLINT);
  PERFORM delete_unused_aggregate_tag(entity_type, old_entity_id, OLD.tag);
  UPDATE tag SET ref_count = ref_count - 1 WHERE id = OLD.tag;
  RETURN NULL;
END;
$_$;


--
-- Name: update_tag_counts_for_raw_insert(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."update_tag_counts_for_raw_insert"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $_$
DECLARE
  entity_type taggable_entity_type;
  new_entity_id INTEGER;
BEGIN
  entity_type := TG_ARGV[0]::taggable_entity_type;
  EXECUTE format('SELECT ($1).%s', entity_type::TEXT) INTO new_entity_id USING NEW;
  PERFORM update_aggregate_tag_count(entity_type, new_entity_id, NEW.tag, (CASE WHEN NEW.is_upvote THEN 1 ELSE -1 END)::SMALLINT);
  UPDATE tag SET ref_count = ref_count + 1 WHERE id = NEW.tag;
  RETURN NULL;
END;
$_$;


--
-- Name: update_tag_counts_for_raw_update(); Type: FUNCTION; Schema: musicbrainz; Owner: -
--

CREATE FUNCTION "musicbrainz"."update_tag_counts_for_raw_update"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $_$
DECLARE
  entity_type taggable_entity_type;
  new_entity_id INTEGER;
  old_entity_id INTEGER;
BEGIN
  entity_type := TG_ARGV[0]::taggable_entity_type;
  EXECUTE format('SELECT ($1).%s', entity_type) INTO new_entity_id USING NEW;
  EXECUTE format('SELECT ($1).%s', entity_type) INTO old_entity_id USING OLD;
  IF (old_entity_id = new_entity_id AND OLD.tag = NEW.tag AND OLD.is_upvote != NEW.is_upvote) THEN
    -- Case 1: only the vote changed.
    PERFORM update_aggregate_tag_count(entity_type, old_entity_id, OLD.tag, (CASE WHEN OLD.is_upvote THEN -2 ELSE 2 END)::SMALLINT);
  ELSIF (old_entity_id != new_entity_id OR OLD.tag != NEW.tag OR OLD.is_upvote != NEW.is_upvote) THEN
    -- Case 2: the entity, tag, or vote changed.
    PERFORM update_aggregate_tag_count(entity_type, old_entity_id, OLD.tag, (CASE WHEN OLD.is_upvote THEN -1 ELSE 1 END)::SMALLINT);
    PERFORM update_aggregate_tag_count(entity_type, new_entity_id, NEW.tag, (CASE WHEN NEW.is_upvote THEN 1 ELSE -1 END)::SMALLINT);
    PERFORM delete_unused_aggregate_tag(entity_type, old_entity_id, OLD.tag);
  END IF;
  IF OLD.tag != NEW.tag THEN
    UPDATE tag SET ref_count = ref_count - 1 WHERE id = OLD.tag;
    UPDATE tag SET ref_count = ref_count + 1 WHERE id = NEW.tag;
  END IF;
  RETURN NULL;
END;
$_$;


--
-- Name: immutable_unaccent("regdictionary", "text"); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "public"."immutable_unaccent"("regdictionary", "text") RETURNS "text"
    LANGUAGE "c" IMMUTABLE STRICT PARALLEL SAFE
    AS '$libdir/unaccent', 'unaccent_dict';


--
-- Name: array_cat_agg(smallint[]); Type: AGGREGATE; Schema: musicbrainz; Owner: -
--

CREATE AGGREGATE "musicbrainz"."array_cat_agg"(smallint[]) (
    SFUNC = "array_cat",
    STYPE = smallint[],
    INITCOND = '{}'
);


--
-- Name: median(integer); Type: AGGREGATE; Schema: musicbrainz; Owner: -
--

CREATE AGGREGATE "musicbrainz"."median"(integer) (
    SFUNC = "array_append",
    STYPE = integer[],
    INITCOND = '{}',
    FINALFUNC = "musicbrainz"."_median"
);


--
-- Name: mb_simple; Type: TEXT SEARCH CONFIGURATION; Schema: musicbrainz; Owner: -
--

CREATE TEXT SEARCH CONFIGURATION "musicbrainz"."mb_simple" (
    PARSER = "pg_catalog"."default" );

ALTER TEXT SEARCH CONFIGURATION "musicbrainz"."mb_simple"
    ADD MAPPING FOR "asciiword" WITH "simple";

ALTER TEXT SEARCH CONFIGURATION "musicbrainz"."mb_simple"
    ADD MAPPING FOR "word" WITH "public"."unaccent", "simple";

ALTER TEXT SEARCH CONFIGURATION "musicbrainz"."mb_simple"
    ADD MAPPING FOR "numword" WITH "public"."unaccent", "simple";

ALTER TEXT SEARCH CONFIGURATION "musicbrainz"."mb_simple"
    ADD MAPPING FOR "email" WITH "simple";

ALTER TEXT SEARCH CONFIGURATION "musicbrainz"."mb_simple"
    ADD MAPPING FOR "url" WITH "simple";

ALTER TEXT SEARCH CONFIGURATION "musicbrainz"."mb_simple"
    ADD MAPPING FOR "host" WITH "simple";

ALTER TEXT SEARCH CONFIGURATION "musicbrainz"."mb_simple"
    ADD MAPPING FOR "sfloat" WITH "simple";

ALTER TEXT SEARCH CONFIGURATION "musicbrainz"."mb_simple"
    ADD MAPPING FOR "version" WITH "simple";

ALTER TEXT SEARCH CONFIGURATION "musicbrainz"."mb_simple"
    ADD MAPPING FOR "hword_numpart" WITH "public"."unaccent", "simple";

ALTER TEXT SEARCH CONFIGURATION "musicbrainz"."mb_simple"
    ADD MAPPING FOR "hword_part" WITH "public"."unaccent", "simple";

ALTER TEXT SEARCH CONFIGURATION "musicbrainz"."mb_simple"
    ADD MAPPING FOR "hword_asciipart" WITH "simple";

ALTER TEXT SEARCH CONFIGURATION "musicbrainz"."mb_simple"
    ADD MAPPING FOR "numhword" WITH "public"."unaccent", "simple";

ALTER TEXT SEARCH CONFIGURATION "musicbrainz"."mb_simple"
    ADD MAPPING FOR "asciihword" WITH "simple";

ALTER TEXT SEARCH CONFIGURATION "musicbrainz"."mb_simple"
    ADD MAPPING FOR "hword" WITH "public"."unaccent", "simple";

ALTER TEXT SEARCH CONFIGURATION "musicbrainz"."mb_simple"
    ADD MAPPING FOR "url_path" WITH "simple";

ALTER TEXT SEARCH CONFIGURATION "musicbrainz"."mb_simple"
    ADD MAPPING FOR "file" WITH "simple";

ALTER TEXT SEARCH CONFIGURATION "musicbrainz"."mb_simple"
    ADD MAPPING FOR "float" WITH "simple";

ALTER TEXT SEARCH CONFIGURATION "musicbrainz"."mb_simple"
    ADD MAPPING FOR "int" WITH "simple";

ALTER TEXT SEARCH CONFIGURATION "musicbrainz"."mb_simple"
    ADD MAPPING FOR "uint" WITH "simple";


--
-- Name: art_type; Type: TABLE; Schema: cover_art_archive; Owner: -
--

CREATE TABLE "cover_art_archive"."art_type" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: art_type_id_seq; Type: SEQUENCE; Schema: cover_art_archive; Owner: -
--

CREATE SEQUENCE "cover_art_archive"."art_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: art_type_id_seq; Type: SEQUENCE OWNED BY; Schema: cover_art_archive; Owner: -
--

ALTER SEQUENCE "cover_art_archive"."art_type_id_seq" OWNED BY "cover_art_archive"."art_type"."id";


--
-- Name: cover_art; Type: TABLE; Schema: cover_art_archive; Owner: -
--

CREATE TABLE "cover_art_archive"."cover_art" (
    "id" bigint NOT NULL,
    "release" integer NOT NULL,
    "comment" "text" DEFAULT ''::"text" NOT NULL,
    "edit" integer NOT NULL,
    "ordering" integer NOT NULL,
    "date_uploaded" timestamp with time zone DEFAULT "now"() NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "mime_type" "text" NOT NULL,
    "filesize" integer,
    "thumb_250_filesize" integer,
    "thumb_500_filesize" integer,
    "thumb_1200_filesize" integer,
    CONSTRAINT "cover_art_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "cover_art_ordering_check" CHECK (("ordering" > 0))
);


--
-- Name: cover_art_type; Type: TABLE; Schema: cover_art_archive; Owner: -
--

CREATE TABLE "cover_art_archive"."cover_art_type" (
    "id" bigint NOT NULL,
    "type_id" integer NOT NULL
);


--
-- Name: image_type; Type: TABLE; Schema: cover_art_archive; Owner: -
--

CREATE TABLE "cover_art_archive"."image_type" (
    "mime_type" "text" NOT NULL,
    "suffix" "text" NOT NULL
);


--
-- Name: edit; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."edit" (
    "id" integer NOT NULL,
    "editor" integer NOT NULL,
    "type" smallint NOT NULL,
    "status" smallint NOT NULL,
    "autoedit" smallint DEFAULT 0 NOT NULL,
    "open_time" timestamp with time zone DEFAULT "now"(),
    "close_time" timestamp with time zone,
    "expire_time" timestamp with time zone NOT NULL,
    "language" integer,
    "quality" smallint DEFAULT 1 NOT NULL
);


--
-- Name: index_listing; Type: VIEW; Schema: cover_art_archive; Owner: -
--

CREATE VIEW "cover_art_archive"."index_listing" AS
 SELECT "cover_art"."id",
    "cover_art"."release",
    "cover_art"."comment",
    "cover_art"."edit",
    "cover_art"."ordering",
    "cover_art"."date_uploaded",
    "cover_art"."edits_pending",
    "cover_art"."mime_type",
    "cover_art"."filesize",
    "cover_art"."thumb_250_filesize",
    "cover_art"."thumb_500_filesize",
    "cover_art"."thumb_1200_filesize",
    ("edit"."close_time" IS NOT NULL) AS "approved",
    COALESCE(("cover_art"."id" = ( SELECT "cover_art_type"."id"
           FROM ("cover_art_archive"."cover_art_type"
             JOIN "cover_art_archive"."cover_art" "ca_front" USING ("id"))
          WHERE (("ca_front"."release" = "cover_art"."release") AND ("cover_art_type"."type_id" = 1))
          ORDER BY "ca_front"."ordering"
         LIMIT 1)), false) AS "is_front",
    COALESCE(("cover_art"."id" = ( SELECT "cover_art_type"."id"
           FROM ("cover_art_archive"."cover_art_type"
             JOIN "cover_art_archive"."cover_art" "ca_front" USING ("id"))
          WHERE (("ca_front"."release" = "cover_art"."release") AND ("cover_art_type"."type_id" = 2))
          ORDER BY "ca_front"."ordering"
         LIMIT 1)), false) AS "is_back",
    ARRAY( SELECT "art_type"."name"
           FROM ("cover_art_archive"."cover_art_type"
             JOIN "cover_art_archive"."art_type" ON (("cover_art_type"."type_id" = "art_type"."id")))
          WHERE ("cover_art_type"."id" = "cover_art"."id")) AS "types"
   FROM ("cover_art_archive"."cover_art"
     LEFT JOIN "musicbrainz"."edit" ON (("edit"."id" = "cover_art"."edit")));


--
-- Name: release_group_cover_art; Type: TABLE; Schema: cover_art_archive; Owner: -
--

CREATE TABLE "cover_art_archive"."release_group_cover_art" (
    "release_group" integer NOT NULL,
    "release" integer NOT NULL
);


--
-- Name: pending_data; Type: TABLE; Schema: dbmirror2; Owner: -
--

CREATE TABLE "dbmirror2"."pending_data" (
    "seqid" bigint NOT NULL,
    "tablename" "text" NOT NULL,
    "op" "char" NOT NULL,
    "xid" bigint NOT NULL,
    "olddata" "json",
    "newdata" "json",
    "oldctid" "tid",
    "trgdepth" integer,
    CONSTRAINT "newdata_is_null_for_deletes" CHECK ((("newdata" IS NULL) = ("op" = 'd'::"char"))),
    CONSTRAINT "olddata_is_null_for_inserts" CHECK ((("olddata" IS NULL) = ("op" = 'i'::"char"))),
    CONSTRAINT "op_in_diu" CHECK (("op" = ANY (ARRAY['d'::"char", 'i'::"char", 'u'::"char"]))),
    CONSTRAINT "tablename_exists" CHECK (("to_regclass"("tablename") IS NOT NULL))
);


--
-- Name: pending_data_seqid_seq; Type: SEQUENCE; Schema: dbmirror2; Owner: -
--

CREATE SEQUENCE "dbmirror2"."pending_data_seqid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pending_data_seqid_seq; Type: SEQUENCE OWNED BY; Schema: dbmirror2; Owner: -
--

ALTER SEQUENCE "dbmirror2"."pending_data_seqid_seq" OWNED BY "dbmirror2"."pending_data"."seqid";


--
-- Name: pending_keys; Type: TABLE; Schema: dbmirror2; Owner: -
--

CREATE TABLE "dbmirror2"."pending_keys" (
    "tablename" "text" NOT NULL,
    "keys" "text"[] NOT NULL
);


--
-- Name: pending_ts; Type: TABLE; Schema: dbmirror2; Owner: -
--

CREATE TABLE "dbmirror2"."pending_ts" (
    "xid" bigint NOT NULL,
    "ts" timestamp with time zone NOT NULL
);


--
-- Name: l_area_area_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_area_area_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_area_artist_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_area_artist_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_area_event_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_area_event_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_area_genre_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_area_genre_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_area_instrument_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_area_instrument_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_area_label_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_area_label_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_area_mood_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_area_mood_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_area_place_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_area_place_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_area_recording_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_area_recording_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_area_release_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_area_release_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_area_release_group_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_area_release_group_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_area_series_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_area_series_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_area_url_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_area_url_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_area_work_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_area_work_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_artist_artist_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_artist_artist_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_artist_event_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_artist_event_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_artist_genre_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_artist_genre_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_artist_instrument_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_artist_instrument_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_artist_label_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_artist_label_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_artist_mood_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_artist_mood_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_artist_place_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_artist_place_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_artist_recording_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_artist_recording_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_artist_release_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_artist_release_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_artist_release_group_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_artist_release_group_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_artist_series_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_artist_series_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_artist_url_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_artist_url_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_artist_work_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_artist_work_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_event_event_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_event_event_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_event_genre_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_event_genre_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_event_instrument_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_event_instrument_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_event_label_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_event_label_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_event_mood_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_event_mood_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_event_place_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_event_place_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_event_recording_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_event_recording_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_event_release_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_event_release_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_event_release_group_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_event_release_group_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_event_series_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_event_series_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_event_url_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_event_url_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_event_work_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_event_work_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_genre_genre_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_genre_genre_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_genre_instrument_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_genre_instrument_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_genre_label_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_genre_label_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_genre_mood_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_genre_mood_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_genre_place_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_genre_place_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_genre_recording_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_genre_recording_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_genre_release_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_genre_release_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_genre_release_group_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_genre_release_group_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_genre_series_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_genre_series_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_genre_url_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_genre_url_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_genre_work_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_genre_work_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_instrument_instrument_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_instrument_instrument_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_instrument_label_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_instrument_label_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_instrument_mood_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_instrument_mood_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_instrument_place_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_instrument_place_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_instrument_recording_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_instrument_recording_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_instrument_release_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_instrument_release_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_instrument_release_group_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_instrument_release_group_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_instrument_series_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_instrument_series_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_instrument_url_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_instrument_url_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_instrument_work_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_instrument_work_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_label_label_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_label_label_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_label_mood_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_label_mood_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_label_place_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_label_place_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_label_recording_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_label_recording_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_label_release_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_label_release_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_label_release_group_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_label_release_group_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_label_series_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_label_series_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_label_url_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_label_url_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_label_work_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_label_work_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_mood_mood_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_mood_mood_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_mood_place_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_mood_place_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_mood_recording_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_mood_recording_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_mood_release_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_mood_release_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_mood_release_group_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_mood_release_group_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_mood_series_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_mood_series_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_mood_url_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_mood_url_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_mood_work_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_mood_work_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_place_place_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_place_place_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_place_recording_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_place_recording_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_place_release_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_place_release_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_place_release_group_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_place_release_group_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_place_series_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_place_series_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_place_url_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_place_url_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_place_work_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_place_work_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_recording_recording_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_recording_recording_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_recording_release_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_recording_release_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_recording_release_group_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_recording_release_group_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_recording_series_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_recording_series_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_recording_url_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_recording_url_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_recording_work_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_recording_work_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_release_group_release_group_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_release_group_release_group_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_release_group_series_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_release_group_series_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_release_group_url_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_release_group_url_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_release_group_work_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_release_group_work_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_release_release_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_release_release_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_release_release_group_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_release_release_group_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_release_series_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_release_series_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_release_url_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_release_url_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_release_work_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_release_work_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_series_series_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_series_series_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_series_url_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_series_url_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_series_work_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_series_work_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_url_url_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_url_url_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_url_work_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_url_work_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: l_work_work_example; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."l_work_work_example" (
    "id" integer NOT NULL,
    "published" boolean NOT NULL,
    "name" "text" NOT NULL
);


--
-- Name: link_type_documentation; Type: TABLE; Schema: documentation; Owner: -
--

CREATE TABLE "documentation"."link_type_documentation" (
    "id" integer NOT NULL,
    "documentation" "text" NOT NULL,
    "examples_deleted" smallint DEFAULT 0 NOT NULL
);


--
-- Name: art_type; Type: TABLE; Schema: event_art_archive; Owner: -
--

CREATE TABLE "event_art_archive"."art_type" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: art_type_id_seq; Type: SEQUENCE; Schema: event_art_archive; Owner: -
--

CREATE SEQUENCE "event_art_archive"."art_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: art_type_id_seq; Type: SEQUENCE OWNED BY; Schema: event_art_archive; Owner: -
--

ALTER SEQUENCE "event_art_archive"."art_type_id_seq" OWNED BY "event_art_archive"."art_type"."id";


--
-- Name: event_art; Type: TABLE; Schema: event_art_archive; Owner: -
--

CREATE TABLE "event_art_archive"."event_art" (
    "id" bigint NOT NULL,
    "event" integer NOT NULL,
    "comment" "text" DEFAULT ''::"text" NOT NULL,
    "edit" integer NOT NULL,
    "ordering" integer NOT NULL,
    "date_uploaded" timestamp with time zone DEFAULT "now"() NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "mime_type" "text" NOT NULL,
    "filesize" integer,
    "thumb_250_filesize" integer,
    "thumb_500_filesize" integer,
    "thumb_1200_filesize" integer,
    CONSTRAINT "event_art_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "event_art_ordering_check" CHECK (("ordering" > 0))
);


--
-- Name: event_art_type; Type: TABLE; Schema: event_art_archive; Owner: -
--

CREATE TABLE "event_art_archive"."event_art_type" (
    "id" bigint NOT NULL,
    "type_id" integer NOT NULL
);


--
-- Name: index_listing; Type: VIEW; Schema: event_art_archive; Owner: -
--

CREATE VIEW "event_art_archive"."index_listing" AS
 SELECT "event_art"."id",
    "event_art"."event",
    "event_art"."comment",
    "event_art"."edit",
    "event_art"."ordering",
    "event_art"."date_uploaded",
    "event_art"."edits_pending",
    "event_art"."mime_type",
    "event_art"."filesize",
    "event_art"."thumb_250_filesize",
    "event_art"."thumb_500_filesize",
    "event_art"."thumb_1200_filesize",
    ("edit"."close_time" IS NOT NULL) AS "approved",
    COALESCE(("event_art"."id" = ( SELECT "event_art_type"."id"
           FROM ("event_art_archive"."event_art_type"
             JOIN "event_art_archive"."event_art" "ea_front" USING ("id"))
          WHERE (("ea_front"."event" = "event_art"."event") AND ("event_art_type"."type_id" = 1))
          ORDER BY "ea_front"."ordering"
         LIMIT 1)), false) AS "is_front",
    ARRAY( SELECT "art_type"."name"
           FROM ("event_art_archive"."event_art_type"
             JOIN "event_art_archive"."art_type" ON (("event_art_type"."type_id" = "art_type"."id")))
          WHERE ("event_art_type"."id" = "event_art"."id")) AS "types"
   FROM ("event_art_archive"."event_art"
     LEFT JOIN "musicbrainz"."edit" ON (("edit"."id" = "event_art"."edit")));


--
-- Name: area_json; Type: TABLE; Schema: json_dump; Owner: -
--

CREATE TABLE "json_dump"."area_json" (
    "id" integer NOT NULL,
    "replication_sequence" integer NOT NULL,
    "json" "jsonb" NOT NULL,
    "last_modified" timestamp with time zone
);


--
-- Name: artist_json; Type: TABLE; Schema: json_dump; Owner: -
--

CREATE TABLE "json_dump"."artist_json" (
    "id" integer NOT NULL,
    "replication_sequence" integer NOT NULL,
    "json" "jsonb" NOT NULL,
    "last_modified" timestamp with time zone
);


--
-- Name: control; Type: TABLE; Schema: json_dump; Owner: -
--

CREATE TABLE "json_dump"."control" (
    "last_processed_replication_sequence" integer,
    "full_json_dump_replication_sequence" integer
);


--
-- Name: deleted_entities; Type: TABLE; Schema: json_dump; Owner: -
--

CREATE TABLE "json_dump"."deleted_entities" (
    "entity_type" character varying(50) NOT NULL,
    "id" integer NOT NULL,
    "replication_sequence" integer NOT NULL
);


--
-- Name: event_json; Type: TABLE; Schema: json_dump; Owner: -
--

CREATE TABLE "json_dump"."event_json" (
    "id" integer NOT NULL,
    "replication_sequence" integer NOT NULL,
    "json" "jsonb" NOT NULL,
    "last_modified" timestamp with time zone
);


--
-- Name: instrument_json; Type: TABLE; Schema: json_dump; Owner: -
--

CREATE TABLE "json_dump"."instrument_json" (
    "id" integer NOT NULL,
    "replication_sequence" integer NOT NULL,
    "json" "jsonb" NOT NULL,
    "last_modified" timestamp with time zone
);


--
-- Name: label_json; Type: TABLE; Schema: json_dump; Owner: -
--

CREATE TABLE "json_dump"."label_json" (
    "id" integer NOT NULL,
    "replication_sequence" integer NOT NULL,
    "json" "jsonb" NOT NULL,
    "last_modified" timestamp with time zone
);


--
-- Name: place_json; Type: TABLE; Schema: json_dump; Owner: -
--

CREATE TABLE "json_dump"."place_json" (
    "id" integer NOT NULL,
    "replication_sequence" integer NOT NULL,
    "json" "jsonb" NOT NULL,
    "last_modified" timestamp with time zone
);


--
-- Name: recording_json; Type: TABLE; Schema: json_dump; Owner: -
--

CREATE TABLE "json_dump"."recording_json" (
    "id" integer NOT NULL,
    "replication_sequence" integer NOT NULL,
    "json" "jsonb" NOT NULL,
    "last_modified" timestamp with time zone
);


--
-- Name: release_group_json; Type: TABLE; Schema: json_dump; Owner: -
--

CREATE TABLE "json_dump"."release_group_json" (
    "id" integer NOT NULL,
    "replication_sequence" integer NOT NULL,
    "json" "jsonb" NOT NULL,
    "last_modified" timestamp with time zone
);


--
-- Name: release_json; Type: TABLE; Schema: json_dump; Owner: -
--

CREATE TABLE "json_dump"."release_json" (
    "id" integer NOT NULL,
    "replication_sequence" integer NOT NULL,
    "json" "jsonb" NOT NULL,
    "last_modified" timestamp with time zone
);


--
-- Name: series_json; Type: TABLE; Schema: json_dump; Owner: -
--

CREATE TABLE "json_dump"."series_json" (
    "id" integer NOT NULL,
    "replication_sequence" integer NOT NULL,
    "json" "jsonb" NOT NULL,
    "last_modified" timestamp with time zone
);


--
-- Name: tmp_checked_entities; Type: TABLE; Schema: json_dump; Owner: -
--

CREATE TABLE "json_dump"."tmp_checked_entities" (
    "id" integer NOT NULL,
    "entity_type" character varying(50) NOT NULL
);


--
-- Name: work_json; Type: TABLE; Schema: json_dump; Owner: -
--

CREATE TABLE "json_dump"."work_json" (
    "id" integer NOT NULL,
    "replication_sequence" integer NOT NULL,
    "json" "jsonb" NOT NULL,
    "last_modified" timestamp with time zone
);


--
-- Name: alternative_medium; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."alternative_medium" (
    "id" integer NOT NULL,
    "medium" integer NOT NULL,
    "alternative_release" integer NOT NULL,
    "name" character varying,
    CONSTRAINT "alternative_medium_name_check" CHECK ((("name")::"text" <> ''::"text"))
);


--
-- Name: alternative_medium_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."alternative_medium_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: alternative_medium_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."alternative_medium_id_seq" OWNED BY "musicbrainz"."alternative_medium"."id";


--
-- Name: alternative_medium_track; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."alternative_medium_track" (
    "alternative_medium" integer NOT NULL,
    "track" integer NOT NULL,
    "alternative_track" integer NOT NULL
);


--
-- Name: alternative_release; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."alternative_release" (
    "id" integer NOT NULL,
    "gid" "uuid" NOT NULL,
    "release" integer NOT NULL,
    "name" character varying,
    "artist_credit" integer,
    "type" integer NOT NULL,
    "language" integer NOT NULL,
    "script" integer NOT NULL,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    CONSTRAINT "alternative_release_name_check" CHECK ((("name")::"text" <> ''::"text"))
);


--
-- Name: alternative_release_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."alternative_release_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: alternative_release_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."alternative_release_id_seq" OWNED BY "musicbrainz"."alternative_release"."id";


--
-- Name: alternative_release_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."alternative_release_type" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: alternative_release_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."alternative_release_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: alternative_release_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."alternative_release_type_id_seq" OWNED BY "musicbrainz"."alternative_release_type"."id";


--
-- Name: alternative_track; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."alternative_track" (
    "id" integer NOT NULL,
    "name" character varying,
    "artist_credit" integer,
    "ref_count" integer DEFAULT 0 NOT NULL,
    CONSTRAINT "alternative_track_check" CHECK (((("name")::"text" <> ''::"text") AND (("name" IS NOT NULL) OR ("artist_credit" IS NOT NULL))))
);


--
-- Name: alternative_track_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."alternative_track_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: alternative_track_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."alternative_track_id_seq" OWNED BY "musicbrainz"."alternative_track"."id";


--
-- Name: annotation; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."annotation" (
    "id" integer NOT NULL,
    "editor" integer NOT NULL,
    "text" "text",
    "changelog" character varying(255),
    "created" timestamp with time zone DEFAULT "now"()
);


--
-- Name: annotation_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."annotation_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: annotation_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."annotation_id_seq" OWNED BY "musicbrainz"."annotation"."id";


--
-- Name: application; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."application" (
    "id" integer NOT NULL,
    "owner" integer NOT NULL,
    "name" "text" NOT NULL,
    "oauth_id" "text" NOT NULL,
    "oauth_secret" "text" NOT NULL,
    "oauth_redirect_uri" "text"
);


--
-- Name: application_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."application_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: application_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."application_id_seq" OWNED BY "musicbrainz"."application"."id";


--
-- Name: area; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."area" (
    "id" integer NOT NULL,
    "gid" "uuid" NOT NULL,
    "name" character varying NOT NULL,
    "type" integer,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "begin_date_year" smallint,
    "begin_date_month" smallint,
    "begin_date_day" smallint,
    "end_date_year" smallint,
    "end_date_month" smallint,
    "end_date_day" smallint,
    "ended" boolean DEFAULT false NOT NULL,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    CONSTRAINT "area_check" CHECK ((((("end_date_year" IS NOT NULL) OR ("end_date_month" IS NOT NULL) OR ("end_date_day" IS NOT NULL)) AND ("ended" = true)) OR (("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL)))),
    CONSTRAINT "area_edits_pending_check" CHECK (("edits_pending" >= 0))
);


--
-- Name: area_alias; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."area_alias" (
    "id" integer NOT NULL,
    "area" integer NOT NULL,
    "name" character varying NOT NULL,
    "locale" "text",
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "type" integer,
    "sort_name" character varying NOT NULL,
    "begin_date_year" smallint,
    "begin_date_month" smallint,
    "begin_date_day" smallint,
    "end_date_year" smallint,
    "end_date_month" smallint,
    "end_date_day" smallint,
    "primary_for_locale" boolean DEFAULT false NOT NULL,
    "ended" boolean DEFAULT false NOT NULL,
    CONSTRAINT "area_alias_check" CHECK ((((("end_date_year" IS NOT NULL) OR ("end_date_month" IS NOT NULL) OR ("end_date_day" IS NOT NULL)) AND ("ended" = true)) OR (("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL)))),
    CONSTRAINT "area_alias_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "primary_check" CHECK (((("locale" IS NULL) AND ("primary_for_locale" IS FALSE)) OR ("locale" IS NOT NULL)))
);


--
-- Name: area_alias_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."area_alias_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: area_alias_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."area_alias_id_seq" OWNED BY "musicbrainz"."area_alias"."id";


--
-- Name: area_alias_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."area_alias_type" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: area_alias_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."area_alias_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: area_alias_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."area_alias_type_id_seq" OWNED BY "musicbrainz"."area_alias_type"."id";


--
-- Name: area_annotation; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."area_annotation" (
    "area" integer NOT NULL,
    "annotation" integer NOT NULL
);


--
-- Name: area_attribute; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."area_attribute" (
    "id" integer NOT NULL,
    "area" integer NOT NULL,
    "area_attribute_type" integer NOT NULL,
    "area_attribute_type_allowed_value" integer,
    "area_attribute_text" "text",
    CONSTRAINT "area_attribute_check" CHECK (((("area_attribute_type_allowed_value" IS NULL) AND ("area_attribute_text" IS NOT NULL)) OR (("area_attribute_type_allowed_value" IS NOT NULL) AND ("area_attribute_text" IS NULL))))
);


--
-- Name: area_attribute_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."area_attribute_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: area_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."area_attribute_id_seq" OWNED BY "musicbrainz"."area_attribute"."id";


--
-- Name: area_attribute_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."area_attribute_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "free_text" boolean NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: area_attribute_type_allowed_value; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."area_attribute_type_allowed_value" (
    "id" integer NOT NULL,
    "area_attribute_type" integer NOT NULL,
    "value" "text",
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: area_attribute_type_allowed_value_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."area_attribute_type_allowed_value_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: area_attribute_type_allowed_value_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."area_attribute_type_allowed_value_id_seq" OWNED BY "musicbrainz"."area_attribute_type_allowed_value"."id";


--
-- Name: area_attribute_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."area_attribute_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: area_attribute_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."area_attribute_type_id_seq" OWNED BY "musicbrainz"."area_attribute_type"."id";


--
-- Name: area_gid_redirect; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."area_gid_redirect" (
    "gid" "uuid" NOT NULL,
    "new_id" integer NOT NULL,
    "created" timestamp with time zone DEFAULT "now"()
);


--
-- Name: area_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."area_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: area_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."area_id_seq" OWNED BY "musicbrainz"."area"."id";


--
-- Name: area_tag; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."area_tag" (
    "area" integer NOT NULL,
    "tag" integer NOT NULL,
    "count" integer NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"()
);


--
-- Name: area_tag_raw; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."area_tag_raw" (
    "area" integer NOT NULL,
    "editor" integer NOT NULL,
    "tag" integer NOT NULL,
    "is_upvote" boolean DEFAULT true NOT NULL
);


--
-- Name: area_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."area_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: area_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."area_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: area_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."area_type_id_seq" OWNED BY "musicbrainz"."area_type"."id";


--
-- Name: artist; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist" (
    "id" integer NOT NULL,
    "gid" "uuid" NOT NULL,
    "name" character varying NOT NULL,
    "sort_name" character varying NOT NULL,
    "begin_date_year" smallint,
    "begin_date_month" smallint,
    "begin_date_day" smallint,
    "end_date_year" smallint,
    "end_date_month" smallint,
    "end_date_day" smallint,
    "type" integer,
    "area" integer,
    "gender" integer,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "ended" boolean DEFAULT false NOT NULL,
    "begin_area" integer,
    "end_area" integer,
    CONSTRAINT "artist_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "artist_ended_check" CHECK ((((("end_date_year" IS NOT NULL) OR ("end_date_month" IS NOT NULL) OR ("end_date_day" IS NOT NULL)) AND ("ended" = true)) OR (("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL))))
);


--
-- Name: artist_alias; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_alias" (
    "id" integer NOT NULL,
    "artist" integer NOT NULL,
    "name" character varying NOT NULL,
    "locale" "text",
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "type" integer,
    "sort_name" character varying NOT NULL,
    "begin_date_year" smallint,
    "begin_date_month" smallint,
    "begin_date_day" smallint,
    "end_date_year" smallint,
    "end_date_month" smallint,
    "end_date_day" smallint,
    "primary_for_locale" boolean DEFAULT false NOT NULL,
    "ended" boolean DEFAULT false NOT NULL,
    CONSTRAINT "artist_alias_check" CHECK ((((("end_date_year" IS NOT NULL) OR ("end_date_month" IS NOT NULL) OR ("end_date_day" IS NOT NULL)) AND ("ended" = true)) OR (("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL)))),
    CONSTRAINT "artist_alias_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "primary_check" CHECK (((("locale" IS NULL) AND ("primary_for_locale" IS FALSE)) OR ("locale" IS NOT NULL))),
    CONSTRAINT "search_hints_are_empty" CHECK ((("type" <> 3) OR (("type" = 3) AND (("sort_name")::"text" = ("name")::"text") AND ("begin_date_year" IS NULL) AND ("begin_date_month" IS NULL) AND ("begin_date_day" IS NULL) AND ("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL) AND ("primary_for_locale" IS FALSE) AND ("locale" IS NULL))))
);


--
-- Name: artist_alias_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."artist_alias_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: artist_alias_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."artist_alias_id_seq" OWNED BY "musicbrainz"."artist_alias"."id";


--
-- Name: artist_alias_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_alias_type" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: artist_alias_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."artist_alias_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: artist_alias_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."artist_alias_type_id_seq" OWNED BY "musicbrainz"."artist_alias_type"."id";


--
-- Name: artist_annotation; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_annotation" (
    "artist" integer NOT NULL,
    "annotation" integer NOT NULL
);


--
-- Name: artist_attribute; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_attribute" (
    "id" integer NOT NULL,
    "artist" integer NOT NULL,
    "artist_attribute_type" integer NOT NULL,
    "artist_attribute_type_allowed_value" integer,
    "artist_attribute_text" "text",
    CONSTRAINT "artist_attribute_check" CHECK (((("artist_attribute_type_allowed_value" IS NULL) AND ("artist_attribute_text" IS NOT NULL)) OR (("artist_attribute_type_allowed_value" IS NOT NULL) AND ("artist_attribute_text" IS NULL))))
);


--
-- Name: artist_attribute_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."artist_attribute_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: artist_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."artist_attribute_id_seq" OWNED BY "musicbrainz"."artist_attribute"."id";


--
-- Name: artist_attribute_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_attribute_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "free_text" boolean NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: artist_attribute_type_allowed_value; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_attribute_type_allowed_value" (
    "id" integer NOT NULL,
    "artist_attribute_type" integer NOT NULL,
    "value" "text",
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: artist_attribute_type_allowed_value_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."artist_attribute_type_allowed_value_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: artist_attribute_type_allowed_value_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."artist_attribute_type_allowed_value_id_seq" OWNED BY "musicbrainz"."artist_attribute_type_allowed_value"."id";


--
-- Name: artist_attribute_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."artist_attribute_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: artist_attribute_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."artist_attribute_type_id_seq" OWNED BY "musicbrainz"."artist_attribute_type"."id";


--
-- Name: artist_credit; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_credit" (
    "id" integer NOT NULL,
    "name" character varying NOT NULL,
    "artist_count" smallint NOT NULL,
    "ref_count" integer DEFAULT 0,
    "created" timestamp with time zone DEFAULT "now"(),
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "gid" "uuid" NOT NULL,
    CONSTRAINT "artist_credit_edits_pending_check" CHECK (("edits_pending" >= 0))
);


--
-- Name: artist_credit_gid_redirect; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_credit_gid_redirect" (
    "gid" "uuid" NOT NULL,
    "new_id" integer NOT NULL,
    "created" timestamp with time zone DEFAULT "now"()
);


--
-- Name: artist_credit_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."artist_credit_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: artist_credit_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."artist_credit_id_seq" OWNED BY "musicbrainz"."artist_credit"."id";


--
-- Name: artist_credit_name; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_credit_name" (
    "artist_credit" integer NOT NULL,
    "position" smallint NOT NULL,
    "artist" integer NOT NULL,
    "name" character varying NOT NULL,
    "join_phrase" "text" DEFAULT ''::"text" NOT NULL
);


--
-- Name: artist_gid_redirect; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_gid_redirect" (
    "gid" "uuid" NOT NULL,
    "new_id" integer NOT NULL,
    "created" timestamp with time zone DEFAULT "now"()
);


--
-- Name: artist_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."artist_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: artist_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."artist_id_seq" OWNED BY "musicbrainz"."artist"."id";


--
-- Name: artist_ipi; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_ipi" (
    "artist" integer NOT NULL,
    "ipi" character(11) NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "created" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "artist_ipi_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "artist_ipi_ipi_check" CHECK (("ipi" ~ '^\d{11}$'::"text"))
);


--
-- Name: artist_isni; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_isni" (
    "artist" integer NOT NULL,
    "isni" character(16) NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "created" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "artist_isni_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "artist_isni_isni_check" CHECK (("isni" ~ '^\d{15}[\dX]$'::"text"))
);


--
-- Name: artist_meta; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_meta" (
    "id" integer NOT NULL,
    "rating" smallint,
    "rating_count" integer,
    CONSTRAINT "artist_meta_rating_check" CHECK ((("rating" >= 0) AND ("rating" <= 100)))
);


--
-- Name: artist_rating_raw; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_rating_raw" (
    "artist" integer NOT NULL,
    "editor" integer NOT NULL,
    "rating" smallint NOT NULL,
    CONSTRAINT "artist_rating_raw_rating_check" CHECK ((("rating" >= 0) AND ("rating" <= 100)))
);


--
-- Name: artist_release_group_nonva; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_release_group_nonva" (
    "is_track_artist" boolean NOT NULL,
    "artist" integer NOT NULL,
    "unofficial" boolean NOT NULL,
    "primary_type_child_order" smallint,
    "primary_type" smallint,
    "secondary_type_child_orders" smallint[],
    "secondary_types" smallint[],
    "first_release_date" integer,
    "name" character varying NOT NULL COLLATE "musicbrainz"."musicbrainz",
    "release_group" integer NOT NULL
);


--
-- Name: artist_release_group_pending_update; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_release_group_pending_update" (
    "release_group" integer NOT NULL
);


--
-- Name: artist_release_group_va; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_release_group_va" (
    "is_track_artist" boolean NOT NULL,
    "artist" integer NOT NULL,
    "unofficial" boolean NOT NULL,
    "primary_type_child_order" smallint,
    "primary_type" smallint,
    "secondary_type_child_orders" smallint[],
    "secondary_types" smallint[],
    "first_release_date" integer,
    "name" character varying NOT NULL COLLATE "musicbrainz"."musicbrainz",
    "release_group" integer NOT NULL
);


--
-- Name: artist_release_nonva; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_release_nonva" (
    "is_track_artist" boolean NOT NULL,
    "artist" integer NOT NULL,
    "first_release_date" integer,
    "catalog_numbers" "text"[],
    "country_code" character(2),
    "barcode" bigint,
    "name" character varying NOT NULL COLLATE "musicbrainz"."musicbrainz",
    "release" integer NOT NULL
);


--
-- Name: artist_release_pending_update; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_release_pending_update" (
    "release" integer NOT NULL
);


--
-- Name: artist_release_va; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_release_va" (
    "is_track_artist" boolean NOT NULL,
    "artist" integer NOT NULL,
    "first_release_date" integer,
    "catalog_numbers" "text"[],
    "country_code" character(2),
    "barcode" bigint,
    "name" character varying NOT NULL COLLATE "musicbrainz"."musicbrainz",
    "release" integer NOT NULL
);


--
-- Name: l_artist_series; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_artist_series" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_artist_series_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_artist_series_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: link; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."link" (
    "id" integer NOT NULL,
    "link_type" integer NOT NULL,
    "begin_date_year" smallint,
    "begin_date_month" smallint,
    "begin_date_day" smallint,
    "end_date_year" smallint,
    "end_date_month" smallint,
    "end_date_day" smallint,
    "attribute_count" integer DEFAULT 0 NOT NULL,
    "created" timestamp with time zone DEFAULT "now"(),
    "ended" boolean DEFAULT false NOT NULL,
    CONSTRAINT "link_ended_check" CHECK ((((("end_date_year" IS NOT NULL) OR ("end_date_month" IS NOT NULL) OR ("end_date_day" IS NOT NULL)) AND ("ended" = true)) OR (("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL))))
);


--
-- Name: link_attribute_text_value; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."link_attribute_text_value" (
    "link" integer NOT NULL,
    "attribute_type" integer NOT NULL,
    "text_value" "text" NOT NULL
);


--
-- Name: link_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."link_type" (
    "id" integer NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "gid" "uuid" NOT NULL,
    "entity_type0" character varying(50) NOT NULL,
    "entity_type1" character varying(50) NOT NULL,
    "name" character varying(255) NOT NULL,
    "description" "text",
    "link_phrase" character varying(255) NOT NULL,
    "reverse_link_phrase" character varying(255) NOT NULL,
    "long_link_phrase" character varying(255) NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "is_deprecated" boolean DEFAULT false NOT NULL,
    "has_dates" boolean DEFAULT true NOT NULL,
    "entity0_cardinality" smallint DEFAULT 0 NOT NULL,
    "entity1_cardinality" smallint DEFAULT 0 NOT NULL
);


--
-- Name: series; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."series" (
    "id" integer NOT NULL,
    "gid" "uuid" NOT NULL,
    "name" character varying NOT NULL,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "type" integer NOT NULL,
    "ordering_type" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "series_edits_pending_check" CHECK (("edits_pending" >= 0))
);


--
-- Name: artist_series; Type: VIEW; Schema: musicbrainz; Owner: -
--

CREATE VIEW "musicbrainz"."artist_series" AS
 SELECT "las"."entity0" AS "artist",
    "las"."entity1" AS "series",
    "las"."id" AS "relationship",
    "las"."link_order",
    "las"."link",
    COALESCE("latv"."text_value", ''::"text") AS "text_value"
   FROM (((("musicbrainz"."l_artist_series" "las"
     JOIN "musicbrainz"."series" "s" ON (("s"."id" = "las"."entity1")))
     JOIN "musicbrainz"."link" "l" ON (("l"."id" = "las"."link")))
     JOIN "musicbrainz"."link_type" "lt" ON ((("lt"."id" = "l"."link_type") AND ("lt"."gid" = 'd1a845d1-8c03-3191-9454-e4e8d37fa5e0'::"uuid"))))
     LEFT JOIN "musicbrainz"."link_attribute_text_value" "latv" ON ((("latv"."attribute_type" = 788) AND ("latv"."link" = "l"."id"))))
  ORDER BY "las"."entity1", "las"."link_order";


--
-- Name: artist_tag; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_tag" (
    "artist" integer NOT NULL,
    "tag" integer NOT NULL,
    "count" integer NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"()
);


--
-- Name: artist_tag_raw; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_tag_raw" (
    "artist" integer NOT NULL,
    "editor" integer NOT NULL,
    "tag" integer NOT NULL,
    "is_upvote" boolean DEFAULT true NOT NULL
);


--
-- Name: artist_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."artist_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: artist_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."artist_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: artist_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."artist_type_id_seq" OWNED BY "musicbrainz"."artist_type"."id";


--
-- Name: autoeditor_election; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."autoeditor_election" (
    "id" integer NOT NULL,
    "candidate" integer NOT NULL,
    "proposer" integer NOT NULL,
    "seconder_1" integer,
    "seconder_2" integer,
    "status" integer DEFAULT 1 NOT NULL,
    "yes_votes" integer DEFAULT 0 NOT NULL,
    "no_votes" integer DEFAULT 0 NOT NULL,
    "propose_time" timestamp with time zone DEFAULT "now"() NOT NULL,
    "open_time" timestamp with time zone,
    "close_time" timestamp with time zone,
    CONSTRAINT "autoeditor_election_status_check" CHECK (("status" = ANY (ARRAY[1, 2, 3, 4, 5, 6])))
);


--
-- Name: autoeditor_election_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."autoeditor_election_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: autoeditor_election_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."autoeditor_election_id_seq" OWNED BY "musicbrainz"."autoeditor_election"."id";


--
-- Name: autoeditor_election_vote; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."autoeditor_election_vote" (
    "id" integer NOT NULL,
    "autoeditor_election" integer NOT NULL,
    "voter" integer NOT NULL,
    "vote" integer NOT NULL,
    "vote_time" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "autoeditor_election_vote_vote_check" CHECK (("vote" = ANY (ARRAY['-1'::integer, 0, 1])))
);


--
-- Name: autoeditor_election_vote_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."autoeditor_election_vote_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: autoeditor_election_vote_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."autoeditor_election_vote_id_seq" OWNED BY "musicbrainz"."autoeditor_election_vote"."id";


--
-- Name: cdtoc; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."cdtoc" (
    "id" integer NOT NULL,
    "discid" character(28) NOT NULL,
    "freedb_id" character(8) NOT NULL,
    "track_count" integer NOT NULL,
    "leadout_offset" integer NOT NULL,
    "track_offset" integer[] NOT NULL,
    "created" timestamp with time zone DEFAULT "now"()
);


--
-- Name: cdtoc_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."cdtoc_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cdtoc_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."cdtoc_id_seq" OWNED BY "musicbrainz"."cdtoc"."id";


--
-- Name: cdtoc_raw; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."cdtoc_raw" (
    "id" integer NOT NULL,
    "release" integer NOT NULL,
    "discid" character(28) NOT NULL,
    "track_count" integer NOT NULL,
    "leadout_offset" integer NOT NULL,
    "track_offset" integer[] NOT NULL
);


--
-- Name: cdtoc_raw_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."cdtoc_raw_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cdtoc_raw_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."cdtoc_raw_id_seq" OWNED BY "musicbrainz"."cdtoc_raw"."id";


--
-- Name: country_area; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."country_area" (
    "area" integer NOT NULL
);


--
-- Name: dbmirror_pending; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."dbmirror_pending" (
    "seqid" integer NOT NULL,
    "tablename" character varying NOT NULL,
    "op" character(1),
    "xid" integer NOT NULL
);


--
-- Name: dbmirror_pending_seqid_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."dbmirror_pending_seqid_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbmirror_pending_seqid_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."dbmirror_pending_seqid_seq" OWNED BY "musicbrainz"."dbmirror_pending"."seqid";


--
-- Name: dbmirror_pendingdata; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."dbmirror_pendingdata" (
    "seqid" integer NOT NULL,
    "iskey" boolean NOT NULL,
    "data" character varying
);


--
-- Name: deleted_entity; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."deleted_entity" (
    "gid" "uuid" NOT NULL,
    "data" "jsonb" NOT NULL,
    "deleted_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


--
-- Name: edit_area; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."edit_area" (
    "edit" integer NOT NULL,
    "area" integer NOT NULL
);


--
-- Name: edit_artist; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."edit_artist" (
    "edit" integer NOT NULL,
    "artist" integer NOT NULL,
    "status" smallint NOT NULL
);


--
-- Name: edit_data; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."edit_data" (
    "edit" integer NOT NULL,
    "data" "jsonb" NOT NULL
);


--
-- Name: edit_event; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."edit_event" (
    "edit" integer NOT NULL,
    "event" integer NOT NULL
);


--
-- Name: edit_genre; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."edit_genre" (
    "edit" integer NOT NULL,
    "genre" integer NOT NULL
);


--
-- Name: edit_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."edit_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: edit_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."edit_id_seq" OWNED BY "musicbrainz"."edit"."id";


--
-- Name: edit_instrument; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."edit_instrument" (
    "edit" integer NOT NULL,
    "instrument" integer NOT NULL
);


--
-- Name: edit_label; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."edit_label" (
    "edit" integer NOT NULL,
    "label" integer NOT NULL,
    "status" smallint NOT NULL
);


--
-- Name: edit_mood; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."edit_mood" (
    "edit" integer NOT NULL,
    "mood" integer NOT NULL
);


--
-- Name: edit_note; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."edit_note" (
    "id" integer NOT NULL,
    "editor" integer NOT NULL,
    "edit" integer NOT NULL,
    "text" "text" NOT NULL,
    "post_time" timestamp with time zone DEFAULT "now"()
);


--
-- Name: edit_note_change; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."edit_note_change" (
    "id" integer NOT NULL,
    "status" "musicbrainz"."edit_note_status",
    "edit_note" integer NOT NULL,
    "change_editor" integer NOT NULL,
    "change_time" timestamp with time zone DEFAULT "now"(),
    "old_note" "text" NOT NULL,
    "new_note" "text" NOT NULL,
    "reason" "text" DEFAULT ''::"text" NOT NULL
);


--
-- Name: edit_note_change_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."edit_note_change_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: edit_note_change_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."edit_note_change_id_seq" OWNED BY "musicbrainz"."edit_note_change"."id";


--
-- Name: edit_note_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."edit_note_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: edit_note_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."edit_note_id_seq" OWNED BY "musicbrainz"."edit_note"."id";


--
-- Name: edit_note_recipient; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."edit_note_recipient" (
    "recipient" integer NOT NULL,
    "edit_note" integer NOT NULL
);


--
-- Name: edit_place; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."edit_place" (
    "edit" integer NOT NULL,
    "place" integer NOT NULL
);


--
-- Name: edit_recording; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."edit_recording" (
    "edit" integer NOT NULL,
    "recording" integer NOT NULL
);


--
-- Name: edit_release; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."edit_release" (
    "edit" integer NOT NULL,
    "release" integer NOT NULL
);


--
-- Name: edit_release_group; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."edit_release_group" (
    "edit" integer NOT NULL,
    "release_group" integer NOT NULL
);


--
-- Name: edit_series; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."edit_series" (
    "edit" integer NOT NULL,
    "series" integer NOT NULL
);


--
-- Name: edit_url; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."edit_url" (
    "edit" integer NOT NULL,
    "url" integer NOT NULL
);


--
-- Name: edit_work; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."edit_work" (
    "edit" integer NOT NULL,
    "work" integer NOT NULL
);


--
-- Name: editor; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor" (
    "id" integer NOT NULL,
    "name" character varying(64) NOT NULL,
    "privs" integer DEFAULT 0,
    "email" character varying(64) DEFAULT NULL::character varying,
    "website" character varying(255) DEFAULT NULL::character varying,
    "bio" "text",
    "member_since" timestamp with time zone DEFAULT "now"(),
    "email_confirm_date" timestamp with time zone,
    "last_login_date" timestamp with time zone DEFAULT "now"(),
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "birth_date" "date",
    "gender" integer,
    "area" integer,
    "password" character varying(128) NOT NULL,
    "ha1" character(32) NOT NULL,
    "deleted" boolean DEFAULT false NOT NULL
);


--
-- Name: editor_collection; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_collection" (
    "id" integer NOT NULL,
    "gid" "uuid" NOT NULL,
    "editor" integer NOT NULL,
    "name" character varying NOT NULL,
    "public" boolean DEFAULT false NOT NULL,
    "description" "text" DEFAULT ''::"text" NOT NULL,
    "type" integer NOT NULL
);


--
-- Name: editor_collection_area; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_collection_area" (
    "collection" integer NOT NULL,
    "area" integer NOT NULL,
    "added" timestamp with time zone DEFAULT "now"(),
    "position" integer DEFAULT 0 NOT NULL,
    "comment" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "editor_collection_area_position_check" CHECK (("position" >= 0))
);


--
-- Name: editor_collection_artist; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_collection_artist" (
    "collection" integer NOT NULL,
    "artist" integer NOT NULL,
    "added" timestamp with time zone DEFAULT "now"(),
    "position" integer DEFAULT 0 NOT NULL,
    "comment" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "editor_collection_artist_position_check" CHECK (("position" >= 0))
);


--
-- Name: editor_collection_collaborator; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_collection_collaborator" (
    "collection" integer NOT NULL,
    "editor" integer NOT NULL
);


--
-- Name: editor_collection_deleted_entity; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_collection_deleted_entity" (
    "collection" integer NOT NULL,
    "gid" "uuid" NOT NULL,
    "added" timestamp with time zone DEFAULT "now"(),
    "position" integer DEFAULT 0 NOT NULL,
    "comment" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "editor_collection_deleted_entity_position_check" CHECK (("position" >= 0))
);


--
-- Name: editor_collection_event; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_collection_event" (
    "collection" integer NOT NULL,
    "event" integer NOT NULL,
    "added" timestamp with time zone DEFAULT "now"(),
    "position" integer DEFAULT 0 NOT NULL,
    "comment" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "editor_collection_event_position_check" CHECK (("position" >= 0))
);


--
-- Name: editor_collection_genre; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_collection_genre" (
    "collection" integer NOT NULL,
    "genre" integer NOT NULL,
    "added" timestamp with time zone DEFAULT "now"(),
    "position" integer DEFAULT 0 NOT NULL,
    "comment" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "editor_collection_genre_position_check" CHECK (("position" >= 0))
);


--
-- Name: editor_collection_gid_redirect; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_collection_gid_redirect" (
    "gid" "uuid" NOT NULL,
    "new_id" integer NOT NULL,
    "created" timestamp with time zone DEFAULT "now"()
);


--
-- Name: editor_collection_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."editor_collection_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: editor_collection_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."editor_collection_id_seq" OWNED BY "musicbrainz"."editor_collection"."id";


--
-- Name: editor_collection_instrument; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_collection_instrument" (
    "collection" integer NOT NULL,
    "instrument" integer NOT NULL,
    "added" timestamp with time zone DEFAULT "now"(),
    "position" integer DEFAULT 0 NOT NULL,
    "comment" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "editor_collection_instrument_position_check" CHECK (("position" >= 0))
);


--
-- Name: editor_collection_label; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_collection_label" (
    "collection" integer NOT NULL,
    "label" integer NOT NULL,
    "added" timestamp with time zone DEFAULT "now"(),
    "position" integer DEFAULT 0 NOT NULL,
    "comment" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "editor_collection_label_position_check" CHECK (("position" >= 0))
);


--
-- Name: editor_collection_place; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_collection_place" (
    "collection" integer NOT NULL,
    "place" integer NOT NULL,
    "added" timestamp with time zone DEFAULT "now"(),
    "position" integer DEFAULT 0 NOT NULL,
    "comment" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "editor_collection_place_position_check" CHECK (("position" >= 0))
);


--
-- Name: editor_collection_recording; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_collection_recording" (
    "collection" integer NOT NULL,
    "recording" integer NOT NULL,
    "added" timestamp with time zone DEFAULT "now"(),
    "position" integer DEFAULT 0 NOT NULL,
    "comment" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "editor_collection_recording_position_check" CHECK (("position" >= 0))
);


--
-- Name: editor_collection_release; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_collection_release" (
    "collection" integer NOT NULL,
    "release" integer NOT NULL,
    "added" timestamp with time zone DEFAULT "now"(),
    "position" integer DEFAULT 0 NOT NULL,
    "comment" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "editor_collection_release_position_check" CHECK (("position" >= 0))
);


--
-- Name: editor_collection_release_group; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_collection_release_group" (
    "collection" integer NOT NULL,
    "release_group" integer NOT NULL,
    "added" timestamp with time zone DEFAULT "now"(),
    "position" integer DEFAULT 0 NOT NULL,
    "comment" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "editor_collection_release_group_position_check" CHECK (("position" >= 0))
);


--
-- Name: editor_collection_series; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_collection_series" (
    "collection" integer NOT NULL,
    "series" integer NOT NULL,
    "added" timestamp with time zone DEFAULT "now"(),
    "position" integer DEFAULT 0 NOT NULL,
    "comment" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "editor_collection_series_position_check" CHECK (("position" >= 0))
);


--
-- Name: editor_collection_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_collection_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "entity_type" character varying(50) NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: editor_collection_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."editor_collection_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: editor_collection_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."editor_collection_type_id_seq" OWNED BY "musicbrainz"."editor_collection_type"."id";


--
-- Name: editor_collection_work; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_collection_work" (
    "collection" integer NOT NULL,
    "work" integer NOT NULL,
    "added" timestamp with time zone DEFAULT "now"(),
    "position" integer DEFAULT 0 NOT NULL,
    "comment" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "editor_collection_work_position_check" CHECK (("position" >= 0))
);


--
-- Name: editor_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."editor_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: editor_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."editor_id_seq" OWNED BY "musicbrainz"."editor"."id";


--
-- Name: editor_language; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_language" (
    "editor" integer NOT NULL,
    "language" integer NOT NULL,
    "fluency" "musicbrainz"."fluency" NOT NULL
);


--
-- Name: editor_oauth_token; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_oauth_token" (
    "id" integer NOT NULL,
    "editor" integer NOT NULL,
    "application" integer NOT NULL,
    "authorization_code" "text",
    "refresh_token" "text",
    "access_token" "text",
    "expire_time" timestamp with time zone NOT NULL,
    "scope" integer DEFAULT 0 NOT NULL,
    "granted" timestamp with time zone DEFAULT "now"() NOT NULL,
    "code_challenge" "text",
    "code_challenge_method" "musicbrainz"."oauth_code_challenge_method",
    CONSTRAINT "valid_code_challenge" CHECK (((("code_challenge" IS NULL) = ("code_challenge_method" IS NULL)) AND (("code_challenge" IS NULL) OR ("code_challenge" ~ '^[A-Za-z0-9.~_-]{43,128}$'::"text"))))
);


--
-- Name: editor_oauth_token_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."editor_oauth_token_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: editor_oauth_token_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."editor_oauth_token_id_seq" OWNED BY "musicbrainz"."editor_oauth_token"."id";


--
-- Name: editor_preference; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_preference" (
    "id" integer NOT NULL,
    "editor" integer NOT NULL,
    "name" character varying(50) NOT NULL,
    "value" character varying(100) NOT NULL
);


--
-- Name: editor_preference_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."editor_preference_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: editor_preference_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."editor_preference_id_seq" OWNED BY "musicbrainz"."editor_preference"."id";


--
-- Name: editor_subscribe_artist; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_subscribe_artist" (
    "id" integer NOT NULL,
    "editor" integer NOT NULL,
    "artist" integer NOT NULL,
    "last_edit_sent" integer NOT NULL
);


--
-- Name: editor_subscribe_artist_deleted; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_subscribe_artist_deleted" (
    "editor" integer NOT NULL,
    "gid" "uuid" NOT NULL,
    "deleted_by" integer NOT NULL
);


--
-- Name: editor_subscribe_artist_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."editor_subscribe_artist_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: editor_subscribe_artist_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."editor_subscribe_artist_id_seq" OWNED BY "musicbrainz"."editor_subscribe_artist"."id";


--
-- Name: editor_subscribe_collection; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_subscribe_collection" (
    "id" integer NOT NULL,
    "editor" integer NOT NULL,
    "collection" integer NOT NULL,
    "last_edit_sent" integer NOT NULL,
    "available" boolean DEFAULT true NOT NULL,
    "last_seen_name" character varying(255)
);


--
-- Name: editor_subscribe_collection_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."editor_subscribe_collection_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: editor_subscribe_collection_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."editor_subscribe_collection_id_seq" OWNED BY "musicbrainz"."editor_subscribe_collection"."id";


--
-- Name: editor_subscribe_editor; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_subscribe_editor" (
    "id" integer NOT NULL,
    "editor" integer NOT NULL,
    "subscribed_editor" integer NOT NULL,
    "last_edit_sent" integer NOT NULL
);


--
-- Name: editor_subscribe_editor_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."editor_subscribe_editor_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: editor_subscribe_editor_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."editor_subscribe_editor_id_seq" OWNED BY "musicbrainz"."editor_subscribe_editor"."id";


--
-- Name: editor_subscribe_label; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_subscribe_label" (
    "id" integer NOT NULL,
    "editor" integer NOT NULL,
    "label" integer NOT NULL,
    "last_edit_sent" integer NOT NULL
);


--
-- Name: editor_subscribe_label_deleted; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_subscribe_label_deleted" (
    "editor" integer NOT NULL,
    "gid" "uuid" NOT NULL,
    "deleted_by" integer NOT NULL
);


--
-- Name: editor_subscribe_label_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."editor_subscribe_label_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: editor_subscribe_label_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."editor_subscribe_label_id_seq" OWNED BY "musicbrainz"."editor_subscribe_label"."id";


--
-- Name: editor_subscribe_series; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_subscribe_series" (
    "id" integer NOT NULL,
    "editor" integer NOT NULL,
    "series" integer NOT NULL,
    "last_edit_sent" integer NOT NULL
);


--
-- Name: editor_subscribe_series_deleted; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."editor_subscribe_series_deleted" (
    "editor" integer NOT NULL,
    "gid" "uuid" NOT NULL,
    "deleted_by" integer NOT NULL
);


--
-- Name: editor_subscribe_series_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."editor_subscribe_series_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: editor_subscribe_series_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."editor_subscribe_series_id_seq" OWNED BY "musicbrainz"."editor_subscribe_series"."id";


--
-- Name: event; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."event" (
    "id" integer NOT NULL,
    "gid" "uuid" NOT NULL,
    "name" character varying NOT NULL,
    "begin_date_year" smallint,
    "begin_date_month" smallint,
    "begin_date_day" smallint,
    "end_date_year" smallint,
    "end_date_month" smallint,
    "end_date_day" smallint,
    "time" time without time zone,
    "type" integer,
    "cancelled" boolean DEFAULT false NOT NULL,
    "setlist" "text",
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "ended" boolean DEFAULT false NOT NULL,
    CONSTRAINT "event_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "event_ended_check" CHECK ((((("end_date_year" IS NOT NULL) OR ("end_date_month" IS NOT NULL) OR ("end_date_day" IS NOT NULL)) AND ("ended" = true)) OR (("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL))))
);


--
-- Name: event_alias; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."event_alias" (
    "id" integer NOT NULL,
    "event" integer NOT NULL,
    "name" character varying NOT NULL,
    "locale" "text",
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "type" integer,
    "sort_name" character varying NOT NULL,
    "begin_date_year" smallint,
    "begin_date_month" smallint,
    "begin_date_day" smallint,
    "end_date_year" smallint,
    "end_date_month" smallint,
    "end_date_day" smallint,
    "primary_for_locale" boolean DEFAULT false NOT NULL,
    "ended" boolean DEFAULT false NOT NULL,
    CONSTRAINT "event_alias_check" CHECK ((((("end_date_year" IS NOT NULL) OR ("end_date_month" IS NOT NULL) OR ("end_date_day" IS NOT NULL)) AND ("ended" = true)) OR (("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL)))),
    CONSTRAINT "event_alias_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "primary_check" CHECK (((("locale" IS NULL) AND ("primary_for_locale" IS FALSE)) OR ("locale" IS NOT NULL))),
    CONSTRAINT "search_hints_are_empty" CHECK ((("type" <> 2) OR (("type" = 2) AND (("sort_name")::"text" = ("name")::"text") AND ("begin_date_year" IS NULL) AND ("begin_date_month" IS NULL) AND ("begin_date_day" IS NULL) AND ("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL) AND ("primary_for_locale" IS FALSE) AND ("locale" IS NULL))))
);


--
-- Name: event_alias_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."event_alias_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: event_alias_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."event_alias_id_seq" OWNED BY "musicbrainz"."event_alias"."id";


--
-- Name: event_alias_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."event_alias_type" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: event_alias_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."event_alias_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: event_alias_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."event_alias_type_id_seq" OWNED BY "musicbrainz"."event_alias_type"."id";


--
-- Name: event_annotation; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."event_annotation" (
    "event" integer NOT NULL,
    "annotation" integer NOT NULL
);


--
-- Name: event_attribute; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."event_attribute" (
    "id" integer NOT NULL,
    "event" integer NOT NULL,
    "event_attribute_type" integer NOT NULL,
    "event_attribute_type_allowed_value" integer,
    "event_attribute_text" "text",
    CONSTRAINT "event_attribute_check" CHECK (((("event_attribute_type_allowed_value" IS NULL) AND ("event_attribute_text" IS NOT NULL)) OR (("event_attribute_type_allowed_value" IS NOT NULL) AND ("event_attribute_text" IS NULL))))
);


--
-- Name: event_attribute_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."event_attribute_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: event_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."event_attribute_id_seq" OWNED BY "musicbrainz"."event_attribute"."id";


--
-- Name: event_attribute_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."event_attribute_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "free_text" boolean NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: event_attribute_type_allowed_value; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."event_attribute_type_allowed_value" (
    "id" integer NOT NULL,
    "event_attribute_type" integer NOT NULL,
    "value" "text",
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: event_attribute_type_allowed_value_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."event_attribute_type_allowed_value_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: event_attribute_type_allowed_value_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."event_attribute_type_allowed_value_id_seq" OWNED BY "musicbrainz"."event_attribute_type_allowed_value"."id";


--
-- Name: event_attribute_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."event_attribute_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: event_attribute_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."event_attribute_type_id_seq" OWNED BY "musicbrainz"."event_attribute_type"."id";


--
-- Name: event_gid_redirect; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."event_gid_redirect" (
    "gid" "uuid" NOT NULL,
    "new_id" integer NOT NULL,
    "created" timestamp with time zone DEFAULT "now"()
);


--
-- Name: event_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."event_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: event_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."event_id_seq" OWNED BY "musicbrainz"."event"."id";


--
-- Name: event_meta; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."event_meta" (
    "id" integer NOT NULL,
    "rating" smallint,
    "rating_count" integer,
    "event_art_presence" "musicbrainz"."event_art_presence" DEFAULT 'absent'::"musicbrainz"."event_art_presence" NOT NULL,
    CONSTRAINT "event_meta_rating_check" CHECK ((("rating" >= 0) AND ("rating" <= 100)))
);


--
-- Name: event_rating_raw; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."event_rating_raw" (
    "event" integer NOT NULL,
    "editor" integer NOT NULL,
    "rating" smallint NOT NULL,
    CONSTRAINT "event_rating_raw_rating_check" CHECK ((("rating" >= 0) AND ("rating" <= 100)))
);


--
-- Name: l_event_series; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_event_series" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_event_series_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_event_series_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: event_series; Type: VIEW; Schema: musicbrainz; Owner: -
--

CREATE VIEW "musicbrainz"."event_series" AS
 SELECT "lrs"."entity0" AS "event",
    "lrs"."entity1" AS "series",
    "lrs"."id" AS "relationship",
    "lrs"."link_order",
    "lrs"."link",
    COALESCE("latv"."text_value", ''::"text") AS "text_value"
   FROM (((("musicbrainz"."l_event_series" "lrs"
     JOIN "musicbrainz"."series" "s" ON (("s"."id" = "lrs"."entity1")))
     JOIN "musicbrainz"."link" "l" ON (("l"."id" = "lrs"."link")))
     JOIN "musicbrainz"."link_type" "lt" ON ((("lt"."id" = "l"."link_type") AND ("lt"."gid" = '707d947d-9563-328a-9a7d-0c5b9c3a9791'::"uuid"))))
     LEFT JOIN "musicbrainz"."link_attribute_text_value" "latv" ON ((("latv"."attribute_type" = 788) AND ("latv"."link" = "l"."id"))))
  ORDER BY "lrs"."entity1", "lrs"."link_order";


--
-- Name: event_tag; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."event_tag" (
    "event" integer NOT NULL,
    "tag" integer NOT NULL,
    "count" integer NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"()
);


--
-- Name: event_tag_raw; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."event_tag_raw" (
    "event" integer NOT NULL,
    "editor" integer NOT NULL,
    "tag" integer NOT NULL,
    "is_upvote" boolean DEFAULT true NOT NULL
);


--
-- Name: event_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."event_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: event_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."event_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: event_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."event_type_id_seq" OWNED BY "musicbrainz"."event_type"."id";


--
-- Name: gender; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."gender" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: gender_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."gender_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gender_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."gender_id_seq" OWNED BY "musicbrainz"."gender"."id";


--
-- Name: genre; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."genre" (
    "id" integer NOT NULL,
    "gid" "uuid" NOT NULL,
    "name" character varying NOT NULL,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "genre_edits_pending_check" CHECK (("edits_pending" >= 0))
);


--
-- Name: genre_alias; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."genre_alias" (
    "id" integer NOT NULL,
    "genre" integer NOT NULL,
    "name" character varying NOT NULL,
    "locale" "text",
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "type" integer,
    "sort_name" character varying NOT NULL,
    "begin_date_year" smallint,
    "begin_date_month" smallint,
    "begin_date_day" smallint,
    "end_date_year" smallint,
    "end_date_month" smallint,
    "end_date_day" smallint,
    "primary_for_locale" boolean DEFAULT false NOT NULL,
    "ended" boolean DEFAULT false NOT NULL,
    CONSTRAINT "genre_alias_check" CHECK ((((("end_date_year" IS NOT NULL) OR ("end_date_month" IS NOT NULL) OR ("end_date_day" IS NOT NULL)) AND ("ended" = true)) OR (("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL)))),
    CONSTRAINT "genre_alias_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "primary_check" CHECK (((("locale" IS NULL) AND ("primary_for_locale" IS FALSE)) OR ("locale" IS NOT NULL))),
    CONSTRAINT "search_hints_are_empty" CHECK ((("type" <> 2) OR (("type" = 2) AND (("sort_name")::"text" = ("name")::"text") AND ("begin_date_year" IS NULL) AND ("begin_date_month" IS NULL) AND ("begin_date_day" IS NULL) AND ("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL) AND ("primary_for_locale" IS FALSE) AND ("locale" IS NULL))))
);


--
-- Name: genre_alias_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."genre_alias_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: genre_alias_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."genre_alias_id_seq" OWNED BY "musicbrainz"."genre_alias"."id";


--
-- Name: genre_alias_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."genre_alias_type" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: genre_alias_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."genre_alias_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: genre_alias_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."genre_alias_type_id_seq" OWNED BY "musicbrainz"."genre_alias_type"."id";


--
-- Name: genre_annotation; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."genre_annotation" (
    "genre" integer NOT NULL,
    "annotation" integer NOT NULL
);


--
-- Name: genre_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."genre_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: genre_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."genre_id_seq" OWNED BY "musicbrainz"."genre"."id";


--
-- Name: instrument; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."instrument" (
    "id" integer NOT NULL,
    "gid" "uuid" NOT NULL,
    "name" character varying NOT NULL,
    "type" integer,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "description" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "instrument_edits_pending_check" CHECK (("edits_pending" >= 0))
);


--
-- Name: instrument_alias; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."instrument_alias" (
    "id" integer NOT NULL,
    "instrument" integer NOT NULL,
    "name" character varying NOT NULL,
    "locale" "text",
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "type" integer,
    "sort_name" character varying NOT NULL,
    "begin_date_year" smallint,
    "begin_date_month" smallint,
    "begin_date_day" smallint,
    "end_date_year" smallint,
    "end_date_month" smallint,
    "end_date_day" smallint,
    "primary_for_locale" boolean DEFAULT false NOT NULL,
    "ended" boolean DEFAULT false NOT NULL,
    CONSTRAINT "instrument_alias_check" CHECK ((((("end_date_year" IS NOT NULL) OR ("end_date_month" IS NOT NULL) OR ("end_date_day" IS NOT NULL)) AND ("ended" = true)) OR (("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL)))),
    CONSTRAINT "instrument_alias_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "primary_check" CHECK (((("locale" IS NULL) AND ("primary_for_locale" IS FALSE)) OR ("locale" IS NOT NULL))),
    CONSTRAINT "search_hints_are_empty" CHECK ((("type" <> 2) OR (("type" = 2) AND (("sort_name")::"text" = ("name")::"text") AND ("begin_date_year" IS NULL) AND ("begin_date_month" IS NULL) AND ("begin_date_day" IS NULL) AND ("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL) AND ("primary_for_locale" IS FALSE) AND ("locale" IS NULL))))
);


--
-- Name: instrument_alias_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."instrument_alias_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: instrument_alias_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."instrument_alias_id_seq" OWNED BY "musicbrainz"."instrument_alias"."id";


--
-- Name: instrument_alias_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."instrument_alias_type" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: instrument_alias_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."instrument_alias_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: instrument_alias_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."instrument_alias_type_id_seq" OWNED BY "musicbrainz"."instrument_alias_type"."id";


--
-- Name: instrument_annotation; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."instrument_annotation" (
    "instrument" integer NOT NULL,
    "annotation" integer NOT NULL
);


--
-- Name: instrument_attribute; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."instrument_attribute" (
    "id" integer NOT NULL,
    "instrument" integer NOT NULL,
    "instrument_attribute_type" integer NOT NULL,
    "instrument_attribute_type_allowed_value" integer,
    "instrument_attribute_text" "text",
    CONSTRAINT "instrument_attribute_check" CHECK (((("instrument_attribute_type_allowed_value" IS NULL) AND ("instrument_attribute_text" IS NOT NULL)) OR (("instrument_attribute_type_allowed_value" IS NOT NULL) AND ("instrument_attribute_text" IS NULL))))
);


--
-- Name: instrument_attribute_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."instrument_attribute_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: instrument_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."instrument_attribute_id_seq" OWNED BY "musicbrainz"."instrument_attribute"."id";


--
-- Name: instrument_attribute_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."instrument_attribute_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "free_text" boolean NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: instrument_attribute_type_allowed_value; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."instrument_attribute_type_allowed_value" (
    "id" integer NOT NULL,
    "instrument_attribute_type" integer NOT NULL,
    "value" "text",
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: instrument_attribute_type_allowed_value_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."instrument_attribute_type_allowed_value_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: instrument_attribute_type_allowed_value_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."instrument_attribute_type_allowed_value_id_seq" OWNED BY "musicbrainz"."instrument_attribute_type_allowed_value"."id";


--
-- Name: instrument_attribute_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."instrument_attribute_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: instrument_attribute_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."instrument_attribute_type_id_seq" OWNED BY "musicbrainz"."instrument_attribute_type"."id";


--
-- Name: instrument_gid_redirect; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."instrument_gid_redirect" (
    "gid" "uuid" NOT NULL,
    "new_id" integer NOT NULL,
    "created" timestamp with time zone DEFAULT "now"()
);


--
-- Name: instrument_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."instrument_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: instrument_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."instrument_id_seq" OWNED BY "musicbrainz"."instrument"."id";


--
-- Name: instrument_tag; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."instrument_tag" (
    "instrument" integer NOT NULL,
    "tag" integer NOT NULL,
    "count" integer NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"()
);


--
-- Name: instrument_tag_raw; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."instrument_tag_raw" (
    "instrument" integer NOT NULL,
    "editor" integer NOT NULL,
    "tag" integer NOT NULL,
    "is_upvote" boolean DEFAULT true NOT NULL
);


--
-- Name: instrument_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."instrument_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: instrument_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."instrument_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: instrument_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."instrument_type_id_seq" OWNED BY "musicbrainz"."instrument_type"."id";


--
-- Name: iso_3166_1; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."iso_3166_1" (
    "area" integer NOT NULL,
    "code" character(2) NOT NULL
);


--
-- Name: iso_3166_2; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."iso_3166_2" (
    "area" integer NOT NULL,
    "code" character varying(10) NOT NULL
);


--
-- Name: iso_3166_3; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."iso_3166_3" (
    "area" integer NOT NULL,
    "code" character(4) NOT NULL
);


--
-- Name: isrc; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."isrc" (
    "id" integer NOT NULL,
    "recording" integer NOT NULL,
    "isrc" character(12) NOT NULL,
    "source" smallint,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "created" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "isrc_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "isrc_isrc_check" CHECK (("isrc" ~ '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$'::"text"))
);


--
-- Name: isrc_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."isrc_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: isrc_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."isrc_id_seq" OWNED BY "musicbrainz"."isrc"."id";


--
-- Name: iswc; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."iswc" (
    "id" integer NOT NULL,
    "work" integer NOT NULL,
    "iswc" character(15),
    "source" smallint,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "created" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "iswc_iswc_check" CHECK (("iswc" ~ '^T-?\d{3}.?\d{3}.?\d{3}[-.]?\d$'::"text"))
);


--
-- Name: iswc_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."iswc_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: iswc_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."iswc_id_seq" OWNED BY "musicbrainz"."iswc"."id";


--
-- Name: l_area_area; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_area_area" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_area_area_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_area_area_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_area_area_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_area_area_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_area_area_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_area_area_id_seq" OWNED BY "musicbrainz"."l_area_area"."id";


--
-- Name: l_area_artist; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_area_artist" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_area_artist_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_area_artist_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_area_artist_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_area_artist_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_area_artist_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_area_artist_id_seq" OWNED BY "musicbrainz"."l_area_artist"."id";


--
-- Name: l_area_event; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_area_event" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_area_event_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_area_event_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_area_event_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_area_event_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_area_event_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_area_event_id_seq" OWNED BY "musicbrainz"."l_area_event"."id";


--
-- Name: l_area_genre; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_area_genre" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_area_genre_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_area_genre_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_area_genre_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_area_genre_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_area_genre_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_area_genre_id_seq" OWNED BY "musicbrainz"."l_area_genre"."id";


--
-- Name: l_area_instrument; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_area_instrument" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_area_instrument_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_area_instrument_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_area_instrument_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_area_instrument_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_area_instrument_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_area_instrument_id_seq" OWNED BY "musicbrainz"."l_area_instrument"."id";


--
-- Name: l_area_label; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_area_label" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_area_label_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_area_label_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_area_label_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_area_label_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_area_label_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_area_label_id_seq" OWNED BY "musicbrainz"."l_area_label"."id";


--
-- Name: l_area_mood; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_area_mood" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_area_mood_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_area_mood_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_area_mood_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_area_mood_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_area_mood_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_area_mood_id_seq" OWNED BY "musicbrainz"."l_area_mood"."id";


--
-- Name: l_area_place; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_area_place" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_area_place_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_area_place_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_area_place_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_area_place_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_area_place_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_area_place_id_seq" OWNED BY "musicbrainz"."l_area_place"."id";


--
-- Name: l_area_recording; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_area_recording" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_area_recording_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_area_recording_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_area_recording_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_area_recording_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_area_recording_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_area_recording_id_seq" OWNED BY "musicbrainz"."l_area_recording"."id";


--
-- Name: l_area_release; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_area_release" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_area_release_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_area_release_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_area_release_group; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_area_release_group" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_area_release_group_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_area_release_group_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_area_release_group_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_area_release_group_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_area_release_group_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_area_release_group_id_seq" OWNED BY "musicbrainz"."l_area_release_group"."id";


--
-- Name: l_area_release_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_area_release_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_area_release_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_area_release_id_seq" OWNED BY "musicbrainz"."l_area_release"."id";


--
-- Name: l_area_series; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_area_series" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_area_series_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_area_series_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_area_series_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_area_series_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_area_series_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_area_series_id_seq" OWNED BY "musicbrainz"."l_area_series"."id";


--
-- Name: l_area_url; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_area_url" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_area_url_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_area_url_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_area_url_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_area_url_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_area_url_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_area_url_id_seq" OWNED BY "musicbrainz"."l_area_url"."id";


--
-- Name: l_area_work; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_area_work" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_area_work_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_area_work_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_area_work_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_area_work_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_area_work_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_area_work_id_seq" OWNED BY "musicbrainz"."l_area_work"."id";


--
-- Name: l_artist_artist; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_artist_artist" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_artist_artist_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_artist_artist_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_artist_artist_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_artist_artist_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_artist_artist_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_artist_artist_id_seq" OWNED BY "musicbrainz"."l_artist_artist"."id";


--
-- Name: l_artist_event; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_artist_event" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_artist_event_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_artist_event_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_artist_event_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_artist_event_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_artist_event_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_artist_event_id_seq" OWNED BY "musicbrainz"."l_artist_event"."id";


--
-- Name: l_artist_genre; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_artist_genre" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_artist_genre_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_artist_genre_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_artist_genre_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_artist_genre_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_artist_genre_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_artist_genre_id_seq" OWNED BY "musicbrainz"."l_artist_genre"."id";


--
-- Name: l_artist_instrument; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_artist_instrument" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_artist_instrument_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_artist_instrument_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_artist_instrument_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_artist_instrument_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_artist_instrument_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_artist_instrument_id_seq" OWNED BY "musicbrainz"."l_artist_instrument"."id";


--
-- Name: l_artist_label; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_artist_label" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_artist_label_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_artist_label_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_artist_label_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_artist_label_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_artist_label_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_artist_label_id_seq" OWNED BY "musicbrainz"."l_artist_label"."id";


--
-- Name: l_artist_mood; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_artist_mood" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_artist_mood_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_artist_mood_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_artist_mood_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_artist_mood_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_artist_mood_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_artist_mood_id_seq" OWNED BY "musicbrainz"."l_artist_mood"."id";


--
-- Name: l_artist_place; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_artist_place" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_artist_place_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_artist_place_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_artist_place_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_artist_place_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_artist_place_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_artist_place_id_seq" OWNED BY "musicbrainz"."l_artist_place"."id";


--
-- Name: l_artist_recording; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_artist_recording" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_artist_recording_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_artist_recording_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_artist_recording_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_artist_recording_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_artist_recording_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_artist_recording_id_seq" OWNED BY "musicbrainz"."l_artist_recording"."id";


--
-- Name: l_artist_release; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_artist_release" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_artist_release_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_artist_release_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_artist_release_group; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_artist_release_group" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_artist_release_group_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_artist_release_group_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_artist_release_group_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_artist_release_group_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_artist_release_group_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_artist_release_group_id_seq" OWNED BY "musicbrainz"."l_artist_release_group"."id";


--
-- Name: l_artist_release_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_artist_release_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_artist_release_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_artist_release_id_seq" OWNED BY "musicbrainz"."l_artist_release"."id";


--
-- Name: l_artist_series_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_artist_series_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_artist_series_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_artist_series_id_seq" OWNED BY "musicbrainz"."l_artist_series"."id";


--
-- Name: l_artist_url; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_artist_url" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_artist_url_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_artist_url_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_artist_url_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_artist_url_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_artist_url_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_artist_url_id_seq" OWNED BY "musicbrainz"."l_artist_url"."id";


--
-- Name: l_artist_work; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_artist_work" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_artist_work_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_artist_work_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_artist_work_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_artist_work_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_artist_work_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_artist_work_id_seq" OWNED BY "musicbrainz"."l_artist_work"."id";


--
-- Name: l_event_event; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_event_event" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_event_event_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_event_event_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_event_event_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_event_event_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_event_event_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_event_event_id_seq" OWNED BY "musicbrainz"."l_event_event"."id";


--
-- Name: l_event_genre; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_event_genre" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_event_genre_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_event_genre_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_event_genre_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_event_genre_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_event_genre_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_event_genre_id_seq" OWNED BY "musicbrainz"."l_event_genre"."id";


--
-- Name: l_event_instrument; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_event_instrument" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_event_instrument_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_event_instrument_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_event_instrument_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_event_instrument_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_event_instrument_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_event_instrument_id_seq" OWNED BY "musicbrainz"."l_event_instrument"."id";


--
-- Name: l_event_label; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_event_label" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_event_label_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_event_label_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_event_label_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_event_label_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_event_label_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_event_label_id_seq" OWNED BY "musicbrainz"."l_event_label"."id";


--
-- Name: l_event_mood; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_event_mood" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_event_mood_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_event_mood_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_event_mood_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_event_mood_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_event_mood_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_event_mood_id_seq" OWNED BY "musicbrainz"."l_event_mood"."id";


--
-- Name: l_event_place; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_event_place" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_event_place_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_event_place_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_event_place_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_event_place_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_event_place_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_event_place_id_seq" OWNED BY "musicbrainz"."l_event_place"."id";


--
-- Name: l_event_recording; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_event_recording" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_event_recording_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_event_recording_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_event_recording_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_event_recording_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_event_recording_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_event_recording_id_seq" OWNED BY "musicbrainz"."l_event_recording"."id";


--
-- Name: l_event_release; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_event_release" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_event_release_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_event_release_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_event_release_group; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_event_release_group" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_event_release_group_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_event_release_group_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_event_release_group_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_event_release_group_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_event_release_group_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_event_release_group_id_seq" OWNED BY "musicbrainz"."l_event_release_group"."id";


--
-- Name: l_event_release_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_event_release_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_event_release_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_event_release_id_seq" OWNED BY "musicbrainz"."l_event_release"."id";


--
-- Name: l_event_series_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_event_series_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_event_series_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_event_series_id_seq" OWNED BY "musicbrainz"."l_event_series"."id";


--
-- Name: l_event_url; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_event_url" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_event_url_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_event_url_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_event_url_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_event_url_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_event_url_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_event_url_id_seq" OWNED BY "musicbrainz"."l_event_url"."id";


--
-- Name: l_event_work; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_event_work" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_event_work_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_event_work_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_event_work_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_event_work_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_event_work_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_event_work_id_seq" OWNED BY "musicbrainz"."l_event_work"."id";


--
-- Name: l_genre_genre; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_genre_genre" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_genre_genre_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_genre_genre_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_genre_genre_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_genre_genre_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_genre_genre_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_genre_genre_id_seq" OWNED BY "musicbrainz"."l_genre_genre"."id";


--
-- Name: l_genre_instrument; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_genre_instrument" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_genre_instrument_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_genre_instrument_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_genre_instrument_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_genre_instrument_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_genre_instrument_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_genre_instrument_id_seq" OWNED BY "musicbrainz"."l_genre_instrument"."id";


--
-- Name: l_genre_label; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_genre_label" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_genre_label_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_genre_label_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_genre_label_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_genre_label_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_genre_label_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_genre_label_id_seq" OWNED BY "musicbrainz"."l_genre_label"."id";


--
-- Name: l_genre_mood; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_genre_mood" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_genre_mood_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_genre_mood_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_genre_mood_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_genre_mood_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_genre_mood_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_genre_mood_id_seq" OWNED BY "musicbrainz"."l_genre_mood"."id";


--
-- Name: l_genre_place; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_genre_place" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_genre_place_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_genre_place_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_genre_place_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_genre_place_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_genre_place_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_genre_place_id_seq" OWNED BY "musicbrainz"."l_genre_place"."id";


--
-- Name: l_genre_recording; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_genre_recording" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_genre_recording_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_genre_recording_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_genre_recording_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_genre_recording_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_genre_recording_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_genre_recording_id_seq" OWNED BY "musicbrainz"."l_genre_recording"."id";


--
-- Name: l_genre_release; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_genre_release" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_genre_release_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_genre_release_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_genre_release_group; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_genre_release_group" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_genre_release_group_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_genre_release_group_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_genre_release_group_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_genre_release_group_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_genre_release_group_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_genre_release_group_id_seq" OWNED BY "musicbrainz"."l_genre_release_group"."id";


--
-- Name: l_genre_release_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_genre_release_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_genre_release_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_genre_release_id_seq" OWNED BY "musicbrainz"."l_genre_release"."id";


--
-- Name: l_genre_series; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_genre_series" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_genre_series_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_genre_series_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_genre_series_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_genre_series_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_genre_series_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_genre_series_id_seq" OWNED BY "musicbrainz"."l_genre_series"."id";


--
-- Name: l_genre_url; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_genre_url" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_genre_url_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_genre_url_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_genre_url_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_genre_url_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_genre_url_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_genre_url_id_seq" OWNED BY "musicbrainz"."l_genre_url"."id";


--
-- Name: l_genre_work; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_genre_work" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_genre_work_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_genre_work_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_genre_work_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_genre_work_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_genre_work_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_genre_work_id_seq" OWNED BY "musicbrainz"."l_genre_work"."id";


--
-- Name: l_instrument_instrument; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_instrument_instrument" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_instrument_instrument_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_instrument_instrument_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_instrument_instrument_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_instrument_instrument_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_instrument_instrument_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_instrument_instrument_id_seq" OWNED BY "musicbrainz"."l_instrument_instrument"."id";


--
-- Name: l_instrument_label; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_instrument_label" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_instrument_label_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_instrument_label_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_instrument_label_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_instrument_label_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_instrument_label_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_instrument_label_id_seq" OWNED BY "musicbrainz"."l_instrument_label"."id";


--
-- Name: l_instrument_mood; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_instrument_mood" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_instrument_mood_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_instrument_mood_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_instrument_mood_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_instrument_mood_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_instrument_mood_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_instrument_mood_id_seq" OWNED BY "musicbrainz"."l_instrument_mood"."id";


--
-- Name: l_instrument_place; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_instrument_place" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_instrument_place_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_instrument_place_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_instrument_place_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_instrument_place_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_instrument_place_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_instrument_place_id_seq" OWNED BY "musicbrainz"."l_instrument_place"."id";


--
-- Name: l_instrument_recording; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_instrument_recording" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_instrument_recording_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_instrument_recording_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_instrument_recording_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_instrument_recording_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_instrument_recording_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_instrument_recording_id_seq" OWNED BY "musicbrainz"."l_instrument_recording"."id";


--
-- Name: l_instrument_release; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_instrument_release" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_instrument_release_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_instrument_release_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_instrument_release_group; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_instrument_release_group" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_instrument_release_group_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_instrument_release_group_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_instrument_release_group_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_instrument_release_group_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_instrument_release_group_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_instrument_release_group_id_seq" OWNED BY "musicbrainz"."l_instrument_release_group"."id";


--
-- Name: l_instrument_release_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_instrument_release_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_instrument_release_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_instrument_release_id_seq" OWNED BY "musicbrainz"."l_instrument_release"."id";


--
-- Name: l_instrument_series; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_instrument_series" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_instrument_series_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_instrument_series_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_instrument_series_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_instrument_series_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_instrument_series_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_instrument_series_id_seq" OWNED BY "musicbrainz"."l_instrument_series"."id";


--
-- Name: l_instrument_url; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_instrument_url" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_instrument_url_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_instrument_url_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_instrument_url_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_instrument_url_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_instrument_url_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_instrument_url_id_seq" OWNED BY "musicbrainz"."l_instrument_url"."id";


--
-- Name: l_instrument_work; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_instrument_work" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_instrument_work_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_instrument_work_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_instrument_work_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_instrument_work_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_instrument_work_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_instrument_work_id_seq" OWNED BY "musicbrainz"."l_instrument_work"."id";


--
-- Name: l_label_label; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_label_label" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_label_label_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_label_label_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_label_label_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_label_label_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_label_label_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_label_label_id_seq" OWNED BY "musicbrainz"."l_label_label"."id";


--
-- Name: l_label_mood; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_label_mood" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_label_mood_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_label_mood_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_label_mood_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_label_mood_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_label_mood_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_label_mood_id_seq" OWNED BY "musicbrainz"."l_label_mood"."id";


--
-- Name: l_label_place; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_label_place" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_label_place_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_label_place_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_label_place_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_label_place_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_label_place_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_label_place_id_seq" OWNED BY "musicbrainz"."l_label_place"."id";


--
-- Name: l_label_recording; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_label_recording" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_label_recording_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_label_recording_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_label_recording_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_label_recording_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_label_recording_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_label_recording_id_seq" OWNED BY "musicbrainz"."l_label_recording"."id";


--
-- Name: l_label_release; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_label_release" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_label_release_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_label_release_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_label_release_group; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_label_release_group" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_label_release_group_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_label_release_group_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_label_release_group_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_label_release_group_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_label_release_group_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_label_release_group_id_seq" OWNED BY "musicbrainz"."l_label_release_group"."id";


--
-- Name: l_label_release_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_label_release_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_label_release_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_label_release_id_seq" OWNED BY "musicbrainz"."l_label_release"."id";


--
-- Name: l_label_series; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_label_series" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_label_series_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_label_series_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_label_series_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_label_series_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_label_series_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_label_series_id_seq" OWNED BY "musicbrainz"."l_label_series"."id";


--
-- Name: l_label_url; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_label_url" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_label_url_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_label_url_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_label_url_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_label_url_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_label_url_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_label_url_id_seq" OWNED BY "musicbrainz"."l_label_url"."id";


--
-- Name: l_label_work; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_label_work" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_label_work_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_label_work_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_label_work_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_label_work_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_label_work_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_label_work_id_seq" OWNED BY "musicbrainz"."l_label_work"."id";


--
-- Name: l_mood_mood; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_mood_mood" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_mood_mood_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_mood_mood_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_mood_mood_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_mood_mood_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_mood_mood_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_mood_mood_id_seq" OWNED BY "musicbrainz"."l_mood_mood"."id";


--
-- Name: l_mood_place; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_mood_place" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_mood_place_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_mood_place_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_mood_place_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_mood_place_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_mood_place_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_mood_place_id_seq" OWNED BY "musicbrainz"."l_mood_place"."id";


--
-- Name: l_mood_recording; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_mood_recording" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_mood_recording_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_mood_recording_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_mood_recording_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_mood_recording_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_mood_recording_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_mood_recording_id_seq" OWNED BY "musicbrainz"."l_mood_recording"."id";


--
-- Name: l_mood_release; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_mood_release" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_mood_release_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_mood_release_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_mood_release_group; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_mood_release_group" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_mood_release_group_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_mood_release_group_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_mood_release_group_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_mood_release_group_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_mood_release_group_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_mood_release_group_id_seq" OWNED BY "musicbrainz"."l_mood_release_group"."id";


--
-- Name: l_mood_release_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_mood_release_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_mood_release_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_mood_release_id_seq" OWNED BY "musicbrainz"."l_mood_release"."id";


--
-- Name: l_mood_series; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_mood_series" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_mood_series_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_mood_series_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_mood_series_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_mood_series_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_mood_series_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_mood_series_id_seq" OWNED BY "musicbrainz"."l_mood_series"."id";


--
-- Name: l_mood_url; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_mood_url" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_mood_url_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_mood_url_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_mood_url_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_mood_url_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_mood_url_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_mood_url_id_seq" OWNED BY "musicbrainz"."l_mood_url"."id";


--
-- Name: l_mood_work; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_mood_work" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_mood_work_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_mood_work_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_mood_work_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_mood_work_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_mood_work_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_mood_work_id_seq" OWNED BY "musicbrainz"."l_mood_work"."id";


--
-- Name: l_place_place; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_place_place" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_place_place_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_place_place_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_place_place_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_place_place_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_place_place_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_place_place_id_seq" OWNED BY "musicbrainz"."l_place_place"."id";


--
-- Name: l_place_recording; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_place_recording" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_place_recording_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_place_recording_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_place_recording_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_place_recording_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_place_recording_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_place_recording_id_seq" OWNED BY "musicbrainz"."l_place_recording"."id";


--
-- Name: l_place_release; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_place_release" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_place_release_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_place_release_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_place_release_group; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_place_release_group" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_place_release_group_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_place_release_group_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_place_release_group_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_place_release_group_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_place_release_group_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_place_release_group_id_seq" OWNED BY "musicbrainz"."l_place_release_group"."id";


--
-- Name: l_place_release_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_place_release_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_place_release_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_place_release_id_seq" OWNED BY "musicbrainz"."l_place_release"."id";


--
-- Name: l_place_series; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_place_series" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_place_series_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_place_series_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_place_series_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_place_series_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_place_series_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_place_series_id_seq" OWNED BY "musicbrainz"."l_place_series"."id";


--
-- Name: l_place_url; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_place_url" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_place_url_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_place_url_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_place_url_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_place_url_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_place_url_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_place_url_id_seq" OWNED BY "musicbrainz"."l_place_url"."id";


--
-- Name: l_place_work; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_place_work" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_place_work_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_place_work_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_place_work_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_place_work_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_place_work_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_place_work_id_seq" OWNED BY "musicbrainz"."l_place_work"."id";


--
-- Name: l_recording_recording; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_recording_recording" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_recording_recording_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_recording_recording_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_recording_recording_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_recording_recording_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_recording_recording_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_recording_recording_id_seq" OWNED BY "musicbrainz"."l_recording_recording"."id";


--
-- Name: l_recording_release; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_recording_release" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_recording_release_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_recording_release_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_recording_release_group; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_recording_release_group" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_recording_release_group_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_recording_release_group_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_recording_release_group_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_recording_release_group_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_recording_release_group_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_recording_release_group_id_seq" OWNED BY "musicbrainz"."l_recording_release_group"."id";


--
-- Name: l_recording_release_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_recording_release_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_recording_release_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_recording_release_id_seq" OWNED BY "musicbrainz"."l_recording_release"."id";


--
-- Name: l_recording_series; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_recording_series" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_recording_series_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_recording_series_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_recording_series_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_recording_series_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_recording_series_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_recording_series_id_seq" OWNED BY "musicbrainz"."l_recording_series"."id";


--
-- Name: l_recording_url; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_recording_url" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_recording_url_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_recording_url_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_recording_url_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_recording_url_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_recording_url_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_recording_url_id_seq" OWNED BY "musicbrainz"."l_recording_url"."id";


--
-- Name: l_recording_work; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_recording_work" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_recording_work_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_recording_work_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_recording_work_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_recording_work_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_recording_work_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_recording_work_id_seq" OWNED BY "musicbrainz"."l_recording_work"."id";


--
-- Name: l_release_group_release_group; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_release_group_release_group" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_release_group_release_group_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_release_group_release_group_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_release_group_release_group_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_release_group_release_group_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_release_group_release_group_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_release_group_release_group_id_seq" OWNED BY "musicbrainz"."l_release_group_release_group"."id";


--
-- Name: l_release_group_series; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_release_group_series" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_release_group_series_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_release_group_series_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_release_group_series_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_release_group_series_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_release_group_series_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_release_group_series_id_seq" OWNED BY "musicbrainz"."l_release_group_series"."id";


--
-- Name: l_release_group_url; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_release_group_url" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_release_group_url_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_release_group_url_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_release_group_url_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_release_group_url_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_release_group_url_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_release_group_url_id_seq" OWNED BY "musicbrainz"."l_release_group_url"."id";


--
-- Name: l_release_group_work; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_release_group_work" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_release_group_work_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_release_group_work_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_release_group_work_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_release_group_work_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_release_group_work_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_release_group_work_id_seq" OWNED BY "musicbrainz"."l_release_group_work"."id";


--
-- Name: l_release_release; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_release_release" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_release_release_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_release_release_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_release_release_group; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_release_release_group" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_release_release_group_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_release_release_group_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_release_release_group_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_release_release_group_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_release_release_group_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_release_release_group_id_seq" OWNED BY "musicbrainz"."l_release_release_group"."id";


--
-- Name: l_release_release_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_release_release_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_release_release_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_release_release_id_seq" OWNED BY "musicbrainz"."l_release_release"."id";


--
-- Name: l_release_series; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_release_series" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_release_series_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_release_series_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_release_series_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_release_series_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_release_series_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_release_series_id_seq" OWNED BY "musicbrainz"."l_release_series"."id";


--
-- Name: l_release_url; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_release_url" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_release_url_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_release_url_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_release_url_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_release_url_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_release_url_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_release_url_id_seq" OWNED BY "musicbrainz"."l_release_url"."id";


--
-- Name: l_release_work; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_release_work" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_release_work_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_release_work_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_release_work_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_release_work_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_release_work_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_release_work_id_seq" OWNED BY "musicbrainz"."l_release_work"."id";


--
-- Name: l_series_series; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_series_series" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_series_series_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_series_series_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_series_series_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_series_series_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_series_series_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_series_series_id_seq" OWNED BY "musicbrainz"."l_series_series"."id";


--
-- Name: l_series_url; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_series_url" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_series_url_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_series_url_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_series_url_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_series_url_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_series_url_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_series_url_id_seq" OWNED BY "musicbrainz"."l_series_url"."id";


--
-- Name: l_series_work; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_series_work" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_series_work_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_series_work_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_series_work_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_series_work_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_series_work_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_series_work_id_seq" OWNED BY "musicbrainz"."l_series_work"."id";


--
-- Name: l_url_url; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_url_url" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_url_url_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_url_url_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_url_url_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_url_url_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_url_url_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_url_url_id_seq" OWNED BY "musicbrainz"."l_url_url"."id";


--
-- Name: l_url_work; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_url_work" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_url_work_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_url_work_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_url_work_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_url_work_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_url_work_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_url_work_id_seq" OWNED BY "musicbrainz"."l_url_work"."id";


--
-- Name: l_work_work; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."l_work_work" (
    "id" integer NOT NULL,
    "link" integer NOT NULL,
    "entity0" integer NOT NULL,
    "entity1" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "link_order" integer DEFAULT 0 NOT NULL,
    "entity0_credit" "text" DEFAULT ''::"text" NOT NULL,
    "entity1_credit" "text" DEFAULT ''::"text" NOT NULL,
    CONSTRAINT "l_work_work_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "l_work_work_link_order_check" CHECK (("link_order" >= 0))
);


--
-- Name: l_work_work_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."l_work_work_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: l_work_work_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."l_work_work_id_seq" OWNED BY "musicbrainz"."l_work_work"."id";


--
-- Name: label; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."label" (
    "id" integer NOT NULL,
    "gid" "uuid" NOT NULL,
    "name" character varying NOT NULL,
    "begin_date_year" smallint,
    "begin_date_month" smallint,
    "begin_date_day" smallint,
    "end_date_year" smallint,
    "end_date_month" smallint,
    "end_date_day" smallint,
    "label_code" integer,
    "type" integer,
    "area" integer,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "ended" boolean DEFAULT false NOT NULL,
    CONSTRAINT "label_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "label_ended_check" CHECK ((((("end_date_year" IS NOT NULL) OR ("end_date_month" IS NOT NULL) OR ("end_date_day" IS NOT NULL)) AND ("ended" = true)) OR (("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL))))
);


--
-- Name: label_alias; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."label_alias" (
    "id" integer NOT NULL,
    "label" integer NOT NULL,
    "name" character varying NOT NULL,
    "locale" "text",
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "type" integer,
    "sort_name" character varying NOT NULL,
    "begin_date_year" smallint,
    "begin_date_month" smallint,
    "begin_date_day" smallint,
    "end_date_year" smallint,
    "end_date_month" smallint,
    "end_date_day" smallint,
    "primary_for_locale" boolean DEFAULT false NOT NULL,
    "ended" boolean DEFAULT false NOT NULL,
    CONSTRAINT "label_alias_check" CHECK ((((("end_date_year" IS NOT NULL) OR ("end_date_month" IS NOT NULL) OR ("end_date_day" IS NOT NULL)) AND ("ended" = true)) OR (("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL)))),
    CONSTRAINT "label_alias_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "primary_check" CHECK (((("locale" IS NULL) AND ("primary_for_locale" IS FALSE)) OR ("locale" IS NOT NULL))),
    CONSTRAINT "search_hints_are_empty" CHECK ((("type" <> 2) OR (("type" = 2) AND (("sort_name")::"text" = ("name")::"text") AND ("begin_date_year" IS NULL) AND ("begin_date_month" IS NULL) AND ("begin_date_day" IS NULL) AND ("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL) AND ("primary_for_locale" IS FALSE) AND ("locale" IS NULL))))
);


--
-- Name: label_alias_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."label_alias_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: label_alias_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."label_alias_id_seq" OWNED BY "musicbrainz"."label_alias"."id";


--
-- Name: label_alias_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."label_alias_type" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: label_alias_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."label_alias_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: label_alias_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."label_alias_type_id_seq" OWNED BY "musicbrainz"."label_alias_type"."id";


--
-- Name: label_annotation; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."label_annotation" (
    "label" integer NOT NULL,
    "annotation" integer NOT NULL
);


--
-- Name: label_attribute; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."label_attribute" (
    "id" integer NOT NULL,
    "label" integer NOT NULL,
    "label_attribute_type" integer NOT NULL,
    "label_attribute_type_allowed_value" integer,
    "label_attribute_text" "text",
    CONSTRAINT "label_attribute_check" CHECK (((("label_attribute_type_allowed_value" IS NULL) AND ("label_attribute_text" IS NOT NULL)) OR (("label_attribute_type_allowed_value" IS NOT NULL) AND ("label_attribute_text" IS NULL))))
);


--
-- Name: label_attribute_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."label_attribute_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: label_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."label_attribute_id_seq" OWNED BY "musicbrainz"."label_attribute"."id";


--
-- Name: label_attribute_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."label_attribute_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "free_text" boolean NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: label_attribute_type_allowed_value; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."label_attribute_type_allowed_value" (
    "id" integer NOT NULL,
    "label_attribute_type" integer NOT NULL,
    "value" "text",
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: label_attribute_type_allowed_value_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."label_attribute_type_allowed_value_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: label_attribute_type_allowed_value_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."label_attribute_type_allowed_value_id_seq" OWNED BY "musicbrainz"."label_attribute_type_allowed_value"."id";


--
-- Name: label_attribute_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."label_attribute_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: label_attribute_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."label_attribute_type_id_seq" OWNED BY "musicbrainz"."label_attribute_type"."id";


--
-- Name: label_gid_redirect; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."label_gid_redirect" (
    "gid" "uuid" NOT NULL,
    "new_id" integer NOT NULL,
    "created" timestamp with time zone DEFAULT "now"()
);


--
-- Name: label_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."label_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: label_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."label_id_seq" OWNED BY "musicbrainz"."label"."id";


--
-- Name: label_ipi; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."label_ipi" (
    "label" integer NOT NULL,
    "ipi" character(11) NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "created" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "label_ipi_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "label_ipi_ipi_check" CHECK (("ipi" ~ '^\d{11}$'::"text"))
);


--
-- Name: label_isni; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."label_isni" (
    "label" integer NOT NULL,
    "isni" character(16) NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "created" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "label_isni_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "label_isni_isni_check" CHECK (("isni" ~ '^\d{15}[\dX]$'::"text"))
);


--
-- Name: label_meta; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."label_meta" (
    "id" integer NOT NULL,
    "rating" smallint,
    "rating_count" integer,
    CONSTRAINT "label_meta_rating_check" CHECK ((("rating" >= 0) AND ("rating" <= 100)))
);


--
-- Name: label_rating_raw; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."label_rating_raw" (
    "label" integer NOT NULL,
    "editor" integer NOT NULL,
    "rating" smallint NOT NULL,
    CONSTRAINT "label_rating_raw_rating_check" CHECK ((("rating" >= 0) AND ("rating" <= 100)))
);


--
-- Name: label_tag; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."label_tag" (
    "label" integer NOT NULL,
    "tag" integer NOT NULL,
    "count" integer NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"()
);


--
-- Name: label_tag_raw; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."label_tag_raw" (
    "label" integer NOT NULL,
    "editor" integer NOT NULL,
    "tag" integer NOT NULL,
    "is_upvote" boolean DEFAULT true NOT NULL
);


--
-- Name: label_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."label_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: label_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."label_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: label_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."label_type_id_seq" OWNED BY "musicbrainz"."label_type"."id";


--
-- Name: language; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."language" (
    "id" integer NOT NULL,
    "iso_code_2t" character(3),
    "iso_code_2b" character(3),
    "iso_code_1" character(2),
    "name" character varying(100) NOT NULL,
    "frequency" smallint DEFAULT 0 NOT NULL,
    "iso_code_3" character(3),
    CONSTRAINT "iso_code_check" CHECK ((("iso_code_2t" IS NOT NULL) OR ("iso_code_3" IS NOT NULL)))
);


--
-- Name: language_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."language_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: language_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."language_id_seq" OWNED BY "musicbrainz"."language"."id";


--
-- Name: link_attribute; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."link_attribute" (
    "link" integer NOT NULL,
    "attribute_type" integer NOT NULL,
    "created" timestamp with time zone DEFAULT "now"()
);


--
-- Name: link_attribute_credit; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."link_attribute_credit" (
    "link" integer NOT NULL,
    "attribute_type" integer NOT NULL,
    "credited_as" "text" NOT NULL
);


--
-- Name: link_attribute_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."link_attribute_type" (
    "id" integer NOT NULL,
    "parent" integer,
    "root" integer NOT NULL,
    "child_order" integer DEFAULT 0 NOT NULL,
    "gid" "uuid" NOT NULL,
    "name" character varying(255) NOT NULL,
    "description" "text",
    "last_updated" timestamp with time zone DEFAULT "now"()
);


--
-- Name: link_attribute_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."link_attribute_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: link_attribute_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."link_attribute_type_id_seq" OWNED BY "musicbrainz"."link_attribute_type"."id";


--
-- Name: link_creditable_attribute_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."link_creditable_attribute_type" (
    "attribute_type" integer NOT NULL
);


--
-- Name: link_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."link_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: link_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."link_id_seq" OWNED BY "musicbrainz"."link"."id";


--
-- Name: link_text_attribute_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."link_text_attribute_type" (
    "attribute_type" integer NOT NULL
);


--
-- Name: link_type_attribute_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."link_type_attribute_type" (
    "link_type" integer NOT NULL,
    "attribute_type" integer NOT NULL,
    "min" smallint,
    "max" smallint,
    "last_updated" timestamp with time zone DEFAULT "now"()
);


--
-- Name: link_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."link_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: link_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."link_type_id_seq" OWNED BY "musicbrainz"."link_type"."id";


--
-- Name: medium_attribute; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."medium_attribute" (
    "id" integer NOT NULL,
    "medium" integer NOT NULL,
    "medium_attribute_type" integer NOT NULL,
    "medium_attribute_type_allowed_value" integer,
    "medium_attribute_text" "text",
    CONSTRAINT "medium_attribute_check" CHECK (((("medium_attribute_type_allowed_value" IS NULL) AND ("medium_attribute_text" IS NOT NULL)) OR (("medium_attribute_type_allowed_value" IS NOT NULL) AND ("medium_attribute_text" IS NULL))))
);


--
-- Name: medium_attribute_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."medium_attribute_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medium_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."medium_attribute_id_seq" OWNED BY "musicbrainz"."medium_attribute"."id";


--
-- Name: medium_attribute_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."medium_attribute_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "free_text" boolean NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: medium_attribute_type_allowed_format; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."medium_attribute_type_allowed_format" (
    "medium_format" integer NOT NULL,
    "medium_attribute_type" integer NOT NULL
);


--
-- Name: medium_attribute_type_allowed_value; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."medium_attribute_type_allowed_value" (
    "id" integer NOT NULL,
    "medium_attribute_type" integer NOT NULL,
    "value" "text",
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: medium_attribute_type_allowed_value_allowed_format; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."medium_attribute_type_allowed_value_allowed_format" (
    "medium_format" integer NOT NULL,
    "medium_attribute_type_allowed_value" integer NOT NULL
);


--
-- Name: medium_attribute_type_allowed_value_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."medium_attribute_type_allowed_value_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medium_attribute_type_allowed_value_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."medium_attribute_type_allowed_value_id_seq" OWNED BY "musicbrainz"."medium_attribute_type_allowed_value"."id";


--
-- Name: medium_attribute_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."medium_attribute_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medium_attribute_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."medium_attribute_type_id_seq" OWNED BY "musicbrainz"."medium_attribute_type"."id";


--
-- Name: medium_cdtoc; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."medium_cdtoc" (
    "id" integer NOT NULL,
    "medium" integer NOT NULL,
    "cdtoc" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "medium_cdtoc_edits_pending_check" CHECK (("edits_pending" >= 0))
);


--
-- Name: medium_cdtoc_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."medium_cdtoc_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medium_cdtoc_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."medium_cdtoc_id_seq" OWNED BY "musicbrainz"."medium_cdtoc"."id";


--
-- Name: medium_format; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."medium_format" (
    "id" integer NOT NULL,
    "name" character varying(100) NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "year" smallint,
    "has_discids" boolean DEFAULT false NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: medium_format_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."medium_format_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medium_format_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."medium_format_id_seq" OWNED BY "musicbrainz"."medium_format"."id";


--
-- Name: medium_gid_redirect; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."medium_gid_redirect" (
    "gid" "uuid" NOT NULL,
    "new_id" integer NOT NULL,
    "created" timestamp with time zone DEFAULT "now"()
);


--
-- Name: medium_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."medium_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medium_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."medium_id_seq" OWNED BY "musicbrainz"."medium"."id";


--
-- Name: medium_index; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."medium_index" (
    "medium" integer NOT NULL,
    "toc" "public"."cube"
);


--
-- Name: track; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."track" (
    "id" integer NOT NULL,
    "gid" "uuid" NOT NULL,
    "recording" integer NOT NULL,
    "medium" integer NOT NULL,
    "position" integer NOT NULL,
    "number" "text" NOT NULL,
    "name" character varying NOT NULL,
    "artist_credit" integer NOT NULL,
    "length" integer,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "is_data_track" boolean DEFAULT false NOT NULL,
    CONSTRAINT "track_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "track_length_check" CHECK ((("length" IS NULL) OR ("length" > 0)))
);


--
-- Name: medium_track_durations; Type: VIEW; Schema: musicbrainz; Owner: -
--

CREATE VIEW "musicbrainz"."medium_track_durations" AS
 SELECT "medium"."id" AS "medium",
    "array_agg"("track"."length" ORDER BY "track"."position") FILTER (WHERE ("track"."position" = 0)) AS "pregap_length",
    "array_agg"("track"."length" ORDER BY "track"."position") FILTER (WHERE (("track"."position" > 0) AND ("track"."is_data_track" = false))) AS "cdtoc_track_lengths",
    "array_agg"("track"."length" ORDER BY "track"."position") FILTER (WHERE ("track"."is_data_track" = true)) AS "data_track_lengths"
   FROM ("musicbrainz"."medium"
     JOIN "musicbrainz"."track" ON (("track"."medium" = "medium"."id")))
  GROUP BY "medium"."id";


--
-- Name: mood; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."mood" (
    "id" integer NOT NULL,
    "gid" "uuid" NOT NULL,
    "name" character varying NOT NULL,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "mood_edits_pending_check" CHECK (("edits_pending" >= 0))
);


--
-- Name: mood_alias; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."mood_alias" (
    "id" integer NOT NULL,
    "mood" integer NOT NULL,
    "name" character varying NOT NULL,
    "locale" "text",
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "type" integer,
    "sort_name" character varying NOT NULL,
    "begin_date_year" smallint,
    "begin_date_month" smallint,
    "begin_date_day" smallint,
    "end_date_year" smallint,
    "end_date_month" smallint,
    "end_date_day" smallint,
    "primary_for_locale" boolean DEFAULT false NOT NULL,
    "ended" boolean DEFAULT false NOT NULL,
    CONSTRAINT "mood_alias_check" CHECK ((((("end_date_year" IS NOT NULL) OR ("end_date_month" IS NOT NULL) OR ("end_date_day" IS NOT NULL)) AND ("ended" = true)) OR (("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL)))),
    CONSTRAINT "mood_alias_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "primary_check" CHECK (((("locale" IS NULL) AND ("primary_for_locale" IS FALSE)) OR ("locale" IS NOT NULL))),
    CONSTRAINT "search_hints_are_empty" CHECK ((("type" <> 2) OR (("type" = 2) AND (("sort_name")::"text" = ("name")::"text") AND ("begin_date_year" IS NULL) AND ("begin_date_month" IS NULL) AND ("begin_date_day" IS NULL) AND ("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL) AND ("primary_for_locale" IS FALSE) AND ("locale" IS NULL))))
);


--
-- Name: mood_alias_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."mood_alias_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mood_alias_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."mood_alias_id_seq" OWNED BY "musicbrainz"."mood_alias"."id";


--
-- Name: mood_alias_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."mood_alias_type" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: mood_alias_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."mood_alias_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mood_alias_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."mood_alias_type_id_seq" OWNED BY "musicbrainz"."mood_alias_type"."id";


--
-- Name: mood_annotation; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."mood_annotation" (
    "mood" integer NOT NULL,
    "annotation" integer NOT NULL
);


--
-- Name: mood_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."mood_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mood_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."mood_id_seq" OWNED BY "musicbrainz"."mood"."id";


--
-- Name: old_editor_name; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."old_editor_name" (
    "name" character varying(64) NOT NULL
);


--
-- Name: orderable_link_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."orderable_link_type" (
    "link_type" integer NOT NULL,
    "direction" smallint DEFAULT 1 NOT NULL,
    CONSTRAINT "orderable_link_type_direction_check" CHECK ((("direction" = 1) OR ("direction" = 2)))
);


--
-- Name: place; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."place" (
    "id" integer NOT NULL,
    "gid" "uuid" NOT NULL,
    "name" character varying NOT NULL,
    "type" integer,
    "address" character varying DEFAULT ''::character varying NOT NULL,
    "area" integer,
    "coordinates" "point",
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "begin_date_year" smallint,
    "begin_date_month" smallint,
    "begin_date_day" smallint,
    "end_date_year" smallint,
    "end_date_month" smallint,
    "end_date_day" smallint,
    "ended" boolean DEFAULT false NOT NULL,
    CONSTRAINT "place_check" CHECK ((((("end_date_year" IS NOT NULL) OR ("end_date_month" IS NOT NULL) OR ("end_date_day" IS NOT NULL)) AND ("ended" = true)) OR (("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL)))),
    CONSTRAINT "place_edits_pending_check" CHECK (("edits_pending" >= 0))
);


--
-- Name: place_alias; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."place_alias" (
    "id" integer NOT NULL,
    "place" integer NOT NULL,
    "name" character varying NOT NULL,
    "locale" "text",
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "type" integer,
    "sort_name" character varying NOT NULL,
    "begin_date_year" smallint,
    "begin_date_month" smallint,
    "begin_date_day" smallint,
    "end_date_year" smallint,
    "end_date_month" smallint,
    "end_date_day" smallint,
    "primary_for_locale" boolean DEFAULT false NOT NULL,
    "ended" boolean DEFAULT false NOT NULL,
    CONSTRAINT "place_alias_check" CHECK ((((("end_date_year" IS NOT NULL) OR ("end_date_month" IS NOT NULL) OR ("end_date_day" IS NOT NULL)) AND ("ended" = true)) OR (("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL)))),
    CONSTRAINT "place_alias_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "primary_check" CHECK (((("locale" IS NULL) AND ("primary_for_locale" IS FALSE)) OR ("locale" IS NOT NULL))),
    CONSTRAINT "search_hints_are_empty" CHECK ((("type" <> 2) OR (("type" = 2) AND (("sort_name")::"text" = ("name")::"text") AND ("begin_date_year" IS NULL) AND ("begin_date_month" IS NULL) AND ("begin_date_day" IS NULL) AND ("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL) AND ("primary_for_locale" IS FALSE) AND ("locale" IS NULL))))
);


--
-- Name: place_alias_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."place_alias_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: place_alias_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."place_alias_id_seq" OWNED BY "musicbrainz"."place_alias"."id";


--
-- Name: place_alias_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."place_alias_type" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: place_alias_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."place_alias_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: place_alias_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."place_alias_type_id_seq" OWNED BY "musicbrainz"."place_alias_type"."id";


--
-- Name: place_annotation; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."place_annotation" (
    "place" integer NOT NULL,
    "annotation" integer NOT NULL
);


--
-- Name: place_attribute; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."place_attribute" (
    "id" integer NOT NULL,
    "place" integer NOT NULL,
    "place_attribute_type" integer NOT NULL,
    "place_attribute_type_allowed_value" integer,
    "place_attribute_text" "text",
    CONSTRAINT "place_attribute_check" CHECK (((("place_attribute_type_allowed_value" IS NULL) AND ("place_attribute_text" IS NOT NULL)) OR (("place_attribute_type_allowed_value" IS NOT NULL) AND ("place_attribute_text" IS NULL))))
);


--
-- Name: place_attribute_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."place_attribute_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: place_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."place_attribute_id_seq" OWNED BY "musicbrainz"."place_attribute"."id";


--
-- Name: place_attribute_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."place_attribute_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "free_text" boolean NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: place_attribute_type_allowed_value; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."place_attribute_type_allowed_value" (
    "id" integer NOT NULL,
    "place_attribute_type" integer NOT NULL,
    "value" "text",
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: place_attribute_type_allowed_value_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."place_attribute_type_allowed_value_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: place_attribute_type_allowed_value_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."place_attribute_type_allowed_value_id_seq" OWNED BY "musicbrainz"."place_attribute_type_allowed_value"."id";


--
-- Name: place_attribute_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."place_attribute_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: place_attribute_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."place_attribute_type_id_seq" OWNED BY "musicbrainz"."place_attribute_type"."id";


--
-- Name: place_gid_redirect; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."place_gid_redirect" (
    "gid" "uuid" NOT NULL,
    "new_id" integer NOT NULL,
    "created" timestamp with time zone DEFAULT "now"()
);


--
-- Name: place_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."place_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: place_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."place_id_seq" OWNED BY "musicbrainz"."place"."id";


--
-- Name: place_meta; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."place_meta" (
    "id" integer NOT NULL,
    "rating" smallint,
    "rating_count" integer,
    CONSTRAINT "place_meta_rating_check" CHECK ((("rating" >= 0) AND ("rating" <= 100)))
);


--
-- Name: place_rating_raw; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."place_rating_raw" (
    "place" integer NOT NULL,
    "editor" integer NOT NULL,
    "rating" smallint NOT NULL,
    CONSTRAINT "place_rating_raw_rating_check" CHECK ((("rating" >= 0) AND ("rating" <= 100)))
);


--
-- Name: place_tag; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."place_tag" (
    "place" integer NOT NULL,
    "tag" integer NOT NULL,
    "count" integer NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"()
);


--
-- Name: place_tag_raw; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."place_tag_raw" (
    "place" integer NOT NULL,
    "editor" integer NOT NULL,
    "tag" integer NOT NULL,
    "is_upvote" boolean DEFAULT true NOT NULL
);


--
-- Name: place_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."place_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: place_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."place_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: place_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."place_type_id_seq" OWNED BY "musicbrainz"."place_type"."id";


--
-- Name: recording; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."recording" (
    "id" integer NOT NULL,
    "gid" "uuid" NOT NULL,
    "name" character varying NOT NULL,
    "artist_credit" integer NOT NULL,
    "length" integer,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "video" boolean DEFAULT false NOT NULL,
    CONSTRAINT "recording_edits_pending_check" CHECK (("edits_pending" >= 0)),
    CONSTRAINT "recording_length_check" CHECK ((("length" IS NULL) OR ("length" > 0)))
);


--
-- Name: recording_alias; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."recording_alias" (
    "id" integer NOT NULL,
    "recording" integer NOT NULL,
    "name" character varying NOT NULL,
    "locale" "text",
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "type" integer,
    "sort_name" character varying NOT NULL,
    "begin_date_year" smallint,
    "begin_date_month" smallint,
    "begin_date_day" smallint,
    "end_date_year" smallint,
    "end_date_month" smallint,
    "end_date_day" smallint,
    "primary_for_locale" boolean DEFAULT false NOT NULL,
    "ended" boolean DEFAULT false NOT NULL,
    CONSTRAINT "primary_check" CHECK (((("locale" IS NULL) AND ("primary_for_locale" IS FALSE)) OR ("locale" IS NOT NULL))),
    CONSTRAINT "recording_alias_check" CHECK ((((("end_date_year" IS NOT NULL) OR ("end_date_month" IS NOT NULL) OR ("end_date_day" IS NOT NULL)) AND ("ended" = true)) OR (("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL)))),
    CONSTRAINT "recording_alias_edits_pending_check" CHECK (("edits_pending" >= 0))
);


--
-- Name: recording_alias_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."recording_alias_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recording_alias_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."recording_alias_id_seq" OWNED BY "musicbrainz"."recording_alias"."id";


--
-- Name: recording_alias_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."recording_alias_type" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: recording_alias_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."recording_alias_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recording_alias_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."recording_alias_type_id_seq" OWNED BY "musicbrainz"."recording_alias_type"."id";


--
-- Name: recording_annotation; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."recording_annotation" (
    "recording" integer NOT NULL,
    "annotation" integer NOT NULL
);


--
-- Name: recording_attribute; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."recording_attribute" (
    "id" integer NOT NULL,
    "recording" integer NOT NULL,
    "recording_attribute_type" integer NOT NULL,
    "recording_attribute_type_allowed_value" integer,
    "recording_attribute_text" "text",
    CONSTRAINT "recording_attribute_check" CHECK (((("recording_attribute_type_allowed_value" IS NULL) AND ("recording_attribute_text" IS NOT NULL)) OR (("recording_attribute_type_allowed_value" IS NOT NULL) AND ("recording_attribute_text" IS NULL))))
);


--
-- Name: recording_attribute_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."recording_attribute_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recording_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."recording_attribute_id_seq" OWNED BY "musicbrainz"."recording_attribute"."id";


--
-- Name: recording_attribute_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."recording_attribute_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "free_text" boolean NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: recording_attribute_type_allowed_value; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."recording_attribute_type_allowed_value" (
    "id" integer NOT NULL,
    "recording_attribute_type" integer NOT NULL,
    "value" "text",
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: recording_attribute_type_allowed_value_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."recording_attribute_type_allowed_value_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recording_attribute_type_allowed_value_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."recording_attribute_type_allowed_value_id_seq" OWNED BY "musicbrainz"."recording_attribute_type_allowed_value"."id";


--
-- Name: recording_attribute_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."recording_attribute_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recording_attribute_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."recording_attribute_type_id_seq" OWNED BY "musicbrainz"."recording_attribute_type"."id";


--
-- Name: recording_gid_redirect; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."recording_gid_redirect" (
    "gid" "uuid" NOT NULL,
    "new_id" integer NOT NULL,
    "created" timestamp with time zone DEFAULT "now"()
);


--
-- Name: recording_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."recording_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recording_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."recording_id_seq" OWNED BY "musicbrainz"."recording"."id";


--
-- Name: recording_meta; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."recording_meta" (
    "id" integer NOT NULL,
    "rating" smallint,
    "rating_count" integer,
    CONSTRAINT "recording_meta_rating_check" CHECK ((("rating" >= 0) AND ("rating" <= 100)))
);


--
-- Name: recording_rating_raw; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."recording_rating_raw" (
    "recording" integer NOT NULL,
    "editor" integer NOT NULL,
    "rating" smallint NOT NULL,
    CONSTRAINT "recording_rating_raw_rating_check" CHECK ((("rating" >= 0) AND ("rating" <= 100)))
);


--
-- Name: recording_series; Type: VIEW; Schema: musicbrainz; Owner: -
--

CREATE VIEW "musicbrainz"."recording_series" AS
 SELECT "lrs"."entity0" AS "recording",
    "lrs"."entity1" AS "series",
    "lrs"."id" AS "relationship",
    "lrs"."link_order",
    "lrs"."link",
    COALESCE("latv"."text_value", ''::"text") AS "text_value"
   FROM (((("musicbrainz"."l_recording_series" "lrs"
     JOIN "musicbrainz"."series" "s" ON (("s"."id" = "lrs"."entity1")))
     JOIN "musicbrainz"."link" "l" ON (("l"."id" = "lrs"."link")))
     JOIN "musicbrainz"."link_type" "lt" ON ((("lt"."id" = "l"."link_type") AND ("lt"."gid" = 'ea6f0698-6782-30d6-b16d-293081b66774'::"uuid"))))
     LEFT JOIN "musicbrainz"."link_attribute_text_value" "latv" ON ((("latv"."attribute_type" = 788) AND ("latv"."link" = "l"."id"))))
  ORDER BY "lrs"."entity1", "lrs"."link_order";


--
-- Name: recording_tag; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."recording_tag" (
    "recording" integer NOT NULL,
    "tag" integer NOT NULL,
    "count" integer NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"()
);


--
-- Name: recording_tag_raw; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."recording_tag_raw" (
    "recording" integer NOT NULL,
    "editor" integer NOT NULL,
    "tag" integer NOT NULL,
    "is_upvote" boolean DEFAULT true NOT NULL
);


--
-- Name: release; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release" (
    "id" integer NOT NULL,
    "gid" "uuid" NOT NULL,
    "name" character varying NOT NULL,
    "artist_credit" integer NOT NULL,
    "release_group" integer NOT NULL,
    "status" integer,
    "packaging" integer,
    "language" integer,
    "script" integer,
    "barcode" character varying(255),
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "quality" smallint DEFAULT '-1'::integer NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "release_edits_pending_check" CHECK (("edits_pending" >= 0))
);


--
-- Name: release_alias; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_alias" (
    "id" integer NOT NULL,
    "release" integer NOT NULL,
    "name" character varying NOT NULL,
    "locale" "text",
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "type" integer,
    "sort_name" character varying NOT NULL,
    "begin_date_year" smallint,
    "begin_date_month" smallint,
    "begin_date_day" smallint,
    "end_date_year" smallint,
    "end_date_month" smallint,
    "end_date_day" smallint,
    "primary_for_locale" boolean DEFAULT false NOT NULL,
    "ended" boolean DEFAULT false NOT NULL,
    CONSTRAINT "primary_check" CHECK (((("locale" IS NULL) AND ("primary_for_locale" IS FALSE)) OR ("locale" IS NOT NULL))),
    CONSTRAINT "release_alias_check" CHECK ((((("end_date_year" IS NOT NULL) OR ("end_date_month" IS NOT NULL) OR ("end_date_day" IS NOT NULL)) AND ("ended" = true)) OR (("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL)))),
    CONSTRAINT "release_alias_edits_pending_check" CHECK (("edits_pending" >= 0))
);


--
-- Name: release_alias_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."release_alias_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: release_alias_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."release_alias_id_seq" OWNED BY "musicbrainz"."release_alias"."id";


--
-- Name: release_alias_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_alias_type" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: release_alias_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."release_alias_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: release_alias_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."release_alias_type_id_seq" OWNED BY "musicbrainz"."release_alias_type"."id";


--
-- Name: release_annotation; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_annotation" (
    "release" integer NOT NULL,
    "annotation" integer NOT NULL
);


--
-- Name: release_attribute; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_attribute" (
    "id" integer NOT NULL,
    "release" integer NOT NULL,
    "release_attribute_type" integer NOT NULL,
    "release_attribute_type_allowed_value" integer,
    "release_attribute_text" "text",
    CONSTRAINT "release_attribute_check" CHECK (((("release_attribute_type_allowed_value" IS NULL) AND ("release_attribute_text" IS NOT NULL)) OR (("release_attribute_type_allowed_value" IS NOT NULL) AND ("release_attribute_text" IS NULL))))
);


--
-- Name: release_attribute_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."release_attribute_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: release_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."release_attribute_id_seq" OWNED BY "musicbrainz"."release_attribute"."id";


--
-- Name: release_attribute_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_attribute_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "free_text" boolean NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: release_attribute_type_allowed_value; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_attribute_type_allowed_value" (
    "id" integer NOT NULL,
    "release_attribute_type" integer NOT NULL,
    "value" "text",
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: release_attribute_type_allowed_value_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."release_attribute_type_allowed_value_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: release_attribute_type_allowed_value_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."release_attribute_type_allowed_value_id_seq" OWNED BY "musicbrainz"."release_attribute_type_allowed_value"."id";


--
-- Name: release_attribute_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."release_attribute_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: release_attribute_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."release_attribute_type_id_seq" OWNED BY "musicbrainz"."release_attribute_type"."id";


--
-- Name: release_country; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_country" (
    "release" integer NOT NULL,
    "country" integer NOT NULL,
    "date_year" smallint,
    "date_month" smallint,
    "date_day" smallint
);


--
-- Name: release_unknown_country; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_unknown_country" (
    "release" integer NOT NULL,
    "date_year" smallint,
    "date_month" smallint,
    "date_day" smallint
);


--
-- Name: release_event; Type: VIEW; Schema: musicbrainz; Owner: -
--

CREATE VIEW "musicbrainz"."release_event" AS
 SELECT "release",
    "date_year",
    "date_month",
    "date_day",
    "country"
   FROM ( SELECT "release_country"."release",
            "release_country"."date_year",
            "release_country"."date_month",
            "release_country"."date_day",
            "release_country"."country"
           FROM "musicbrainz"."release_country"
        UNION ALL
         SELECT "release_unknown_country"."release",
            "release_unknown_country"."date_year",
            "release_unknown_country"."date_month",
            "release_unknown_country"."date_day",
            NULL::integer
           FROM "musicbrainz"."release_unknown_country") "q";


--
-- Name: release_gid_redirect; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_gid_redirect" (
    "gid" "uuid" NOT NULL,
    "new_id" integer NOT NULL,
    "created" timestamp with time zone DEFAULT "now"()
);


--
-- Name: release_group; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_group" (
    "id" integer NOT NULL,
    "gid" "uuid" NOT NULL,
    "name" character varying NOT NULL,
    "artist_credit" integer NOT NULL,
    "type" integer,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "release_group_edits_pending_check" CHECK (("edits_pending" >= 0))
);


--
-- Name: release_group_alias; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_group_alias" (
    "id" integer NOT NULL,
    "release_group" integer NOT NULL,
    "name" character varying NOT NULL,
    "locale" "text",
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "type" integer,
    "sort_name" character varying NOT NULL,
    "begin_date_year" smallint,
    "begin_date_month" smallint,
    "begin_date_day" smallint,
    "end_date_year" smallint,
    "end_date_month" smallint,
    "end_date_day" smallint,
    "primary_for_locale" boolean DEFAULT false NOT NULL,
    "ended" boolean DEFAULT false NOT NULL,
    CONSTRAINT "primary_check" CHECK (((("locale" IS NULL) AND ("primary_for_locale" IS FALSE)) OR ("locale" IS NOT NULL))),
    CONSTRAINT "release_group_alias_check" CHECK ((((("end_date_year" IS NOT NULL) OR ("end_date_month" IS NOT NULL) OR ("end_date_day" IS NOT NULL)) AND ("ended" = true)) OR (("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL)))),
    CONSTRAINT "release_group_alias_edits_pending_check" CHECK (("edits_pending" >= 0))
);


--
-- Name: release_group_alias_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."release_group_alias_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: release_group_alias_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."release_group_alias_id_seq" OWNED BY "musicbrainz"."release_group_alias"."id";


--
-- Name: release_group_alias_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_group_alias_type" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: release_group_alias_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."release_group_alias_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: release_group_alias_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."release_group_alias_type_id_seq" OWNED BY "musicbrainz"."release_group_alias_type"."id";


--
-- Name: release_group_annotation; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_group_annotation" (
    "release_group" integer NOT NULL,
    "annotation" integer NOT NULL
);


--
-- Name: release_group_attribute; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_group_attribute" (
    "id" integer NOT NULL,
    "release_group" integer NOT NULL,
    "release_group_attribute_type" integer NOT NULL,
    "release_group_attribute_type_allowed_value" integer,
    "release_group_attribute_text" "text",
    CONSTRAINT "release_group_attribute_check" CHECK (((("release_group_attribute_type_allowed_value" IS NULL) AND ("release_group_attribute_text" IS NOT NULL)) OR (("release_group_attribute_type_allowed_value" IS NOT NULL) AND ("release_group_attribute_text" IS NULL))))
);


--
-- Name: release_group_attribute_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."release_group_attribute_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: release_group_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."release_group_attribute_id_seq" OWNED BY "musicbrainz"."release_group_attribute"."id";


--
-- Name: release_group_attribute_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_group_attribute_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "free_text" boolean NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: release_group_attribute_type_allowed_value; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_group_attribute_type_allowed_value" (
    "id" integer NOT NULL,
    "release_group_attribute_type" integer NOT NULL,
    "value" "text",
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: release_group_attribute_type_allowed_value_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."release_group_attribute_type_allowed_value_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: release_group_attribute_type_allowed_value_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."release_group_attribute_type_allowed_value_id_seq" OWNED BY "musicbrainz"."release_group_attribute_type_allowed_value"."id";


--
-- Name: release_group_attribute_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."release_group_attribute_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: release_group_attribute_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."release_group_attribute_type_id_seq" OWNED BY "musicbrainz"."release_group_attribute_type"."id";


--
-- Name: release_group_gid_redirect; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_group_gid_redirect" (
    "gid" "uuid" NOT NULL,
    "new_id" integer NOT NULL,
    "created" timestamp with time zone DEFAULT "now"()
);


--
-- Name: release_group_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."release_group_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: release_group_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."release_group_id_seq" OWNED BY "musicbrainz"."release_group"."id";


--
-- Name: release_group_meta; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_group_meta" (
    "id" integer NOT NULL,
    "release_count" integer DEFAULT 0 NOT NULL,
    "first_release_date_year" smallint,
    "first_release_date_month" smallint,
    "first_release_date_day" smallint,
    "rating" smallint,
    "rating_count" integer,
    CONSTRAINT "release_group_meta_rating_check" CHECK ((("rating" >= 0) AND ("rating" <= 100)))
);


--
-- Name: release_group_primary_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_group_primary_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: release_group_primary_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."release_group_primary_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: release_group_primary_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."release_group_primary_type_id_seq" OWNED BY "musicbrainz"."release_group_primary_type"."id";


--
-- Name: release_group_rating_raw; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_group_rating_raw" (
    "release_group" integer NOT NULL,
    "editor" integer NOT NULL,
    "rating" smallint NOT NULL,
    CONSTRAINT "release_group_rating_raw_rating_check" CHECK ((("rating" >= 0) AND ("rating" <= 100)))
);


--
-- Name: release_group_secondary_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_group_secondary_type" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: release_group_secondary_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."release_group_secondary_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: release_group_secondary_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."release_group_secondary_type_id_seq" OWNED BY "musicbrainz"."release_group_secondary_type"."id";


--
-- Name: release_group_secondary_type_join; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_group_secondary_type_join" (
    "release_group" integer NOT NULL,
    "secondary_type" integer NOT NULL,
    "created" timestamp with time zone DEFAULT "now"() NOT NULL
);


--
-- Name: release_group_series; Type: VIEW; Schema: musicbrainz; Owner: -
--

CREATE VIEW "musicbrainz"."release_group_series" AS
 SELECT "lrgs"."entity0" AS "release_group",
    "lrgs"."entity1" AS "series",
    "lrgs"."id" AS "relationship",
    "lrgs"."link_order",
    "lrgs"."link",
    COALESCE("latv"."text_value", ''::"text") AS "text_value"
   FROM (((("musicbrainz"."l_release_group_series" "lrgs"
     JOIN "musicbrainz"."series" "s" ON (("s"."id" = "lrgs"."entity1")))
     JOIN "musicbrainz"."link" "l" ON (("l"."id" = "lrgs"."link")))
     JOIN "musicbrainz"."link_type" "lt" ON ((("lt"."id" = "l"."link_type") AND ("lt"."gid" = '01018437-91d8-36b9-bf89-3f885d53b5bd'::"uuid"))))
     LEFT JOIN "musicbrainz"."link_attribute_text_value" "latv" ON ((("latv"."attribute_type" = 788) AND ("latv"."link" = "l"."id"))))
  ORDER BY "lrgs"."entity1", "lrgs"."link_order";


--
-- Name: release_group_tag; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_group_tag" (
    "release_group" integer NOT NULL,
    "tag" integer NOT NULL,
    "count" integer NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"()
);


--
-- Name: release_group_tag_raw; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_group_tag_raw" (
    "release_group" integer NOT NULL,
    "editor" integer NOT NULL,
    "tag" integer NOT NULL,
    "is_upvote" boolean DEFAULT true NOT NULL
);


--
-- Name: release_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."release_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: release_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."release_id_seq" OWNED BY "musicbrainz"."release"."id";


--
-- Name: release_label; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_label" (
    "id" integer NOT NULL,
    "release" integer NOT NULL,
    "label" integer,
    "catalog_number" character varying(255),
    "last_updated" timestamp with time zone DEFAULT "now"()
);


--
-- Name: release_label_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."release_label_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: release_label_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."release_label_id_seq" OWNED BY "musicbrainz"."release_label"."id";


--
-- Name: release_meta; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_meta" (
    "id" integer NOT NULL,
    "date_added" timestamp with time zone DEFAULT "now"(),
    "info_url" character varying(255),
    "amazon_asin" character varying(10),
    "cover_art_presence" "musicbrainz"."cover_art_presence" DEFAULT 'absent'::"musicbrainz"."cover_art_presence" NOT NULL
);


--
-- Name: release_packaging; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_packaging" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: release_packaging_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."release_packaging_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: release_packaging_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."release_packaging_id_seq" OWNED BY "musicbrainz"."release_packaging"."id";


--
-- Name: release_raw; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_raw" (
    "id" integer NOT NULL,
    "title" character varying(255) NOT NULL,
    "artist" character varying(255),
    "added" timestamp with time zone DEFAULT "now"(),
    "last_modified" timestamp with time zone DEFAULT "now"(),
    "lookup_count" integer DEFAULT 0,
    "modify_count" integer DEFAULT 0,
    "source" integer DEFAULT 0,
    "barcode" character varying(255),
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL
);


--
-- Name: release_raw_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."release_raw_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: release_raw_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."release_raw_id_seq" OWNED BY "musicbrainz"."release_raw"."id";


--
-- Name: release_series; Type: VIEW; Schema: musicbrainz; Owner: -
--

CREATE VIEW "musicbrainz"."release_series" AS
 SELECT "lrs"."entity0" AS "release",
    "lrs"."entity1" AS "series",
    "lrs"."id" AS "relationship",
    "lrs"."link_order",
    "lrs"."link",
    COALESCE("latv"."text_value", ''::"text") AS "text_value"
   FROM (((("musicbrainz"."l_release_series" "lrs"
     JOIN "musicbrainz"."series" "s" ON (("s"."id" = "lrs"."entity1")))
     JOIN "musicbrainz"."link" "l" ON (("l"."id" = "lrs"."link")))
     JOIN "musicbrainz"."link_type" "lt" ON ((("lt"."id" = "l"."link_type") AND ("lt"."gid" = '3fa29f01-8e13-3e49-9b0a-ad212aa2f81d'::"uuid"))))
     LEFT JOIN "musicbrainz"."link_attribute_text_value" "latv" ON ((("latv"."attribute_type" = 788) AND ("latv"."link" = "l"."id"))))
  ORDER BY "lrs"."entity1", "lrs"."link_order";


--
-- Name: release_status; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_status" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: release_status_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."release_status_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: release_status_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."release_status_id_seq" OWNED BY "musicbrainz"."release_status"."id";


--
-- Name: release_tag; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_tag" (
    "release" integer NOT NULL,
    "tag" integer NOT NULL,
    "count" integer NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"()
);


--
-- Name: release_tag_raw; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."release_tag_raw" (
    "release" integer NOT NULL,
    "editor" integer NOT NULL,
    "tag" integer NOT NULL,
    "is_upvote" boolean DEFAULT true NOT NULL
);


--
-- Name: replication_control; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."replication_control" (
    "id" integer NOT NULL,
    "current_schema_sequence" integer NOT NULL,
    "current_replication_sequence" integer,
    "last_replication_date" timestamp with time zone
);


--
-- Name: replication_control_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."replication_control_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: replication_control_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."replication_control_id_seq" OWNED BY "musicbrainz"."replication_control"."id";


--
-- Name: script; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."script" (
    "id" integer NOT NULL,
    "iso_code" character(4) NOT NULL,
    "iso_number" character(3) NOT NULL,
    "name" character varying(100) NOT NULL,
    "frequency" smallint DEFAULT 0 NOT NULL
);


--
-- Name: script_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."script_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: script_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."script_id_seq" OWNED BY "musicbrainz"."script"."id";


--
-- Name: series_alias; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."series_alias" (
    "id" integer NOT NULL,
    "series" integer NOT NULL,
    "name" character varying NOT NULL,
    "locale" "text",
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "type" integer,
    "sort_name" character varying NOT NULL,
    "begin_date_year" smallint,
    "begin_date_month" smallint,
    "begin_date_day" smallint,
    "end_date_year" smallint,
    "end_date_month" smallint,
    "end_date_day" smallint,
    "primary_for_locale" boolean DEFAULT false NOT NULL,
    "ended" boolean DEFAULT false NOT NULL,
    CONSTRAINT "primary_check" CHECK (((("locale" IS NULL) AND ("primary_for_locale" IS FALSE)) OR ("locale" IS NOT NULL))),
    CONSTRAINT "search_hints_are_empty" CHECK ((("type" <> 2) OR (("type" = 2) AND (("sort_name")::"text" = ("name")::"text") AND ("begin_date_year" IS NULL) AND ("begin_date_month" IS NULL) AND ("begin_date_day" IS NULL) AND ("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL) AND ("primary_for_locale" IS FALSE) AND ("locale" IS NULL)))),
    CONSTRAINT "series_alias_check" CHECK ((((("end_date_year" IS NOT NULL) OR ("end_date_month" IS NOT NULL) OR ("end_date_day" IS NOT NULL)) AND ("ended" = true)) OR (("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL)))),
    CONSTRAINT "series_alias_edits_pending_check" CHECK (("edits_pending" >= 0))
);


--
-- Name: series_alias_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."series_alias_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: series_alias_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."series_alias_id_seq" OWNED BY "musicbrainz"."series_alias"."id";


--
-- Name: series_alias_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."series_alias_type" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: series_alias_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."series_alias_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: series_alias_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."series_alias_type_id_seq" OWNED BY "musicbrainz"."series_alias_type"."id";


--
-- Name: series_annotation; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."series_annotation" (
    "series" integer NOT NULL,
    "annotation" integer NOT NULL
);


--
-- Name: series_attribute; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."series_attribute" (
    "id" integer NOT NULL,
    "series" integer NOT NULL,
    "series_attribute_type" integer NOT NULL,
    "series_attribute_type_allowed_value" integer,
    "series_attribute_text" "text",
    CONSTRAINT "series_attribute_check" CHECK (((("series_attribute_type_allowed_value" IS NULL) AND ("series_attribute_text" IS NOT NULL)) OR (("series_attribute_type_allowed_value" IS NOT NULL) AND ("series_attribute_text" IS NULL))))
);


--
-- Name: series_attribute_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."series_attribute_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: series_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."series_attribute_id_seq" OWNED BY "musicbrainz"."series_attribute"."id";


--
-- Name: series_attribute_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."series_attribute_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "free_text" boolean NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: series_attribute_type_allowed_value; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."series_attribute_type_allowed_value" (
    "id" integer NOT NULL,
    "series_attribute_type" integer NOT NULL,
    "value" "text",
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: series_attribute_type_allowed_value_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."series_attribute_type_allowed_value_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: series_attribute_type_allowed_value_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."series_attribute_type_allowed_value_id_seq" OWNED BY "musicbrainz"."series_attribute_type_allowed_value"."id";


--
-- Name: series_attribute_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."series_attribute_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: series_attribute_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."series_attribute_type_id_seq" OWNED BY "musicbrainz"."series_attribute_type"."id";


--
-- Name: series_gid_redirect; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."series_gid_redirect" (
    "gid" "uuid" NOT NULL,
    "new_id" integer NOT NULL,
    "created" timestamp with time zone DEFAULT "now"()
);


--
-- Name: series_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."series_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: series_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."series_id_seq" OWNED BY "musicbrainz"."series"."id";


--
-- Name: series_ordering_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."series_ordering_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: series_ordering_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."series_ordering_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: series_ordering_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."series_ordering_type_id_seq" OWNED BY "musicbrainz"."series_ordering_type"."id";


--
-- Name: series_tag; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."series_tag" (
    "series" integer NOT NULL,
    "tag" integer NOT NULL,
    "count" integer NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"()
);


--
-- Name: series_tag_raw; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."series_tag_raw" (
    "series" integer NOT NULL,
    "editor" integer NOT NULL,
    "tag" integer NOT NULL,
    "is_upvote" boolean DEFAULT true NOT NULL
);


--
-- Name: series_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."series_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "entity_type" character varying(50) NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: series_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."series_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: series_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."series_type_id_seq" OWNED BY "musicbrainz"."series_type"."id";


--
-- Name: tag; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."tag" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "ref_count" integer DEFAULT 0 NOT NULL
);


--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."tag_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."tag_id_seq" OWNED BY "musicbrainz"."tag"."id";


--
-- Name: tag_relation; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."tag_relation" (
    "tag1" integer NOT NULL,
    "tag2" integer NOT NULL,
    "weight" integer NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "tag_relation_check" CHECK (("tag1" < "tag2"))
);


--
-- Name: track_gid_redirect; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."track_gid_redirect" (
    "gid" "uuid" NOT NULL,
    "new_id" integer NOT NULL,
    "created" timestamp with time zone DEFAULT "now"()
);


--
-- Name: track_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."track_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: track_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."track_id_seq" OWNED BY "musicbrainz"."track"."id";


--
-- Name: track_raw; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."track_raw" (
    "id" integer NOT NULL,
    "release" integer NOT NULL,
    "title" character varying(255) NOT NULL,
    "artist" character varying(255),
    "sequence" integer NOT NULL
);


--
-- Name: track_raw_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."track_raw_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: track_raw_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."track_raw_id_seq" OWNED BY "musicbrainz"."track_raw"."id";


--
-- Name: unreferenced_row_log; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."unreferenced_row_log" (
    "table_name" character varying NOT NULL,
    "row_id" integer NOT NULL,
    "inserted" timestamp with time zone DEFAULT "now"()
);


--
-- Name: url; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."url" (
    "id" integer NOT NULL,
    "gid" "uuid" NOT NULL,
    "url" "text" NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "url_edits_pending_check" CHECK (("edits_pending" >= 0))
);


--
-- Name: url_gid_redirect; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."url_gid_redirect" (
    "gid" "uuid" NOT NULL,
    "new_id" integer NOT NULL,
    "created" timestamp with time zone DEFAULT "now"()
);


--
-- Name: url_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."url_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: url_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."url_id_seq" OWNED BY "musicbrainz"."url"."id";


--
-- Name: vote; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."vote" (
    "id" integer NOT NULL,
    "editor" integer NOT NULL,
    "edit" integer NOT NULL,
    "vote" smallint NOT NULL,
    "vote_time" timestamp with time zone DEFAULT "now"(),
    "superseded" boolean DEFAULT false NOT NULL
);


--
-- Name: vote_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."vote_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vote_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."vote_id_seq" OWNED BY "musicbrainz"."vote"."id";


--
-- Name: work; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."work" (
    "id" integer NOT NULL,
    "gid" "uuid" NOT NULL,
    "name" character varying NOT NULL,
    "type" integer,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "work_edits_pending_check" CHECK (("edits_pending" >= 0))
);


--
-- Name: work_alias; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."work_alias" (
    "id" integer NOT NULL,
    "work" integer NOT NULL,
    "name" character varying NOT NULL,
    "locale" "text",
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"(),
    "type" integer,
    "sort_name" character varying NOT NULL,
    "begin_date_year" smallint,
    "begin_date_month" smallint,
    "begin_date_day" smallint,
    "end_date_year" smallint,
    "end_date_month" smallint,
    "end_date_day" smallint,
    "primary_for_locale" boolean DEFAULT false NOT NULL,
    "ended" boolean DEFAULT false NOT NULL,
    CONSTRAINT "primary_check" CHECK (((("locale" IS NULL) AND ("primary_for_locale" IS FALSE)) OR ("locale" IS NOT NULL))),
    CONSTRAINT "search_hints_are_empty" CHECK ((("type" <> 2) OR (("type" = 2) AND (("sort_name")::"text" = ("name")::"text") AND ("begin_date_year" IS NULL) AND ("begin_date_month" IS NULL) AND ("begin_date_day" IS NULL) AND ("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL) AND ("primary_for_locale" IS FALSE) AND ("locale" IS NULL)))),
    CONSTRAINT "work_alias_check" CHECK ((((("end_date_year" IS NOT NULL) OR ("end_date_month" IS NOT NULL) OR ("end_date_day" IS NOT NULL)) AND ("ended" = true)) OR (("end_date_year" IS NULL) AND ("end_date_month" IS NULL) AND ("end_date_day" IS NULL)))),
    CONSTRAINT "work_alias_edits_pending_check" CHECK (("edits_pending" >= 0))
);


--
-- Name: work_alias_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."work_alias_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: work_alias_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."work_alias_id_seq" OWNED BY "musicbrainz"."work_alias"."id";


--
-- Name: work_alias_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."work_alias_type" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: work_alias_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."work_alias_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: work_alias_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."work_alias_type_id_seq" OWNED BY "musicbrainz"."work_alias_type"."id";


--
-- Name: work_annotation; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."work_annotation" (
    "work" integer NOT NULL,
    "annotation" integer NOT NULL
);


--
-- Name: work_attribute; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."work_attribute" (
    "id" integer NOT NULL,
    "work" integer NOT NULL,
    "work_attribute_type" integer NOT NULL,
    "work_attribute_type_allowed_value" integer,
    "work_attribute_text" "text",
    CONSTRAINT "work_attribute_check" CHECK (((("work_attribute_type_allowed_value" IS NULL) AND ("work_attribute_text" IS NOT NULL)) OR (("work_attribute_type_allowed_value" IS NOT NULL) AND ("work_attribute_text" IS NULL))))
);


--
-- Name: work_attribute_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."work_attribute_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: work_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."work_attribute_id_seq" OWNED BY "musicbrainz"."work_attribute"."id";


--
-- Name: work_attribute_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."work_attribute_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "comment" character varying(255) DEFAULT ''::character varying NOT NULL,
    "free_text" boolean NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: work_attribute_type_allowed_value; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."work_attribute_type_allowed_value" (
    "id" integer NOT NULL,
    "work_attribute_type" integer NOT NULL,
    "value" "text",
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: work_attribute_type_allowed_value_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."work_attribute_type_allowed_value_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: work_attribute_type_allowed_value_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."work_attribute_type_allowed_value_id_seq" OWNED BY "musicbrainz"."work_attribute_type_allowed_value"."id";


--
-- Name: work_attribute_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."work_attribute_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: work_attribute_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."work_attribute_type_id_seq" OWNED BY "musicbrainz"."work_attribute_type"."id";


--
-- Name: work_gid_redirect; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."work_gid_redirect" (
    "gid" "uuid" NOT NULL,
    "new_id" integer NOT NULL,
    "created" timestamp with time zone DEFAULT "now"()
);


--
-- Name: work_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."work_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: work_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."work_id_seq" OWNED BY "musicbrainz"."work"."id";


--
-- Name: work_language; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."work_language" (
    "work" integer NOT NULL,
    "language" integer NOT NULL,
    "edits_pending" integer DEFAULT 0 NOT NULL,
    "created" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "work_language_edits_pending_check" CHECK (("edits_pending" >= 0))
);


--
-- Name: work_meta; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."work_meta" (
    "id" integer NOT NULL,
    "rating" smallint,
    "rating_count" integer,
    CONSTRAINT "work_meta_rating_check" CHECK ((("rating" >= 0) AND ("rating" <= 100)))
);


--
-- Name: work_rating_raw; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."work_rating_raw" (
    "work" integer NOT NULL,
    "editor" integer NOT NULL,
    "rating" smallint NOT NULL,
    CONSTRAINT "work_rating_raw_rating_check" CHECK ((("rating" >= 0) AND ("rating" <= 100)))
);


--
-- Name: work_series; Type: VIEW; Schema: musicbrainz; Owner: -
--

CREATE VIEW "musicbrainz"."work_series" AS
 SELECT "lsw"."entity1" AS "work",
    "lsw"."entity0" AS "series",
    "lsw"."id" AS "relationship",
    "lsw"."link_order",
    "lsw"."link",
    COALESCE("latv"."text_value", ''::"text") AS "text_value"
   FROM (((("musicbrainz"."l_series_work" "lsw"
     JOIN "musicbrainz"."series" "s" ON (("s"."id" = "lsw"."entity0")))
     JOIN "musicbrainz"."link" "l" ON (("l"."id" = "lsw"."link")))
     JOIN "musicbrainz"."link_type" "lt" ON ((("lt"."id" = "l"."link_type") AND ("lt"."gid" = 'b0d44366-cdf0-3acb-bee6-0f65a77a6ef0'::"uuid"))))
     LEFT JOIN "musicbrainz"."link_attribute_text_value" "latv" ON ((("latv"."attribute_type" = 788) AND ("latv"."link" = "l"."id"))))
  ORDER BY "lsw"."entity0", "lsw"."link_order";


--
-- Name: work_tag; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."work_tag" (
    "work" integer NOT NULL,
    "tag" integer NOT NULL,
    "count" integer NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "now"()
);


--
-- Name: work_tag_raw; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."work_tag_raw" (
    "work" integer NOT NULL,
    "editor" integer NOT NULL,
    "tag" integer NOT NULL,
    "is_upvote" boolean DEFAULT true NOT NULL
);


--
-- Name: work_type; Type: TABLE; Schema: musicbrainz; Owner: -
--

CREATE TABLE "musicbrainz"."work_type" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "parent" integer,
    "child_order" integer DEFAULT 0 NOT NULL,
    "description" "text",
    "gid" "uuid" NOT NULL
);


--
-- Name: work_type_id_seq; Type: SEQUENCE; Schema: musicbrainz; Owner: -
--

CREATE SEQUENCE "musicbrainz"."work_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: work_type_id_seq; Type: SEQUENCE OWNED BY; Schema: musicbrainz; Owner: -
--

ALTER SEQUENCE "musicbrainz"."work_type_id_seq" OWNED BY "musicbrainz"."work_type"."id";


--
-- Name: index; Type: TABLE; Schema: report; Owner: -
--

CREATE TABLE "report"."index" (
    "report_name" "text" NOT NULL,
    "generated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


--
-- Name: artist_lastmod; Type: TABLE; Schema: sitemaps; Owner: -
--

CREATE TABLE "sitemaps"."artist_lastmod" (
    "id" integer NOT NULL,
    "url" character varying(128) NOT NULL,
    "paginated" boolean NOT NULL,
    "sitemap_suffix_key" character varying(50) NOT NULL,
    "jsonld_sha1" "bytea" NOT NULL,
    "last_modified" timestamp with time zone NOT NULL,
    "replication_sequence" integer NOT NULL
);


--
-- Name: control; Type: TABLE; Schema: sitemaps; Owner: -
--

CREATE TABLE "sitemaps"."control" (
    "last_processed_replication_sequence" integer,
    "overall_sitemaps_replication_sequence" integer,
    "building_overall_sitemaps" boolean NOT NULL
);


--
-- Name: label_lastmod; Type: TABLE; Schema: sitemaps; Owner: -
--

CREATE TABLE "sitemaps"."label_lastmod" (
    "id" integer NOT NULL,
    "url" character varying(128) NOT NULL,
    "paginated" boolean NOT NULL,
    "sitemap_suffix_key" character varying(50) NOT NULL,
    "jsonld_sha1" "bytea" NOT NULL,
    "last_modified" timestamp with time zone NOT NULL,
    "replication_sequence" integer NOT NULL
);


--
-- Name: place_lastmod; Type: TABLE; Schema: sitemaps; Owner: -
--

CREATE TABLE "sitemaps"."place_lastmod" (
    "id" integer NOT NULL,
    "url" character varying(128) NOT NULL,
    "paginated" boolean NOT NULL,
    "sitemap_suffix_key" character varying(50) NOT NULL,
    "jsonld_sha1" "bytea" NOT NULL,
    "last_modified" timestamp with time zone NOT NULL,
    "replication_sequence" integer NOT NULL
);


--
-- Name: recording_lastmod; Type: TABLE; Schema: sitemaps; Owner: -
--

CREATE TABLE "sitemaps"."recording_lastmod" (
    "id" integer NOT NULL,
    "url" character varying(128) NOT NULL,
    "paginated" boolean NOT NULL,
    "sitemap_suffix_key" character varying(50) NOT NULL,
    "jsonld_sha1" "bytea" NOT NULL,
    "last_modified" timestamp with time zone NOT NULL,
    "replication_sequence" integer NOT NULL
);


--
-- Name: release_group_lastmod; Type: TABLE; Schema: sitemaps; Owner: -
--

CREATE TABLE "sitemaps"."release_group_lastmod" (
    "id" integer NOT NULL,
    "url" character varying(128) NOT NULL,
    "paginated" boolean NOT NULL,
    "sitemap_suffix_key" character varying(50) NOT NULL,
    "jsonld_sha1" "bytea" NOT NULL,
    "last_modified" timestamp with time zone NOT NULL,
    "replication_sequence" integer NOT NULL
);


--
-- Name: release_lastmod; Type: TABLE; Schema: sitemaps; Owner: -
--

CREATE TABLE "sitemaps"."release_lastmod" (
    "id" integer NOT NULL,
    "url" character varying(128) NOT NULL,
    "paginated" boolean NOT NULL,
    "sitemap_suffix_key" character varying(50) NOT NULL,
    "jsonld_sha1" "bytea" NOT NULL,
    "last_modified" timestamp with time zone NOT NULL,
    "replication_sequence" integer NOT NULL
);


--
-- Name: tmp_checked_entities; Type: TABLE; Schema: sitemaps; Owner: -
--

CREATE TABLE "sitemaps"."tmp_checked_entities" (
    "id" integer NOT NULL,
    "entity_type" character varying(50) NOT NULL
);


--
-- Name: work_lastmod; Type: TABLE; Schema: sitemaps; Owner: -
--

CREATE TABLE "sitemaps"."work_lastmod" (
    "id" integer NOT NULL,
    "url" character varying(128) NOT NULL,
    "paginated" boolean NOT NULL,
    "sitemap_suffix_key" character varying(50) NOT NULL,
    "jsonld_sha1" "bytea" NOT NULL,
    "last_modified" timestamp with time zone NOT NULL,
    "replication_sequence" integer NOT NULL
);


--
-- Name: statistic; Type: TABLE; Schema: statistics; Owner: -
--

CREATE TABLE "statistics"."statistic" (
    "id" integer NOT NULL,
    "name" character varying(100) NOT NULL,
    "value" integer NOT NULL,
    "date_collected" "date" DEFAULT "now"() NOT NULL
);


--
-- Name: statistic_event; Type: TABLE; Schema: statistics; Owner: -
--

CREATE TABLE "statistics"."statistic_event" (
    "date" "date" NOT NULL,
    "title" "text" NOT NULL,
    "link" "text" NOT NULL,
    "description" "text" NOT NULL,
    CONSTRAINT "statistic_event_date_check" CHECK (("date" >= '2000-01-01'::"date"))
);


--
-- Name: statistic_id_seq; Type: SEQUENCE; Schema: statistics; Owner: -
--

CREATE SEQUENCE "statistics"."statistic_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: statistic_id_seq; Type: SEQUENCE OWNED BY; Schema: statistics; Owner: -
--

ALTER SEQUENCE "statistics"."statistic_id_seq" OWNED BY "statistics"."statistic"."id";


--
-- Name: wikidocs_index; Type: TABLE; Schema: wikidocs; Owner: -
--

CREATE TABLE "wikidocs"."wikidocs_index" (
    "page_name" "text" NOT NULL,
    "revision" integer NOT NULL
);


--
-- Name: artist_release_group_nonva; Type: TABLE ATTACH; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_release_group" ATTACH PARTITION "musicbrainz"."artist_release_group_nonva" FOR VALUES IN (false);


--
-- Name: artist_release_group_va; Type: TABLE ATTACH; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_release_group" ATTACH PARTITION "musicbrainz"."artist_release_group_va" FOR VALUES IN (true);


--
-- Name: artist_release_nonva; Type: TABLE ATTACH; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_release" ATTACH PARTITION "musicbrainz"."artist_release_nonva" FOR VALUES IN (false);


--
-- Name: artist_release_va; Type: TABLE ATTACH; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_release" ATTACH PARTITION "musicbrainz"."artist_release_va" FOR VALUES IN (true);


--
-- Name: art_type id; Type: DEFAULT; Schema: cover_art_archive; Owner: -
--

ALTER TABLE ONLY "cover_art_archive"."art_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"cover_art_archive"."art_type_id_seq"'::"regclass");


--
-- Name: pending_data seqid; Type: DEFAULT; Schema: dbmirror2; Owner: -
--

ALTER TABLE ONLY "dbmirror2"."pending_data" ALTER COLUMN "seqid" SET DEFAULT "nextval"('"dbmirror2"."pending_data_seqid_seq"'::"regclass");


--
-- Name: art_type id; Type: DEFAULT; Schema: event_art_archive; Owner: -
--

ALTER TABLE ONLY "event_art_archive"."art_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"event_art_archive"."art_type_id_seq"'::"regclass");


--
-- Name: alternative_medium id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."alternative_medium" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."alternative_medium_id_seq"'::"regclass");


--
-- Name: alternative_release id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."alternative_release" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."alternative_release_id_seq"'::"regclass");


--
-- Name: alternative_release_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."alternative_release_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."alternative_release_type_id_seq"'::"regclass");


--
-- Name: alternative_track id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."alternative_track" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."alternative_track_id_seq"'::"regclass");


--
-- Name: annotation id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."annotation" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."annotation_id_seq"'::"regclass");


--
-- Name: application id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."application" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."application_id_seq"'::"regclass");


--
-- Name: area id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."area" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."area_id_seq"'::"regclass");


--
-- Name: area_alias id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."area_alias" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."area_alias_id_seq"'::"regclass");


--
-- Name: area_alias_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."area_alias_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."area_alias_type_id_seq"'::"regclass");


--
-- Name: area_attribute id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."area_attribute" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."area_attribute_id_seq"'::"regclass");


--
-- Name: area_attribute_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."area_attribute_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."area_attribute_type_id_seq"'::"regclass");


--
-- Name: area_attribute_type_allowed_value id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."area_attribute_type_allowed_value" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."area_attribute_type_allowed_value_id_seq"'::"regclass");


--
-- Name: area_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."area_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."area_type_id_seq"'::"regclass");


--
-- Name: artist id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."artist_id_seq"'::"regclass");


--
-- Name: artist_alias id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_alias" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."artist_alias_id_seq"'::"regclass");


--
-- Name: artist_alias_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_alias_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."artist_alias_type_id_seq"'::"regclass");


--
-- Name: artist_attribute id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_attribute" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."artist_attribute_id_seq"'::"regclass");


--
-- Name: artist_attribute_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_attribute_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."artist_attribute_type_id_seq"'::"regclass");


--
-- Name: artist_attribute_type_allowed_value id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_attribute_type_allowed_value" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."artist_attribute_type_allowed_value_id_seq"'::"regclass");


--
-- Name: artist_credit id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_credit" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."artist_credit_id_seq"'::"regclass");


--
-- Name: artist_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."artist_type_id_seq"'::"regclass");


--
-- Name: autoeditor_election id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."autoeditor_election" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."autoeditor_election_id_seq"'::"regclass");


--
-- Name: autoeditor_election_vote id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."autoeditor_election_vote" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."autoeditor_election_vote_id_seq"'::"regclass");


--
-- Name: cdtoc id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."cdtoc" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."cdtoc_id_seq"'::"regclass");


--
-- Name: cdtoc_raw id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."cdtoc_raw" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."cdtoc_raw_id_seq"'::"regclass");


--
-- Name: dbmirror_pending seqid; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."dbmirror_pending" ALTER COLUMN "seqid" SET DEFAULT "nextval"('"musicbrainz"."dbmirror_pending_seqid_seq"'::"regclass");


--
-- Name: edit id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."edit_id_seq"'::"regclass");


--
-- Name: edit_note id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit_note" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."edit_note_id_seq"'::"regclass");


--
-- Name: edit_note_change id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit_note_change" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."edit_note_change_id_seq"'::"regclass");


--
-- Name: editor id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."editor_id_seq"'::"regclass");


--
-- Name: editor_collection id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_collection" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."editor_collection_id_seq"'::"regclass");


--
-- Name: editor_collection_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_collection_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."editor_collection_type_id_seq"'::"regclass");


--
-- Name: editor_oauth_token id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_oauth_token" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."editor_oauth_token_id_seq"'::"regclass");


--
-- Name: editor_preference id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_preference" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."editor_preference_id_seq"'::"regclass");


--
-- Name: editor_subscribe_artist id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_subscribe_artist" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."editor_subscribe_artist_id_seq"'::"regclass");


--
-- Name: editor_subscribe_collection id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_subscribe_collection" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."editor_subscribe_collection_id_seq"'::"regclass");


--
-- Name: editor_subscribe_editor id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_subscribe_editor" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."editor_subscribe_editor_id_seq"'::"regclass");


--
-- Name: editor_subscribe_label id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_subscribe_label" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."editor_subscribe_label_id_seq"'::"regclass");


--
-- Name: editor_subscribe_series id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_subscribe_series" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."editor_subscribe_series_id_seq"'::"regclass");


--
-- Name: event id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."event" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."event_id_seq"'::"regclass");


--
-- Name: event_alias id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."event_alias" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."event_alias_id_seq"'::"regclass");


--
-- Name: event_alias_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."event_alias_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."event_alias_type_id_seq"'::"regclass");


--
-- Name: event_attribute id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."event_attribute" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."event_attribute_id_seq"'::"regclass");


--
-- Name: event_attribute_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."event_attribute_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."event_attribute_type_id_seq"'::"regclass");


--
-- Name: event_attribute_type_allowed_value id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."event_attribute_type_allowed_value" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."event_attribute_type_allowed_value_id_seq"'::"regclass");


--
-- Name: event_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."event_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."event_type_id_seq"'::"regclass");


--
-- Name: gender id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."gender" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."gender_id_seq"'::"regclass");


--
-- Name: genre id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."genre" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."genre_id_seq"'::"regclass");


--
-- Name: genre_alias id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."genre_alias" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."genre_alias_id_seq"'::"regclass");


--
-- Name: genre_alias_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."genre_alias_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."genre_alias_type_id_seq"'::"regclass");


--
-- Name: instrument id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."instrument" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."instrument_id_seq"'::"regclass");


--
-- Name: instrument_alias id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."instrument_alias" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."instrument_alias_id_seq"'::"regclass");


--
-- Name: instrument_alias_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."instrument_alias_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."instrument_alias_type_id_seq"'::"regclass");


--
-- Name: instrument_attribute id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."instrument_attribute" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."instrument_attribute_id_seq"'::"regclass");


--
-- Name: instrument_attribute_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."instrument_attribute_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."instrument_attribute_type_id_seq"'::"regclass");


--
-- Name: instrument_attribute_type_allowed_value id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."instrument_attribute_type_allowed_value" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."instrument_attribute_type_allowed_value_id_seq"'::"regclass");


--
-- Name: instrument_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."instrument_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."instrument_type_id_seq"'::"regclass");


--
-- Name: isrc id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."isrc" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."isrc_id_seq"'::"regclass");


--
-- Name: iswc id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."iswc" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."iswc_id_seq"'::"regclass");


--
-- Name: l_area_area id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_area" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_area_area_id_seq"'::"regclass");


--
-- Name: l_area_artist id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_artist" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_area_artist_id_seq"'::"regclass");


--
-- Name: l_area_event id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_event" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_area_event_id_seq"'::"regclass");


--
-- Name: l_area_genre id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_genre" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_area_genre_id_seq"'::"regclass");


--
-- Name: l_area_instrument id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_instrument" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_area_instrument_id_seq"'::"regclass");


--
-- Name: l_area_label id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_label" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_area_label_id_seq"'::"regclass");


--
-- Name: l_area_mood id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_mood" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_area_mood_id_seq"'::"regclass");


--
-- Name: l_area_place id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_place" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_area_place_id_seq"'::"regclass");


--
-- Name: l_area_recording id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_recording" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_area_recording_id_seq"'::"regclass");


--
-- Name: l_area_release id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_release" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_area_release_id_seq"'::"regclass");


--
-- Name: l_area_release_group id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_release_group" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_area_release_group_id_seq"'::"regclass");


--
-- Name: l_area_series id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_series" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_area_series_id_seq"'::"regclass");


--
-- Name: l_area_url id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_url" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_area_url_id_seq"'::"regclass");


--
-- Name: l_area_work id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_work" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_area_work_id_seq"'::"regclass");


--
-- Name: l_artist_artist id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_artist" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_artist_artist_id_seq"'::"regclass");


--
-- Name: l_artist_event id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_event" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_artist_event_id_seq"'::"regclass");


--
-- Name: l_artist_genre id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_genre" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_artist_genre_id_seq"'::"regclass");


--
-- Name: l_artist_instrument id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_instrument" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_artist_instrument_id_seq"'::"regclass");


--
-- Name: l_artist_label id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_label" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_artist_label_id_seq"'::"regclass");


--
-- Name: l_artist_mood id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_mood" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_artist_mood_id_seq"'::"regclass");


--
-- Name: l_artist_place id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_place" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_artist_place_id_seq"'::"regclass");


--
-- Name: l_artist_recording id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_recording" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_artist_recording_id_seq"'::"regclass");


--
-- Name: l_artist_release id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_release" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_artist_release_id_seq"'::"regclass");


--
-- Name: l_artist_release_group id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_release_group" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_artist_release_group_id_seq"'::"regclass");


--
-- Name: l_artist_series id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_series" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_artist_series_id_seq"'::"regclass");


--
-- Name: l_artist_url id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_url" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_artist_url_id_seq"'::"regclass");


--
-- Name: l_artist_work id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_work" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_artist_work_id_seq"'::"regclass");


--
-- Name: l_event_event id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_event" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_event_event_id_seq"'::"regclass");


--
-- Name: l_event_genre id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_genre" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_event_genre_id_seq"'::"regclass");


--
-- Name: l_event_instrument id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_instrument" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_event_instrument_id_seq"'::"regclass");


--
-- Name: l_event_label id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_label" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_event_label_id_seq"'::"regclass");


--
-- Name: l_event_mood id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_mood" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_event_mood_id_seq"'::"regclass");


--
-- Name: l_event_place id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_place" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_event_place_id_seq"'::"regclass");


--
-- Name: l_event_recording id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_recording" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_event_recording_id_seq"'::"regclass");


--
-- Name: l_event_release id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_release" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_event_release_id_seq"'::"regclass");


--
-- Name: l_event_release_group id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_release_group" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_event_release_group_id_seq"'::"regclass");


--
-- Name: l_event_series id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_series" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_event_series_id_seq"'::"regclass");


--
-- Name: l_event_url id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_url" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_event_url_id_seq"'::"regclass");


--
-- Name: l_event_work id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_work" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_event_work_id_seq"'::"regclass");


--
-- Name: l_genre_genre id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_genre" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_genre_genre_id_seq"'::"regclass");


--
-- Name: l_genre_instrument id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_instrument" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_genre_instrument_id_seq"'::"regclass");


--
-- Name: l_genre_label id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_label" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_genre_label_id_seq"'::"regclass");


--
-- Name: l_genre_mood id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_mood" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_genre_mood_id_seq"'::"regclass");


--
-- Name: l_genre_place id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_place" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_genre_place_id_seq"'::"regclass");


--
-- Name: l_genre_recording id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_recording" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_genre_recording_id_seq"'::"regclass");


--
-- Name: l_genre_release id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_release" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_genre_release_id_seq"'::"regclass");


--
-- Name: l_genre_release_group id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_release_group" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_genre_release_group_id_seq"'::"regclass");


--
-- Name: l_genre_series id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_series" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_genre_series_id_seq"'::"regclass");


--
-- Name: l_genre_url id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_url" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_genre_url_id_seq"'::"regclass");


--
-- Name: l_genre_work id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_work" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_genre_work_id_seq"'::"regclass");


--
-- Name: l_instrument_instrument id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_instrument_instrument" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_instrument_instrument_id_seq"'::"regclass");


--
-- Name: l_instrument_label id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_instrument_label" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_instrument_label_id_seq"'::"regclass");


--
-- Name: l_instrument_mood id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_instrument_mood" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_instrument_mood_id_seq"'::"regclass");


--
-- Name: l_instrument_place id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_instrument_place" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_instrument_place_id_seq"'::"regclass");


--
-- Name: l_instrument_recording id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_instrument_recording" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_instrument_recording_id_seq"'::"regclass");


--
-- Name: l_instrument_release id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_instrument_release" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_instrument_release_id_seq"'::"regclass");


--
-- Name: l_instrument_release_group id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_instrument_release_group" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_instrument_release_group_id_seq"'::"regclass");


--
-- Name: l_instrument_series id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_instrument_series" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_instrument_series_id_seq"'::"regclass");


--
-- Name: l_instrument_url id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_instrument_url" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_instrument_url_id_seq"'::"regclass");


--
-- Name: l_instrument_work id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_instrument_work" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_instrument_work_id_seq"'::"regclass");


--
-- Name: l_label_label id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_label_label" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_label_label_id_seq"'::"regclass");


--
-- Name: l_label_mood id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_label_mood" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_label_mood_id_seq"'::"regclass");


--
-- Name: l_label_place id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_label_place" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_label_place_id_seq"'::"regclass");


--
-- Name: l_label_recording id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_label_recording" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_label_recording_id_seq"'::"regclass");


--
-- Name: l_label_release id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_label_release" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_label_release_id_seq"'::"regclass");


--
-- Name: l_label_release_group id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_label_release_group" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_label_release_group_id_seq"'::"regclass");


--
-- Name: l_label_series id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_label_series" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_label_series_id_seq"'::"regclass");


--
-- Name: l_label_url id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_label_url" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_label_url_id_seq"'::"regclass");


--
-- Name: l_label_work id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_label_work" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_label_work_id_seq"'::"regclass");


--
-- Name: l_mood_mood id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_mood_mood" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_mood_mood_id_seq"'::"regclass");


--
-- Name: l_mood_place id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_mood_place" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_mood_place_id_seq"'::"regclass");


--
-- Name: l_mood_recording id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_mood_recording" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_mood_recording_id_seq"'::"regclass");


--
-- Name: l_mood_release id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_mood_release" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_mood_release_id_seq"'::"regclass");


--
-- Name: l_mood_release_group id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_mood_release_group" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_mood_release_group_id_seq"'::"regclass");


--
-- Name: l_mood_series id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_mood_series" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_mood_series_id_seq"'::"regclass");


--
-- Name: l_mood_url id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_mood_url" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_mood_url_id_seq"'::"regclass");


--
-- Name: l_mood_work id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_mood_work" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_mood_work_id_seq"'::"regclass");


--
-- Name: l_place_place id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_place_place" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_place_place_id_seq"'::"regclass");


--
-- Name: l_place_recording id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_place_recording" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_place_recording_id_seq"'::"regclass");


--
-- Name: l_place_release id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_place_release" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_place_release_id_seq"'::"regclass");


--
-- Name: l_place_release_group id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_place_release_group" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_place_release_group_id_seq"'::"regclass");


--
-- Name: l_place_series id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_place_series" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_place_series_id_seq"'::"regclass");


--
-- Name: l_place_url id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_place_url" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_place_url_id_seq"'::"regclass");


--
-- Name: l_place_work id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_place_work" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_place_work_id_seq"'::"regclass");


--
-- Name: l_recording_recording id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_recording_recording" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_recording_recording_id_seq"'::"regclass");


--
-- Name: l_recording_release id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_recording_release" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_recording_release_id_seq"'::"regclass");


--
-- Name: l_recording_release_group id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_recording_release_group" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_recording_release_group_id_seq"'::"regclass");


--
-- Name: l_recording_series id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_recording_series" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_recording_series_id_seq"'::"regclass");


--
-- Name: l_recording_url id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_recording_url" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_recording_url_id_seq"'::"regclass");


--
-- Name: l_recording_work id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_recording_work" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_recording_work_id_seq"'::"regclass");


--
-- Name: l_release_group_release_group id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_release_group_release_group" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_release_group_release_group_id_seq"'::"regclass");


--
-- Name: l_release_group_series id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_release_group_series" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_release_group_series_id_seq"'::"regclass");


--
-- Name: l_release_group_url id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_release_group_url" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_release_group_url_id_seq"'::"regclass");


--
-- Name: l_release_group_work id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_release_group_work" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_release_group_work_id_seq"'::"regclass");


--
-- Name: l_release_release id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_release_release" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_release_release_id_seq"'::"regclass");


--
-- Name: l_release_release_group id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_release_release_group" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_release_release_group_id_seq"'::"regclass");


--
-- Name: l_release_series id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_release_series" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_release_series_id_seq"'::"regclass");


--
-- Name: l_release_url id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_release_url" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_release_url_id_seq"'::"regclass");


--
-- Name: l_release_work id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_release_work" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_release_work_id_seq"'::"regclass");


--
-- Name: l_series_series id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_series_series" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_series_series_id_seq"'::"regclass");


--
-- Name: l_series_url id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_series_url" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_series_url_id_seq"'::"regclass");


--
-- Name: l_series_work id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_series_work" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_series_work_id_seq"'::"regclass");


--
-- Name: l_url_url id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_url_url" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_url_url_id_seq"'::"regclass");


--
-- Name: l_url_work id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_url_work" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_url_work_id_seq"'::"regclass");


--
-- Name: l_work_work id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_work_work" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."l_work_work_id_seq"'::"regclass");


--
-- Name: label id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."label_id_seq"'::"regclass");


--
-- Name: label_alias id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label_alias" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."label_alias_id_seq"'::"regclass");


--
-- Name: label_alias_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label_alias_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."label_alias_type_id_seq"'::"regclass");


--
-- Name: label_attribute id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label_attribute" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."label_attribute_id_seq"'::"regclass");


--
-- Name: label_attribute_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label_attribute_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."label_attribute_type_id_seq"'::"regclass");


--
-- Name: label_attribute_type_allowed_value id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label_attribute_type_allowed_value" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."label_attribute_type_allowed_value_id_seq"'::"regclass");


--
-- Name: label_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."label_type_id_seq"'::"regclass");


--
-- Name: language id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."language" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."language_id_seq"'::"regclass");


--
-- Name: link id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."link" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."link_id_seq"'::"regclass");


--
-- Name: link_attribute_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."link_attribute_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."link_attribute_type_id_seq"'::"regclass");


--
-- Name: link_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."link_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."link_type_id_seq"'::"regclass");


--
-- Name: medium id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."medium" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."medium_id_seq"'::"regclass");


--
-- Name: medium_attribute id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."medium_attribute" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."medium_attribute_id_seq"'::"regclass");


--
-- Name: medium_attribute_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."medium_attribute_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."medium_attribute_type_id_seq"'::"regclass");


--
-- Name: medium_attribute_type_allowed_value id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."medium_attribute_type_allowed_value" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."medium_attribute_type_allowed_value_id_seq"'::"regclass");


--
-- Name: medium_cdtoc id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."medium_cdtoc" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."medium_cdtoc_id_seq"'::"regclass");


--
-- Name: medium_format id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."medium_format" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."medium_format_id_seq"'::"regclass");


--
-- Name: mood id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."mood" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."mood_id_seq"'::"regclass");


--
-- Name: mood_alias id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."mood_alias" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."mood_alias_id_seq"'::"regclass");


--
-- Name: mood_alias_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."mood_alias_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."mood_alias_type_id_seq"'::"regclass");


--
-- Name: place id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."place" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."place_id_seq"'::"regclass");


--
-- Name: place_alias id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."place_alias" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."place_alias_id_seq"'::"regclass");


--
-- Name: place_alias_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."place_alias_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."place_alias_type_id_seq"'::"regclass");


--
-- Name: place_attribute id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."place_attribute" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."place_attribute_id_seq"'::"regclass");


--
-- Name: place_attribute_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."place_attribute_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."place_attribute_type_id_seq"'::"regclass");


--
-- Name: place_attribute_type_allowed_value id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."place_attribute_type_allowed_value" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."place_attribute_type_allowed_value_id_seq"'::"regclass");


--
-- Name: place_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."place_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."place_type_id_seq"'::"regclass");


--
-- Name: recording id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."recording" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."recording_id_seq"'::"regclass");


--
-- Name: recording_alias id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."recording_alias" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."recording_alias_id_seq"'::"regclass");


--
-- Name: recording_alias_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."recording_alias_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."recording_alias_type_id_seq"'::"regclass");


--
-- Name: recording_attribute id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."recording_attribute" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."recording_attribute_id_seq"'::"regclass");


--
-- Name: recording_attribute_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."recording_attribute_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."recording_attribute_type_id_seq"'::"regclass");


--
-- Name: recording_attribute_type_allowed_value id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."recording_attribute_type_allowed_value" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."recording_attribute_type_allowed_value_id_seq"'::"regclass");


--
-- Name: release id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."release_id_seq"'::"regclass");


--
-- Name: release_alias id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_alias" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."release_alias_id_seq"'::"regclass");


--
-- Name: release_alias_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_alias_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."release_alias_type_id_seq"'::"regclass");


--
-- Name: release_attribute id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_attribute" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."release_attribute_id_seq"'::"regclass");


--
-- Name: release_attribute_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_attribute_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."release_attribute_type_id_seq"'::"regclass");


--
-- Name: release_attribute_type_allowed_value id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_attribute_type_allowed_value" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."release_attribute_type_allowed_value_id_seq"'::"regclass");


--
-- Name: release_group id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."release_group_id_seq"'::"regclass");


--
-- Name: release_group_alias id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group_alias" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."release_group_alias_id_seq"'::"regclass");


--
-- Name: release_group_alias_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group_alias_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."release_group_alias_type_id_seq"'::"regclass");


--
-- Name: release_group_attribute id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group_attribute" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."release_group_attribute_id_seq"'::"regclass");


--
-- Name: release_group_attribute_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group_attribute_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."release_group_attribute_type_id_seq"'::"regclass");


--
-- Name: release_group_attribute_type_allowed_value id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group_attribute_type_allowed_value" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."release_group_attribute_type_allowed_value_id_seq"'::"regclass");


--
-- Name: release_group_primary_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group_primary_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."release_group_primary_type_id_seq"'::"regclass");


--
-- Name: release_group_secondary_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group_secondary_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."release_group_secondary_type_id_seq"'::"regclass");


--
-- Name: release_label id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_label" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."release_label_id_seq"'::"regclass");


--
-- Name: release_packaging id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_packaging" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."release_packaging_id_seq"'::"regclass");


--
-- Name: release_raw id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_raw" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."release_raw_id_seq"'::"regclass");


--
-- Name: release_status id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_status" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."release_status_id_seq"'::"regclass");


--
-- Name: replication_control id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."replication_control" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."replication_control_id_seq"'::"regclass");


--
-- Name: script id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."script" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."script_id_seq"'::"regclass");


--
-- Name: series id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."series" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."series_id_seq"'::"regclass");


--
-- Name: series_alias id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."series_alias" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."series_alias_id_seq"'::"regclass");


--
-- Name: series_alias_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."series_alias_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."series_alias_type_id_seq"'::"regclass");


--
-- Name: series_attribute id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."series_attribute" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."series_attribute_id_seq"'::"regclass");


--
-- Name: series_attribute_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."series_attribute_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."series_attribute_type_id_seq"'::"regclass");


--
-- Name: series_attribute_type_allowed_value id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."series_attribute_type_allowed_value" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."series_attribute_type_allowed_value_id_seq"'::"regclass");


--
-- Name: series_ordering_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."series_ordering_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."series_ordering_type_id_seq"'::"regclass");


--
-- Name: series_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."series_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."series_type_id_seq"'::"regclass");


--
-- Name: tag id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."tag" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."tag_id_seq"'::"regclass");


--
-- Name: track id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."track" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."track_id_seq"'::"regclass");


--
-- Name: track_raw id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."track_raw" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."track_raw_id_seq"'::"regclass");


--
-- Name: url id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."url" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."url_id_seq"'::"regclass");


--
-- Name: vote id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."vote" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."vote_id_seq"'::"regclass");


--
-- Name: work id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."work" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."work_id_seq"'::"regclass");


--
-- Name: work_alias id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."work_alias" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."work_alias_id_seq"'::"regclass");


--
-- Name: work_alias_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."work_alias_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."work_alias_type_id_seq"'::"regclass");


--
-- Name: work_attribute id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."work_attribute" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."work_attribute_id_seq"'::"regclass");


--
-- Name: work_attribute_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."work_attribute_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."work_attribute_type_id_seq"'::"regclass");


--
-- Name: work_attribute_type_allowed_value id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."work_attribute_type_allowed_value" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."work_attribute_type_allowed_value_id_seq"'::"regclass");


--
-- Name: work_type id; Type: DEFAULT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."work_type" ALTER COLUMN "id" SET DEFAULT "nextval"('"musicbrainz"."work_type_id_seq"'::"regclass");


--
-- Name: statistic id; Type: DEFAULT; Schema: statistics; Owner: -
--

ALTER TABLE ONLY "statistics"."statistic" ALTER COLUMN "id" SET DEFAULT "nextval"('"statistics"."statistic_id_seq"'::"regclass");


--
-- Name: art_type art_type_pkey; Type: CONSTRAINT; Schema: cover_art_archive; Owner: -
--

ALTER TABLE ONLY "cover_art_archive"."art_type"
    ADD CONSTRAINT "art_type_pkey" PRIMARY KEY ("id");


--
-- Name: cover_art cover_art_pkey; Type: CONSTRAINT; Schema: cover_art_archive; Owner: -
--

ALTER TABLE ONLY "cover_art_archive"."cover_art"
    ADD CONSTRAINT "cover_art_pkey" PRIMARY KEY ("id");


--
-- Name: cover_art_type cover_art_type_pkey; Type: CONSTRAINT; Schema: cover_art_archive; Owner: -
--

ALTER TABLE ONLY "cover_art_archive"."cover_art_type"
    ADD CONSTRAINT "cover_art_type_pkey" PRIMARY KEY ("id", "type_id");


--
-- Name: image_type image_type_pkey; Type: CONSTRAINT; Schema: cover_art_archive; Owner: -
--

ALTER TABLE ONLY "cover_art_archive"."image_type"
    ADD CONSTRAINT "image_type_pkey" PRIMARY KEY ("mime_type");


--
-- Name: release_group_cover_art release_group_cover_art_pkey; Type: CONSTRAINT; Schema: cover_art_archive; Owner: -
--

ALTER TABLE ONLY "cover_art_archive"."release_group_cover_art"
    ADD CONSTRAINT "release_group_cover_art_pkey" PRIMARY KEY ("release_group");


--
-- Name: pending_data pending_data_pkey; Type: CONSTRAINT; Schema: dbmirror2; Owner: -
--

ALTER TABLE ONLY "dbmirror2"."pending_data"
    ADD CONSTRAINT "pending_data_pkey" PRIMARY KEY ("seqid");


--
-- Name: pending_keys pending_keys_pkey; Type: CONSTRAINT; Schema: dbmirror2; Owner: -
--

ALTER TABLE ONLY "dbmirror2"."pending_keys"
    ADD CONSTRAINT "pending_keys_pkey" PRIMARY KEY ("tablename");


--
-- Name: pending_ts pending_ts_pkey; Type: CONSTRAINT; Schema: dbmirror2; Owner: -
--

ALTER TABLE ONLY "dbmirror2"."pending_ts"
    ADD CONSTRAINT "pending_ts_pkey" PRIMARY KEY ("xid");


--
-- Name: l_area_area_example l_area_area_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_area_area_example"
    ADD CONSTRAINT "l_area_area_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_artist_example l_area_artist_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_area_artist_example"
    ADD CONSTRAINT "l_area_artist_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_event_example l_area_event_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_area_event_example"
    ADD CONSTRAINT "l_area_event_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_genre_example l_area_genre_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_area_genre_example"
    ADD CONSTRAINT "l_area_genre_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_instrument_example l_area_instrument_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_area_instrument_example"
    ADD CONSTRAINT "l_area_instrument_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_label_example l_area_label_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_area_label_example"
    ADD CONSTRAINT "l_area_label_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_mood_example l_area_mood_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_area_mood_example"
    ADD CONSTRAINT "l_area_mood_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_place_example l_area_place_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_area_place_example"
    ADD CONSTRAINT "l_area_place_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_recording_example l_area_recording_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_area_recording_example"
    ADD CONSTRAINT "l_area_recording_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_release_example l_area_release_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_area_release_example"
    ADD CONSTRAINT "l_area_release_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_release_group_example l_area_release_group_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_area_release_group_example"
    ADD CONSTRAINT "l_area_release_group_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_series_example l_area_series_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_area_series_example"
    ADD CONSTRAINT "l_area_series_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_url_example l_area_url_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_area_url_example"
    ADD CONSTRAINT "l_area_url_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_work_example l_area_work_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_area_work_example"
    ADD CONSTRAINT "l_area_work_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_artist_example l_artist_artist_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_artist_artist_example"
    ADD CONSTRAINT "l_artist_artist_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_event_example l_artist_event_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_artist_event_example"
    ADD CONSTRAINT "l_artist_event_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_genre_example l_artist_genre_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_artist_genre_example"
    ADD CONSTRAINT "l_artist_genre_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_instrument_example l_artist_instrument_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_artist_instrument_example"
    ADD CONSTRAINT "l_artist_instrument_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_label_example l_artist_label_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_artist_label_example"
    ADD CONSTRAINT "l_artist_label_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_mood_example l_artist_mood_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_artist_mood_example"
    ADD CONSTRAINT "l_artist_mood_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_place_example l_artist_place_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_artist_place_example"
    ADD CONSTRAINT "l_artist_place_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_recording_example l_artist_recording_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_artist_recording_example"
    ADD CONSTRAINT "l_artist_recording_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_release_example l_artist_release_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_artist_release_example"
    ADD CONSTRAINT "l_artist_release_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_release_group_example l_artist_release_group_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_artist_release_group_example"
    ADD CONSTRAINT "l_artist_release_group_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_series_example l_artist_series_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_artist_series_example"
    ADD CONSTRAINT "l_artist_series_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_url_example l_artist_url_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_artist_url_example"
    ADD CONSTRAINT "l_artist_url_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_work_example l_artist_work_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_artist_work_example"
    ADD CONSTRAINT "l_artist_work_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_event_example l_event_event_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_event_event_example"
    ADD CONSTRAINT "l_event_event_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_genre_example l_event_genre_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_event_genre_example"
    ADD CONSTRAINT "l_event_genre_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_instrument_example l_event_instrument_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_event_instrument_example"
    ADD CONSTRAINT "l_event_instrument_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_label_example l_event_label_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_event_label_example"
    ADD CONSTRAINT "l_event_label_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_mood_example l_event_mood_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_event_mood_example"
    ADD CONSTRAINT "l_event_mood_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_place_example l_event_place_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_event_place_example"
    ADD CONSTRAINT "l_event_place_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_recording_example l_event_recording_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_event_recording_example"
    ADD CONSTRAINT "l_event_recording_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_release_example l_event_release_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_event_release_example"
    ADD CONSTRAINT "l_event_release_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_release_group_example l_event_release_group_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_event_release_group_example"
    ADD CONSTRAINT "l_event_release_group_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_series_example l_event_series_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_event_series_example"
    ADD CONSTRAINT "l_event_series_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_url_example l_event_url_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_event_url_example"
    ADD CONSTRAINT "l_event_url_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_work_example l_event_work_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_event_work_example"
    ADD CONSTRAINT "l_event_work_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_genre_example l_genre_genre_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_genre_genre_example"
    ADD CONSTRAINT "l_genre_genre_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_instrument_example l_genre_instrument_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_genre_instrument_example"
    ADD CONSTRAINT "l_genre_instrument_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_label_example l_genre_label_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_genre_label_example"
    ADD CONSTRAINT "l_genre_label_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_mood_example l_genre_mood_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_genre_mood_example"
    ADD CONSTRAINT "l_genre_mood_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_place_example l_genre_place_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_genre_place_example"
    ADD CONSTRAINT "l_genre_place_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_recording_example l_genre_recording_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_genre_recording_example"
    ADD CONSTRAINT "l_genre_recording_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_release_example l_genre_release_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_genre_release_example"
    ADD CONSTRAINT "l_genre_release_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_release_group_example l_genre_release_group_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_genre_release_group_example"
    ADD CONSTRAINT "l_genre_release_group_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_series_example l_genre_series_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_genre_series_example"
    ADD CONSTRAINT "l_genre_series_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_url_example l_genre_url_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_genre_url_example"
    ADD CONSTRAINT "l_genre_url_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_work_example l_genre_work_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_genre_work_example"
    ADD CONSTRAINT "l_genre_work_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_instrument_instrument_example l_instrument_instrument_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_instrument_instrument_example"
    ADD CONSTRAINT "l_instrument_instrument_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_instrument_label_example l_instrument_label_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_instrument_label_example"
    ADD CONSTRAINT "l_instrument_label_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_instrument_mood_example l_instrument_mood_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_instrument_mood_example"
    ADD CONSTRAINT "l_instrument_mood_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_instrument_place_example l_instrument_place_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_instrument_place_example"
    ADD CONSTRAINT "l_instrument_place_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_instrument_recording_example l_instrument_recording_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_instrument_recording_example"
    ADD CONSTRAINT "l_instrument_recording_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_instrument_release_example l_instrument_release_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_instrument_release_example"
    ADD CONSTRAINT "l_instrument_release_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_instrument_release_group_example l_instrument_release_group_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_instrument_release_group_example"
    ADD CONSTRAINT "l_instrument_release_group_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_instrument_series_example l_instrument_series_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_instrument_series_example"
    ADD CONSTRAINT "l_instrument_series_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_instrument_url_example l_instrument_url_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_instrument_url_example"
    ADD CONSTRAINT "l_instrument_url_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_instrument_work_example l_instrument_work_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_instrument_work_example"
    ADD CONSTRAINT "l_instrument_work_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_label_label_example l_label_label_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_label_label_example"
    ADD CONSTRAINT "l_label_label_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_label_mood_example l_label_mood_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_label_mood_example"
    ADD CONSTRAINT "l_label_mood_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_label_place_example l_label_place_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_label_place_example"
    ADD CONSTRAINT "l_label_place_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_label_recording_example l_label_recording_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_label_recording_example"
    ADD CONSTRAINT "l_label_recording_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_label_release_example l_label_release_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_label_release_example"
    ADD CONSTRAINT "l_label_release_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_label_release_group_example l_label_release_group_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_label_release_group_example"
    ADD CONSTRAINT "l_label_release_group_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_label_series_example l_label_series_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_label_series_example"
    ADD CONSTRAINT "l_label_series_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_label_url_example l_label_url_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_label_url_example"
    ADD CONSTRAINT "l_label_url_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_label_work_example l_label_work_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_label_work_example"
    ADD CONSTRAINT "l_label_work_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_mood_mood_example l_mood_mood_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_mood_mood_example"
    ADD CONSTRAINT "l_mood_mood_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_mood_place_example l_mood_place_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_mood_place_example"
    ADD CONSTRAINT "l_mood_place_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_mood_recording_example l_mood_recording_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_mood_recording_example"
    ADD CONSTRAINT "l_mood_recording_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_mood_release_example l_mood_release_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_mood_release_example"
    ADD CONSTRAINT "l_mood_release_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_mood_release_group_example l_mood_release_group_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_mood_release_group_example"
    ADD CONSTRAINT "l_mood_release_group_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_mood_series_example l_mood_series_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_mood_series_example"
    ADD CONSTRAINT "l_mood_series_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_mood_url_example l_mood_url_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_mood_url_example"
    ADD CONSTRAINT "l_mood_url_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_mood_work_example l_mood_work_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_mood_work_example"
    ADD CONSTRAINT "l_mood_work_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_place_place_example l_place_place_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_place_place_example"
    ADD CONSTRAINT "l_place_place_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_place_recording_example l_place_recording_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_place_recording_example"
    ADD CONSTRAINT "l_place_recording_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_place_release_example l_place_release_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_place_release_example"
    ADD CONSTRAINT "l_place_release_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_place_release_group_example l_place_release_group_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_place_release_group_example"
    ADD CONSTRAINT "l_place_release_group_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_place_series_example l_place_series_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_place_series_example"
    ADD CONSTRAINT "l_place_series_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_place_url_example l_place_url_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_place_url_example"
    ADD CONSTRAINT "l_place_url_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_place_work_example l_place_work_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_place_work_example"
    ADD CONSTRAINT "l_place_work_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_recording_recording_example l_recording_recording_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_recording_recording_example"
    ADD CONSTRAINT "l_recording_recording_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_recording_release_example l_recording_release_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_recording_release_example"
    ADD CONSTRAINT "l_recording_release_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_recording_release_group_example l_recording_release_group_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_recording_release_group_example"
    ADD CONSTRAINT "l_recording_release_group_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_recording_series_example l_recording_series_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_recording_series_example"
    ADD CONSTRAINT "l_recording_series_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_recording_url_example l_recording_url_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_recording_url_example"
    ADD CONSTRAINT "l_recording_url_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_recording_work_example l_recording_work_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_recording_work_example"
    ADD CONSTRAINT "l_recording_work_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_release_group_release_group_example l_release_group_release_group_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_release_group_release_group_example"
    ADD CONSTRAINT "l_release_group_release_group_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_release_group_series_example l_release_group_series_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_release_group_series_example"
    ADD CONSTRAINT "l_release_group_series_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_release_group_url_example l_release_group_url_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_release_group_url_example"
    ADD CONSTRAINT "l_release_group_url_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_release_group_work_example l_release_group_work_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_release_group_work_example"
    ADD CONSTRAINT "l_release_group_work_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_release_release_example l_release_release_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_release_release_example"
    ADD CONSTRAINT "l_release_release_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_release_release_group_example l_release_release_group_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_release_release_group_example"
    ADD CONSTRAINT "l_release_release_group_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_release_series_example l_release_series_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_release_series_example"
    ADD CONSTRAINT "l_release_series_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_release_url_example l_release_url_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_release_url_example"
    ADD CONSTRAINT "l_release_url_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_release_work_example l_release_work_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_release_work_example"
    ADD CONSTRAINT "l_release_work_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_series_series_example l_series_series_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_series_series_example"
    ADD CONSTRAINT "l_series_series_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_series_url_example l_series_url_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_series_url_example"
    ADD CONSTRAINT "l_series_url_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_series_work_example l_series_work_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_series_work_example"
    ADD CONSTRAINT "l_series_work_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_url_url_example l_url_url_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_url_url_example"
    ADD CONSTRAINT "l_url_url_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_url_work_example l_url_work_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_url_work_example"
    ADD CONSTRAINT "l_url_work_example_pkey" PRIMARY KEY ("id");


--
-- Name: l_work_work_example l_work_work_example_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."l_work_work_example"
    ADD CONSTRAINT "l_work_work_example_pkey" PRIMARY KEY ("id");


--
-- Name: link_type_documentation link_type_documentation_pkey; Type: CONSTRAINT; Schema: documentation; Owner: -
--

ALTER TABLE ONLY "documentation"."link_type_documentation"
    ADD CONSTRAINT "link_type_documentation_pkey" PRIMARY KEY ("id");


--
-- Name: art_type art_type_pkey; Type: CONSTRAINT; Schema: event_art_archive; Owner: -
--

ALTER TABLE ONLY "event_art_archive"."art_type"
    ADD CONSTRAINT "art_type_pkey" PRIMARY KEY ("id");


--
-- Name: event_art event_art_pkey; Type: CONSTRAINT; Schema: event_art_archive; Owner: -
--

ALTER TABLE ONLY "event_art_archive"."event_art"
    ADD CONSTRAINT "event_art_pkey" PRIMARY KEY ("id");


--
-- Name: event_art_type event_art_type_pkey; Type: CONSTRAINT; Schema: event_art_archive; Owner: -
--

ALTER TABLE ONLY "event_art_archive"."event_art_type"
    ADD CONSTRAINT "event_art_type_pkey" PRIMARY KEY ("id", "type_id");


--
-- Name: area_json area_json_pkey; Type: CONSTRAINT; Schema: json_dump; Owner: -
--

ALTER TABLE ONLY "json_dump"."area_json"
    ADD CONSTRAINT "area_json_pkey" PRIMARY KEY ("id", "replication_sequence");


--
-- Name: artist_json artist_json_pkey; Type: CONSTRAINT; Schema: json_dump; Owner: -
--

ALTER TABLE ONLY "json_dump"."artist_json"
    ADD CONSTRAINT "artist_json_pkey" PRIMARY KEY ("id", "replication_sequence");


--
-- Name: deleted_entities deleted_entities_pkey; Type: CONSTRAINT; Schema: json_dump; Owner: -
--

ALTER TABLE ONLY "json_dump"."deleted_entities"
    ADD CONSTRAINT "deleted_entities_pkey" PRIMARY KEY ("entity_type", "id");


--
-- Name: event_json event_json_pkey; Type: CONSTRAINT; Schema: json_dump; Owner: -
--

ALTER TABLE ONLY "json_dump"."event_json"
    ADD CONSTRAINT "event_json_pkey" PRIMARY KEY ("id", "replication_sequence");


--
-- Name: instrument_json instrument_json_pkey; Type: CONSTRAINT; Schema: json_dump; Owner: -
--

ALTER TABLE ONLY "json_dump"."instrument_json"
    ADD CONSTRAINT "instrument_json_pkey" PRIMARY KEY ("id", "replication_sequence");


--
-- Name: label_json label_json_pkey; Type: CONSTRAINT; Schema: json_dump; Owner: -
--

ALTER TABLE ONLY "json_dump"."label_json"
    ADD CONSTRAINT "label_json_pkey" PRIMARY KEY ("id", "replication_sequence");


--
-- Name: place_json place_json_pkey; Type: CONSTRAINT; Schema: json_dump; Owner: -
--

ALTER TABLE ONLY "json_dump"."place_json"
    ADD CONSTRAINT "place_json_pkey" PRIMARY KEY ("id", "replication_sequence");


--
-- Name: recording_json recording_json_pkey; Type: CONSTRAINT; Schema: json_dump; Owner: -
--

ALTER TABLE ONLY "json_dump"."recording_json"
    ADD CONSTRAINT "recording_json_pkey" PRIMARY KEY ("id", "replication_sequence");


--
-- Name: release_group_json release_group_json_pkey; Type: CONSTRAINT; Schema: json_dump; Owner: -
--

ALTER TABLE ONLY "json_dump"."release_group_json"
    ADD CONSTRAINT "release_group_json_pkey" PRIMARY KEY ("id", "replication_sequence");


--
-- Name: release_json release_json_pkey; Type: CONSTRAINT; Schema: json_dump; Owner: -
--

ALTER TABLE ONLY "json_dump"."release_json"
    ADD CONSTRAINT "release_json_pkey" PRIMARY KEY ("id", "replication_sequence");


--
-- Name: series_json series_json_pkey; Type: CONSTRAINT; Schema: json_dump; Owner: -
--

ALTER TABLE ONLY "json_dump"."series_json"
    ADD CONSTRAINT "series_json_pkey" PRIMARY KEY ("id", "replication_sequence");


--
-- Name: work_json work_json_pkey; Type: CONSTRAINT; Schema: json_dump; Owner: -
--

ALTER TABLE ONLY "json_dump"."work_json"
    ADD CONSTRAINT "work_json_pkey" PRIMARY KEY ("id", "replication_sequence");


--
-- Name: alternative_medium alternative_medium_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."alternative_medium"
    ADD CONSTRAINT "alternative_medium_pkey" PRIMARY KEY ("id");


--
-- Name: alternative_medium_track alternative_medium_track_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."alternative_medium_track"
    ADD CONSTRAINT "alternative_medium_track_pkey" PRIMARY KEY ("alternative_medium", "track");


--
-- Name: alternative_release alternative_release_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."alternative_release"
    ADD CONSTRAINT "alternative_release_pkey" PRIMARY KEY ("id");


--
-- Name: alternative_release_type alternative_release_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."alternative_release_type"
    ADD CONSTRAINT "alternative_release_type_pkey" PRIMARY KEY ("id");


--
-- Name: alternative_track alternative_track_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."alternative_track"
    ADD CONSTRAINT "alternative_track_pkey" PRIMARY KEY ("id");


--
-- Name: annotation annotation_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."annotation"
    ADD CONSTRAINT "annotation_pkey" PRIMARY KEY ("id");


--
-- Name: application application_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."application"
    ADD CONSTRAINT "application_pkey" PRIMARY KEY ("id");


--
-- Name: area_alias area_alias_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."area_alias"
    ADD CONSTRAINT "area_alias_pkey" PRIMARY KEY ("id");


--
-- Name: area_alias_type area_alias_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."area_alias_type"
    ADD CONSTRAINT "area_alias_type_pkey" PRIMARY KEY ("id");


--
-- Name: area_annotation area_annotation_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."area_annotation"
    ADD CONSTRAINT "area_annotation_pkey" PRIMARY KEY ("area", "annotation");


--
-- Name: area_attribute area_attribute_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."area_attribute"
    ADD CONSTRAINT "area_attribute_pkey" PRIMARY KEY ("id");


--
-- Name: area_attribute_type_allowed_value area_attribute_type_allowed_value_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."area_attribute_type_allowed_value"
    ADD CONSTRAINT "area_attribute_type_allowed_value_pkey" PRIMARY KEY ("id");


--
-- Name: area_attribute_type area_attribute_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."area_attribute_type"
    ADD CONSTRAINT "area_attribute_type_pkey" PRIMARY KEY ("id");


--
-- Name: area_containment area_containment_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."area_containment"
    ADD CONSTRAINT "area_containment_pkey" PRIMARY KEY ("descendant", "parent");


--
-- Name: area_gid_redirect area_gid_redirect_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."area_gid_redirect"
    ADD CONSTRAINT "area_gid_redirect_pkey" PRIMARY KEY ("gid");


--
-- Name: area area_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."area"
    ADD CONSTRAINT "area_pkey" PRIMARY KEY ("id");


--
-- Name: area_tag area_tag_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."area_tag"
    ADD CONSTRAINT "area_tag_pkey" PRIMARY KEY ("area", "tag");


--
-- Name: area_tag_raw area_tag_raw_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."area_tag_raw"
    ADD CONSTRAINT "area_tag_raw_pkey" PRIMARY KEY ("area", "editor", "tag");


--
-- Name: area_type area_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."area_type"
    ADD CONSTRAINT "area_type_pkey" PRIMARY KEY ("id");


--
-- Name: artist_alias artist_alias_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_alias"
    ADD CONSTRAINT "artist_alias_pkey" PRIMARY KEY ("id");


--
-- Name: artist_alias_type artist_alias_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_alias_type"
    ADD CONSTRAINT "artist_alias_type_pkey" PRIMARY KEY ("id");


--
-- Name: artist_annotation artist_annotation_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_annotation"
    ADD CONSTRAINT "artist_annotation_pkey" PRIMARY KEY ("artist", "annotation");


--
-- Name: artist_attribute artist_attribute_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_attribute"
    ADD CONSTRAINT "artist_attribute_pkey" PRIMARY KEY ("id");


--
-- Name: artist_attribute_type_allowed_value artist_attribute_type_allowed_value_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_attribute_type_allowed_value"
    ADD CONSTRAINT "artist_attribute_type_allowed_value_pkey" PRIMARY KEY ("id");


--
-- Name: artist_attribute_type artist_attribute_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_attribute_type"
    ADD CONSTRAINT "artist_attribute_type_pkey" PRIMARY KEY ("id");


--
-- Name: artist_credit_gid_redirect artist_credit_gid_redirect_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_credit_gid_redirect"
    ADD CONSTRAINT "artist_credit_gid_redirect_pkey" PRIMARY KEY ("gid");


--
-- Name: artist_credit_name artist_credit_name_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_credit_name"
    ADD CONSTRAINT "artist_credit_name_pkey" PRIMARY KEY ("artist_credit", "position");


--
-- Name: artist_credit artist_credit_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_credit"
    ADD CONSTRAINT "artist_credit_pkey" PRIMARY KEY ("id");


--
-- Name: artist_gid_redirect artist_gid_redirect_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_gid_redirect"
    ADD CONSTRAINT "artist_gid_redirect_pkey" PRIMARY KEY ("gid");


--
-- Name: artist_ipi artist_ipi_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_ipi"
    ADD CONSTRAINT "artist_ipi_pkey" PRIMARY KEY ("artist", "ipi");


--
-- Name: artist_isni artist_isni_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_isni"
    ADD CONSTRAINT "artist_isni_pkey" PRIMARY KEY ("artist", "isni");


--
-- Name: artist_meta artist_meta_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_meta"
    ADD CONSTRAINT "artist_meta_pkey" PRIMARY KEY ("id");


--
-- Name: artist artist_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist"
    ADD CONSTRAINT "artist_pkey" PRIMARY KEY ("id");


--
-- Name: artist_rating_raw artist_rating_raw_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_rating_raw"
    ADD CONSTRAINT "artist_rating_raw_pkey" PRIMARY KEY ("artist", "editor");


--
-- Name: artist_tag artist_tag_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_tag"
    ADD CONSTRAINT "artist_tag_pkey" PRIMARY KEY ("artist", "tag");


--
-- Name: artist_tag_raw artist_tag_raw_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_tag_raw"
    ADD CONSTRAINT "artist_tag_raw_pkey" PRIMARY KEY ("artist", "editor", "tag");


--
-- Name: artist_type artist_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."artist_type"
    ADD CONSTRAINT "artist_type_pkey" PRIMARY KEY ("id");


--
-- Name: autoeditor_election autoeditor_election_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."autoeditor_election"
    ADD CONSTRAINT "autoeditor_election_pkey" PRIMARY KEY ("id");


--
-- Name: autoeditor_election_vote autoeditor_election_vote_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."autoeditor_election_vote"
    ADD CONSTRAINT "autoeditor_election_vote_pkey" PRIMARY KEY ("id");


--
-- Name: cdtoc cdtoc_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."cdtoc"
    ADD CONSTRAINT "cdtoc_pkey" PRIMARY KEY ("id");


--
-- Name: cdtoc_raw cdtoc_raw_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."cdtoc_raw"
    ADD CONSTRAINT "cdtoc_raw_pkey" PRIMARY KEY ("id");


--
-- Name: country_area country_area_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."country_area"
    ADD CONSTRAINT "country_area_pkey" PRIMARY KEY ("area");


--
-- Name: dbmirror_pending dbmirror_pending_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."dbmirror_pending"
    ADD CONSTRAINT "dbmirror_pending_pkey" PRIMARY KEY ("seqid");


--
-- Name: dbmirror_pendingdata dbmirror_pendingdata_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."dbmirror_pendingdata"
    ADD CONSTRAINT "dbmirror_pendingdata_pkey" PRIMARY KEY ("seqid", "iskey");


--
-- Name: deleted_entity deleted_entity_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."deleted_entity"
    ADD CONSTRAINT "deleted_entity_pkey" PRIMARY KEY ("gid");


--
-- Name: edit_area edit_area_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit_area"
    ADD CONSTRAINT "edit_area_pkey" PRIMARY KEY ("edit", "area");


--
-- Name: edit_artist edit_artist_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit_artist"
    ADD CONSTRAINT "edit_artist_pkey" PRIMARY KEY ("edit", "artist");


--
-- Name: edit_data edit_data_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit_data"
    ADD CONSTRAINT "edit_data_pkey" PRIMARY KEY ("edit");


--
-- Name: edit_event edit_event_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit_event"
    ADD CONSTRAINT "edit_event_pkey" PRIMARY KEY ("edit", "event");


--
-- Name: edit_genre edit_genre_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit_genre"
    ADD CONSTRAINT "edit_genre_pkey" PRIMARY KEY ("edit", "genre");


--
-- Name: edit_instrument edit_instrument_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit_instrument"
    ADD CONSTRAINT "edit_instrument_pkey" PRIMARY KEY ("edit", "instrument");


--
-- Name: edit_label edit_label_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit_label"
    ADD CONSTRAINT "edit_label_pkey" PRIMARY KEY ("edit", "label");


--
-- Name: edit_mood edit_mood_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit_mood"
    ADD CONSTRAINT "edit_mood_pkey" PRIMARY KEY ("edit", "mood");


--
-- Name: edit_note_change edit_note_change_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit_note_change"
    ADD CONSTRAINT "edit_note_change_pkey" PRIMARY KEY ("id");


--
-- Name: edit_note edit_note_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit_note"
    ADD CONSTRAINT "edit_note_pkey" PRIMARY KEY ("id");


--
-- Name: edit_note_recipient edit_note_recipient_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit_note_recipient"
    ADD CONSTRAINT "edit_note_recipient_pkey" PRIMARY KEY ("recipient", "edit_note");


--
-- Name: edit edit_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit"
    ADD CONSTRAINT "edit_pkey" PRIMARY KEY ("id");


--
-- Name: edit_place edit_place_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit_place"
    ADD CONSTRAINT "edit_place_pkey" PRIMARY KEY ("edit", "place");


--
-- Name: edit_recording edit_recording_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit_recording"
    ADD CONSTRAINT "edit_recording_pkey" PRIMARY KEY ("edit", "recording");


--
-- Name: edit_release_group edit_release_group_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit_release_group"
    ADD CONSTRAINT "edit_release_group_pkey" PRIMARY KEY ("edit", "release_group");


--
-- Name: edit_release edit_release_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit_release"
    ADD CONSTRAINT "edit_release_pkey" PRIMARY KEY ("edit", "release");


--
-- Name: edit_series edit_series_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit_series"
    ADD CONSTRAINT "edit_series_pkey" PRIMARY KEY ("edit", "series");


--
-- Name: edit_url edit_url_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit_url"
    ADD CONSTRAINT "edit_url_pkey" PRIMARY KEY ("edit", "url");


--
-- Name: edit_work edit_work_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."edit_work"
    ADD CONSTRAINT "edit_work_pkey" PRIMARY KEY ("edit", "work");


--
-- Name: editor_collection_area editor_collection_area_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_collection_area"
    ADD CONSTRAINT "editor_collection_area_pkey" PRIMARY KEY ("collection", "area");


--
-- Name: editor_collection_artist editor_collection_artist_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_collection_artist"
    ADD CONSTRAINT "editor_collection_artist_pkey" PRIMARY KEY ("collection", "artist");


--
-- Name: editor_collection_collaborator editor_collection_collaborator_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_collection_collaborator"
    ADD CONSTRAINT "editor_collection_collaborator_pkey" PRIMARY KEY ("collection", "editor");


--
-- Name: editor_collection_deleted_entity editor_collection_deleted_entity_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_collection_deleted_entity"
    ADD CONSTRAINT "editor_collection_deleted_entity_pkey" PRIMARY KEY ("collection", "gid");


--
-- Name: editor_collection_event editor_collection_event_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_collection_event"
    ADD CONSTRAINT "editor_collection_event_pkey" PRIMARY KEY ("collection", "event");


--
-- Name: editor_collection_genre editor_collection_genre_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_collection_genre"
    ADD CONSTRAINT "editor_collection_genre_pkey" PRIMARY KEY ("collection", "genre");


--
-- Name: editor_collection_gid_redirect editor_collection_gid_redirect_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_collection_gid_redirect"
    ADD CONSTRAINT "editor_collection_gid_redirect_pkey" PRIMARY KEY ("gid");


--
-- Name: editor_collection_instrument editor_collection_instrument_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_collection_instrument"
    ADD CONSTRAINT "editor_collection_instrument_pkey" PRIMARY KEY ("collection", "instrument");


--
-- Name: editor_collection_label editor_collection_label_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_collection_label"
    ADD CONSTRAINT "editor_collection_label_pkey" PRIMARY KEY ("collection", "label");


--
-- Name: editor_collection editor_collection_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_collection"
    ADD CONSTRAINT "editor_collection_pkey" PRIMARY KEY ("id");


--
-- Name: editor_collection_place editor_collection_place_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_collection_place"
    ADD CONSTRAINT "editor_collection_place_pkey" PRIMARY KEY ("collection", "place");


--
-- Name: editor_collection_recording editor_collection_recording_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_collection_recording"
    ADD CONSTRAINT "editor_collection_recording_pkey" PRIMARY KEY ("collection", "recording");


--
-- Name: editor_collection_release_group editor_collection_release_group_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_collection_release_group"
    ADD CONSTRAINT "editor_collection_release_group_pkey" PRIMARY KEY ("collection", "release_group");


--
-- Name: editor_collection_release editor_collection_release_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_collection_release"
    ADD CONSTRAINT "editor_collection_release_pkey" PRIMARY KEY ("collection", "release");


--
-- Name: editor_collection_series editor_collection_series_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_collection_series"
    ADD CONSTRAINT "editor_collection_series_pkey" PRIMARY KEY ("collection", "series");


--
-- Name: editor_collection_type editor_collection_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_collection_type"
    ADD CONSTRAINT "editor_collection_type_pkey" PRIMARY KEY ("id");


--
-- Name: editor_collection_work editor_collection_work_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_collection_work"
    ADD CONSTRAINT "editor_collection_work_pkey" PRIMARY KEY ("collection", "work");


--
-- Name: editor_language editor_language_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_language"
    ADD CONSTRAINT "editor_language_pkey" PRIMARY KEY ("editor", "language");


--
-- Name: editor_oauth_token editor_oauth_token_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_oauth_token"
    ADD CONSTRAINT "editor_oauth_token_pkey" PRIMARY KEY ("id");


--
-- Name: editor editor_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor"
    ADD CONSTRAINT "editor_pkey" PRIMARY KEY ("id");


--
-- Name: editor_preference editor_preference_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_preference"
    ADD CONSTRAINT "editor_preference_pkey" PRIMARY KEY ("id");


--
-- Name: editor_subscribe_artist_deleted editor_subscribe_artist_deleted_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_subscribe_artist_deleted"
    ADD CONSTRAINT "editor_subscribe_artist_deleted_pkey" PRIMARY KEY ("editor", "gid");


--
-- Name: editor_subscribe_artist editor_subscribe_artist_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_subscribe_artist"
    ADD CONSTRAINT "editor_subscribe_artist_pkey" PRIMARY KEY ("id");


--
-- Name: editor_subscribe_collection editor_subscribe_collection_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_subscribe_collection"
    ADD CONSTRAINT "editor_subscribe_collection_pkey" PRIMARY KEY ("id");


--
-- Name: editor_subscribe_editor editor_subscribe_editor_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_subscribe_editor"
    ADD CONSTRAINT "editor_subscribe_editor_pkey" PRIMARY KEY ("id");


--
-- Name: editor_subscribe_label_deleted editor_subscribe_label_deleted_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_subscribe_label_deleted"
    ADD CONSTRAINT "editor_subscribe_label_deleted_pkey" PRIMARY KEY ("editor", "gid");


--
-- Name: editor_subscribe_label editor_subscribe_label_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_subscribe_label"
    ADD CONSTRAINT "editor_subscribe_label_pkey" PRIMARY KEY ("id");


--
-- Name: editor_subscribe_series_deleted editor_subscribe_series_deleted_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_subscribe_series_deleted"
    ADD CONSTRAINT "editor_subscribe_series_deleted_pkey" PRIMARY KEY ("editor", "gid");


--
-- Name: editor_subscribe_series editor_subscribe_series_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."editor_subscribe_series"
    ADD CONSTRAINT "editor_subscribe_series_pkey" PRIMARY KEY ("id");


--
-- Name: event_alias event_alias_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."event_alias"
    ADD CONSTRAINT "event_alias_pkey" PRIMARY KEY ("id");


--
-- Name: event_alias_type event_alias_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."event_alias_type"
    ADD CONSTRAINT "event_alias_type_pkey" PRIMARY KEY ("id");


--
-- Name: event_annotation event_annotation_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."event_annotation"
    ADD CONSTRAINT "event_annotation_pkey" PRIMARY KEY ("event", "annotation");


--
-- Name: event_attribute event_attribute_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."event_attribute"
    ADD CONSTRAINT "event_attribute_pkey" PRIMARY KEY ("id");


--
-- Name: event_attribute_type_allowed_value event_attribute_type_allowed_value_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."event_attribute_type_allowed_value"
    ADD CONSTRAINT "event_attribute_type_allowed_value_pkey" PRIMARY KEY ("id");


--
-- Name: event_attribute_type event_attribute_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."event_attribute_type"
    ADD CONSTRAINT "event_attribute_type_pkey" PRIMARY KEY ("id");


--
-- Name: event_gid_redirect event_gid_redirect_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."event_gid_redirect"
    ADD CONSTRAINT "event_gid_redirect_pkey" PRIMARY KEY ("gid");


--
-- Name: event_meta event_meta_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."event_meta"
    ADD CONSTRAINT "event_meta_pkey" PRIMARY KEY ("id");


--
-- Name: event event_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."event"
    ADD CONSTRAINT "event_pkey" PRIMARY KEY ("id");


--
-- Name: event_rating_raw event_rating_raw_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."event_rating_raw"
    ADD CONSTRAINT "event_rating_raw_pkey" PRIMARY KEY ("event", "editor");


--
-- Name: event_tag event_tag_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."event_tag"
    ADD CONSTRAINT "event_tag_pkey" PRIMARY KEY ("event", "tag");


--
-- Name: event_tag_raw event_tag_raw_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."event_tag_raw"
    ADD CONSTRAINT "event_tag_raw_pkey" PRIMARY KEY ("event", "editor", "tag");


--
-- Name: event_type event_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."event_type"
    ADD CONSTRAINT "event_type_pkey" PRIMARY KEY ("id");


--
-- Name: gender gender_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."gender"
    ADD CONSTRAINT "gender_pkey" PRIMARY KEY ("id");


--
-- Name: genre_alias genre_alias_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."genre_alias"
    ADD CONSTRAINT "genre_alias_pkey" PRIMARY KEY ("id");


--
-- Name: genre_alias_type genre_alias_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."genre_alias_type"
    ADD CONSTRAINT "genre_alias_type_pkey" PRIMARY KEY ("id");


--
-- Name: genre_annotation genre_annotation_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."genre_annotation"
    ADD CONSTRAINT "genre_annotation_pkey" PRIMARY KEY ("genre", "annotation");


--
-- Name: genre genre_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."genre"
    ADD CONSTRAINT "genre_pkey" PRIMARY KEY ("id");


--
-- Name: instrument_alias instrument_alias_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."instrument_alias"
    ADD CONSTRAINT "instrument_alias_pkey" PRIMARY KEY ("id");


--
-- Name: instrument_alias_type instrument_alias_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."instrument_alias_type"
    ADD CONSTRAINT "instrument_alias_type_pkey" PRIMARY KEY ("id");


--
-- Name: instrument_annotation instrument_annotation_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."instrument_annotation"
    ADD CONSTRAINT "instrument_annotation_pkey" PRIMARY KEY ("instrument", "annotation");


--
-- Name: instrument_attribute instrument_attribute_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."instrument_attribute"
    ADD CONSTRAINT "instrument_attribute_pkey" PRIMARY KEY ("id");


--
-- Name: instrument_attribute_type_allowed_value instrument_attribute_type_allowed_value_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."instrument_attribute_type_allowed_value"
    ADD CONSTRAINT "instrument_attribute_type_allowed_value_pkey" PRIMARY KEY ("id");


--
-- Name: instrument_attribute_type instrument_attribute_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."instrument_attribute_type"
    ADD CONSTRAINT "instrument_attribute_type_pkey" PRIMARY KEY ("id");


--
-- Name: instrument_gid_redirect instrument_gid_redirect_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."instrument_gid_redirect"
    ADD CONSTRAINT "instrument_gid_redirect_pkey" PRIMARY KEY ("gid");


--
-- Name: instrument instrument_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."instrument"
    ADD CONSTRAINT "instrument_pkey" PRIMARY KEY ("id");


--
-- Name: instrument_tag instrument_tag_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."instrument_tag"
    ADD CONSTRAINT "instrument_tag_pkey" PRIMARY KEY ("instrument", "tag");


--
-- Name: instrument_tag_raw instrument_tag_raw_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."instrument_tag_raw"
    ADD CONSTRAINT "instrument_tag_raw_pkey" PRIMARY KEY ("instrument", "editor", "tag");


--
-- Name: instrument_type instrument_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."instrument_type"
    ADD CONSTRAINT "instrument_type_pkey" PRIMARY KEY ("id");


--
-- Name: iso_3166_1 iso_3166_1_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."iso_3166_1"
    ADD CONSTRAINT "iso_3166_1_pkey" PRIMARY KEY ("code");


--
-- Name: iso_3166_2 iso_3166_2_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."iso_3166_2"
    ADD CONSTRAINT "iso_3166_2_pkey" PRIMARY KEY ("code");


--
-- Name: iso_3166_3 iso_3166_3_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."iso_3166_3"
    ADD CONSTRAINT "iso_3166_3_pkey" PRIMARY KEY ("code");


--
-- Name: isrc isrc_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."isrc"
    ADD CONSTRAINT "isrc_pkey" PRIMARY KEY ("id");


--
-- Name: iswc iswc_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."iswc"
    ADD CONSTRAINT "iswc_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_area l_area_area_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_area"
    ADD CONSTRAINT "l_area_area_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_artist l_area_artist_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_artist"
    ADD CONSTRAINT "l_area_artist_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_event l_area_event_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_event"
    ADD CONSTRAINT "l_area_event_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_genre l_area_genre_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_genre"
    ADD CONSTRAINT "l_area_genre_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_instrument l_area_instrument_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_instrument"
    ADD CONSTRAINT "l_area_instrument_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_label l_area_label_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_label"
    ADD CONSTRAINT "l_area_label_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_mood l_area_mood_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_mood"
    ADD CONSTRAINT "l_area_mood_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_place l_area_place_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_place"
    ADD CONSTRAINT "l_area_place_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_recording l_area_recording_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_recording"
    ADD CONSTRAINT "l_area_recording_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_release_group l_area_release_group_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_release_group"
    ADD CONSTRAINT "l_area_release_group_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_release l_area_release_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_release"
    ADD CONSTRAINT "l_area_release_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_series l_area_series_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_series"
    ADD CONSTRAINT "l_area_series_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_url l_area_url_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_url"
    ADD CONSTRAINT "l_area_url_pkey" PRIMARY KEY ("id");


--
-- Name: l_area_work l_area_work_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_area_work"
    ADD CONSTRAINT "l_area_work_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_artist l_artist_artist_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_artist"
    ADD CONSTRAINT "l_artist_artist_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_event l_artist_event_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_event"
    ADD CONSTRAINT "l_artist_event_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_genre l_artist_genre_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_genre"
    ADD CONSTRAINT "l_artist_genre_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_instrument l_artist_instrument_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_instrument"
    ADD CONSTRAINT "l_artist_instrument_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_label l_artist_label_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_label"
    ADD CONSTRAINT "l_artist_label_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_mood l_artist_mood_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_mood"
    ADD CONSTRAINT "l_artist_mood_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_place l_artist_place_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_place"
    ADD CONSTRAINT "l_artist_place_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_recording l_artist_recording_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_recording"
    ADD CONSTRAINT "l_artist_recording_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_release_group l_artist_release_group_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_release_group"
    ADD CONSTRAINT "l_artist_release_group_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_release l_artist_release_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_release"
    ADD CONSTRAINT "l_artist_release_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_series l_artist_series_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_series"
    ADD CONSTRAINT "l_artist_series_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_url l_artist_url_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_url"
    ADD CONSTRAINT "l_artist_url_pkey" PRIMARY KEY ("id");


--
-- Name: l_artist_work l_artist_work_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_artist_work"
    ADD CONSTRAINT "l_artist_work_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_event l_event_event_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_event"
    ADD CONSTRAINT "l_event_event_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_genre l_event_genre_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_genre"
    ADD CONSTRAINT "l_event_genre_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_instrument l_event_instrument_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_instrument"
    ADD CONSTRAINT "l_event_instrument_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_label l_event_label_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_label"
    ADD CONSTRAINT "l_event_label_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_mood l_event_mood_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_mood"
    ADD CONSTRAINT "l_event_mood_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_place l_event_place_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_place"
    ADD CONSTRAINT "l_event_place_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_recording l_event_recording_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_recording"
    ADD CONSTRAINT "l_event_recording_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_release_group l_event_release_group_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_release_group"
    ADD CONSTRAINT "l_event_release_group_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_release l_event_release_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_release"
    ADD CONSTRAINT "l_event_release_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_series l_event_series_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_series"
    ADD CONSTRAINT "l_event_series_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_url l_event_url_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_url"
    ADD CONSTRAINT "l_event_url_pkey" PRIMARY KEY ("id");


--
-- Name: l_event_work l_event_work_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_event_work"
    ADD CONSTRAINT "l_event_work_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_genre l_genre_genre_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_genre"
    ADD CONSTRAINT "l_genre_genre_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_instrument l_genre_instrument_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_instrument"
    ADD CONSTRAINT "l_genre_instrument_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_label l_genre_label_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_label"
    ADD CONSTRAINT "l_genre_label_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_mood l_genre_mood_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_mood"
    ADD CONSTRAINT "l_genre_mood_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_place l_genre_place_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_place"
    ADD CONSTRAINT "l_genre_place_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_recording l_genre_recording_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_recording"
    ADD CONSTRAINT "l_genre_recording_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_release_group l_genre_release_group_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_release_group"
    ADD CONSTRAINT "l_genre_release_group_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_release l_genre_release_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_release"
    ADD CONSTRAINT "l_genre_release_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_series l_genre_series_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_series"
    ADD CONSTRAINT "l_genre_series_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_url l_genre_url_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_url"
    ADD CONSTRAINT "l_genre_url_pkey" PRIMARY KEY ("id");


--
-- Name: l_genre_work l_genre_work_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_genre_work"
    ADD CONSTRAINT "l_genre_work_pkey" PRIMARY KEY ("id");


--
-- Name: l_instrument_instrument l_instrument_instrument_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_instrument_instrument"
    ADD CONSTRAINT "l_instrument_instrument_pkey" PRIMARY KEY ("id");


--
-- Name: l_instrument_label l_instrument_label_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_instrument_label"
    ADD CONSTRAINT "l_instrument_label_pkey" PRIMARY KEY ("id");


--
-- Name: l_instrument_mood l_instrument_mood_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_instrument_mood"
    ADD CONSTRAINT "l_instrument_mood_pkey" PRIMARY KEY ("id");


--
-- Name: l_instrument_place l_instrument_place_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_instrument_place"
    ADD CONSTRAINT "l_instrument_place_pkey" PRIMARY KEY ("id");


--
-- Name: l_instrument_recording l_instrument_recording_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_instrument_recording"
    ADD CONSTRAINT "l_instrument_recording_pkey" PRIMARY KEY ("id");


--
-- Name: l_instrument_release_group l_instrument_release_group_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_instrument_release_group"
    ADD CONSTRAINT "l_instrument_release_group_pkey" PRIMARY KEY ("id");


--
-- Name: l_instrument_release l_instrument_release_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_instrument_release"
    ADD CONSTRAINT "l_instrument_release_pkey" PRIMARY KEY ("id");


--
-- Name: l_instrument_series l_instrument_series_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_instrument_series"
    ADD CONSTRAINT "l_instrument_series_pkey" PRIMARY KEY ("id");


--
-- Name: l_instrument_url l_instrument_url_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_instrument_url"
    ADD CONSTRAINT "l_instrument_url_pkey" PRIMARY KEY ("id");


--
-- Name: l_instrument_work l_instrument_work_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_instrument_work"
    ADD CONSTRAINT "l_instrument_work_pkey" PRIMARY KEY ("id");


--
-- Name: l_label_label l_label_label_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_label_label"
    ADD CONSTRAINT "l_label_label_pkey" PRIMARY KEY ("id");


--
-- Name: l_label_mood l_label_mood_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_label_mood"
    ADD CONSTRAINT "l_label_mood_pkey" PRIMARY KEY ("id");


--
-- Name: l_label_place l_label_place_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_label_place"
    ADD CONSTRAINT "l_label_place_pkey" PRIMARY KEY ("id");


--
-- Name: l_label_recording l_label_recording_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_label_recording"
    ADD CONSTRAINT "l_label_recording_pkey" PRIMARY KEY ("id");


--
-- Name: l_label_release_group l_label_release_group_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_label_release_group"
    ADD CONSTRAINT "l_label_release_group_pkey" PRIMARY KEY ("id");


--
-- Name: l_label_release l_label_release_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_label_release"
    ADD CONSTRAINT "l_label_release_pkey" PRIMARY KEY ("id");


--
-- Name: l_label_series l_label_series_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_label_series"
    ADD CONSTRAINT "l_label_series_pkey" PRIMARY KEY ("id");


--
-- Name: l_label_url l_label_url_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_label_url"
    ADD CONSTRAINT "l_label_url_pkey" PRIMARY KEY ("id");


--
-- Name: l_label_work l_label_work_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_label_work"
    ADD CONSTRAINT "l_label_work_pkey" PRIMARY KEY ("id");


--
-- Name: l_mood_mood l_mood_mood_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_mood_mood"
    ADD CONSTRAINT "l_mood_mood_pkey" PRIMARY KEY ("id");


--
-- Name: l_mood_place l_mood_place_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_mood_place"
    ADD CONSTRAINT "l_mood_place_pkey" PRIMARY KEY ("id");


--
-- Name: l_mood_recording l_mood_recording_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_mood_recording"
    ADD CONSTRAINT "l_mood_recording_pkey" PRIMARY KEY ("id");


--
-- Name: l_mood_release_group l_mood_release_group_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_mood_release_group"
    ADD CONSTRAINT "l_mood_release_group_pkey" PRIMARY KEY ("id");


--
-- Name: l_mood_release l_mood_release_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_mood_release"
    ADD CONSTRAINT "l_mood_release_pkey" PRIMARY KEY ("id");


--
-- Name: l_mood_series l_mood_series_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_mood_series"
    ADD CONSTRAINT "l_mood_series_pkey" PRIMARY KEY ("id");


--
-- Name: l_mood_url l_mood_url_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_mood_url"
    ADD CONSTRAINT "l_mood_url_pkey" PRIMARY KEY ("id");


--
-- Name: l_mood_work l_mood_work_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_mood_work"
    ADD CONSTRAINT "l_mood_work_pkey" PRIMARY KEY ("id");


--
-- Name: l_place_place l_place_place_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_place_place"
    ADD CONSTRAINT "l_place_place_pkey" PRIMARY KEY ("id");


--
-- Name: l_place_recording l_place_recording_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_place_recording"
    ADD CONSTRAINT "l_place_recording_pkey" PRIMARY KEY ("id");


--
-- Name: l_place_release_group l_place_release_group_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_place_release_group"
    ADD CONSTRAINT "l_place_release_group_pkey" PRIMARY KEY ("id");


--
-- Name: l_place_release l_place_release_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_place_release"
    ADD CONSTRAINT "l_place_release_pkey" PRIMARY KEY ("id");


--
-- Name: l_place_series l_place_series_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_place_series"
    ADD CONSTRAINT "l_place_series_pkey" PRIMARY KEY ("id");


--
-- Name: l_place_url l_place_url_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_place_url"
    ADD CONSTRAINT "l_place_url_pkey" PRIMARY KEY ("id");


--
-- Name: l_place_work l_place_work_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_place_work"
    ADD CONSTRAINT "l_place_work_pkey" PRIMARY KEY ("id");


--
-- Name: l_recording_recording l_recording_recording_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_recording_recording"
    ADD CONSTRAINT "l_recording_recording_pkey" PRIMARY KEY ("id");


--
-- Name: l_recording_release_group l_recording_release_group_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_recording_release_group"
    ADD CONSTRAINT "l_recording_release_group_pkey" PRIMARY KEY ("id");


--
-- Name: l_recording_release l_recording_release_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_recording_release"
    ADD CONSTRAINT "l_recording_release_pkey" PRIMARY KEY ("id");


--
-- Name: l_recording_series l_recording_series_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_recording_series"
    ADD CONSTRAINT "l_recording_series_pkey" PRIMARY KEY ("id");


--
-- Name: l_recording_url l_recording_url_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_recording_url"
    ADD CONSTRAINT "l_recording_url_pkey" PRIMARY KEY ("id");


--
-- Name: l_recording_work l_recording_work_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_recording_work"
    ADD CONSTRAINT "l_recording_work_pkey" PRIMARY KEY ("id");


--
-- Name: l_release_group_release_group l_release_group_release_group_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_release_group_release_group"
    ADD CONSTRAINT "l_release_group_release_group_pkey" PRIMARY KEY ("id");


--
-- Name: l_release_group_series l_release_group_series_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_release_group_series"
    ADD CONSTRAINT "l_release_group_series_pkey" PRIMARY KEY ("id");


--
-- Name: l_release_group_url l_release_group_url_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_release_group_url"
    ADD CONSTRAINT "l_release_group_url_pkey" PRIMARY KEY ("id");


--
-- Name: l_release_group_work l_release_group_work_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_release_group_work"
    ADD CONSTRAINT "l_release_group_work_pkey" PRIMARY KEY ("id");


--
-- Name: l_release_release_group l_release_release_group_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_release_release_group"
    ADD CONSTRAINT "l_release_release_group_pkey" PRIMARY KEY ("id");


--
-- Name: l_release_release l_release_release_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_release_release"
    ADD CONSTRAINT "l_release_release_pkey" PRIMARY KEY ("id");


--
-- Name: l_release_series l_release_series_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_release_series"
    ADD CONSTRAINT "l_release_series_pkey" PRIMARY KEY ("id");


--
-- Name: l_release_url l_release_url_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_release_url"
    ADD CONSTRAINT "l_release_url_pkey" PRIMARY KEY ("id");


--
-- Name: l_release_work l_release_work_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_release_work"
    ADD CONSTRAINT "l_release_work_pkey" PRIMARY KEY ("id");


--
-- Name: l_series_series l_series_series_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_series_series"
    ADD CONSTRAINT "l_series_series_pkey" PRIMARY KEY ("id");


--
-- Name: l_series_url l_series_url_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_series_url"
    ADD CONSTRAINT "l_series_url_pkey" PRIMARY KEY ("id");


--
-- Name: l_series_work l_series_work_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_series_work"
    ADD CONSTRAINT "l_series_work_pkey" PRIMARY KEY ("id");


--
-- Name: l_url_url l_url_url_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_url_url"
    ADD CONSTRAINT "l_url_url_pkey" PRIMARY KEY ("id");


--
-- Name: l_url_work l_url_work_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_url_work"
    ADD CONSTRAINT "l_url_work_pkey" PRIMARY KEY ("id");


--
-- Name: l_work_work l_work_work_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."l_work_work"
    ADD CONSTRAINT "l_work_work_pkey" PRIMARY KEY ("id");


--
-- Name: label_alias label_alias_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label_alias"
    ADD CONSTRAINT "label_alias_pkey" PRIMARY KEY ("id");


--
-- Name: label_alias_type label_alias_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label_alias_type"
    ADD CONSTRAINT "label_alias_type_pkey" PRIMARY KEY ("id");


--
-- Name: label_annotation label_annotation_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label_annotation"
    ADD CONSTRAINT "label_annotation_pkey" PRIMARY KEY ("label", "annotation");


--
-- Name: label_attribute label_attribute_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label_attribute"
    ADD CONSTRAINT "label_attribute_pkey" PRIMARY KEY ("id");


--
-- Name: label_attribute_type_allowed_value label_attribute_type_allowed_value_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label_attribute_type_allowed_value"
    ADD CONSTRAINT "label_attribute_type_allowed_value_pkey" PRIMARY KEY ("id");


--
-- Name: label_attribute_type label_attribute_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label_attribute_type"
    ADD CONSTRAINT "label_attribute_type_pkey" PRIMARY KEY ("id");


--
-- Name: label_gid_redirect label_gid_redirect_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label_gid_redirect"
    ADD CONSTRAINT "label_gid_redirect_pkey" PRIMARY KEY ("gid");


--
-- Name: label_ipi label_ipi_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label_ipi"
    ADD CONSTRAINT "label_ipi_pkey" PRIMARY KEY ("label", "ipi");


--
-- Name: label_isni label_isni_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label_isni"
    ADD CONSTRAINT "label_isni_pkey" PRIMARY KEY ("label", "isni");


--
-- Name: label_meta label_meta_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label_meta"
    ADD CONSTRAINT "label_meta_pkey" PRIMARY KEY ("id");


--
-- Name: label label_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label"
    ADD CONSTRAINT "label_pkey" PRIMARY KEY ("id");


--
-- Name: label_rating_raw label_rating_raw_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label_rating_raw"
    ADD CONSTRAINT "label_rating_raw_pkey" PRIMARY KEY ("label", "editor");


--
-- Name: label_tag label_tag_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label_tag"
    ADD CONSTRAINT "label_tag_pkey" PRIMARY KEY ("label", "tag");


--
-- Name: label_tag_raw label_tag_raw_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label_tag_raw"
    ADD CONSTRAINT "label_tag_raw_pkey" PRIMARY KEY ("label", "editor", "tag");


--
-- Name: label_type label_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."label_type"
    ADD CONSTRAINT "label_type_pkey" PRIMARY KEY ("id");


--
-- Name: language language_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."language"
    ADD CONSTRAINT "language_pkey" PRIMARY KEY ("id");


--
-- Name: link_attribute_credit link_attribute_credit_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."link_attribute_credit"
    ADD CONSTRAINT "link_attribute_credit_pkey" PRIMARY KEY ("link", "attribute_type");


--
-- Name: link_attribute link_attribute_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."link_attribute"
    ADD CONSTRAINT "link_attribute_pkey" PRIMARY KEY ("link", "attribute_type");


--
-- Name: link_attribute_text_value link_attribute_text_value_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."link_attribute_text_value"
    ADD CONSTRAINT "link_attribute_text_value_pkey" PRIMARY KEY ("link", "attribute_type");


--
-- Name: link_attribute_type link_attribute_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."link_attribute_type"
    ADD CONSTRAINT "link_attribute_type_pkey" PRIMARY KEY ("id");


--
-- Name: link_creditable_attribute_type link_creditable_attribute_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."link_creditable_attribute_type"
    ADD CONSTRAINT "link_creditable_attribute_type_pkey" PRIMARY KEY ("attribute_type");


--
-- Name: link link_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."link"
    ADD CONSTRAINT "link_pkey" PRIMARY KEY ("id");


--
-- Name: link_text_attribute_type link_text_attribute_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."link_text_attribute_type"
    ADD CONSTRAINT "link_text_attribute_type_pkey" PRIMARY KEY ("attribute_type");


--
-- Name: link_type_attribute_type link_type_attribute_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."link_type_attribute_type"
    ADD CONSTRAINT "link_type_attribute_type_pkey" PRIMARY KEY ("link_type", "attribute_type");


--
-- Name: link_type link_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."link_type"
    ADD CONSTRAINT "link_type_pkey" PRIMARY KEY ("id");


--
-- Name: medium_attribute medium_attribute_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."medium_attribute"
    ADD CONSTRAINT "medium_attribute_pkey" PRIMARY KEY ("id");


--
-- Name: medium_attribute_type_allowed_format medium_attribute_type_allowed_format_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."medium_attribute_type_allowed_format"
    ADD CONSTRAINT "medium_attribute_type_allowed_format_pkey" PRIMARY KEY ("medium_format", "medium_attribute_type");


--
-- Name: medium_attribute_type_allowed_value_allowed_format medium_attribute_type_allowed_value_allowed_format_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."medium_attribute_type_allowed_value_allowed_format"
    ADD CONSTRAINT "medium_attribute_type_allowed_value_allowed_format_pkey" PRIMARY KEY ("medium_format", "medium_attribute_type_allowed_value");


--
-- Name: medium_attribute_type_allowed_value medium_attribute_type_allowed_value_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."medium_attribute_type_allowed_value"
    ADD CONSTRAINT "medium_attribute_type_allowed_value_pkey" PRIMARY KEY ("id");


--
-- Name: medium_attribute_type medium_attribute_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."medium_attribute_type"
    ADD CONSTRAINT "medium_attribute_type_pkey" PRIMARY KEY ("id");


--
-- Name: medium_cdtoc medium_cdtoc_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."medium_cdtoc"
    ADD CONSTRAINT "medium_cdtoc_pkey" PRIMARY KEY ("id");


--
-- Name: medium_format medium_format_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."medium_format"
    ADD CONSTRAINT "medium_format_pkey" PRIMARY KEY ("id");


--
-- Name: medium_gid_redirect medium_gid_redirect_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."medium_gid_redirect"
    ADD CONSTRAINT "medium_gid_redirect_pkey" PRIMARY KEY ("gid");


--
-- Name: medium_index medium_index_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."medium_index"
    ADD CONSTRAINT "medium_index_pkey" PRIMARY KEY ("medium");


--
-- Name: medium medium_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."medium"
    ADD CONSTRAINT "medium_pkey" PRIMARY KEY ("id");


--
-- Name: mood_alias mood_alias_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."mood_alias"
    ADD CONSTRAINT "mood_alias_pkey" PRIMARY KEY ("id");


--
-- Name: mood_alias_type mood_alias_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."mood_alias_type"
    ADD CONSTRAINT "mood_alias_type_pkey" PRIMARY KEY ("id");


--
-- Name: mood_annotation mood_annotation_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."mood_annotation"
    ADD CONSTRAINT "mood_annotation_pkey" PRIMARY KEY ("mood", "annotation");


--
-- Name: mood mood_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."mood"
    ADD CONSTRAINT "mood_pkey" PRIMARY KEY ("id");


--
-- Name: orderable_link_type orderable_link_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."orderable_link_type"
    ADD CONSTRAINT "orderable_link_type_pkey" PRIMARY KEY ("link_type");


--
-- Name: place_alias place_alias_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."place_alias"
    ADD CONSTRAINT "place_alias_pkey" PRIMARY KEY ("id");


--
-- Name: place_alias_type place_alias_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."place_alias_type"
    ADD CONSTRAINT "place_alias_type_pkey" PRIMARY KEY ("id");


--
-- Name: place_annotation place_annotation_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."place_annotation"
    ADD CONSTRAINT "place_annotation_pkey" PRIMARY KEY ("place", "annotation");


--
-- Name: place_attribute place_attribute_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."place_attribute"
    ADD CONSTRAINT "place_attribute_pkey" PRIMARY KEY ("id");


--
-- Name: place_attribute_type_allowed_value place_attribute_type_allowed_value_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."place_attribute_type_allowed_value"
    ADD CONSTRAINT "place_attribute_type_allowed_value_pkey" PRIMARY KEY ("id");


--
-- Name: place_attribute_type place_attribute_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."place_attribute_type"
    ADD CONSTRAINT "place_attribute_type_pkey" PRIMARY KEY ("id");


--
-- Name: place_gid_redirect place_gid_redirect_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."place_gid_redirect"
    ADD CONSTRAINT "place_gid_redirect_pkey" PRIMARY KEY ("gid");


--
-- Name: place_meta place_meta_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."place_meta"
    ADD CONSTRAINT "place_meta_pkey" PRIMARY KEY ("id");


--
-- Name: place place_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."place"
    ADD CONSTRAINT "place_pkey" PRIMARY KEY ("id");


--
-- Name: place_rating_raw place_rating_raw_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."place_rating_raw"
    ADD CONSTRAINT "place_rating_raw_pkey" PRIMARY KEY ("place", "editor");


--
-- Name: place_tag place_tag_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."place_tag"
    ADD CONSTRAINT "place_tag_pkey" PRIMARY KEY ("place", "tag");


--
-- Name: place_tag_raw place_tag_raw_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."place_tag_raw"
    ADD CONSTRAINT "place_tag_raw_pkey" PRIMARY KEY ("place", "editor", "tag");


--
-- Name: place_type place_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."place_type"
    ADD CONSTRAINT "place_type_pkey" PRIMARY KEY ("id");


--
-- Name: recording_alias recording_alias_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."recording_alias"
    ADD CONSTRAINT "recording_alias_pkey" PRIMARY KEY ("id");


--
-- Name: recording_alias_type recording_alias_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."recording_alias_type"
    ADD CONSTRAINT "recording_alias_type_pkey" PRIMARY KEY ("id");


--
-- Name: recording_annotation recording_annotation_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."recording_annotation"
    ADD CONSTRAINT "recording_annotation_pkey" PRIMARY KEY ("recording", "annotation");


--
-- Name: recording_attribute recording_attribute_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."recording_attribute"
    ADD CONSTRAINT "recording_attribute_pkey" PRIMARY KEY ("id");


--
-- Name: recording_attribute_type_allowed_value recording_attribute_type_allowed_value_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."recording_attribute_type_allowed_value"
    ADD CONSTRAINT "recording_attribute_type_allowed_value_pkey" PRIMARY KEY ("id");


--
-- Name: recording_attribute_type recording_attribute_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."recording_attribute_type"
    ADD CONSTRAINT "recording_attribute_type_pkey" PRIMARY KEY ("id");


--
-- Name: recording_first_release_date recording_first_release_date_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."recording_first_release_date"
    ADD CONSTRAINT "recording_first_release_date_pkey" PRIMARY KEY ("recording");


--
-- Name: recording_gid_redirect recording_gid_redirect_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."recording_gid_redirect"
    ADD CONSTRAINT "recording_gid_redirect_pkey" PRIMARY KEY ("gid");


--
-- Name: recording_meta recording_meta_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."recording_meta"
    ADD CONSTRAINT "recording_meta_pkey" PRIMARY KEY ("id");


--
-- Name: recording recording_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."recording"
    ADD CONSTRAINT "recording_pkey" PRIMARY KEY ("id");


--
-- Name: recording_rating_raw recording_rating_raw_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."recording_rating_raw"
    ADD CONSTRAINT "recording_rating_raw_pkey" PRIMARY KEY ("recording", "editor");


--
-- Name: recording_tag recording_tag_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."recording_tag"
    ADD CONSTRAINT "recording_tag_pkey" PRIMARY KEY ("recording", "tag");


--
-- Name: recording_tag_raw recording_tag_raw_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."recording_tag_raw"
    ADD CONSTRAINT "recording_tag_raw_pkey" PRIMARY KEY ("recording", "editor", "tag");


--
-- Name: release_alias release_alias_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_alias"
    ADD CONSTRAINT "release_alias_pkey" PRIMARY KEY ("id");


--
-- Name: release_alias_type release_alias_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_alias_type"
    ADD CONSTRAINT "release_alias_type_pkey" PRIMARY KEY ("id");


--
-- Name: release_annotation release_annotation_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_annotation"
    ADD CONSTRAINT "release_annotation_pkey" PRIMARY KEY ("release", "annotation");


--
-- Name: release_attribute release_attribute_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_attribute"
    ADD CONSTRAINT "release_attribute_pkey" PRIMARY KEY ("id");


--
-- Name: release_attribute_type_allowed_value release_attribute_type_allowed_value_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_attribute_type_allowed_value"
    ADD CONSTRAINT "release_attribute_type_allowed_value_pkey" PRIMARY KEY ("id");


--
-- Name: release_attribute_type release_attribute_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_attribute_type"
    ADD CONSTRAINT "release_attribute_type_pkey" PRIMARY KEY ("id");


--
-- Name: release_country release_country_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_country"
    ADD CONSTRAINT "release_country_pkey" PRIMARY KEY ("release", "country");


--
-- Name: release_first_release_date release_first_release_date_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_first_release_date"
    ADD CONSTRAINT "release_first_release_date_pkey" PRIMARY KEY ("release");


--
-- Name: release_gid_redirect release_gid_redirect_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_gid_redirect"
    ADD CONSTRAINT "release_gid_redirect_pkey" PRIMARY KEY ("gid");


--
-- Name: release_group_alias release_group_alias_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group_alias"
    ADD CONSTRAINT "release_group_alias_pkey" PRIMARY KEY ("id");


--
-- Name: release_group_alias_type release_group_alias_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group_alias_type"
    ADD CONSTRAINT "release_group_alias_type_pkey" PRIMARY KEY ("id");


--
-- Name: release_group_annotation release_group_annotation_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group_annotation"
    ADD CONSTRAINT "release_group_annotation_pkey" PRIMARY KEY ("release_group", "annotation");


--
-- Name: release_group_attribute release_group_attribute_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group_attribute"
    ADD CONSTRAINT "release_group_attribute_pkey" PRIMARY KEY ("id");


--
-- Name: release_group_attribute_type_allowed_value release_group_attribute_type_allowed_value_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group_attribute_type_allowed_value"
    ADD CONSTRAINT "release_group_attribute_type_allowed_value_pkey" PRIMARY KEY ("id");


--
-- Name: release_group_attribute_type release_group_attribute_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group_attribute_type"
    ADD CONSTRAINT "release_group_attribute_type_pkey" PRIMARY KEY ("id");


--
-- Name: release_group_gid_redirect release_group_gid_redirect_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group_gid_redirect"
    ADD CONSTRAINT "release_group_gid_redirect_pkey" PRIMARY KEY ("gid");


--
-- Name: release_group_meta release_group_meta_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group_meta"
    ADD CONSTRAINT "release_group_meta_pkey" PRIMARY KEY ("id");


--
-- Name: release_group release_group_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group"
    ADD CONSTRAINT "release_group_pkey" PRIMARY KEY ("id");


--
-- Name: release_group_primary_type release_group_primary_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group_primary_type"
    ADD CONSTRAINT "release_group_primary_type_pkey" PRIMARY KEY ("id");


--
-- Name: release_group_rating_raw release_group_rating_raw_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group_rating_raw"
    ADD CONSTRAINT "release_group_rating_raw_pkey" PRIMARY KEY ("release_group", "editor");


--
-- Name: release_group_secondary_type_join release_group_secondary_type_join_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group_secondary_type_join"
    ADD CONSTRAINT "release_group_secondary_type_join_pkey" PRIMARY KEY ("release_group", "secondary_type");


--
-- Name: release_group_secondary_type release_group_secondary_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group_secondary_type"
    ADD CONSTRAINT "release_group_secondary_type_pkey" PRIMARY KEY ("id");


--
-- Name: release_group_tag release_group_tag_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group_tag"
    ADD CONSTRAINT "release_group_tag_pkey" PRIMARY KEY ("release_group", "tag");


--
-- Name: release_group_tag_raw release_group_tag_raw_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_group_tag_raw"
    ADD CONSTRAINT "release_group_tag_raw_pkey" PRIMARY KEY ("release_group", "editor", "tag");


--
-- Name: release_label release_label_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_label"
    ADD CONSTRAINT "release_label_pkey" PRIMARY KEY ("id");


--
-- Name: release_meta release_meta_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_meta"
    ADD CONSTRAINT "release_meta_pkey" PRIMARY KEY ("id");


--
-- Name: release_packaging release_packaging_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_packaging"
    ADD CONSTRAINT "release_packaging_pkey" PRIMARY KEY ("id");


--
-- Name: release release_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release"
    ADD CONSTRAINT "release_pkey" PRIMARY KEY ("id");


--
-- Name: release_raw release_raw_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_raw"
    ADD CONSTRAINT "release_raw_pkey" PRIMARY KEY ("id");


--
-- Name: release_status release_status_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_status"
    ADD CONSTRAINT "release_status_pkey" PRIMARY KEY ("id");


--
-- Name: release_tag release_tag_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_tag"
    ADD CONSTRAINT "release_tag_pkey" PRIMARY KEY ("release", "tag");


--
-- Name: release_tag_raw release_tag_raw_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_tag_raw"
    ADD CONSTRAINT "release_tag_raw_pkey" PRIMARY KEY ("release", "editor", "tag");


--
-- Name: release_unknown_country release_unknown_country_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."release_unknown_country"
    ADD CONSTRAINT "release_unknown_country_pkey" PRIMARY KEY ("release");


--
-- Name: replication_control replication_control_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."replication_control"
    ADD CONSTRAINT "replication_control_pkey" PRIMARY KEY ("id");


--
-- Name: script script_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."script"
    ADD CONSTRAINT "script_pkey" PRIMARY KEY ("id");


--
-- Name: series_alias series_alias_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."series_alias"
    ADD CONSTRAINT "series_alias_pkey" PRIMARY KEY ("id");


--
-- Name: series_alias_type series_alias_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."series_alias_type"
    ADD CONSTRAINT "series_alias_type_pkey" PRIMARY KEY ("id");


--
-- Name: series_annotation series_annotation_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."series_annotation"
    ADD CONSTRAINT "series_annotation_pkey" PRIMARY KEY ("series", "annotation");


--
-- Name: series_attribute series_attribute_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."series_attribute"
    ADD CONSTRAINT "series_attribute_pkey" PRIMARY KEY ("id");


--
-- Name: series_attribute_type_allowed_value series_attribute_type_allowed_value_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."series_attribute_type_allowed_value"
    ADD CONSTRAINT "series_attribute_type_allowed_value_pkey" PRIMARY KEY ("id");


--
-- Name: series_attribute_type series_attribute_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."series_attribute_type"
    ADD CONSTRAINT "series_attribute_type_pkey" PRIMARY KEY ("id");


--
-- Name: series_gid_redirect series_gid_redirect_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."series_gid_redirect"
    ADD CONSTRAINT "series_gid_redirect_pkey" PRIMARY KEY ("gid");


--
-- Name: series_ordering_type series_ordering_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."series_ordering_type"
    ADD CONSTRAINT "series_ordering_type_pkey" PRIMARY KEY ("id");


--
-- Name: series series_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."series"
    ADD CONSTRAINT "series_pkey" PRIMARY KEY ("id");


--
-- Name: series_tag series_tag_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."series_tag"
    ADD CONSTRAINT "series_tag_pkey" PRIMARY KEY ("series", "tag");


--
-- Name: series_tag_raw series_tag_raw_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."series_tag_raw"
    ADD CONSTRAINT "series_tag_raw_pkey" PRIMARY KEY ("series", "editor", "tag");


--
-- Name: series_type series_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."series_type"
    ADD CONSTRAINT "series_type_pkey" PRIMARY KEY ("id");


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."tag"
    ADD CONSTRAINT "tag_pkey" PRIMARY KEY ("id");


--
-- Name: tag_relation tag_relation_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."tag_relation"
    ADD CONSTRAINT "tag_relation_pkey" PRIMARY KEY ("tag1", "tag2");


--
-- Name: track_gid_redirect track_gid_redirect_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."track_gid_redirect"
    ADD CONSTRAINT "track_gid_redirect_pkey" PRIMARY KEY ("gid");


--
-- Name: track track_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."track"
    ADD CONSTRAINT "track_pkey" PRIMARY KEY ("id");


--
-- Name: track_raw track_raw_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."track_raw"
    ADD CONSTRAINT "track_raw_pkey" PRIMARY KEY ("id");


--
-- Name: unreferenced_row_log unreferenced_row_log_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."unreferenced_row_log"
    ADD CONSTRAINT "unreferenced_row_log_pkey" PRIMARY KEY ("table_name", "row_id");


--
-- Name: url_gid_redirect url_gid_redirect_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."url_gid_redirect"
    ADD CONSTRAINT "url_gid_redirect_pkey" PRIMARY KEY ("gid");


--
-- Name: url url_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."url"
    ADD CONSTRAINT "url_pkey" PRIMARY KEY ("id");


--
-- Name: vote vote_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."vote"
    ADD CONSTRAINT "vote_pkey" PRIMARY KEY ("id");


--
-- Name: work_alias work_alias_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."work_alias"
    ADD CONSTRAINT "work_alias_pkey" PRIMARY KEY ("id");


--
-- Name: work_alias_type work_alias_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."work_alias_type"
    ADD CONSTRAINT "work_alias_type_pkey" PRIMARY KEY ("id");


--
-- Name: work_annotation work_annotation_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."work_annotation"
    ADD CONSTRAINT "work_annotation_pkey" PRIMARY KEY ("work", "annotation");


--
-- Name: work_attribute work_attribute_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."work_attribute"
    ADD CONSTRAINT "work_attribute_pkey" PRIMARY KEY ("id");


--
-- Name: work_attribute_type_allowed_value work_attribute_type_allowed_value_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."work_attribute_type_allowed_value"
    ADD CONSTRAINT "work_attribute_type_allowed_value_pkey" PRIMARY KEY ("id");


--
-- Name: work_attribute_type work_attribute_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."work_attribute_type"
    ADD CONSTRAINT "work_attribute_type_pkey" PRIMARY KEY ("id");


--
-- Name: work_gid_redirect work_gid_redirect_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."work_gid_redirect"
    ADD CONSTRAINT "work_gid_redirect_pkey" PRIMARY KEY ("gid");


--
-- Name: work_language work_language_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."work_language"
    ADD CONSTRAINT "work_language_pkey" PRIMARY KEY ("work", "language");


--
-- Name: work_meta work_meta_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."work_meta"
    ADD CONSTRAINT "work_meta_pkey" PRIMARY KEY ("id");


--
-- Name: work work_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."work"
    ADD CONSTRAINT "work_pkey" PRIMARY KEY ("id");


--
-- Name: work_rating_raw work_rating_raw_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."work_rating_raw"
    ADD CONSTRAINT "work_rating_raw_pkey" PRIMARY KEY ("work", "editor");


--
-- Name: work_tag work_tag_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."work_tag"
    ADD CONSTRAINT "work_tag_pkey" PRIMARY KEY ("work", "tag");


--
-- Name: work_tag_raw work_tag_raw_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."work_tag_raw"
    ADD CONSTRAINT "work_tag_raw_pkey" PRIMARY KEY ("work", "editor", "tag");


--
-- Name: work_type work_type_pkey; Type: CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."work_type"
    ADD CONSTRAINT "work_type_pkey" PRIMARY KEY ("id");


--
-- Name: index index_pkey; Type: CONSTRAINT; Schema: report; Owner: -
--

ALTER TABLE ONLY "report"."index"
    ADD CONSTRAINT "index_pkey" PRIMARY KEY ("report_name");


--
-- Name: statistic_event statistic_event_pkey; Type: CONSTRAINT; Schema: statistics; Owner: -
--

ALTER TABLE ONLY "statistics"."statistic_event"
    ADD CONSTRAINT "statistic_event_pkey" PRIMARY KEY ("date");


--
-- Name: statistic statistic_pkey; Type: CONSTRAINT; Schema: statistics; Owner: -
--

ALTER TABLE ONLY "statistics"."statistic"
    ADD CONSTRAINT "statistic_pkey" PRIMARY KEY ("id");


--
-- Name: wikidocs_index wikidocs_index_pkey; Type: CONSTRAINT; Schema: wikidocs; Owner: -
--

ALTER TABLE ONLY "wikidocs"."wikidocs_index"
    ADD CONSTRAINT "wikidocs_index_pkey" PRIMARY KEY ("page_name");


--
-- Name: art_type_idx_gid; Type: INDEX; Schema: cover_art_archive; Owner: -
--

CREATE UNIQUE INDEX "art_type_idx_gid" ON "cover_art_archive"."art_type" USING "btree" ("gid");


--
-- Name: cover_art_idx_release; Type: INDEX; Schema: cover_art_archive; Owner: -
--

CREATE INDEX "cover_art_idx_release" ON "cover_art_archive"."cover_art" USING "btree" ("release");


--
-- Name: pending_data_idx_oldctid_xid; Type: INDEX; Schema: dbmirror2; Owner: -
--

CREATE INDEX "pending_data_idx_oldctid_xid" ON "dbmirror2"."pending_data" USING "btree" ("oldctid", "xid");


--
-- Name: pending_data_idx_xid_seqid; Type: INDEX; Schema: dbmirror2; Owner: -
--

CREATE INDEX "pending_data_idx_xid_seqid" ON "dbmirror2"."pending_data" USING "btree" ("xid", "seqid");


--
-- Name: art_type_idx_gid; Type: INDEX; Schema: event_art_archive; Owner: -
--

CREATE UNIQUE INDEX "art_type_idx_gid" ON "event_art_archive"."art_type" USING "btree" ("gid");


--
-- Name: event_art_idx_event; Type: INDEX; Schema: event_art_archive; Owner: -
--

CREATE INDEX "event_art_idx_event" ON "event_art_archive"."event_art" USING "btree" ("event");


--
-- Name: deleted_entities_idx_replication_sequence; Type: INDEX; Schema: json_dump; Owner: -
--

CREATE INDEX "deleted_entities_idx_replication_sequence" ON "json_dump"."deleted_entities" USING "btree" ("replication_sequence");


--
-- Name: tmp_checked_entities_idx_uniq; Type: INDEX; Schema: json_dump; Owner: -
--

CREATE UNIQUE INDEX "tmp_checked_entities_idx_uniq" ON "json_dump"."tmp_checked_entities" USING "btree" ("id", "entity_type");


--
-- Name: alternative_medium_idx_alternative_release; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "alternative_medium_idx_alternative_release" ON "musicbrainz"."alternative_medium" USING "btree" ("alternative_release");


--
-- Name: alternative_release_idx_artist_credit; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "alternative_release_idx_artist_credit" ON "musicbrainz"."alternative_release" USING "btree" ("artist_credit");


--
-- Name: alternative_release_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "alternative_release_idx_gid" ON "musicbrainz"."alternative_release" USING "btree" ("gid");


--
-- Name: alternative_release_idx_language_script; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "alternative_release_idx_language_script" ON "musicbrainz"."alternative_release" USING "btree" ("language", "script");


--
-- Name: alternative_release_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "alternative_release_idx_name" ON "musicbrainz"."alternative_release" USING "btree" ("name");


--
-- Name: alternative_release_idx_release; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "alternative_release_idx_release" ON "musicbrainz"."alternative_release" USING "btree" ("release");


--
-- Name: alternative_track_idx_artist_credit; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "alternative_track_idx_artist_credit" ON "musicbrainz"."alternative_track" USING "btree" ("artist_credit");


--
-- Name: alternative_track_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "alternative_track_idx_name" ON "musicbrainz"."alternative_track" USING "btree" ("name");


--
-- Name: application_idx_oauth_id; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "application_idx_oauth_id" ON "musicbrainz"."application" USING "btree" ("oauth_id");


--
-- Name: application_idx_owner; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "application_idx_owner" ON "musicbrainz"."application" USING "btree" ("owner");


--
-- Name: area_alias_idx_area; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "area_alias_idx_area" ON "musicbrainz"."area_alias" USING "btree" ("area");


--
-- Name: area_alias_idx_primary; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "area_alias_idx_primary" ON "musicbrainz"."area_alias" USING "btree" ("area", "locale") WHERE (("primary_for_locale" = true) AND ("locale" IS NOT NULL));


--
-- Name: area_alias_idx_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "area_alias_idx_txt" ON "musicbrainz"."area_alias" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: area_alias_idx_txt_sort; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "area_alias_idx_txt_sort" ON "musicbrainz"."area_alias" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("sort_name")::"text"));


--
-- Name: area_alias_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "area_alias_type_idx_gid" ON "musicbrainz"."area_alias_type" USING "btree" ("gid");


--
-- Name: area_attribute_idx_area; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "area_attribute_idx_area" ON "musicbrainz"."area_attribute" USING "btree" ("area");


--
-- Name: area_attribute_type_allowed_value_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "area_attribute_type_allowed_value_idx_gid" ON "musicbrainz"."area_attribute_type_allowed_value" USING "btree" ("gid");


--
-- Name: area_attribute_type_allowed_value_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "area_attribute_type_allowed_value_idx_name" ON "musicbrainz"."area_attribute_type_allowed_value" USING "btree" ("area_attribute_type");


--
-- Name: area_attribute_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "area_attribute_type_idx_gid" ON "musicbrainz"."area_attribute_type" USING "btree" ("gid");


--
-- Name: area_containment_idx_parent; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "area_containment_idx_parent" ON "musicbrainz"."area_containment" USING "btree" ("parent");


--
-- Name: area_gid_redirect_idx_new_id; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "area_gid_redirect_idx_new_id" ON "musicbrainz"."area_gid_redirect" USING "btree" ("new_id");


--
-- Name: area_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "area_idx_gid" ON "musicbrainz"."area" USING "btree" ("gid");


--
-- Name: area_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "area_idx_name" ON "musicbrainz"."area" USING "btree" ("name");


--
-- Name: area_idx_name_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "area_idx_name_txt" ON "musicbrainz"."area" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: area_tag_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "area_tag_idx_tag" ON "musicbrainz"."area_tag" USING "btree" ("tag");


--
-- Name: area_tag_raw_idx_area; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "area_tag_raw_idx_area" ON "musicbrainz"."area_tag_raw" USING "btree" ("area");


--
-- Name: area_tag_raw_idx_editor; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "area_tag_raw_idx_editor" ON "musicbrainz"."area_tag_raw" USING "btree" ("editor");


--
-- Name: area_tag_raw_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "area_tag_raw_idx_tag" ON "musicbrainz"."area_tag_raw" USING "btree" ("tag");


--
-- Name: area_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "area_type_idx_gid" ON "musicbrainz"."area_type" USING "btree" ("gid");


--
-- Name: artist_alias_idx_artist; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_alias_idx_artist" ON "musicbrainz"."artist_alias" USING "btree" ("artist");


--
-- Name: artist_alias_idx_lower_unaccent_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_alias_idx_lower_unaccent_name" ON "musicbrainz"."artist_alias" USING "btree" ("lower"("musicbrainz"."musicbrainz_unaccent"(("name")::"text")));


--
-- Name: artist_alias_idx_primary; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "artist_alias_idx_primary" ON "musicbrainz"."artist_alias" USING "btree" ("artist", "locale") WHERE (("primary_for_locale" = true) AND ("locale" IS NOT NULL));


--
-- Name: artist_alias_idx_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_alias_idx_txt" ON "musicbrainz"."artist_alias" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: artist_alias_idx_txt_sort; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_alias_idx_txt_sort" ON "musicbrainz"."artist_alias" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("sort_name")::"text"));


--
-- Name: artist_alias_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "artist_alias_type_idx_gid" ON "musicbrainz"."artist_alias_type" USING "btree" ("gid");


--
-- Name: artist_attribute_idx_artist; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_attribute_idx_artist" ON "musicbrainz"."artist_attribute" USING "btree" ("artist");


--
-- Name: artist_attribute_type_allowed_value_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "artist_attribute_type_allowed_value_idx_gid" ON "musicbrainz"."artist_attribute_type_allowed_value" USING "btree" ("gid");


--
-- Name: artist_attribute_type_allowed_value_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_attribute_type_allowed_value_idx_name" ON "musicbrainz"."artist_attribute_type_allowed_value" USING "btree" ("artist_attribute_type");


--
-- Name: artist_attribute_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "artist_attribute_type_idx_gid" ON "musicbrainz"."artist_attribute_type" USING "btree" ("gid");


--
-- Name: artist_credit_gid_redirect_idx_new_id; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_credit_gid_redirect_idx_new_id" ON "musicbrainz"."artist_credit_gid_redirect" USING "btree" ("new_id");


--
-- Name: artist_credit_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "artist_credit_idx_gid" ON "musicbrainz"."artist_credit" USING "btree" ("gid");


--
-- Name: artist_credit_idx_musicbrainz_collate; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_credit_idx_musicbrainz_collate" ON "musicbrainz"."artist_credit" USING "btree" ("name" COLLATE "musicbrainz"."musicbrainz");


--
-- Name: artist_credit_idx_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_credit_idx_txt" ON "musicbrainz"."artist_credit" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: artist_credit_name_idx_artist; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_credit_name_idx_artist" ON "musicbrainz"."artist_credit_name" USING "btree" ("artist");


--
-- Name: artist_credit_name_idx_musicbrainz_collate; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_credit_name_idx_musicbrainz_collate" ON "musicbrainz"."artist_credit_name" USING "btree" ("name" COLLATE "musicbrainz"."musicbrainz");


--
-- Name: artist_credit_name_idx_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_credit_name_idx_txt" ON "musicbrainz"."artist_credit_name" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: artist_gid_redirect_idx_new_id; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_gid_redirect_idx_new_id" ON "musicbrainz"."artist_gid_redirect" USING "btree" ("new_id");


--
-- Name: artist_idx_area; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_idx_area" ON "musicbrainz"."artist" USING "btree" ("area");


--
-- Name: artist_idx_begin_area; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_idx_begin_area" ON "musicbrainz"."artist" USING "btree" ("begin_area");


--
-- Name: artist_idx_end_area; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_idx_end_area" ON "musicbrainz"."artist" USING "btree" ("end_area");


--
-- Name: artist_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "artist_idx_gid" ON "musicbrainz"."artist" USING "btree" ("gid");


--
-- Name: artist_idx_lower_unaccent_name_comment; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_idx_lower_unaccent_name_comment" ON "musicbrainz"."artist" USING "btree" ("lower"("musicbrainz"."musicbrainz_unaccent"(("name")::"text")), "lower"("musicbrainz"."musicbrainz_unaccent"(("comment")::"text")));


--
-- Name: artist_idx_musicbrainz_collate; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_idx_musicbrainz_collate" ON "musicbrainz"."artist" USING "btree" ("name" COLLATE "musicbrainz"."musicbrainz");


--
-- Name: artist_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_idx_name" ON "musicbrainz"."artist" USING "btree" ("name");


--
-- Name: artist_idx_null_comment; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "artist_idx_null_comment" ON "musicbrainz"."artist" USING "btree" ("name") WHERE ("comment" IS NULL);


--
-- Name: artist_idx_sort_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_idx_sort_name" ON "musicbrainz"."artist" USING "btree" ("sort_name");


--
-- Name: artist_idx_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_idx_txt" ON "musicbrainz"."artist" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: artist_idx_txt_sort; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_idx_txt_sort" ON "musicbrainz"."artist" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("sort_name")::"text"));


--
-- Name: artist_idx_uniq_name_comment; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "artist_idx_uniq_name_comment" ON "musicbrainz"."artist" USING "btree" ("name", "comment") WHERE ("comment" IS NOT NULL);


--
-- Name: artist_rating_raw_idx_editor; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_rating_raw_idx_editor" ON "musicbrainz"."artist_rating_raw" USING "btree" ("editor");


--
-- Name: artist_release_group_nonva_idx_sort; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_release_group_nonva_idx_sort" ON "musicbrainz"."artist_release_group_nonva" USING "btree" ("artist", "unofficial", "primary_type_child_order" NULLS FIRST, "primary_type" NULLS FIRST, "secondary_type_child_orders" NULLS FIRST, "secondary_types" NULLS FIRST, "first_release_date", "name", "release_group");


--
-- Name: artist_release_group_nonva_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "artist_release_group_nonva_idx_uniq" ON "musicbrainz"."artist_release_group_nonva" USING "btree" ("release_group", "artist");


--
-- Name: artist_release_group_pending_update_idx_release_group; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_release_group_pending_update_idx_release_group" ON "musicbrainz"."artist_release_group_pending_update" USING "hash" ("release_group");


--
-- Name: artist_release_group_va_idx_sort; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_release_group_va_idx_sort" ON "musicbrainz"."artist_release_group_va" USING "btree" ("artist", "unofficial", "primary_type_child_order" NULLS FIRST, "primary_type" NULLS FIRST, "secondary_type_child_orders" NULLS FIRST, "secondary_types" NULLS FIRST, "first_release_date", "name", "release_group");


--
-- Name: artist_release_group_va_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "artist_release_group_va_idx_uniq" ON "musicbrainz"."artist_release_group_va" USING "btree" ("release_group", "artist");


--
-- Name: artist_release_nonva_idx_sort; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_release_nonva_idx_sort" ON "musicbrainz"."artist_release_nonva" USING "btree" ("artist", "first_release_date", "catalog_numbers", "country_code", "barcode", "name", "release");


--
-- Name: artist_release_nonva_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "artist_release_nonva_idx_uniq" ON "musicbrainz"."artist_release_nonva" USING "btree" ("release", "artist");


--
-- Name: artist_release_pending_update_idx_release; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_release_pending_update_idx_release" ON "musicbrainz"."artist_release_pending_update" USING "hash" ("release");


--
-- Name: artist_release_va_idx_sort; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_release_va_idx_sort" ON "musicbrainz"."artist_release_va" USING "btree" ("artist", "first_release_date", "catalog_numbers", "country_code", "barcode", "name", "release");


--
-- Name: artist_release_va_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "artist_release_va_idx_uniq" ON "musicbrainz"."artist_release_va" USING "btree" ("release", "artist");


--
-- Name: artist_tag_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_tag_idx_tag" ON "musicbrainz"."artist_tag" USING "btree" ("tag");


--
-- Name: artist_tag_raw_idx_editor; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_tag_raw_idx_editor" ON "musicbrainz"."artist_tag_raw" USING "btree" ("editor");


--
-- Name: artist_tag_raw_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "artist_tag_raw_idx_tag" ON "musicbrainz"."artist_tag_raw" USING "btree" ("tag");


--
-- Name: artist_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "artist_type_idx_gid" ON "musicbrainz"."artist_type" USING "btree" ("gid");


--
-- Name: cdtoc_idx_discid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "cdtoc_idx_discid" ON "musicbrainz"."cdtoc" USING "btree" ("discid");


--
-- Name: cdtoc_idx_freedb_id; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "cdtoc_idx_freedb_id" ON "musicbrainz"."cdtoc" USING "btree" ("freedb_id");


--
-- Name: cdtoc_raw_discid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "cdtoc_raw_discid" ON "musicbrainz"."cdtoc_raw" USING "btree" ("discid");


--
-- Name: cdtoc_raw_toc; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "cdtoc_raw_toc" ON "musicbrainz"."cdtoc_raw" USING "btree" ("track_count", "leadout_offset", "track_offset");


--
-- Name: dbmirror_pending_xid_index; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "dbmirror_pending_xid_index" ON "musicbrainz"."dbmirror_pending" USING "btree" ("xid");


--
-- Name: edit_area_idx; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_area_idx" ON "musicbrainz"."edit_area" USING "btree" ("area");


--
-- Name: edit_artist_idx; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_artist_idx" ON "musicbrainz"."edit_artist" USING "btree" ("artist");


--
-- Name: edit_artist_idx_status; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_artist_idx_status" ON "musicbrainz"."edit_artist" USING "btree" ("status");


--
-- Name: edit_data_idx_link_type; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_data_idx_link_type" ON "musicbrainz"."edit_data" USING "gin" ("array_remove"(ARRAY[(("data" #>> '{link_type,id}'::"text"[]))::integer, (("data" #>> '{link,link_type,id}'::"text"[]))::integer, (("data" #>> '{old,link_type,id}'::"text"[]))::integer, (("data" #>> '{new,link_type,id}'::"text"[]))::integer, (("data" #>> '{relationship,link,type,id}'::"text"[]))::integer], NULL::integer));


--
-- Name: edit_event_idx; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_event_idx" ON "musicbrainz"."edit_event" USING "btree" ("event");


--
-- Name: edit_genre_idx; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_genre_idx" ON "musicbrainz"."edit_genre" USING "btree" ("genre");


--
-- Name: edit_idx_close_time; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_idx_close_time" ON "musicbrainz"."edit" USING "brin" ("close_time");


--
-- Name: edit_idx_editor_id_desc; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_idx_editor_id_desc" ON "musicbrainz"."edit" USING "btree" ("editor", "id" DESC);


--
-- Name: edit_idx_editor_open_time; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_idx_editor_open_time" ON "musicbrainz"."edit" USING "btree" ("editor", "open_time");


--
-- Name: edit_idx_expire_time; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_idx_expire_time" ON "musicbrainz"."edit" USING "brin" ("expire_time");


--
-- Name: edit_idx_open_time; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_idx_open_time" ON "musicbrainz"."edit" USING "brin" ("open_time");


--
-- Name: edit_idx_status_id; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_idx_status_id" ON "musicbrainz"."edit" USING "btree" ("status", "id") WHERE ("status" <> 2);


--
-- Name: edit_idx_type_id; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_idx_type_id" ON "musicbrainz"."edit" USING "btree" ("type", "id");


--
-- Name: edit_instrument_idx; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_instrument_idx" ON "musicbrainz"."edit_instrument" USING "btree" ("instrument");


--
-- Name: edit_label_idx; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_label_idx" ON "musicbrainz"."edit_label" USING "btree" ("label");


--
-- Name: edit_label_idx_status; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_label_idx_status" ON "musicbrainz"."edit_label" USING "btree" ("status");


--
-- Name: edit_mood_idx; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_mood_idx" ON "musicbrainz"."edit_mood" USING "btree" ("mood");


--
-- Name: edit_note_change_idx_edit_note; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_note_change_idx_edit_note" ON "musicbrainz"."edit_note_change" USING "btree" ("edit_note");


--
-- Name: edit_note_idx_edit; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_note_idx_edit" ON "musicbrainz"."edit_note" USING "btree" ("edit");


--
-- Name: edit_note_idx_editor; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_note_idx_editor" ON "musicbrainz"."edit_note" USING "btree" ("editor");


--
-- Name: edit_note_recipient_idx_recipient; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_note_recipient_idx_recipient" ON "musicbrainz"."edit_note_recipient" USING "btree" ("recipient");


--
-- Name: edit_place_idx; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_place_idx" ON "musicbrainz"."edit_place" USING "btree" ("place");


--
-- Name: edit_recording_idx; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_recording_idx" ON "musicbrainz"."edit_recording" USING "btree" ("recording");


--
-- Name: edit_release_group_idx; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_release_group_idx" ON "musicbrainz"."edit_release_group" USING "btree" ("release_group");


--
-- Name: edit_release_idx; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_release_idx" ON "musicbrainz"."edit_release" USING "btree" ("release");


--
-- Name: edit_series_idx; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_series_idx" ON "musicbrainz"."edit_series" USING "btree" ("series");


--
-- Name: edit_url_idx; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_url_idx" ON "musicbrainz"."edit_url" USING "btree" ("url");


--
-- Name: edit_work_idx; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "edit_work_idx" ON "musicbrainz"."edit_work" USING "btree" ("work");


--
-- Name: editor_collection_gid_redirect_idx_new_id; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "editor_collection_gid_redirect_idx_new_id" ON "musicbrainz"."editor_collection_gid_redirect" USING "btree" ("new_id");


--
-- Name: editor_collection_idx_editor; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "editor_collection_idx_editor" ON "musicbrainz"."editor_collection" USING "btree" ("editor");


--
-- Name: editor_collection_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "editor_collection_idx_gid" ON "musicbrainz"."editor_collection" USING "btree" ("gid");


--
-- Name: editor_collection_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "editor_collection_type_idx_gid" ON "musicbrainz"."editor_collection_type" USING "btree" ("gid");


--
-- Name: editor_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "editor_idx_name" ON "musicbrainz"."editor" USING "btree" ("lower"(("name")::"text"));


--
-- Name: editor_language_idx_language; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "editor_language_idx_language" ON "musicbrainz"."editor_language" USING "btree" ("language");


--
-- Name: editor_oauth_token_idx_access_token; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "editor_oauth_token_idx_access_token" ON "musicbrainz"."editor_oauth_token" USING "btree" ("access_token");


--
-- Name: editor_oauth_token_idx_editor; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "editor_oauth_token_idx_editor" ON "musicbrainz"."editor_oauth_token" USING "btree" ("editor");


--
-- Name: editor_oauth_token_idx_refresh_token; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "editor_oauth_token_idx_refresh_token" ON "musicbrainz"."editor_oauth_token" USING "btree" ("refresh_token");


--
-- Name: editor_preference_idx_editor_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "editor_preference_idx_editor_name" ON "musicbrainz"."editor_preference" USING "btree" ("editor", "name");


--
-- Name: editor_subscribe_artist_idx_artist; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "editor_subscribe_artist_idx_artist" ON "musicbrainz"."editor_subscribe_artist" USING "btree" ("artist");


--
-- Name: editor_subscribe_artist_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "editor_subscribe_artist_idx_uniq" ON "musicbrainz"."editor_subscribe_artist" USING "btree" ("editor", "artist");


--
-- Name: editor_subscribe_collection_idx_collection; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "editor_subscribe_collection_idx_collection" ON "musicbrainz"."editor_subscribe_collection" USING "btree" ("collection");


--
-- Name: editor_subscribe_collection_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "editor_subscribe_collection_idx_uniq" ON "musicbrainz"."editor_subscribe_collection" USING "btree" ("editor", "collection");


--
-- Name: editor_subscribe_editor_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "editor_subscribe_editor_idx_uniq" ON "musicbrainz"."editor_subscribe_editor" USING "btree" ("editor", "subscribed_editor");


--
-- Name: editor_subscribe_label_idx_label; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "editor_subscribe_label_idx_label" ON "musicbrainz"."editor_subscribe_label" USING "btree" ("label");


--
-- Name: editor_subscribe_label_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "editor_subscribe_label_idx_uniq" ON "musicbrainz"."editor_subscribe_label" USING "btree" ("editor", "label");


--
-- Name: editor_subscribe_series_idx_series; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "editor_subscribe_series_idx_series" ON "musicbrainz"."editor_subscribe_series" USING "btree" ("series");


--
-- Name: editor_subscribe_series_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "editor_subscribe_series_idx_uniq" ON "musicbrainz"."editor_subscribe_series" USING "btree" ("editor", "series");


--
-- Name: event_alias_idx_event; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "event_alias_idx_event" ON "musicbrainz"."event_alias" USING "btree" ("event");


--
-- Name: event_alias_idx_primary; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "event_alias_idx_primary" ON "musicbrainz"."event_alias" USING "btree" ("event", "locale") WHERE (("primary_for_locale" = true) AND ("locale" IS NOT NULL));


--
-- Name: event_alias_idx_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "event_alias_idx_txt" ON "musicbrainz"."event_alias" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: event_alias_idx_txt_sort; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "event_alias_idx_txt_sort" ON "musicbrainz"."event_alias" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("sort_name")::"text"));


--
-- Name: event_alias_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "event_alias_type_idx_gid" ON "musicbrainz"."event_alias_type" USING "btree" ("gid");


--
-- Name: event_attribute_idx_event; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "event_attribute_idx_event" ON "musicbrainz"."event_attribute" USING "btree" ("event");


--
-- Name: event_attribute_type_allowed_value_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "event_attribute_type_allowed_value_idx_gid" ON "musicbrainz"."event_attribute_type_allowed_value" USING "btree" ("gid");


--
-- Name: event_attribute_type_allowed_value_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "event_attribute_type_allowed_value_idx_name" ON "musicbrainz"."event_attribute_type_allowed_value" USING "btree" ("event_attribute_type");


--
-- Name: event_attribute_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "event_attribute_type_idx_gid" ON "musicbrainz"."event_attribute_type" USING "btree" ("gid");


--
-- Name: event_gid_redirect_idx_new_id; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "event_gid_redirect_idx_new_id" ON "musicbrainz"."event_gid_redirect" USING "btree" ("new_id");


--
-- Name: event_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "event_idx_gid" ON "musicbrainz"."event" USING "btree" ("gid");


--
-- Name: event_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "event_idx_name" ON "musicbrainz"."event" USING "btree" ("name");


--
-- Name: event_idx_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "event_idx_txt" ON "musicbrainz"."event" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: event_rating_raw_idx_editor; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "event_rating_raw_idx_editor" ON "musicbrainz"."event_rating_raw" USING "btree" ("editor");


--
-- Name: event_tag_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "event_tag_idx_tag" ON "musicbrainz"."event_tag" USING "btree" ("tag");


--
-- Name: event_tag_raw_idx_editor; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "event_tag_raw_idx_editor" ON "musicbrainz"."event_tag_raw" USING "btree" ("editor");


--
-- Name: event_tag_raw_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "event_tag_raw_idx_tag" ON "musicbrainz"."event_tag_raw" USING "btree" ("tag");


--
-- Name: event_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "event_type_idx_gid" ON "musicbrainz"."event_type" USING "btree" ("gid");


--
-- Name: gender_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "gender_idx_gid" ON "musicbrainz"."gender" USING "btree" ("gid");


--
-- Name: genre_alias_idx_genre; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "genre_alias_idx_genre" ON "musicbrainz"."genre_alias" USING "btree" ("genre");


--
-- Name: genre_alias_idx_primary; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "genre_alias_idx_primary" ON "musicbrainz"."genre_alias" USING "btree" ("genre", "locale") WHERE (("primary_for_locale" = true) AND ("locale" IS NOT NULL));


--
-- Name: genre_alias_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "genre_alias_type_idx_gid" ON "musicbrainz"."genre_alias_type" USING "btree" ("gid");


--
-- Name: genre_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "genre_idx_gid" ON "musicbrainz"."genre" USING "btree" ("gid");


--
-- Name: genre_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "genre_idx_name" ON "musicbrainz"."genre" USING "btree" ("lower"(("name")::"text"));


--
-- Name: instrument_alias_idx_instrument; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "instrument_alias_idx_instrument" ON "musicbrainz"."instrument_alias" USING "btree" ("instrument");


--
-- Name: instrument_alias_idx_primary; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "instrument_alias_idx_primary" ON "musicbrainz"."instrument_alias" USING "btree" ("instrument", "locale") WHERE (("primary_for_locale" = true) AND ("locale" IS NOT NULL));


--
-- Name: instrument_alias_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "instrument_alias_type_idx_gid" ON "musicbrainz"."instrument_alias_type" USING "btree" ("gid");


--
-- Name: instrument_attribute_idx_instrument; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "instrument_attribute_idx_instrument" ON "musicbrainz"."instrument_attribute" USING "btree" ("instrument");


--
-- Name: instrument_attribute_type_allowed_value_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "instrument_attribute_type_allowed_value_idx_gid" ON "musicbrainz"."instrument_attribute_type_allowed_value" USING "btree" ("gid");


--
-- Name: instrument_attribute_type_allowed_value_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "instrument_attribute_type_allowed_value_idx_name" ON "musicbrainz"."instrument_attribute_type_allowed_value" USING "btree" ("instrument_attribute_type");


--
-- Name: instrument_attribute_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "instrument_attribute_type_idx_gid" ON "musicbrainz"."instrument_attribute_type" USING "btree" ("gid");


--
-- Name: instrument_gid_redirect_idx_new_id; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "instrument_gid_redirect_idx_new_id" ON "musicbrainz"."instrument_gid_redirect" USING "btree" ("new_id");


--
-- Name: instrument_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "instrument_idx_gid" ON "musicbrainz"."instrument" USING "btree" ("gid");


--
-- Name: instrument_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "instrument_idx_name" ON "musicbrainz"."instrument" USING "btree" ("name");


--
-- Name: instrument_idx_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "instrument_idx_txt" ON "musicbrainz"."instrument" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: instrument_tag_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "instrument_tag_idx_tag" ON "musicbrainz"."instrument_tag" USING "btree" ("tag");


--
-- Name: instrument_tag_raw_idx_editor; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "instrument_tag_raw_idx_editor" ON "musicbrainz"."instrument_tag_raw" USING "btree" ("editor");


--
-- Name: instrument_tag_raw_idx_instrument; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "instrument_tag_raw_idx_instrument" ON "musicbrainz"."instrument_tag_raw" USING "btree" ("instrument");


--
-- Name: instrument_tag_raw_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "instrument_tag_raw_idx_tag" ON "musicbrainz"."instrument_tag_raw" USING "btree" ("tag");


--
-- Name: instrument_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "instrument_type_idx_gid" ON "musicbrainz"."instrument_type" USING "btree" ("gid");


--
-- Name: iso_3166_1_idx_area; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "iso_3166_1_idx_area" ON "musicbrainz"."iso_3166_1" USING "btree" ("area");


--
-- Name: iso_3166_2_idx_area; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "iso_3166_2_idx_area" ON "musicbrainz"."iso_3166_2" USING "btree" ("area");


--
-- Name: iso_3166_3_idx_area; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "iso_3166_3_idx_area" ON "musicbrainz"."iso_3166_3" USING "btree" ("area");


--
-- Name: isrc_idx_isrc; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "isrc_idx_isrc" ON "musicbrainz"."isrc" USING "btree" ("isrc");


--
-- Name: isrc_idx_isrc_recording; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "isrc_idx_isrc_recording" ON "musicbrainz"."isrc" USING "btree" ("isrc", "recording");


--
-- Name: isrc_idx_recording; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "isrc_idx_recording" ON "musicbrainz"."isrc" USING "btree" ("recording");


--
-- Name: iswc_idx_iswc; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "iswc_idx_iswc" ON "musicbrainz"."iswc" USING "btree" ("iswc", "work");


--
-- Name: iswc_idx_work; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "iswc_idx_work" ON "musicbrainz"."iswc" USING "btree" ("work");


--
-- Name: l_area_area_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_area_area_idx_entity1" ON "musicbrainz"."l_area_area" USING "btree" ("entity1");


--
-- Name: l_area_area_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_area_area_idx_uniq" ON "musicbrainz"."l_area_area" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_area_artist_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_area_artist_idx_entity1" ON "musicbrainz"."l_area_artist" USING "btree" ("entity1");


--
-- Name: l_area_artist_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_area_artist_idx_uniq" ON "musicbrainz"."l_area_artist" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_area_event_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_area_event_idx_entity1" ON "musicbrainz"."l_area_event" USING "btree" ("entity1");


--
-- Name: l_area_event_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_area_event_idx_uniq" ON "musicbrainz"."l_area_event" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_area_genre_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_area_genre_idx_entity1" ON "musicbrainz"."l_area_genre" USING "btree" ("entity1");


--
-- Name: l_area_genre_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_area_genre_idx_uniq" ON "musicbrainz"."l_area_genre" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_area_instrument_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_area_instrument_idx_entity1" ON "musicbrainz"."l_area_instrument" USING "btree" ("entity1");


--
-- Name: l_area_instrument_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_area_instrument_idx_uniq" ON "musicbrainz"."l_area_instrument" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_area_label_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_area_label_idx_entity1" ON "musicbrainz"."l_area_label" USING "btree" ("entity1");


--
-- Name: l_area_label_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_area_label_idx_uniq" ON "musicbrainz"."l_area_label" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_area_mood_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_area_mood_idx_entity1" ON "musicbrainz"."l_area_mood" USING "btree" ("entity1");


--
-- Name: l_area_mood_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_area_mood_idx_uniq" ON "musicbrainz"."l_area_mood" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_area_place_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_area_place_idx_entity1" ON "musicbrainz"."l_area_place" USING "btree" ("entity1");


--
-- Name: l_area_place_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_area_place_idx_uniq" ON "musicbrainz"."l_area_place" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_area_recording_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_area_recording_idx_entity1" ON "musicbrainz"."l_area_recording" USING "btree" ("entity1");


--
-- Name: l_area_recording_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_area_recording_idx_uniq" ON "musicbrainz"."l_area_recording" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_area_release_group_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_area_release_group_idx_entity1" ON "musicbrainz"."l_area_release_group" USING "btree" ("entity1");


--
-- Name: l_area_release_group_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_area_release_group_idx_uniq" ON "musicbrainz"."l_area_release_group" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_area_release_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_area_release_idx_entity1" ON "musicbrainz"."l_area_release" USING "btree" ("entity1");


--
-- Name: l_area_release_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_area_release_idx_uniq" ON "musicbrainz"."l_area_release" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_area_series_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_area_series_idx_entity1" ON "musicbrainz"."l_area_series" USING "btree" ("entity1");


--
-- Name: l_area_series_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_area_series_idx_uniq" ON "musicbrainz"."l_area_series" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_area_url_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_area_url_idx_entity1" ON "musicbrainz"."l_area_url" USING "btree" ("entity1");


--
-- Name: l_area_url_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_area_url_idx_uniq" ON "musicbrainz"."l_area_url" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_area_work_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_area_work_idx_entity1" ON "musicbrainz"."l_area_work" USING "btree" ("entity1");


--
-- Name: l_area_work_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_area_work_idx_uniq" ON "musicbrainz"."l_area_work" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_artist_artist_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_artist_artist_idx_entity1" ON "musicbrainz"."l_artist_artist" USING "btree" ("entity1");


--
-- Name: l_artist_artist_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_artist_artist_idx_uniq" ON "musicbrainz"."l_artist_artist" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_artist_event_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_artist_event_idx_entity1" ON "musicbrainz"."l_artist_event" USING "btree" ("entity1");


--
-- Name: l_artist_event_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_artist_event_idx_uniq" ON "musicbrainz"."l_artist_event" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_artist_genre_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_artist_genre_idx_entity1" ON "musicbrainz"."l_artist_genre" USING "btree" ("entity1");


--
-- Name: l_artist_genre_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_artist_genre_idx_uniq" ON "musicbrainz"."l_artist_genre" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_artist_instrument_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_artist_instrument_idx_entity1" ON "musicbrainz"."l_artist_instrument" USING "btree" ("entity1");


--
-- Name: l_artist_instrument_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_artist_instrument_idx_uniq" ON "musicbrainz"."l_artist_instrument" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_artist_label_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_artist_label_idx_entity1" ON "musicbrainz"."l_artist_label" USING "btree" ("entity1");


--
-- Name: l_artist_label_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_artist_label_idx_uniq" ON "musicbrainz"."l_artist_label" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_artist_mood_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_artist_mood_idx_entity1" ON "musicbrainz"."l_artist_mood" USING "btree" ("entity1");


--
-- Name: l_artist_mood_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_artist_mood_idx_uniq" ON "musicbrainz"."l_artist_mood" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_artist_place_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_artist_place_idx_entity1" ON "musicbrainz"."l_artist_place" USING "btree" ("entity1");


--
-- Name: l_artist_place_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_artist_place_idx_uniq" ON "musicbrainz"."l_artist_place" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_artist_recording_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_artist_recording_idx_entity1" ON "musicbrainz"."l_artist_recording" USING "btree" ("entity1");


--
-- Name: l_artist_recording_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_artist_recording_idx_uniq" ON "musicbrainz"."l_artist_recording" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_artist_release_group_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_artist_release_group_idx_entity1" ON "musicbrainz"."l_artist_release_group" USING "btree" ("entity1");


--
-- Name: l_artist_release_group_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_artist_release_group_idx_uniq" ON "musicbrainz"."l_artist_release_group" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_artist_release_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_artist_release_idx_entity1" ON "musicbrainz"."l_artist_release" USING "btree" ("entity1");


--
-- Name: l_artist_release_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_artist_release_idx_uniq" ON "musicbrainz"."l_artist_release" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_artist_series_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_artist_series_idx_entity1" ON "musicbrainz"."l_artist_series" USING "btree" ("entity1");


--
-- Name: l_artist_series_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_artist_series_idx_uniq" ON "musicbrainz"."l_artist_series" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_artist_url_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_artist_url_idx_entity1" ON "musicbrainz"."l_artist_url" USING "btree" ("entity1");


--
-- Name: l_artist_url_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_artist_url_idx_uniq" ON "musicbrainz"."l_artist_url" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_artist_work_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_artist_work_idx_entity1" ON "musicbrainz"."l_artist_work" USING "btree" ("entity1");


--
-- Name: l_artist_work_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_artist_work_idx_uniq" ON "musicbrainz"."l_artist_work" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_event_event_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_event_event_idx_entity1" ON "musicbrainz"."l_event_event" USING "btree" ("entity1");


--
-- Name: l_event_event_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_event_event_idx_uniq" ON "musicbrainz"."l_event_event" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_event_genre_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_event_genre_idx_entity1" ON "musicbrainz"."l_event_genre" USING "btree" ("entity1");


--
-- Name: l_event_genre_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_event_genre_idx_uniq" ON "musicbrainz"."l_event_genre" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_event_instrument_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_event_instrument_idx_entity1" ON "musicbrainz"."l_event_instrument" USING "btree" ("entity1");


--
-- Name: l_event_instrument_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_event_instrument_idx_uniq" ON "musicbrainz"."l_event_instrument" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_event_label_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_event_label_idx_entity1" ON "musicbrainz"."l_event_label" USING "btree" ("entity1");


--
-- Name: l_event_label_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_event_label_idx_uniq" ON "musicbrainz"."l_event_label" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_event_mood_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_event_mood_idx_entity1" ON "musicbrainz"."l_event_mood" USING "btree" ("entity1");


--
-- Name: l_event_mood_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_event_mood_idx_uniq" ON "musicbrainz"."l_event_mood" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_event_place_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_event_place_idx_entity1" ON "musicbrainz"."l_event_place" USING "btree" ("entity1");


--
-- Name: l_event_place_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_event_place_idx_uniq" ON "musicbrainz"."l_event_place" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_event_recording_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_event_recording_idx_entity1" ON "musicbrainz"."l_event_recording" USING "btree" ("entity1");


--
-- Name: l_event_recording_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_event_recording_idx_uniq" ON "musicbrainz"."l_event_recording" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_event_release_group_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_event_release_group_idx_entity1" ON "musicbrainz"."l_event_release_group" USING "btree" ("entity1");


--
-- Name: l_event_release_group_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_event_release_group_idx_uniq" ON "musicbrainz"."l_event_release_group" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_event_release_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_event_release_idx_entity1" ON "musicbrainz"."l_event_release" USING "btree" ("entity1");


--
-- Name: l_event_release_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_event_release_idx_uniq" ON "musicbrainz"."l_event_release" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_event_series_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_event_series_idx_entity1" ON "musicbrainz"."l_event_series" USING "btree" ("entity1");


--
-- Name: l_event_series_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_event_series_idx_uniq" ON "musicbrainz"."l_event_series" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_event_url_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_event_url_idx_entity1" ON "musicbrainz"."l_event_url" USING "btree" ("entity1");


--
-- Name: l_event_url_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_event_url_idx_uniq" ON "musicbrainz"."l_event_url" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_event_work_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_event_work_idx_entity1" ON "musicbrainz"."l_event_work" USING "btree" ("entity1");


--
-- Name: l_event_work_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_event_work_idx_uniq" ON "musicbrainz"."l_event_work" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_genre_genre_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_genre_genre_idx_entity1" ON "musicbrainz"."l_genre_genre" USING "btree" ("entity1");


--
-- Name: l_genre_genre_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_genre_genre_idx_uniq" ON "musicbrainz"."l_genre_genre" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_genre_instrument_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_genre_instrument_idx_entity1" ON "musicbrainz"."l_genre_instrument" USING "btree" ("entity1");


--
-- Name: l_genre_instrument_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_genre_instrument_idx_uniq" ON "musicbrainz"."l_genre_instrument" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_genre_label_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_genre_label_idx_entity1" ON "musicbrainz"."l_genre_label" USING "btree" ("entity1");


--
-- Name: l_genre_label_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_genre_label_idx_uniq" ON "musicbrainz"."l_genre_label" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_genre_mood_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_genre_mood_idx_entity1" ON "musicbrainz"."l_genre_mood" USING "btree" ("entity1");


--
-- Name: l_genre_mood_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_genre_mood_idx_uniq" ON "musicbrainz"."l_genre_mood" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_genre_place_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_genre_place_idx_entity1" ON "musicbrainz"."l_genre_place" USING "btree" ("entity1");


--
-- Name: l_genre_place_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_genre_place_idx_uniq" ON "musicbrainz"."l_genre_place" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_genre_recording_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_genre_recording_idx_entity1" ON "musicbrainz"."l_genre_recording" USING "btree" ("entity1");


--
-- Name: l_genre_recording_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_genre_recording_idx_uniq" ON "musicbrainz"."l_genre_recording" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_genre_release_group_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_genre_release_group_idx_entity1" ON "musicbrainz"."l_genre_release_group" USING "btree" ("entity1");


--
-- Name: l_genre_release_group_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_genre_release_group_idx_uniq" ON "musicbrainz"."l_genre_release_group" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_genre_release_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_genre_release_idx_entity1" ON "musicbrainz"."l_genre_release" USING "btree" ("entity1");


--
-- Name: l_genre_release_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_genre_release_idx_uniq" ON "musicbrainz"."l_genre_release" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_genre_series_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_genre_series_idx_entity1" ON "musicbrainz"."l_genre_series" USING "btree" ("entity1");


--
-- Name: l_genre_series_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_genre_series_idx_uniq" ON "musicbrainz"."l_genre_series" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_genre_url_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_genre_url_idx_entity1" ON "musicbrainz"."l_genre_url" USING "btree" ("entity1");


--
-- Name: l_genre_url_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_genre_url_idx_uniq" ON "musicbrainz"."l_genre_url" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_genre_work_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_genre_work_idx_entity1" ON "musicbrainz"."l_genre_work" USING "btree" ("entity1");


--
-- Name: l_genre_work_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_genre_work_idx_uniq" ON "musicbrainz"."l_genre_work" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_instrument_instrument_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_instrument_instrument_idx_entity1" ON "musicbrainz"."l_instrument_instrument" USING "btree" ("entity1");


--
-- Name: l_instrument_instrument_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_instrument_instrument_idx_uniq" ON "musicbrainz"."l_instrument_instrument" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_instrument_label_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_instrument_label_idx_entity1" ON "musicbrainz"."l_instrument_label" USING "btree" ("entity1");


--
-- Name: l_instrument_label_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_instrument_label_idx_uniq" ON "musicbrainz"."l_instrument_label" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_instrument_mood_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_instrument_mood_idx_entity1" ON "musicbrainz"."l_instrument_mood" USING "btree" ("entity1");


--
-- Name: l_instrument_mood_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_instrument_mood_idx_uniq" ON "musicbrainz"."l_instrument_mood" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_instrument_place_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_instrument_place_idx_entity1" ON "musicbrainz"."l_instrument_place" USING "btree" ("entity1");


--
-- Name: l_instrument_place_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_instrument_place_idx_uniq" ON "musicbrainz"."l_instrument_place" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_instrument_recording_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_instrument_recording_idx_entity1" ON "musicbrainz"."l_instrument_recording" USING "btree" ("entity1");


--
-- Name: l_instrument_recording_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_instrument_recording_idx_uniq" ON "musicbrainz"."l_instrument_recording" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_instrument_release_group_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_instrument_release_group_idx_entity1" ON "musicbrainz"."l_instrument_release_group" USING "btree" ("entity1");


--
-- Name: l_instrument_release_group_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_instrument_release_group_idx_uniq" ON "musicbrainz"."l_instrument_release_group" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_instrument_release_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_instrument_release_idx_entity1" ON "musicbrainz"."l_instrument_release" USING "btree" ("entity1");


--
-- Name: l_instrument_release_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_instrument_release_idx_uniq" ON "musicbrainz"."l_instrument_release" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_instrument_series_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_instrument_series_idx_entity1" ON "musicbrainz"."l_instrument_series" USING "btree" ("entity1");


--
-- Name: l_instrument_series_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_instrument_series_idx_uniq" ON "musicbrainz"."l_instrument_series" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_instrument_url_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_instrument_url_idx_entity1" ON "musicbrainz"."l_instrument_url" USING "btree" ("entity1");


--
-- Name: l_instrument_url_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_instrument_url_idx_uniq" ON "musicbrainz"."l_instrument_url" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_instrument_work_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_instrument_work_idx_entity1" ON "musicbrainz"."l_instrument_work" USING "btree" ("entity1");


--
-- Name: l_instrument_work_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_instrument_work_idx_uniq" ON "musicbrainz"."l_instrument_work" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_label_label_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_label_label_idx_entity1" ON "musicbrainz"."l_label_label" USING "btree" ("entity1");


--
-- Name: l_label_label_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_label_label_idx_uniq" ON "musicbrainz"."l_label_label" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_label_mood_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_label_mood_idx_entity1" ON "musicbrainz"."l_label_mood" USING "btree" ("entity1");


--
-- Name: l_label_mood_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_label_mood_idx_uniq" ON "musicbrainz"."l_label_mood" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_label_place_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_label_place_idx_entity1" ON "musicbrainz"."l_label_place" USING "btree" ("entity1");


--
-- Name: l_label_place_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_label_place_idx_uniq" ON "musicbrainz"."l_label_place" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_label_recording_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_label_recording_idx_entity1" ON "musicbrainz"."l_label_recording" USING "btree" ("entity1");


--
-- Name: l_label_recording_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_label_recording_idx_uniq" ON "musicbrainz"."l_label_recording" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_label_release_group_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_label_release_group_idx_entity1" ON "musicbrainz"."l_label_release_group" USING "btree" ("entity1");


--
-- Name: l_label_release_group_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_label_release_group_idx_uniq" ON "musicbrainz"."l_label_release_group" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_label_release_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_label_release_idx_entity1" ON "musicbrainz"."l_label_release" USING "btree" ("entity1");


--
-- Name: l_label_release_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_label_release_idx_uniq" ON "musicbrainz"."l_label_release" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_label_series_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_label_series_idx_entity1" ON "musicbrainz"."l_label_series" USING "btree" ("entity1");


--
-- Name: l_label_series_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_label_series_idx_uniq" ON "musicbrainz"."l_label_series" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_label_url_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_label_url_idx_entity1" ON "musicbrainz"."l_label_url" USING "btree" ("entity1");


--
-- Name: l_label_url_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_label_url_idx_uniq" ON "musicbrainz"."l_label_url" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_label_work_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_label_work_idx_entity1" ON "musicbrainz"."l_label_work" USING "btree" ("entity1");


--
-- Name: l_label_work_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_label_work_idx_uniq" ON "musicbrainz"."l_label_work" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_mood_mood_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_mood_mood_idx_entity1" ON "musicbrainz"."l_mood_mood" USING "btree" ("entity1");


--
-- Name: l_mood_mood_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_mood_mood_idx_uniq" ON "musicbrainz"."l_mood_mood" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_mood_place_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_mood_place_idx_entity1" ON "musicbrainz"."l_mood_place" USING "btree" ("entity1");


--
-- Name: l_mood_place_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_mood_place_idx_uniq" ON "musicbrainz"."l_mood_place" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_mood_recording_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_mood_recording_idx_entity1" ON "musicbrainz"."l_mood_recording" USING "btree" ("entity1");


--
-- Name: l_mood_recording_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_mood_recording_idx_uniq" ON "musicbrainz"."l_mood_recording" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_mood_release_group_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_mood_release_group_idx_entity1" ON "musicbrainz"."l_mood_release_group" USING "btree" ("entity1");


--
-- Name: l_mood_release_group_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_mood_release_group_idx_uniq" ON "musicbrainz"."l_mood_release_group" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_mood_release_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_mood_release_idx_entity1" ON "musicbrainz"."l_mood_release" USING "btree" ("entity1");


--
-- Name: l_mood_release_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_mood_release_idx_uniq" ON "musicbrainz"."l_mood_release" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_mood_series_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_mood_series_idx_entity1" ON "musicbrainz"."l_mood_series" USING "btree" ("entity1");


--
-- Name: l_mood_series_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_mood_series_idx_uniq" ON "musicbrainz"."l_mood_series" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_mood_url_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_mood_url_idx_entity1" ON "musicbrainz"."l_mood_url" USING "btree" ("entity1");


--
-- Name: l_mood_url_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_mood_url_idx_uniq" ON "musicbrainz"."l_mood_url" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_mood_work_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_mood_work_idx_entity1" ON "musicbrainz"."l_mood_work" USING "btree" ("entity1");


--
-- Name: l_mood_work_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_mood_work_idx_uniq" ON "musicbrainz"."l_mood_work" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_place_place_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_place_place_idx_entity1" ON "musicbrainz"."l_place_place" USING "btree" ("entity1");


--
-- Name: l_place_place_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_place_place_idx_uniq" ON "musicbrainz"."l_place_place" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_place_recording_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_place_recording_idx_entity1" ON "musicbrainz"."l_place_recording" USING "btree" ("entity1");


--
-- Name: l_place_recording_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_place_recording_idx_uniq" ON "musicbrainz"."l_place_recording" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_place_release_group_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_place_release_group_idx_entity1" ON "musicbrainz"."l_place_release_group" USING "btree" ("entity1");


--
-- Name: l_place_release_group_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_place_release_group_idx_uniq" ON "musicbrainz"."l_place_release_group" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_place_release_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_place_release_idx_entity1" ON "musicbrainz"."l_place_release" USING "btree" ("entity1");


--
-- Name: l_place_release_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_place_release_idx_uniq" ON "musicbrainz"."l_place_release" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_place_series_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_place_series_idx_entity1" ON "musicbrainz"."l_place_series" USING "btree" ("entity1");


--
-- Name: l_place_series_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_place_series_idx_uniq" ON "musicbrainz"."l_place_series" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_place_url_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_place_url_idx_entity1" ON "musicbrainz"."l_place_url" USING "btree" ("entity1");


--
-- Name: l_place_url_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_place_url_idx_uniq" ON "musicbrainz"."l_place_url" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_place_work_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_place_work_idx_entity1" ON "musicbrainz"."l_place_work" USING "btree" ("entity1");


--
-- Name: l_place_work_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_place_work_idx_uniq" ON "musicbrainz"."l_place_work" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_recording_recording_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_recording_recording_idx_entity1" ON "musicbrainz"."l_recording_recording" USING "btree" ("entity1");


--
-- Name: l_recording_recording_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_recording_recording_idx_uniq" ON "musicbrainz"."l_recording_recording" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_recording_release_group_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_recording_release_group_idx_entity1" ON "musicbrainz"."l_recording_release_group" USING "btree" ("entity1");


--
-- Name: l_recording_release_group_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_recording_release_group_idx_uniq" ON "musicbrainz"."l_recording_release_group" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_recording_release_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_recording_release_idx_entity1" ON "musicbrainz"."l_recording_release" USING "btree" ("entity1");


--
-- Name: l_recording_release_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_recording_release_idx_uniq" ON "musicbrainz"."l_recording_release" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_recording_series_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_recording_series_idx_entity1" ON "musicbrainz"."l_recording_series" USING "btree" ("entity1");


--
-- Name: l_recording_series_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_recording_series_idx_uniq" ON "musicbrainz"."l_recording_series" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_recording_url_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_recording_url_idx_entity1" ON "musicbrainz"."l_recording_url" USING "btree" ("entity1");


--
-- Name: l_recording_url_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_recording_url_idx_uniq" ON "musicbrainz"."l_recording_url" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_recording_work_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_recording_work_idx_entity1" ON "musicbrainz"."l_recording_work" USING "btree" ("entity1");


--
-- Name: l_recording_work_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_recording_work_idx_uniq" ON "musicbrainz"."l_recording_work" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_release_group_release_group_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_release_group_release_group_idx_entity1" ON "musicbrainz"."l_release_group_release_group" USING "btree" ("entity1");


--
-- Name: l_release_group_release_group_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_release_group_release_group_idx_uniq" ON "musicbrainz"."l_release_group_release_group" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_release_group_series_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_release_group_series_idx_entity1" ON "musicbrainz"."l_release_group_series" USING "btree" ("entity1");


--
-- Name: l_release_group_series_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_release_group_series_idx_uniq" ON "musicbrainz"."l_release_group_series" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_release_group_url_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_release_group_url_idx_entity1" ON "musicbrainz"."l_release_group_url" USING "btree" ("entity1");


--
-- Name: l_release_group_url_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_release_group_url_idx_uniq" ON "musicbrainz"."l_release_group_url" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_release_group_work_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_release_group_work_idx_entity1" ON "musicbrainz"."l_release_group_work" USING "btree" ("entity1");


--
-- Name: l_release_group_work_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_release_group_work_idx_uniq" ON "musicbrainz"."l_release_group_work" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_release_release_group_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_release_release_group_idx_entity1" ON "musicbrainz"."l_release_release_group" USING "btree" ("entity1");


--
-- Name: l_release_release_group_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_release_release_group_idx_uniq" ON "musicbrainz"."l_release_release_group" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_release_release_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_release_release_idx_entity1" ON "musicbrainz"."l_release_release" USING "btree" ("entity1");


--
-- Name: l_release_release_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_release_release_idx_uniq" ON "musicbrainz"."l_release_release" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_release_series_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_release_series_idx_entity1" ON "musicbrainz"."l_release_series" USING "btree" ("entity1");


--
-- Name: l_release_series_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_release_series_idx_uniq" ON "musicbrainz"."l_release_series" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_release_url_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_release_url_idx_entity1" ON "musicbrainz"."l_release_url" USING "btree" ("entity1");


--
-- Name: l_release_url_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_release_url_idx_uniq" ON "musicbrainz"."l_release_url" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_release_work_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_release_work_idx_entity1" ON "musicbrainz"."l_release_work" USING "btree" ("entity1");


--
-- Name: l_release_work_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_release_work_idx_uniq" ON "musicbrainz"."l_release_work" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_series_series_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_series_series_idx_entity1" ON "musicbrainz"."l_series_series" USING "btree" ("entity1");


--
-- Name: l_series_series_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_series_series_idx_uniq" ON "musicbrainz"."l_series_series" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_series_url_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_series_url_idx_entity1" ON "musicbrainz"."l_series_url" USING "btree" ("entity1");


--
-- Name: l_series_url_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_series_url_idx_uniq" ON "musicbrainz"."l_series_url" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_series_work_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_series_work_idx_entity1" ON "musicbrainz"."l_series_work" USING "btree" ("entity1");


--
-- Name: l_series_work_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_series_work_idx_uniq" ON "musicbrainz"."l_series_work" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_url_url_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_url_url_idx_entity1" ON "musicbrainz"."l_url_url" USING "btree" ("entity1");


--
-- Name: l_url_url_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_url_url_idx_uniq" ON "musicbrainz"."l_url_url" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_url_work_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_url_work_idx_entity1" ON "musicbrainz"."l_url_work" USING "btree" ("entity1");


--
-- Name: l_url_work_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_url_work_idx_uniq" ON "musicbrainz"."l_url_work" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: l_work_work_idx_entity1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "l_work_work_idx_entity1" ON "musicbrainz"."l_work_work" USING "btree" ("entity1");


--
-- Name: l_work_work_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "l_work_work_idx_uniq" ON "musicbrainz"."l_work_work" USING "btree" ("entity0", "entity1", "link", "link_order");


--
-- Name: label_alias_idx_label; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "label_alias_idx_label" ON "musicbrainz"."label_alias" USING "btree" ("label");


--
-- Name: label_alias_idx_lower_unaccent_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "label_alias_idx_lower_unaccent_name" ON "musicbrainz"."label_alias" USING "btree" ("lower"("musicbrainz"."musicbrainz_unaccent"(("name")::"text")));


--
-- Name: label_alias_idx_primary; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "label_alias_idx_primary" ON "musicbrainz"."label_alias" USING "btree" ("label", "locale") WHERE (("primary_for_locale" = true) AND ("locale" IS NOT NULL));


--
-- Name: label_alias_idx_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "label_alias_idx_txt" ON "musicbrainz"."label_alias" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: label_alias_idx_txt_sort; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "label_alias_idx_txt_sort" ON "musicbrainz"."label_alias" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("sort_name")::"text"));


--
-- Name: label_alias_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "label_alias_type_idx_gid" ON "musicbrainz"."label_alias_type" USING "btree" ("gid");


--
-- Name: label_attribute_idx_label; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "label_attribute_idx_label" ON "musicbrainz"."label_attribute" USING "btree" ("label");


--
-- Name: label_attribute_type_allowed_value_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "label_attribute_type_allowed_value_idx_gid" ON "musicbrainz"."label_attribute_type_allowed_value" USING "btree" ("gid");


--
-- Name: label_attribute_type_allowed_value_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "label_attribute_type_allowed_value_idx_name" ON "musicbrainz"."label_attribute_type_allowed_value" USING "btree" ("label_attribute_type");


--
-- Name: label_attribute_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "label_attribute_type_idx_gid" ON "musicbrainz"."label_attribute_type" USING "btree" ("gid");


--
-- Name: label_gid_redirect_idx_new_id; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "label_gid_redirect_idx_new_id" ON "musicbrainz"."label_gid_redirect" USING "btree" ("new_id");


--
-- Name: label_idx_area; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "label_idx_area" ON "musicbrainz"."label" USING "btree" ("area");


--
-- Name: label_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "label_idx_gid" ON "musicbrainz"."label" USING "btree" ("gid");


--
-- Name: label_idx_lower_unaccent_name_comment; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "label_idx_lower_unaccent_name_comment" ON "musicbrainz"."label" USING "btree" ("lower"("musicbrainz"."musicbrainz_unaccent"(("name")::"text")), "lower"("musicbrainz"."musicbrainz_unaccent"(("comment")::"text")));


--
-- Name: label_idx_musicbrainz_collate; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "label_idx_musicbrainz_collate" ON "musicbrainz"."label" USING "btree" ("name" COLLATE "musicbrainz"."musicbrainz");


--
-- Name: label_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "label_idx_name" ON "musicbrainz"."label" USING "btree" ("name");


--
-- Name: label_idx_null_comment; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "label_idx_null_comment" ON "musicbrainz"."label" USING "btree" ("name") WHERE ("comment" IS NULL);


--
-- Name: label_idx_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "label_idx_txt" ON "musicbrainz"."label" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: label_idx_uniq_name_comment; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "label_idx_uniq_name_comment" ON "musicbrainz"."label" USING "btree" ("name", "comment") WHERE ("comment" IS NOT NULL);


--
-- Name: label_rating_raw_idx_editor; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "label_rating_raw_idx_editor" ON "musicbrainz"."label_rating_raw" USING "btree" ("editor");


--
-- Name: label_tag_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "label_tag_idx_tag" ON "musicbrainz"."label_tag" USING "btree" ("tag");


--
-- Name: label_tag_raw_idx_editor; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "label_tag_raw_idx_editor" ON "musicbrainz"."label_tag_raw" USING "btree" ("editor");


--
-- Name: label_tag_raw_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "label_tag_raw_idx_tag" ON "musicbrainz"."label_tag_raw" USING "btree" ("tag");


--
-- Name: label_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "label_type_idx_gid" ON "musicbrainz"."label_type" USING "btree" ("gid");


--
-- Name: language_idx_iso_code_1; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "language_idx_iso_code_1" ON "musicbrainz"."language" USING "btree" ("iso_code_1");


--
-- Name: language_idx_iso_code_2b; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "language_idx_iso_code_2b" ON "musicbrainz"."language" USING "btree" ("iso_code_2b");


--
-- Name: language_idx_iso_code_2t; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "language_idx_iso_code_2t" ON "musicbrainz"."language" USING "btree" ("iso_code_2t");


--
-- Name: language_idx_iso_code_3; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "language_idx_iso_code_3" ON "musicbrainz"."language" USING "btree" ("iso_code_3");


--
-- Name: link_attribute_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "link_attribute_type_idx_gid" ON "musicbrainz"."link_attribute_type" USING "btree" ("gid");


--
-- Name: link_idx_type_attr; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "link_idx_type_attr" ON "musicbrainz"."link" USING "btree" ("link_type", "attribute_count");


--
-- Name: link_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "link_type_idx_gid" ON "musicbrainz"."link_type" USING "btree" ("gid");


--
-- Name: medium_attribute_idx_medium; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "medium_attribute_idx_medium" ON "musicbrainz"."medium_attribute" USING "btree" ("medium");


--
-- Name: medium_attribute_type_allowed_value_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "medium_attribute_type_allowed_value_idx_gid" ON "musicbrainz"."medium_attribute_type_allowed_value" USING "btree" ("gid");


--
-- Name: medium_attribute_type_allowed_value_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "medium_attribute_type_allowed_value_idx_name" ON "musicbrainz"."medium_attribute_type_allowed_value" USING "btree" ("medium_attribute_type");


--
-- Name: medium_attribute_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "medium_attribute_type_idx_gid" ON "musicbrainz"."medium_attribute_type" USING "btree" ("gid");


--
-- Name: medium_cdtoc_idx_cdtoc; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "medium_cdtoc_idx_cdtoc" ON "musicbrainz"."medium_cdtoc" USING "btree" ("cdtoc");


--
-- Name: medium_cdtoc_idx_medium; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "medium_cdtoc_idx_medium" ON "musicbrainz"."medium_cdtoc" USING "btree" ("medium");


--
-- Name: medium_cdtoc_idx_uniq; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "medium_cdtoc_idx_uniq" ON "musicbrainz"."medium_cdtoc" USING "btree" ("medium", "cdtoc");


--
-- Name: medium_format_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "medium_format_idx_gid" ON "musicbrainz"."medium_format" USING "btree" ("gid");


--
-- Name: medium_gid_redirect_idx_new_id; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "medium_gid_redirect_idx_new_id" ON "musicbrainz"."medium_gid_redirect" USING "btree" ("new_id");


--
-- Name: medium_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "medium_idx_gid" ON "musicbrainz"."medium" USING "btree" ("gid");


--
-- Name: medium_idx_release_position; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "medium_idx_release_position" ON "musicbrainz"."medium" USING "btree" ("release", "position");


--
-- Name: medium_idx_track_count; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "medium_idx_track_count" ON "musicbrainz"."medium" USING "btree" ("track_count");


--
-- Name: medium_index_idx; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "medium_index_idx" ON "musicbrainz"."medium_index" USING "gist" ("toc");


--
-- Name: mood_alias_idx_mood; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "mood_alias_idx_mood" ON "musicbrainz"."mood_alias" USING "btree" ("mood");


--
-- Name: mood_alias_idx_primary; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "mood_alias_idx_primary" ON "musicbrainz"."mood_alias" USING "btree" ("mood", "locale") WHERE (("primary_for_locale" = true) AND ("locale" IS NOT NULL));


--
-- Name: mood_alias_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "mood_alias_type_idx_gid" ON "musicbrainz"."mood_alias_type" USING "btree" ("gid");


--
-- Name: mood_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "mood_idx_gid" ON "musicbrainz"."mood" USING "btree" ("gid");


--
-- Name: mood_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "mood_idx_name" ON "musicbrainz"."mood" USING "btree" ("lower"(("name")::"text"));


--
-- Name: old_editor_name_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "old_editor_name_idx_name" ON "musicbrainz"."old_editor_name" USING "btree" ("lower"(("name")::"text"));


--
-- Name: place_alias_idx_lower_unaccent_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "place_alias_idx_lower_unaccent_name" ON "musicbrainz"."place_alias" USING "btree" ("lower"("musicbrainz"."musicbrainz_unaccent"(("name")::"text")));


--
-- Name: place_alias_idx_place; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "place_alias_idx_place" ON "musicbrainz"."place_alias" USING "btree" ("place");


--
-- Name: place_alias_idx_primary; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "place_alias_idx_primary" ON "musicbrainz"."place_alias" USING "btree" ("place", "locale") WHERE (("primary_for_locale" = true) AND ("locale" IS NOT NULL));


--
-- Name: place_alias_idx_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "place_alias_idx_txt" ON "musicbrainz"."place_alias" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: place_alias_idx_txt_sort; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "place_alias_idx_txt_sort" ON "musicbrainz"."place_alias" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("sort_name")::"text"));


--
-- Name: place_alias_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "place_alias_type_idx_gid" ON "musicbrainz"."place_alias_type" USING "btree" ("gid");


--
-- Name: place_attribute_idx_place; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "place_attribute_idx_place" ON "musicbrainz"."place_attribute" USING "btree" ("place");


--
-- Name: place_attribute_type_allowed_value_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "place_attribute_type_allowed_value_idx_gid" ON "musicbrainz"."place_attribute_type_allowed_value" USING "btree" ("gid");


--
-- Name: place_attribute_type_allowed_value_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "place_attribute_type_allowed_value_idx_name" ON "musicbrainz"."place_attribute_type_allowed_value" USING "btree" ("place_attribute_type");


--
-- Name: place_attribute_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "place_attribute_type_idx_gid" ON "musicbrainz"."place_attribute_type" USING "btree" ("gid");


--
-- Name: place_gid_redirect_idx_new_id; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "place_gid_redirect_idx_new_id" ON "musicbrainz"."place_gid_redirect" USING "btree" ("new_id");


--
-- Name: place_idx_area; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "place_idx_area" ON "musicbrainz"."place" USING "btree" ("area");


--
-- Name: place_idx_geo; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "place_idx_geo" ON "musicbrainz"."place" USING "gist" ("musicbrainz"."ll_to_earth"("coordinates"[0], "coordinates"[1])) WHERE ("coordinates" IS NOT NULL);


--
-- Name: place_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "place_idx_gid" ON "musicbrainz"."place" USING "btree" ("gid");


--
-- Name: place_idx_lower_unaccent_name_comment; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "place_idx_lower_unaccent_name_comment" ON "musicbrainz"."place" USING "btree" ("lower"("musicbrainz"."musicbrainz_unaccent"(("name")::"text")), "lower"("musicbrainz"."musicbrainz_unaccent"(("comment")::"text")));


--
-- Name: place_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "place_idx_name" ON "musicbrainz"."place" USING "btree" ("name");


--
-- Name: place_idx_name_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "place_idx_name_txt" ON "musicbrainz"."place" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: place_rating_raw_idx_editor; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "place_rating_raw_idx_editor" ON "musicbrainz"."place_rating_raw" USING "btree" ("editor");


--
-- Name: place_tag_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "place_tag_idx_tag" ON "musicbrainz"."place_tag" USING "btree" ("tag");


--
-- Name: place_tag_raw_idx_editor; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "place_tag_raw_idx_editor" ON "musicbrainz"."place_tag_raw" USING "btree" ("editor");


--
-- Name: place_tag_raw_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "place_tag_raw_idx_tag" ON "musicbrainz"."place_tag_raw" USING "btree" ("tag");


--
-- Name: place_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "place_type_idx_gid" ON "musicbrainz"."place_type" USING "btree" ("gid");


--
-- Name: recording_alias_idx_primary; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "recording_alias_idx_primary" ON "musicbrainz"."recording_alias" USING "btree" ("recording", "locale") WHERE (("primary_for_locale" = true) AND ("locale" IS NOT NULL));


--
-- Name: recording_alias_idx_recording; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "recording_alias_idx_recording" ON "musicbrainz"."recording_alias" USING "btree" ("recording");


--
-- Name: recording_alias_idx_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "recording_alias_idx_txt" ON "musicbrainz"."recording_alias" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: recording_alias_idx_txt_sort; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "recording_alias_idx_txt_sort" ON "musicbrainz"."recording_alias" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("sort_name")::"text"));


--
-- Name: recording_alias_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "recording_alias_type_idx_gid" ON "musicbrainz"."recording_alias_type" USING "btree" ("gid");


--
-- Name: recording_attribute_idx_recording; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "recording_attribute_idx_recording" ON "musicbrainz"."recording_attribute" USING "btree" ("recording");


--
-- Name: recording_attribute_type_allowed_value_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "recording_attribute_type_allowed_value_idx_gid" ON "musicbrainz"."recording_attribute_type_allowed_value" USING "btree" ("gid");


--
-- Name: recording_attribute_type_allowed_value_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "recording_attribute_type_allowed_value_idx_name" ON "musicbrainz"."recording_attribute_type_allowed_value" USING "btree" ("recording_attribute_type");


--
-- Name: recording_attribute_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "recording_attribute_type_idx_gid" ON "musicbrainz"."recording_attribute_type" USING "btree" ("gid");


--
-- Name: recording_gid_redirect_idx_new_id; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "recording_gid_redirect_idx_new_id" ON "musicbrainz"."recording_gid_redirect" USING "btree" ("new_id");


--
-- Name: recording_idx_artist_credit; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "recording_idx_artist_credit" ON "musicbrainz"."recording" USING "btree" ("artist_credit");


--
-- Name: recording_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "recording_idx_gid" ON "musicbrainz"."recording" USING "btree" ("gid");


--
-- Name: recording_idx_musicbrainz_collate; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "recording_idx_musicbrainz_collate" ON "musicbrainz"."recording" USING "btree" ("name" COLLATE "musicbrainz"."musicbrainz");


--
-- Name: recording_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "recording_idx_name" ON "musicbrainz"."recording" USING "btree" ("name");


--
-- Name: recording_idx_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "recording_idx_txt" ON "musicbrainz"."recording" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: recording_rating_raw_idx_editor; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "recording_rating_raw_idx_editor" ON "musicbrainz"."recording_rating_raw" USING "btree" ("editor");


--
-- Name: recording_tag_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "recording_tag_idx_tag" ON "musicbrainz"."recording_tag" USING "btree" ("tag");


--
-- Name: recording_tag_raw_idx_editor; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "recording_tag_raw_idx_editor" ON "musicbrainz"."recording_tag_raw" USING "btree" ("editor");


--
-- Name: recording_tag_raw_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "recording_tag_raw_idx_tag" ON "musicbrainz"."recording_tag_raw" USING "btree" ("tag");


--
-- Name: recording_tag_raw_idx_track; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "recording_tag_raw_idx_track" ON "musicbrainz"."recording_tag_raw" USING "btree" ("recording");


--
-- Name: release_alias_idx_primary; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "release_alias_idx_primary" ON "musicbrainz"."release_alias" USING "btree" ("release", "locale") WHERE (("primary_for_locale" = true) AND ("locale" IS NOT NULL));


--
-- Name: release_alias_idx_release; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_alias_idx_release" ON "musicbrainz"."release_alias" USING "btree" ("release");


--
-- Name: release_alias_idx_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_alias_idx_txt" ON "musicbrainz"."release_alias" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: release_alias_idx_txt_sort; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_alias_idx_txt_sort" ON "musicbrainz"."release_alias" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("sort_name")::"text"));


--
-- Name: release_attribute_idx_release; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_attribute_idx_release" ON "musicbrainz"."release_attribute" USING "btree" ("release");


--
-- Name: release_attribute_type_allowed_value_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "release_attribute_type_allowed_value_idx_gid" ON "musicbrainz"."release_attribute_type_allowed_value" USING "btree" ("gid");


--
-- Name: release_attribute_type_allowed_value_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_attribute_type_allowed_value_idx_name" ON "musicbrainz"."release_attribute_type_allowed_value" USING "btree" ("release_attribute_type");


--
-- Name: release_attribute_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "release_attribute_type_idx_gid" ON "musicbrainz"."release_attribute_type" USING "btree" ("gid");


--
-- Name: release_country_idx_country; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_country_idx_country" ON "musicbrainz"."release_country" USING "btree" ("country");


--
-- Name: release_gid_redirect_idx_new_id; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_gid_redirect_idx_new_id" ON "musicbrainz"."release_gid_redirect" USING "btree" ("new_id");


--
-- Name: release_group_alias_idx_primary; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "release_group_alias_idx_primary" ON "musicbrainz"."release_group_alias" USING "btree" ("release_group", "locale") WHERE (("primary_for_locale" = true) AND ("locale" IS NOT NULL));


--
-- Name: release_group_alias_idx_release_group; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_group_alias_idx_release_group" ON "musicbrainz"."release_group_alias" USING "btree" ("release_group");


--
-- Name: release_group_alias_idx_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_group_alias_idx_txt" ON "musicbrainz"."release_group_alias" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: release_group_alias_idx_txt_sort; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_group_alias_idx_txt_sort" ON "musicbrainz"."release_group_alias" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("sort_name")::"text"));


--
-- Name: release_group_alias_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "release_group_alias_type_idx_gid" ON "musicbrainz"."release_group_alias_type" USING "btree" ("gid");


--
-- Name: release_group_attribute_idx_release_group; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_group_attribute_idx_release_group" ON "musicbrainz"."release_group_attribute" USING "btree" ("release_group");


--
-- Name: release_group_attribute_type_allowed_value_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "release_group_attribute_type_allowed_value_idx_gid" ON "musicbrainz"."release_group_attribute_type_allowed_value" USING "btree" ("gid");


--
-- Name: release_group_attribute_type_allowed_value_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_group_attribute_type_allowed_value_idx_name" ON "musicbrainz"."release_group_attribute_type_allowed_value" USING "btree" ("release_group_attribute_type");


--
-- Name: release_group_attribute_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "release_group_attribute_type_idx_gid" ON "musicbrainz"."release_group_attribute_type" USING "btree" ("gid");


--
-- Name: release_group_gid_redirect_idx_new_id; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_group_gid_redirect_idx_new_id" ON "musicbrainz"."release_group_gid_redirect" USING "btree" ("new_id");


--
-- Name: release_group_idx_artist_credit; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_group_idx_artist_credit" ON "musicbrainz"."release_group" USING "btree" ("artist_credit");


--
-- Name: release_group_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "release_group_idx_gid" ON "musicbrainz"."release_group" USING "btree" ("gid");


--
-- Name: release_group_idx_musicbrainz_collate; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_group_idx_musicbrainz_collate" ON "musicbrainz"."release_group" USING "btree" ("name" COLLATE "musicbrainz"."musicbrainz");


--
-- Name: release_group_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_group_idx_name" ON "musicbrainz"."release_group" USING "btree" ("name");


--
-- Name: release_group_idx_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_group_idx_txt" ON "musicbrainz"."release_group" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: release_group_primary_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "release_group_primary_type_idx_gid" ON "musicbrainz"."release_group_primary_type" USING "btree" ("gid");


--
-- Name: release_group_rating_raw_idx_editor; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_group_rating_raw_idx_editor" ON "musicbrainz"."release_group_rating_raw" USING "btree" ("editor");


--
-- Name: release_group_secondary_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "release_group_secondary_type_idx_gid" ON "musicbrainz"."release_group_secondary_type" USING "btree" ("gid");


--
-- Name: release_group_tag_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_group_tag_idx_tag" ON "musicbrainz"."release_group_tag" USING "btree" ("tag");


--
-- Name: release_group_tag_raw_idx_editor; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_group_tag_raw_idx_editor" ON "musicbrainz"."release_group_tag_raw" USING "btree" ("editor");


--
-- Name: release_group_tag_raw_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_group_tag_raw_idx_tag" ON "musicbrainz"."release_group_tag_raw" USING "btree" ("tag");


--
-- Name: release_idx_artist_credit; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_idx_artist_credit" ON "musicbrainz"."release" USING "btree" ("artist_credit");


--
-- Name: release_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "release_idx_gid" ON "musicbrainz"."release" USING "btree" ("gid");


--
-- Name: release_idx_musicbrainz_collate; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_idx_musicbrainz_collate" ON "musicbrainz"."release" USING "btree" ("name" COLLATE "musicbrainz"."musicbrainz");


--
-- Name: release_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_idx_name" ON "musicbrainz"."release" USING "btree" ("name");


--
-- Name: release_idx_release_group; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_idx_release_group" ON "musicbrainz"."release" USING "btree" ("release_group");


--
-- Name: release_idx_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_idx_txt" ON "musicbrainz"."release" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: release_label_idx_label; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_label_idx_label" ON "musicbrainz"."release_label" USING "btree" ("label");


--
-- Name: release_label_idx_release; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_label_idx_release" ON "musicbrainz"."release_label" USING "btree" ("release");


--
-- Name: release_packaging_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "release_packaging_idx_gid" ON "musicbrainz"."release_packaging" USING "btree" ("gid");


--
-- Name: release_status_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "release_status_idx_gid" ON "musicbrainz"."release_status" USING "btree" ("gid");


--
-- Name: release_tag_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_tag_idx_tag" ON "musicbrainz"."release_tag" USING "btree" ("tag");


--
-- Name: release_tag_raw_idx_editor; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_tag_raw_idx_editor" ON "musicbrainz"."release_tag_raw" USING "btree" ("editor");


--
-- Name: release_tag_raw_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "release_tag_raw_idx_tag" ON "musicbrainz"."release_tag_raw" USING "btree" ("tag");


--
-- Name: script_idx_iso_code; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "script_idx_iso_code" ON "musicbrainz"."script" USING "btree" ("iso_code");


--
-- Name: series_alias_idx_lower_unaccent_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "series_alias_idx_lower_unaccent_name" ON "musicbrainz"."series_alias" USING "btree" ("lower"("musicbrainz"."musicbrainz_unaccent"(("name")::"text")));


--
-- Name: series_alias_idx_primary; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "series_alias_idx_primary" ON "musicbrainz"."series_alias" USING "btree" ("series", "locale") WHERE (("primary_for_locale" = true) AND ("locale" IS NOT NULL));


--
-- Name: series_alias_idx_series; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "series_alias_idx_series" ON "musicbrainz"."series_alias" USING "btree" ("series");


--
-- Name: series_alias_idx_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "series_alias_idx_txt" ON "musicbrainz"."series_alias" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: series_alias_idx_txt_sort; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "series_alias_idx_txt_sort" ON "musicbrainz"."series_alias" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("sort_name")::"text"));


--
-- Name: series_alias_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "series_alias_type_idx_gid" ON "musicbrainz"."series_alias_type" USING "btree" ("gid");


--
-- Name: series_attribute_idx_series; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "series_attribute_idx_series" ON "musicbrainz"."series_attribute" USING "btree" ("series");


--
-- Name: series_attribute_type_allowed_value_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "series_attribute_type_allowed_value_idx_gid" ON "musicbrainz"."series_attribute_type_allowed_value" USING "btree" ("gid");


--
-- Name: series_attribute_type_allowed_value_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "series_attribute_type_allowed_value_idx_name" ON "musicbrainz"."series_attribute_type_allowed_value" USING "btree" ("series_attribute_type");


--
-- Name: series_attribute_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "series_attribute_type_idx_gid" ON "musicbrainz"."series_attribute_type" USING "btree" ("gid");


--
-- Name: series_gid_redirect_idx_new_id; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "series_gid_redirect_idx_new_id" ON "musicbrainz"."series_gid_redirect" USING "btree" ("new_id");


--
-- Name: series_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "series_idx_gid" ON "musicbrainz"."series" USING "btree" ("gid");


--
-- Name: series_idx_lower_unaccent_name_comment; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "series_idx_lower_unaccent_name_comment" ON "musicbrainz"."series" USING "btree" ("lower"("musicbrainz"."musicbrainz_unaccent"(("name")::"text")), "lower"("musicbrainz"."musicbrainz_unaccent"(("comment")::"text")));


--
-- Name: series_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "series_idx_name" ON "musicbrainz"."series" USING "btree" ("name");


--
-- Name: series_idx_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "series_idx_txt" ON "musicbrainz"."series" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: series_ordering_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "series_ordering_type_idx_gid" ON "musicbrainz"."series_ordering_type" USING "btree" ("gid");


--
-- Name: series_tag_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "series_tag_idx_tag" ON "musicbrainz"."series_tag" USING "btree" ("tag");


--
-- Name: series_tag_raw_idx_editor; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "series_tag_raw_idx_editor" ON "musicbrainz"."series_tag_raw" USING "btree" ("editor");


--
-- Name: series_tag_raw_idx_series; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "series_tag_raw_idx_series" ON "musicbrainz"."series_tag_raw" USING "btree" ("series");


--
-- Name: series_tag_raw_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "series_tag_raw_idx_tag" ON "musicbrainz"."series_tag_raw" USING "btree" ("tag");


--
-- Name: series_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "series_type_idx_gid" ON "musicbrainz"."series_type" USING "btree" ("gid");


--
-- Name: tag_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "tag_idx_name" ON "musicbrainz"."tag" USING "btree" ("name");


--
-- Name: tag_idx_name_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "tag_idx_name_txt" ON "musicbrainz"."tag" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: track_gid_redirect_idx_new_id; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "track_gid_redirect_idx_new_id" ON "musicbrainz"."track_gid_redirect" USING "btree" ("new_id");


--
-- Name: track_idx_artist_credit; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "track_idx_artist_credit" ON "musicbrainz"."track" USING "btree" ("artist_credit");


--
-- Name: track_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "track_idx_gid" ON "musicbrainz"."track" USING "btree" ("gid");


--
-- Name: track_idx_medium_position; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "track_idx_medium_position" ON "musicbrainz"."track" USING "btree" ("medium", "position");


--
-- Name: track_idx_recording; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "track_idx_recording" ON "musicbrainz"."track" USING "btree" ("recording");


--
-- Name: track_raw_idx_release; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "track_raw_idx_release" ON "musicbrainz"."track_raw" USING "btree" ("release");


--
-- Name: unreferenced_row_log_idx_inserted; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "unreferenced_row_log_idx_inserted" ON "musicbrainz"."unreferenced_row_log" USING "brin" ("inserted");


--
-- Name: url_gid_redirect_idx_new_id; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "url_gid_redirect_idx_new_id" ON "musicbrainz"."url_gid_redirect" USING "btree" ("new_id");


--
-- Name: url_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "url_idx_gid" ON "musicbrainz"."url" USING "btree" ("gid");


--
-- Name: url_idx_url; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "url_idx_url" ON "musicbrainz"."url" USING "btree" ("url");


--
-- Name: vote_idx_edit; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "vote_idx_edit" ON "musicbrainz"."vote" USING "btree" ("edit");


--
-- Name: vote_idx_editor_edit; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "vote_idx_editor_edit" ON "musicbrainz"."vote" USING "btree" ("editor", "edit") WHERE ("superseded" = false);


--
-- Name: vote_idx_editor_vote_time; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "vote_idx_editor_vote_time" ON "musicbrainz"."vote" USING "btree" ("editor", "vote_time");


--
-- Name: work_alias_idx_primary; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "work_alias_idx_primary" ON "musicbrainz"."work_alias" USING "btree" ("work", "locale") WHERE (("primary_for_locale" = true) AND ("locale" IS NOT NULL));


--
-- Name: work_alias_idx_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "work_alias_idx_txt" ON "musicbrainz"."work_alias" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: work_alias_idx_txt_sort; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "work_alias_idx_txt_sort" ON "musicbrainz"."work_alias" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("sort_name")::"text"));


--
-- Name: work_alias_idx_work; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "work_alias_idx_work" ON "musicbrainz"."work_alias" USING "btree" ("work");


--
-- Name: work_alias_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "work_alias_type_idx_gid" ON "musicbrainz"."work_alias_type" USING "btree" ("gid");


--
-- Name: work_attribute_idx_work; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "work_attribute_idx_work" ON "musicbrainz"."work_attribute" USING "btree" ("work");


--
-- Name: work_attribute_type_allowed_value_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "work_attribute_type_allowed_value_idx_gid" ON "musicbrainz"."work_attribute_type_allowed_value" USING "btree" ("gid");


--
-- Name: work_attribute_type_allowed_value_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "work_attribute_type_allowed_value_idx_name" ON "musicbrainz"."work_attribute_type_allowed_value" USING "btree" ("work_attribute_type");


--
-- Name: work_attribute_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "work_attribute_type_idx_gid" ON "musicbrainz"."work_attribute_type" USING "btree" ("gid");


--
-- Name: work_gid_redirect_idx_new_id; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "work_gid_redirect_idx_new_id" ON "musicbrainz"."work_gid_redirect" USING "btree" ("new_id");


--
-- Name: work_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "work_idx_gid" ON "musicbrainz"."work" USING "btree" ("gid");


--
-- Name: work_idx_musicbrainz_collate; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "work_idx_musicbrainz_collate" ON "musicbrainz"."work" USING "btree" ("name" COLLATE "musicbrainz"."musicbrainz");


--
-- Name: work_idx_name; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "work_idx_name" ON "musicbrainz"."work" USING "btree" ("name");


--
-- Name: work_idx_txt; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "work_idx_txt" ON "musicbrainz"."work" USING "gin" ("musicbrainz"."mb_simple_tsvector"(("name")::"text"));


--
-- Name: work_tag_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "work_tag_idx_tag" ON "musicbrainz"."work_tag" USING "btree" ("tag");


--
-- Name: work_tag_raw_idx_tag; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE INDEX "work_tag_raw_idx_tag" ON "musicbrainz"."work_tag_raw" USING "btree" ("tag");


--
-- Name: work_type_idx_gid; Type: INDEX; Schema: musicbrainz; Owner: -
--

CREATE UNIQUE INDEX "work_type_idx_gid" ON "musicbrainz"."work_type" USING "btree" ("gid");


--
-- Name: artist_lastmod_idx_url; Type: INDEX; Schema: sitemaps; Owner: -
--

CREATE UNIQUE INDEX "artist_lastmod_idx_url" ON "sitemaps"."artist_lastmod" USING "btree" ("url");


--
-- Name: label_lastmod_idx_url; Type: INDEX; Schema: sitemaps; Owner: -
--

CREATE UNIQUE INDEX "label_lastmod_idx_url" ON "sitemaps"."label_lastmod" USING "btree" ("url");


--
-- Name: place_lastmod_idx_url; Type: INDEX; Schema: sitemaps; Owner: -
--

CREATE UNIQUE INDEX "place_lastmod_idx_url" ON "sitemaps"."place_lastmod" USING "btree" ("url");


--
-- Name: recording_lastmod_idx_url; Type: INDEX; Schema: sitemaps; Owner: -
--

CREATE UNIQUE INDEX "recording_lastmod_idx_url" ON "sitemaps"."recording_lastmod" USING "btree" ("url");


--
-- Name: release_group_lastmod_idx_url; Type: INDEX; Schema: sitemaps; Owner: -
--

CREATE UNIQUE INDEX "release_group_lastmod_idx_url" ON "sitemaps"."release_group_lastmod" USING "btree" ("url");


--
-- Name: release_lastmod_idx_url; Type: INDEX; Schema: sitemaps; Owner: -
--

CREATE UNIQUE INDEX "release_lastmod_idx_url" ON "sitemaps"."release_lastmod" USING "btree" ("url");


--
-- Name: tmp_checked_entities_idx_uniq; Type: INDEX; Schema: sitemaps; Owner: -
--

CREATE UNIQUE INDEX "tmp_checked_entities_idx_uniq" ON "sitemaps"."tmp_checked_entities" USING "btree" ("id", "entity_type");


--
-- Name: work_lastmod_idx_url; Type: INDEX; Schema: sitemaps; Owner: -
--

CREATE UNIQUE INDEX "work_lastmod_idx_url" ON "sitemaps"."work_lastmod" USING "btree" ("url");


--
-- Name: statistic_name; Type: INDEX; Schema: statistics; Owner: -
--

CREATE INDEX "statistic_name" ON "statistics"."statistic" USING "btree" ("name");


--
-- Name: statistic_name_date_collected; Type: INDEX; Schema: statistics; Owner: -
--

CREATE UNIQUE INDEX "statistic_name_date_collected" ON "statistics"."statistic" USING "btree" ("name", "date_collected");


--
-- Name: l_area_area a_del_l_area_area_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_del_l_area_area_mirror" AFTER DELETE ON "musicbrainz"."l_area_area" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_del_l_area_area_mirror"();


--
-- Name: release_country a_del_release_event_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_del_release_event_mirror" AFTER DELETE ON "musicbrainz"."release_country" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_del_release_event_mirror"();


--
-- Name: release_unknown_country a_del_release_event_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_del_release_event_mirror" AFTER DELETE ON "musicbrainz"."release_unknown_country" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_del_release_event_mirror"();


--
-- Name: release_group a_del_release_group_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_del_release_group_mirror" AFTER DELETE ON "musicbrainz"."release_group" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_del_release_group_mirror"();


--
-- Name: release_group_secondary_type_join a_del_release_group_secondary_type_join_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_del_release_group_secondary_type_join_mirror" AFTER DELETE ON "musicbrainz"."release_group_secondary_type_join" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_del_release_group_secondary_type_join_mirror"();


--
-- Name: release_label a_del_release_label_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_del_release_label_mirror" AFTER DELETE ON "musicbrainz"."release_label" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_del_release_label_mirror"();


--
-- Name: release a_del_release_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_del_release_mirror" AFTER DELETE ON "musicbrainz"."release" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_del_release_mirror"();


--
-- Name: track a_del_track_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_del_track_mirror" AFTER DELETE ON "musicbrainz"."track" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_del_track_mirror"();


--
-- Name: l_area_area a_ins_l_area_area_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_ins_l_area_area_mirror" AFTER INSERT ON "musicbrainz"."l_area_area" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_ins_l_area_area_mirror"();


--
-- Name: release_country a_ins_release_event_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_ins_release_event_mirror" AFTER INSERT ON "musicbrainz"."release_country" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_ins_release_event_mirror"();


--
-- Name: release_unknown_country a_ins_release_event_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_ins_release_event_mirror" AFTER INSERT ON "musicbrainz"."release_unknown_country" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_ins_release_event_mirror"();


--
-- Name: release_group a_ins_release_group_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_ins_release_group_mirror" AFTER INSERT ON "musicbrainz"."release_group" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_ins_release_group_mirror"();


--
-- Name: release_group_secondary_type_join a_ins_release_group_secondary_type_join_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_ins_release_group_secondary_type_join_mirror" AFTER INSERT ON "musicbrainz"."release_group_secondary_type_join" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_ins_release_group_secondary_type_join_mirror"();


--
-- Name: release_label a_ins_release_label_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_ins_release_label_mirror" AFTER INSERT ON "musicbrainz"."release_label" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_ins_release_label_mirror"();


--
-- Name: release a_ins_release_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_ins_release_mirror" AFTER INSERT ON "musicbrainz"."release" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_ins_release_mirror"();


--
-- Name: track a_ins_track_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_ins_track_mirror" AFTER INSERT ON "musicbrainz"."track" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_ins_track_mirror"();


--
-- Name: l_area_area a_upd_l_area_area_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_upd_l_area_area_mirror" AFTER UPDATE ON "musicbrainz"."l_area_area" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_upd_l_area_area_mirror"();


--
-- Name: medium a_upd_medium; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_upd_medium" AFTER UPDATE ON "musicbrainz"."medium" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_upd_medium_mirror"();


--
-- Name: release_country a_upd_release_event_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_upd_release_event_mirror" AFTER UPDATE ON "musicbrainz"."release_country" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_upd_release_event_mirror"();


--
-- Name: release_unknown_country a_upd_release_event_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_upd_release_event_mirror" AFTER UPDATE ON "musicbrainz"."release_unknown_country" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_upd_release_event_mirror"();


--
-- Name: release_group_meta a_upd_release_group_meta_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_upd_release_group_meta_mirror" AFTER UPDATE ON "musicbrainz"."release_group_meta" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_upd_release_group_meta_mirror"();


--
-- Name: release_group a_upd_release_group_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_upd_release_group_mirror" AFTER UPDATE ON "musicbrainz"."release_group" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_upd_release_group_mirror"();


--
-- Name: release_group_primary_type a_upd_release_group_primary_type_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_upd_release_group_primary_type_mirror" AFTER UPDATE ON "musicbrainz"."release_group_primary_type" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_upd_release_group_primary_type_mirror"();


--
-- Name: release_group_secondary_type a_upd_release_group_secondary_type_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_upd_release_group_secondary_type_mirror" AFTER UPDATE ON "musicbrainz"."release_group_secondary_type" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_upd_release_group_secondary_type_mirror"();


--
-- Name: release_label a_upd_release_label_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_upd_release_label_mirror" AFTER UPDATE ON "musicbrainz"."release_label" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_upd_release_label_mirror"();


--
-- Name: release a_upd_release_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_upd_release_mirror" AFTER UPDATE ON "musicbrainz"."release" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_upd_release_mirror"();


--
-- Name: track a_upd_track_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE TRIGGER "a_upd_track_mirror" AFTER UPDATE ON "musicbrainz"."track" FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."a_upd_track_mirror"();


--
-- Name: release apply_artist_release_group_pending_updates_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE CONSTRAINT TRIGGER "apply_artist_release_group_pending_updates_mirror" AFTER INSERT OR DELETE OR UPDATE ON "musicbrainz"."release" DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."apply_artist_release_group_pending_updates"();


--
-- Name: release_group apply_artist_release_group_pending_updates_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE CONSTRAINT TRIGGER "apply_artist_release_group_pending_updates_mirror" AFTER INSERT OR DELETE OR UPDATE ON "musicbrainz"."release_group" DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."apply_artist_release_group_pending_updates"();


--
-- Name: release_group_meta apply_artist_release_group_pending_updates_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE CONSTRAINT TRIGGER "apply_artist_release_group_pending_updates_mirror" AFTER UPDATE ON "musicbrainz"."release_group_meta" DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."apply_artist_release_group_pending_updates"();


--
-- Name: release_group_primary_type apply_artist_release_group_pending_updates_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE CONSTRAINT TRIGGER "apply_artist_release_group_pending_updates_mirror" AFTER UPDATE ON "musicbrainz"."release_group_primary_type" DEFERRABLE INITIALLY DEFERRED FOR EACH ROW WHEN (("old"."child_order" IS DISTINCT FROM "new"."child_order")) EXECUTE FUNCTION "musicbrainz"."apply_artist_release_group_pending_updates"();


--
-- Name: release_group_secondary_type apply_artist_release_group_pending_updates_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE CONSTRAINT TRIGGER "apply_artist_release_group_pending_updates_mirror" AFTER UPDATE ON "musicbrainz"."release_group_secondary_type" DEFERRABLE INITIALLY DEFERRED FOR EACH ROW WHEN (("old"."child_order" IS DISTINCT FROM "new"."child_order")) EXECUTE FUNCTION "musicbrainz"."apply_artist_release_group_pending_updates"();


--
-- Name: release_group_secondary_type_join apply_artist_release_group_pending_updates_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE CONSTRAINT TRIGGER "apply_artist_release_group_pending_updates_mirror" AFTER INSERT OR DELETE ON "musicbrainz"."release_group_secondary_type_join" DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."apply_artist_release_group_pending_updates"();


--
-- Name: track apply_artist_release_group_pending_updates_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE CONSTRAINT TRIGGER "apply_artist_release_group_pending_updates_mirror" AFTER INSERT OR DELETE OR UPDATE ON "musicbrainz"."track" DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."apply_artist_release_group_pending_updates"();


--
-- Name: release apply_artist_release_pending_updates_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE CONSTRAINT TRIGGER "apply_artist_release_pending_updates_mirror" AFTER INSERT OR DELETE OR UPDATE ON "musicbrainz"."release" DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."apply_artist_release_pending_updates"();


--
-- Name: release_country apply_artist_release_pending_updates_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE CONSTRAINT TRIGGER "apply_artist_release_pending_updates_mirror" AFTER INSERT OR DELETE OR UPDATE ON "musicbrainz"."release_country" DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."apply_artist_release_pending_updates"();


--
-- Name: release_first_release_date apply_artist_release_pending_updates_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE CONSTRAINT TRIGGER "apply_artist_release_pending_updates_mirror" AFTER INSERT OR DELETE OR UPDATE ON "musicbrainz"."release_first_release_date" DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."apply_artist_release_pending_updates"();


--
-- Name: release_label apply_artist_release_pending_updates_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE CONSTRAINT TRIGGER "apply_artist_release_pending_updates_mirror" AFTER INSERT OR DELETE OR UPDATE ON "musicbrainz"."release_label" DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."apply_artist_release_pending_updates"();


--
-- Name: track apply_artist_release_pending_updates_mirror; Type: TRIGGER; Schema: musicbrainz; Owner: -
--

CREATE CONSTRAINT TRIGGER "apply_artist_release_pending_updates_mirror" AFTER INSERT OR DELETE OR UPDATE ON "musicbrainz"."track" DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION "musicbrainz"."apply_artist_release_pending_updates"();


--
-- Name: dbmirror_pendingdata dbmirror_pendingdata_seqid_fkey; Type: FK CONSTRAINT; Schema: musicbrainz; Owner: -
--

ALTER TABLE ONLY "musicbrainz"."dbmirror_pendingdata"
    ADD CONSTRAINT "dbmirror_pendingdata_seqid_fkey" FOREIGN KEY ("seqid") REFERENCES "musicbrainz"."dbmirror_pending"("seqid") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict BnLCtHjd3NbgaeEfrgfAKWoOjK8g5e66EtnYKoPaLUky1DBHMMTxZgM6AezDzak

