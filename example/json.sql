select row_to_json(t) from (select username, user_id from public.user) t;
