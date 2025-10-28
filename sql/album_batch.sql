SELECT
    rg.id AS rg_id,
    rg.gid::text AS object_uuid,
    rg.name AS title,
    rgm.first_release_date_year AS fr_year,
    rgm.first_release_date_month AS fr_month,
    rgm.first_release_date_day AS fr_day,
    rgm.rating AS rating_0_100,
    rgm.rating_count AS rating_count,
    ac_info.artist_names,
    ac_info.countries,
    tags.tag_names,
    sec_types.secondary_names,
    mus.musician_names,
    mus.musician_details,
    caa.cover_release_gid
FROM musicbrainz.release_group rg
JOIN musicbrainz.release_group_primary_type rpt ON rpt.id = rg.type
LEFT JOIN musicbrainz.release_group_meta rgm ON rgm.id = rg.id
LEFT JOIN LATERAL (
    SELECT
        ARRAY_AGG(acn.name ORDER BY acn."position") AS artist_names,
        ARRAY_REMOVE(ARRAY_AGG(DISTINCT i1.code), NULL) AS countries
    FROM musicbrainz.artist_credit_name acn
    JOIN musicbrainz.artist a ON a.id = acn.artist
    LEFT JOIN musicbrainz.area ar ON ar.id = a.area
    LEFT JOIN musicbrainz.iso_3166_1 i1 ON i1.area = ar.id
    WHERE acn.artist_credit = rg.artist_credit
) ac_info ON TRUE
LEFT JOIN LATERAL (
    SELECT ARRAY_AGG(t.name ORDER BY rgt.count DESC) AS tag_names
    FROM musicbrainz.release_group_tag rgt
    JOIN musicbrainz.tag t ON t.id = rgt.tag
    WHERE rgt.release_group = rg.id
) tags ON TRUE
LEFT JOIN LATERAL (
    SELECT ARRAY_AGG(rgst.name ORDER BY rgst.name) AS secondary_names
    FROM musicbrainz.release_group_secondary_type_join rgstj
    JOIN musicbrainz.release_group_secondary_type rgst ON rgst.id = rgstj.secondary_type
    WHERE rgstj.release_group = rg.id
) sec_types ON TRUE
LEFT JOIN LATERAL (
    WITH recs AS (
        SELECT DISTINCT rec.id AS recording_id
        FROM musicbrainz.release r2
        JOIN musicbrainz.medium m ON m.release = r2.id
        JOIN musicbrainz.track t ON t.medium = m.id
        JOIN musicbrainz.recording rec ON rec.id = t.recording
        WHERE r2.release_group = rg.id
    ),
    per_artist AS (
        SELECT
            lar.entity0 AS artist_id,
            ARRAY_AGG(DISTINCT lat.name) FILTER (WHERE lat.name IS NOT NULL AND lat.name <> '') AS instrument_names
        FROM recs
        JOIN musicbrainz.l_artist_recording lar ON lar.entity1 = recs.recording_id
        JOIN musicbrainz.link lk ON lk.id = lar.link
        LEFT JOIN musicbrainz.link_attribute la ON la.link = lk.id
        LEFT JOIN musicbrainz.link_attribute_type lat ON lat.id = la.attribute_type
        GROUP BY lar.entity0
    )
    SELECT
        ARRAY_AGG(DISTINCT a2.name) AS musician_names,
        JSONB_AGG(
            DISTINCT JSONB_BUILD_OBJECT(
                'name', a2.name,
                'mbid', a2.gid::text,
                'instruments', COALESCE(per_artist.instrument_names, ARRAY[]::text[])
            )
        ) AS musician_details
    FROM per_artist
    JOIN musicbrainz.artist a2 ON a2.id = per_artist.artist_id
) mus ON TRUE
LEFT JOIN LATERAL (
    SELECT rel_choice.rel_gid AS cover_release_gid
    FROM (
        SELECT
            r.gid::text AS rel_gid,
            MAX(CASE WHEN at.name = 'Front' THEN 1 ELSE 0 END) AS has_front,
            MIN(ca.ordering) AS min_ordering
        FROM musicbrainz.release r
        JOIN cover_art_archive.cover_art ca ON ca.release = r.id
        LEFT JOIN cover_art_archive.cover_art_type cat ON cat.id = ca.id
        LEFT JOIN cover_art_archive.art_type at ON at.id = cat.type_id
        WHERE r.release_group = rg.id
        GROUP BY r.gid
        ORDER BY has_front DESC, min_ordering ASC
        LIMIT 1
    ) rel_choice
) caa ON TRUE
WHERE rpt.name = 'Album' AND rg.id > %s AND sec_types.secondary_names IS NULL
ORDER BY rg.id
LIMIT %s
