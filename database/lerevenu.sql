--
-- PostgreSQL database dump
--


-- Dumped from database version 16.15
-- Dumped by pg_dump version 16.15

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.upload_folders DROP CONSTRAINT IF EXISTS upload_folders_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.upload_folders_parent_lnk DROP CONSTRAINT IF EXISTS upload_folders_parent_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.upload_folders_parent_lnk DROP CONSTRAINT IF EXISTS upload_folders_parent_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.upload_folders DROP CONSTRAINT IF EXISTS upload_folders_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.up_users DROP CONSTRAINT IF EXISTS up_users_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.up_users_role_lnk DROP CONSTRAINT IF EXISTS up_users_role_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.up_users_role_lnk DROP CONSTRAINT IF EXISTS up_users_role_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.up_users DROP CONSTRAINT IF EXISTS up_users_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.up_roles DROP CONSTRAINT IF EXISTS up_roles_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.up_roles DROP CONSTRAINT IF EXISTS up_roles_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.up_permissions DROP CONSTRAINT IF EXISTS up_permissions_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.up_permissions_role_lnk DROP CONSTRAINT IF EXISTS up_permissions_role_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.up_permissions_role_lnk DROP CONSTRAINT IF EXISTS up_permissions_role_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.up_permissions DROP CONSTRAINT IF EXISTS up_permissions_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_workflows DROP CONSTRAINT IF EXISTS strapi_workflows_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_workflows_stages_workflow_lnk DROP CONSTRAINT IF EXISTS strapi_workflows_stages_workflow_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.strapi_workflows_stages_workflow_lnk DROP CONSTRAINT IF EXISTS strapi_workflows_stages_workflow_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_workflows_stages DROP CONSTRAINT IF EXISTS strapi_workflows_stages_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_workflows_stages_permissions_lnk DROP CONSTRAINT IF EXISTS strapi_workflows_stages_permissions_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.strapi_workflows_stages_permissions_lnk DROP CONSTRAINT IF EXISTS strapi_workflows_stages_permissions_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_workflows_stages DROP CONSTRAINT IF EXISTS strapi_workflows_stages_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_workflows_stage_required_to_publish_lnk DROP CONSTRAINT IF EXISTS strapi_workflows_stage_required_to_publish_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.strapi_workflows_stage_required_to_publish_lnk DROP CONSTRAINT IF EXISTS strapi_workflows_stage_required_to_publish_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_workflows DROP CONSTRAINT IF EXISTS strapi_workflows_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_transfer_tokens DROP CONSTRAINT IF EXISTS strapi_transfer_tokens_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_transfer_tokens DROP CONSTRAINT IF EXISTS strapi_transfer_tokens_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_transfer_token_permissions DROP CONSTRAINT IF EXISTS strapi_transfer_token_permissions_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_transfer_token_permissions_token_lnk DROP CONSTRAINT IF EXISTS strapi_transfer_token_permissions_token_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.strapi_transfer_token_permissions_token_lnk DROP CONSTRAINT IF EXISTS strapi_transfer_token_permissions_token_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_transfer_token_permissions DROP CONSTRAINT IF EXISTS strapi_transfer_token_permissions_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_sessions DROP CONSTRAINT IF EXISTS strapi_sessions_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_sessions DROP CONSTRAINT IF EXISTS strapi_sessions_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_releases DROP CONSTRAINT IF EXISTS strapi_releases_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_releases DROP CONSTRAINT IF EXISTS strapi_releases_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_release_actions DROP CONSTRAINT IF EXISTS strapi_release_actions_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_release_actions_release_lnk DROP CONSTRAINT IF EXISTS strapi_release_actions_release_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.strapi_release_actions_release_lnk DROP CONSTRAINT IF EXISTS strapi_release_actions_release_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_release_actions DROP CONSTRAINT IF EXISTS strapi_release_actions_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_history_versions DROP CONSTRAINT IF EXISTS strapi_history_versions_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_api_tokens DROP CONSTRAINT IF EXISTS strapi_api_tokens_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_api_tokens DROP CONSTRAINT IF EXISTS strapi_api_tokens_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_api_tokens_admin_user_owner_lnk DROP CONSTRAINT IF EXISTS strapi_api_tokens_admin_user_owner_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.strapi_api_tokens_admin_user_owner_lnk DROP CONSTRAINT IF EXISTS strapi_api_tokens_admin_user_owner_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_api_token_permissions DROP CONSTRAINT IF EXISTS strapi_api_token_permissions_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_api_token_permissions_token_lnk DROP CONSTRAINT IF EXISTS strapi_api_token_permissions_token_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.strapi_api_token_permissions_token_lnk DROP CONSTRAINT IF EXISTS strapi_api_token_permissions_token_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.strapi_api_token_permissions DROP CONSTRAINT IF EXISTS strapi_api_token_permissions_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.rewards DROP CONSTRAINT IF EXISTS rewards_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.rewards_recipient_lnk DROP CONSTRAINT IF EXISTS rewards_recipient_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.rewards_recipient_lnk DROP CONSTRAINT IF EXISTS rewards_recipient_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.rewards DROP CONSTRAINT IF EXISTS rewards_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.replies_useful_by_lnk DROP CONSTRAINT IF EXISTS replies_useful_by_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.replies_useful_by_lnk DROP CONSTRAINT IF EXISTS replies_useful_by_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.replies DROP CONSTRAINT IF EXISTS replies_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.replies_discussion_lnk DROP CONSTRAINT IF EXISTS replies_discussion_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.replies_discussion_lnk DROP CONSTRAINT IF EXISTS replies_discussion_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.replies DROP CONSTRAINT IF EXISTS replies_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.replies_author_lnk DROP CONSTRAINT IF EXISTS replies_author_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.replies_author_lnk DROP CONSTRAINT IF EXISTS replies_author_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS notifications_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.notifications_recipient_lnk DROP CONSTRAINT IF EXISTS notifications_recipient_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.notifications_recipient_lnk DROP CONSTRAINT IF EXISTS notifications_recipient_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.notifications_discussion_lnk DROP CONSTRAINT IF EXISTS notifications_discussion_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.notifications_discussion_lnk DROP CONSTRAINT IF EXISTS notifications_discussion_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS notifications_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.notifications_blog_post_lnk DROP CONSTRAINT IF EXISTS notifications_blog_post_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.notifications_blog_post_lnk DROP CONSTRAINT IF EXISTS notifications_blog_post_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.notifications_actor_lnk DROP CONSTRAINT IF EXISTS notifications_actor_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.notifications_actor_lnk DROP CONSTRAINT IF EXISTS notifications_actor_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.i18n_locale DROP CONSTRAINT IF EXISTS i18n_locale_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.i18n_locale DROP CONSTRAINT IF EXISTS i18n_locale_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.files DROP CONSTRAINT IF EXISTS files_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.files_related_mph DROP CONSTRAINT IF EXISTS files_related_mph_fk;
ALTER TABLE IF EXISTS ONLY public.files_folder_lnk DROP CONSTRAINT IF EXISTS files_folder_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.files_folder_lnk DROP CONSTRAINT IF EXISTS files_folder_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.files DROP CONSTRAINT IF EXISTS files_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.events DROP CONSTRAINT IF EXISTS events_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.events DROP CONSTRAINT IF EXISTS events_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.events_category_lnk DROP CONSTRAINT IF EXISTS events_category_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.events_category_lnk DROP CONSTRAINT IF EXISTS events_category_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.events_attendees_lnk DROP CONSTRAINT IF EXISTS events_attendees_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.events_attendees_lnk DROP CONSTRAINT IF EXISTS events_attendees_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.discussions_useful_by_lnk DROP CONSTRAINT IF EXISTS discussions_useful_by_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.discussions_useful_by_lnk DROP CONSTRAINT IF EXISTS discussions_useful_by_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.discussions DROP CONSTRAINT IF EXISTS discussions_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.discussions_followed_by_lnk DROP CONSTRAINT IF EXISTS discussions_followed_by_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.discussions_followed_by_lnk DROP CONSTRAINT IF EXISTS discussions_followed_by_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.discussions DROP CONSTRAINT IF EXISTS discussions_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.discussions_category_lnk DROP CONSTRAINT IF EXISTS discussions_category_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.discussions_category_lnk DROP CONSTRAINT IF EXISTS discussions_category_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.discussions_author_lnk DROP CONSTRAINT IF EXISTS discussions_author_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.discussions_author_lnk DROP CONSTRAINT IF EXISTS discussions_author_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.categories DROP CONSTRAINT IF EXISTS categories_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.categories DROP CONSTRAINT IF EXISTS categories_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.blog_posts_useful_by_lnk DROP CONSTRAINT IF EXISTS blog_posts_useful_by_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.blog_posts_useful_by_lnk DROP CONSTRAINT IF EXISTS blog_posts_useful_by_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.blog_posts DROP CONSTRAINT IF EXISTS blog_posts_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.blog_posts DROP CONSTRAINT IF EXISTS blog_posts_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.blog_posts_category_lnk DROP CONSTRAINT IF EXISTS blog_posts_category_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.blog_posts_category_lnk DROP CONSTRAINT IF EXISTS blog_posts_category_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.blog_posts_author_lnk DROP CONSTRAINT IF EXISTS blog_posts_author_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.blog_posts_author_lnk DROP CONSTRAINT IF EXISTS blog_posts_author_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.blog_comments_useful_by_lnk DROP CONSTRAINT IF EXISTS blog_comments_useful_by_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.blog_comments_useful_by_lnk DROP CONSTRAINT IF EXISTS blog_comments_useful_by_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.blog_comments DROP CONSTRAINT IF EXISTS blog_comments_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.blog_comments_post_lnk DROP CONSTRAINT IF EXISTS blog_comments_post_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.blog_comments_post_lnk DROP CONSTRAINT IF EXISTS blog_comments_post_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.blog_comments DROP CONSTRAINT IF EXISTS blog_comments_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.blog_comments_author_lnk DROP CONSTRAINT IF EXISTS blog_comments_author_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.blog_comments_author_lnk DROP CONSTRAINT IF EXISTS blog_comments_author_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.admin_users DROP CONSTRAINT IF EXISTS admin_users_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.admin_users_roles_lnk DROP CONSTRAINT IF EXISTS admin_users_roles_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.admin_users_roles_lnk DROP CONSTRAINT IF EXISTS admin_users_roles_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.admin_users DROP CONSTRAINT IF EXISTS admin_users_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.admin_roles DROP CONSTRAINT IF EXISTS admin_roles_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.admin_roles DROP CONSTRAINT IF EXISTS admin_roles_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.admin_permissions DROP CONSTRAINT IF EXISTS admin_permissions_updated_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.admin_permissions_role_lnk DROP CONSTRAINT IF EXISTS admin_permissions_role_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.admin_permissions_role_lnk DROP CONSTRAINT IF EXISTS admin_permissions_role_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.admin_permissions DROP CONSTRAINT IF EXISTS admin_permissions_created_by_id_fk;
ALTER TABLE IF EXISTS ONLY public.admin_permissions_api_token_lnk DROP CONSTRAINT IF EXISTS admin_permissions_api_token_lnk_ifk;
ALTER TABLE IF EXISTS ONLY public.admin_permissions_api_token_lnk DROP CONSTRAINT IF EXISTS admin_permissions_api_token_lnk_fk;
DROP INDEX IF EXISTS public.upload_folders_updated_by_id_fk;
DROP INDEX IF EXISTS public.upload_folders_parent_lnk_oifk;
DROP INDEX IF EXISTS public.upload_folders_parent_lnk_ifk;
DROP INDEX IF EXISTS public.upload_folders_parent_lnk_fk;
DROP INDEX IF EXISTS public.upload_folders_documents_idx;
DROP INDEX IF EXISTS public.upload_folders_created_by_id_fk;
DROP INDEX IF EXISTS public.upload_files_updated_at_index;
DROP INDEX IF EXISTS public.upload_files_size_index;
DROP INDEX IF EXISTS public.upload_files_name_index;
DROP INDEX IF EXISTS public.upload_files_folder_path_index;
DROP INDEX IF EXISTS public.upload_files_ext_index;
DROP INDEX IF EXISTS public.upload_files_created_at_index;
DROP INDEX IF EXISTS public.up_users_updated_by_id_fk;
DROP INDEX IF EXISTS public.up_users_role_lnk_oifk;
DROP INDEX IF EXISTS public.up_users_role_lnk_ifk;
DROP INDEX IF EXISTS public.up_users_role_lnk_fk;
DROP INDEX IF EXISTS public.up_users_documents_idx;
DROP INDEX IF EXISTS public.up_users_created_by_id_fk;
DROP INDEX IF EXISTS public.up_roles_updated_by_id_fk;
DROP INDEX IF EXISTS public.up_roles_documents_idx;
DROP INDEX IF EXISTS public.up_roles_created_by_id_fk;
DROP INDEX IF EXISTS public.up_permissions_updated_by_id_fk;
DROP INDEX IF EXISTS public.up_permissions_role_lnk_oifk;
DROP INDEX IF EXISTS public.up_permissions_role_lnk_ifk;
DROP INDEX IF EXISTS public.up_permissions_role_lnk_fk;
DROP INDEX IF EXISTS public.up_permissions_documents_idx;
DROP INDEX IF EXISTS public.up_permissions_created_by_id_fk;
DROP INDEX IF EXISTS public.strapi_workflows_updated_by_id_fk;
DROP INDEX IF EXISTS public.strapi_workflows_stages_workflow_lnk_oifk;
DROP INDEX IF EXISTS public.strapi_workflows_stages_workflow_lnk_ifk;
DROP INDEX IF EXISTS public.strapi_workflows_stages_workflow_lnk_fk;
DROP INDEX IF EXISTS public.strapi_workflows_stages_updated_by_id_fk;
DROP INDEX IF EXISTS public.strapi_workflows_stages_permissions_lnk_ofk;
DROP INDEX IF EXISTS public.strapi_workflows_stages_permissions_lnk_ifk;
DROP INDEX IF EXISTS public.strapi_workflows_stages_permissions_lnk_fk;
DROP INDEX IF EXISTS public.strapi_workflows_stages_documents_idx;
DROP INDEX IF EXISTS public.strapi_workflows_stages_created_by_id_fk;
DROP INDEX IF EXISTS public.strapi_workflows_stage_required_to_publish_lnk_ifk;
DROP INDEX IF EXISTS public.strapi_workflows_stage_required_to_publish_lnk_fk;
DROP INDEX IF EXISTS public.strapi_workflows_documents_idx;
DROP INDEX IF EXISTS public.strapi_workflows_created_by_id_fk;
DROP INDEX IF EXISTS public.strapi_transfer_tokens_updated_by_id_fk;
DROP INDEX IF EXISTS public.strapi_transfer_tokens_documents_idx;
DROP INDEX IF EXISTS public.strapi_transfer_tokens_created_by_id_fk;
DROP INDEX IF EXISTS public.strapi_transfer_token_permissions_updated_by_id_fk;
DROP INDEX IF EXISTS public.strapi_transfer_token_permissions_token_lnk_oifk;
DROP INDEX IF EXISTS public.strapi_transfer_token_permissions_token_lnk_ifk;
DROP INDEX IF EXISTS public.strapi_transfer_token_permissions_token_lnk_fk;
DROP INDEX IF EXISTS public.strapi_transfer_token_permissions_documents_idx;
DROP INDEX IF EXISTS public.strapi_transfer_token_permissions_created_by_id_fk;
DROP INDEX IF EXISTS public.strapi_sessions_updated_by_id_fk;
DROP INDEX IF EXISTS public.strapi_sessions_documents_idx;
DROP INDEX IF EXISTS public.strapi_sessions_created_by_id_fk;
DROP INDEX IF EXISTS public.strapi_releases_updated_by_id_fk;
DROP INDEX IF EXISTS public.strapi_releases_documents_idx;
DROP INDEX IF EXISTS public.strapi_releases_created_by_id_fk;
DROP INDEX IF EXISTS public.strapi_release_actions_updated_by_id_fk;
DROP INDEX IF EXISTS public.strapi_release_actions_release_lnk_oifk;
DROP INDEX IF EXISTS public.strapi_release_actions_release_lnk_ifk;
DROP INDEX IF EXISTS public.strapi_release_actions_release_lnk_fk;
DROP INDEX IF EXISTS public.strapi_release_actions_documents_idx;
DROP INDEX IF EXISTS public.strapi_release_actions_created_by_id_fk;
DROP INDEX IF EXISTS public.strapi_history_versions_created_by_id_fk;
DROP INDEX IF EXISTS public.strapi_api_tokens_updated_by_id_fk;
DROP INDEX IF EXISTS public.strapi_api_tokens_documents_idx;
DROP INDEX IF EXISTS public.strapi_api_tokens_created_by_id_fk;
DROP INDEX IF EXISTS public.strapi_api_tokens_admin_user_owner_lnk_oifk;
DROP INDEX IF EXISTS public.strapi_api_tokens_admin_user_owner_lnk_ifk;
DROP INDEX IF EXISTS public.strapi_api_tokens_admin_user_owner_lnk_fk;
DROP INDEX IF EXISTS public.strapi_api_token_permissions_updated_by_id_fk;
DROP INDEX IF EXISTS public.strapi_api_token_permissions_token_lnk_oifk;
DROP INDEX IF EXISTS public.strapi_api_token_permissions_token_lnk_ifk;
DROP INDEX IF EXISTS public.strapi_api_token_permissions_token_lnk_fk;
DROP INDEX IF EXISTS public.strapi_api_token_permissions_documents_idx;
DROP INDEX IF EXISTS public.strapi_api_token_permissions_created_by_id_fk;
DROP INDEX IF EXISTS public.rewards_updated_by_id_fk;
DROP INDEX IF EXISTS public.rewards_recipient_lnk_ifk;
DROP INDEX IF EXISTS public.rewards_recipient_lnk_fk;
DROP INDEX IF EXISTS public.rewards_documents_idx;
DROP INDEX IF EXISTS public.rewards_created_by_id_fk;
DROP INDEX IF EXISTS public.replies_useful_by_lnk_oifk;
DROP INDEX IF EXISTS public.replies_useful_by_lnk_ofk;
DROP INDEX IF EXISTS public.replies_useful_by_lnk_ifk;
DROP INDEX IF EXISTS public.replies_useful_by_lnk_fk;
DROP INDEX IF EXISTS public.replies_updated_by_id_fk;
DROP INDEX IF EXISTS public.replies_documents_idx;
DROP INDEX IF EXISTS public.replies_discussion_lnk_oifk;
DROP INDEX IF EXISTS public.replies_discussion_lnk_ifk;
DROP INDEX IF EXISTS public.replies_discussion_lnk_fk;
DROP INDEX IF EXISTS public.replies_created_by_id_fk;
DROP INDEX IF EXISTS public.replies_author_lnk_oifk;
DROP INDEX IF EXISTS public.replies_author_lnk_ifk;
DROP INDEX IF EXISTS public.replies_author_lnk_fk;
DROP INDEX IF EXISTS public.notifications_updated_by_id_fk;
DROP INDEX IF EXISTS public.notifications_recipient_lnk_ifk;
DROP INDEX IF EXISTS public.notifications_recipient_lnk_fk;
DROP INDEX IF EXISTS public.notifications_documents_idx;
DROP INDEX IF EXISTS public.notifications_discussion_lnk_ifk;
DROP INDEX IF EXISTS public.notifications_discussion_lnk_fk;
DROP INDEX IF EXISTS public.notifications_created_by_id_fk;
DROP INDEX IF EXISTS public.notifications_blog_post_lnk_ifk;
DROP INDEX IF EXISTS public.notifications_blog_post_lnk_fk;
DROP INDEX IF EXISTS public.notifications_actor_lnk_ifk;
DROP INDEX IF EXISTS public.notifications_actor_lnk_fk;
DROP INDEX IF EXISTS public.i18n_locale_updated_by_id_fk;
DROP INDEX IF EXISTS public.i18n_locale_documents_idx;
DROP INDEX IF EXISTS public.i18n_locale_created_by_id_fk;
DROP INDEX IF EXISTS public.files_updated_by_id_fk;
DROP INDEX IF EXISTS public.files_related_mph_oidx;
DROP INDEX IF EXISTS public.files_related_mph_idix;
DROP INDEX IF EXISTS public.files_related_mph_fk;
DROP INDEX IF EXISTS public.files_folder_lnk_oifk;
DROP INDEX IF EXISTS public.files_folder_lnk_ifk;
DROP INDEX IF EXISTS public.files_folder_lnk_fk;
DROP INDEX IF EXISTS public.files_documents_idx;
DROP INDEX IF EXISTS public.files_created_by_id_fk;
DROP INDEX IF EXISTS public.events_updated_by_id_fk;
DROP INDEX IF EXISTS public.events_documents_idx;
DROP INDEX IF EXISTS public.events_created_by_id_fk;
DROP INDEX IF EXISTS public.events_category_lnk_ifk;
DROP INDEX IF EXISTS public.events_category_lnk_fk;
DROP INDEX IF EXISTS public.events_attendees_lnk_oifk;
DROP INDEX IF EXISTS public.events_attendees_lnk_ofk;
DROP INDEX IF EXISTS public.events_attendees_lnk_ifk;
DROP INDEX IF EXISTS public.events_attendees_lnk_fk;
DROP INDEX IF EXISTS public.discussions_useful_by_lnk_oifk;
DROP INDEX IF EXISTS public.discussions_useful_by_lnk_ofk;
DROP INDEX IF EXISTS public.discussions_useful_by_lnk_ifk;
DROP INDEX IF EXISTS public.discussions_useful_by_lnk_fk;
DROP INDEX IF EXISTS public.discussions_updated_by_id_fk;
DROP INDEX IF EXISTS public.discussions_followed_by_lnk_oifk;
DROP INDEX IF EXISTS public.discussions_followed_by_lnk_ofk;
DROP INDEX IF EXISTS public.discussions_followed_by_lnk_ifk;
DROP INDEX IF EXISTS public.discussions_followed_by_lnk_fk;
DROP INDEX IF EXISTS public.discussions_documents_idx;
DROP INDEX IF EXISTS public.discussions_created_by_id_fk;
DROP INDEX IF EXISTS public.discussions_category_lnk_oifk;
DROP INDEX IF EXISTS public.discussions_category_lnk_ifk;
DROP INDEX IF EXISTS public.discussions_category_lnk_fk;
DROP INDEX IF EXISTS public.discussions_author_lnk_oifk;
DROP INDEX IF EXISTS public.discussions_author_lnk_ifk;
DROP INDEX IF EXISTS public.discussions_author_lnk_fk;
DROP INDEX IF EXISTS public.categories_updated_by_id_fk;
DROP INDEX IF EXISTS public.categories_documents_idx;
DROP INDEX IF EXISTS public.categories_created_by_id_fk;
DROP INDEX IF EXISTS public.blog_posts_useful_by_lnk_oifk;
DROP INDEX IF EXISTS public.blog_posts_useful_by_lnk_ofk;
DROP INDEX IF EXISTS public.blog_posts_useful_by_lnk_ifk;
DROP INDEX IF EXISTS public.blog_posts_useful_by_lnk_fk;
DROP INDEX IF EXISTS public.blog_posts_updated_by_id_fk;
DROP INDEX IF EXISTS public.blog_posts_documents_idx;
DROP INDEX IF EXISTS public.blog_posts_created_by_id_fk;
DROP INDEX IF EXISTS public.blog_posts_category_lnk_ifk;
DROP INDEX IF EXISTS public.blog_posts_category_lnk_fk;
DROP INDEX IF EXISTS public.blog_posts_author_lnk_oifk;
DROP INDEX IF EXISTS public.blog_posts_author_lnk_ifk;
DROP INDEX IF EXISTS public.blog_posts_author_lnk_fk;
DROP INDEX IF EXISTS public.blog_comments_useful_by_lnk_oifk;
DROP INDEX IF EXISTS public.blog_comments_useful_by_lnk_ofk;
DROP INDEX IF EXISTS public.blog_comments_useful_by_lnk_ifk;
DROP INDEX IF EXISTS public.blog_comments_useful_by_lnk_fk;
DROP INDEX IF EXISTS public.blog_comments_updated_by_id_fk;
DROP INDEX IF EXISTS public.blog_comments_post_lnk_oifk;
DROP INDEX IF EXISTS public.blog_comments_post_lnk_ifk;
DROP INDEX IF EXISTS public.blog_comments_post_lnk_fk;
DROP INDEX IF EXISTS public.blog_comments_documents_idx;
DROP INDEX IF EXISTS public.blog_comments_created_by_id_fk;
DROP INDEX IF EXISTS public.blog_comments_author_lnk_oifk;
DROP INDEX IF EXISTS public.blog_comments_author_lnk_ifk;
DROP INDEX IF EXISTS public.blog_comments_author_lnk_fk;
DROP INDEX IF EXISTS public.admin_users_updated_by_id_fk;
DROP INDEX IF EXISTS public.admin_users_roles_lnk_oifk;
DROP INDEX IF EXISTS public.admin_users_roles_lnk_ofk;
DROP INDEX IF EXISTS public.admin_users_roles_lnk_ifk;
DROP INDEX IF EXISTS public.admin_users_roles_lnk_fk;
DROP INDEX IF EXISTS public.admin_users_documents_idx;
DROP INDEX IF EXISTS public.admin_users_created_by_id_fk;
DROP INDEX IF EXISTS public.admin_roles_updated_by_id_fk;
DROP INDEX IF EXISTS public.admin_roles_documents_idx;
DROP INDEX IF EXISTS public.admin_roles_created_by_id_fk;
DROP INDEX IF EXISTS public.admin_permissions_updated_by_id_fk;
DROP INDEX IF EXISTS public.admin_permissions_role_lnk_oifk;
DROP INDEX IF EXISTS public.admin_permissions_role_lnk_ifk;
DROP INDEX IF EXISTS public.admin_permissions_role_lnk_fk;
DROP INDEX IF EXISTS public.admin_permissions_documents_idx;
DROP INDEX IF EXISTS public.admin_permissions_created_by_id_fk;
DROP INDEX IF EXISTS public.admin_permissions_api_token_lnk_oifk;
DROP INDEX IF EXISTS public.admin_permissions_api_token_lnk_ifk;
DROP INDEX IF EXISTS public.admin_permissions_api_token_lnk_fk;
ALTER TABLE IF EXISTS ONLY public.upload_folders DROP CONSTRAINT IF EXISTS upload_folders_pkey;
ALTER TABLE IF EXISTS ONLY public.upload_folders DROP CONSTRAINT IF EXISTS upload_folders_path_index;
ALTER TABLE IF EXISTS ONLY public.upload_folders DROP CONSTRAINT IF EXISTS upload_folders_path_id_index;
ALTER TABLE IF EXISTS ONLY public.upload_folders_parent_lnk DROP CONSTRAINT IF EXISTS upload_folders_parent_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.upload_folders_parent_lnk DROP CONSTRAINT IF EXISTS upload_folders_parent_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.up_users_role_lnk DROP CONSTRAINT IF EXISTS up_users_role_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.up_users_role_lnk DROP CONSTRAINT IF EXISTS up_users_role_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.up_users DROP CONSTRAINT IF EXISTS up_users_pkey;
ALTER TABLE IF EXISTS ONLY public.up_roles DROP CONSTRAINT IF EXISTS up_roles_pkey;
ALTER TABLE IF EXISTS ONLY public.up_permissions_role_lnk DROP CONSTRAINT IF EXISTS up_permissions_role_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.up_permissions_role_lnk DROP CONSTRAINT IF EXISTS up_permissions_role_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.up_permissions DROP CONSTRAINT IF EXISTS up_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_workflows_stages_workflow_lnk DROP CONSTRAINT IF EXISTS strapi_workflows_stages_workflow_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.strapi_workflows_stages_workflow_lnk DROP CONSTRAINT IF EXISTS strapi_workflows_stages_workflow_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_workflows_stages DROP CONSTRAINT IF EXISTS strapi_workflows_stages_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_workflows_stages_permissions_lnk DROP CONSTRAINT IF EXISTS strapi_workflows_stages_permissions_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.strapi_workflows_stages_permissions_lnk DROP CONSTRAINT IF EXISTS strapi_workflows_stages_permissions_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_workflows_stage_required_to_publish_lnk DROP CONSTRAINT IF EXISTS strapi_workflows_stage_required_to_publish_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.strapi_workflows_stage_required_to_publish_lnk DROP CONSTRAINT IF EXISTS strapi_workflows_stage_required_to_publish_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_workflows DROP CONSTRAINT IF EXISTS strapi_workflows_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_webhooks DROP CONSTRAINT IF EXISTS strapi_webhooks_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_transfer_tokens DROP CONSTRAINT IF EXISTS strapi_transfer_tokens_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_transfer_token_permissions_token_lnk DROP CONSTRAINT IF EXISTS strapi_transfer_token_permissions_token_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.strapi_transfer_token_permissions_token_lnk DROP CONSTRAINT IF EXISTS strapi_transfer_token_permissions_token_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_transfer_token_permissions DROP CONSTRAINT IF EXISTS strapi_transfer_token_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_sessions DROP CONSTRAINT IF EXISTS strapi_sessions_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_releases DROP CONSTRAINT IF EXISTS strapi_releases_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_release_actions_release_lnk DROP CONSTRAINT IF EXISTS strapi_release_actions_release_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.strapi_release_actions_release_lnk DROP CONSTRAINT IF EXISTS strapi_release_actions_release_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_release_actions DROP CONSTRAINT IF EXISTS strapi_release_actions_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_migrations DROP CONSTRAINT IF EXISTS strapi_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_migrations_internal DROP CONSTRAINT IF EXISTS strapi_migrations_internal_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_history_versions DROP CONSTRAINT IF EXISTS strapi_history_versions_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_database_schema DROP CONSTRAINT IF EXISTS strapi_database_schema_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_core_store_settings DROP CONSTRAINT IF EXISTS strapi_core_store_settings_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_api_tokens DROP CONSTRAINT IF EXISTS strapi_api_tokens_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_api_tokens_admin_user_owner_lnk DROP CONSTRAINT IF EXISTS strapi_api_tokens_admin_user_owner_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.strapi_api_tokens_admin_user_owner_lnk DROP CONSTRAINT IF EXISTS strapi_api_tokens_admin_user_owner_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_api_token_permissions_token_lnk DROP CONSTRAINT IF EXISTS strapi_api_token_permissions_token_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.strapi_api_token_permissions_token_lnk DROP CONSTRAINT IF EXISTS strapi_api_token_permissions_token_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_api_token_permissions DROP CONSTRAINT IF EXISTS strapi_api_token_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_ai_metadata_jobs DROP CONSTRAINT IF EXISTS strapi_ai_metadata_jobs_pkey;
ALTER TABLE IF EXISTS ONLY public.strapi_ai_localization_jobs DROP CONSTRAINT IF EXISTS strapi_ai_localization_jobs_pkey;
ALTER TABLE IF EXISTS ONLY public.rewards_recipient_lnk DROP CONSTRAINT IF EXISTS rewards_recipient_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.rewards_recipient_lnk DROP CONSTRAINT IF EXISTS rewards_recipient_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.rewards DROP CONSTRAINT IF EXISTS rewards_pkey;
ALTER TABLE IF EXISTS ONLY public.replies_useful_by_lnk DROP CONSTRAINT IF EXISTS replies_useful_by_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.replies_useful_by_lnk DROP CONSTRAINT IF EXISTS replies_useful_by_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.replies DROP CONSTRAINT IF EXISTS replies_pkey;
ALTER TABLE IF EXISTS ONLY public.replies_discussion_lnk DROP CONSTRAINT IF EXISTS replies_discussion_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.replies_discussion_lnk DROP CONSTRAINT IF EXISTS replies_discussion_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.replies_author_lnk DROP CONSTRAINT IF EXISTS replies_author_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.replies_author_lnk DROP CONSTRAINT IF EXISTS replies_author_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.notifications_recipient_lnk DROP CONSTRAINT IF EXISTS notifications_recipient_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.notifications_recipient_lnk DROP CONSTRAINT IF EXISTS notifications_recipient_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS notifications_pkey;
ALTER TABLE IF EXISTS ONLY public.notifications_discussion_lnk DROP CONSTRAINT IF EXISTS notifications_discussion_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.notifications_discussion_lnk DROP CONSTRAINT IF EXISTS notifications_discussion_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.notifications_blog_post_lnk DROP CONSTRAINT IF EXISTS notifications_blog_post_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.notifications_blog_post_lnk DROP CONSTRAINT IF EXISTS notifications_blog_post_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.notifications_actor_lnk DROP CONSTRAINT IF EXISTS notifications_actor_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.notifications_actor_lnk DROP CONSTRAINT IF EXISTS notifications_actor_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.i18n_locale DROP CONSTRAINT IF EXISTS i18n_locale_pkey;
ALTER TABLE IF EXISTS ONLY public.files_related_mph DROP CONSTRAINT IF EXISTS files_related_mph_pkey;
ALTER TABLE IF EXISTS ONLY public.files DROP CONSTRAINT IF EXISTS files_pkey;
ALTER TABLE IF EXISTS ONLY public.files_folder_lnk DROP CONSTRAINT IF EXISTS files_folder_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.files_folder_lnk DROP CONSTRAINT IF EXISTS files_folder_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.events DROP CONSTRAINT IF EXISTS events_pkey;
ALTER TABLE IF EXISTS ONLY public.events_category_lnk DROP CONSTRAINT IF EXISTS events_category_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.events_category_lnk DROP CONSTRAINT IF EXISTS events_category_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.events_attendees_lnk DROP CONSTRAINT IF EXISTS events_attendees_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.events_attendees_lnk DROP CONSTRAINT IF EXISTS events_attendees_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.discussions_useful_by_lnk DROP CONSTRAINT IF EXISTS discussions_useful_by_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.discussions_useful_by_lnk DROP CONSTRAINT IF EXISTS discussions_useful_by_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.discussions DROP CONSTRAINT IF EXISTS discussions_pkey;
ALTER TABLE IF EXISTS ONLY public.discussions_followed_by_lnk DROP CONSTRAINT IF EXISTS discussions_followed_by_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.discussions_followed_by_lnk DROP CONSTRAINT IF EXISTS discussions_followed_by_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.discussions_category_lnk DROP CONSTRAINT IF EXISTS discussions_category_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.discussions_category_lnk DROP CONSTRAINT IF EXISTS discussions_category_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.discussions_author_lnk DROP CONSTRAINT IF EXISTS discussions_author_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.discussions_author_lnk DROP CONSTRAINT IF EXISTS discussions_author_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.categories DROP CONSTRAINT IF EXISTS categories_pkey;
ALTER TABLE IF EXISTS ONLY public.blog_posts_useful_by_lnk DROP CONSTRAINT IF EXISTS blog_posts_useful_by_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.blog_posts_useful_by_lnk DROP CONSTRAINT IF EXISTS blog_posts_useful_by_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.blog_posts DROP CONSTRAINT IF EXISTS blog_posts_pkey;
ALTER TABLE IF EXISTS ONLY public.blog_posts_category_lnk DROP CONSTRAINT IF EXISTS blog_posts_category_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.blog_posts_category_lnk DROP CONSTRAINT IF EXISTS blog_posts_category_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.blog_posts_author_lnk DROP CONSTRAINT IF EXISTS blog_posts_author_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.blog_posts_author_lnk DROP CONSTRAINT IF EXISTS blog_posts_author_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.blog_comments_useful_by_lnk DROP CONSTRAINT IF EXISTS blog_comments_useful_by_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.blog_comments_useful_by_lnk DROP CONSTRAINT IF EXISTS blog_comments_useful_by_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.blog_comments_post_lnk DROP CONSTRAINT IF EXISTS blog_comments_post_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.blog_comments_post_lnk DROP CONSTRAINT IF EXISTS blog_comments_post_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.blog_comments DROP CONSTRAINT IF EXISTS blog_comments_pkey;
ALTER TABLE IF EXISTS ONLY public.blog_comments_author_lnk DROP CONSTRAINT IF EXISTS blog_comments_author_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.blog_comments_author_lnk DROP CONSTRAINT IF EXISTS blog_comments_author_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.admin_users_roles_lnk DROP CONSTRAINT IF EXISTS admin_users_roles_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.admin_users_roles_lnk DROP CONSTRAINT IF EXISTS admin_users_roles_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.admin_users DROP CONSTRAINT IF EXISTS admin_users_pkey;
ALTER TABLE IF EXISTS ONLY public.admin_roles DROP CONSTRAINT IF EXISTS admin_roles_pkey;
ALTER TABLE IF EXISTS ONLY public.admin_permissions_role_lnk DROP CONSTRAINT IF EXISTS admin_permissions_role_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.admin_permissions_role_lnk DROP CONSTRAINT IF EXISTS admin_permissions_role_lnk_pkey;
ALTER TABLE IF EXISTS ONLY public.admin_permissions DROP CONSTRAINT IF EXISTS admin_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.admin_permissions_api_token_lnk DROP CONSTRAINT IF EXISTS admin_permissions_api_token_lnk_uq;
ALTER TABLE IF EXISTS ONLY public.admin_permissions_api_token_lnk DROP CONSTRAINT IF EXISTS admin_permissions_api_token_lnk_pkey;
ALTER TABLE IF EXISTS public.upload_folders_parent_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.upload_folders ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.up_users_role_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.up_users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.up_roles ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.up_permissions_role_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.up_permissions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_workflows_stages_workflow_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_workflows_stages_permissions_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_workflows_stages ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_workflows_stage_required_to_publish_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_workflows ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_webhooks ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_transfer_tokens ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_transfer_token_permissions_token_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_transfer_token_permissions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_sessions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_releases ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_release_actions_release_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_release_actions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_migrations_internal ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_migrations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_history_versions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_database_schema ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_core_store_settings ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_api_tokens_admin_user_owner_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_api_tokens ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_api_token_permissions_token_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_api_token_permissions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_ai_metadata_jobs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.strapi_ai_localization_jobs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.rewards_recipient_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.rewards ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.replies_useful_by_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.replies_discussion_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.replies_author_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.replies ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.notifications_recipient_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.notifications_discussion_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.notifications_blog_post_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.notifications_actor_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.notifications ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.i18n_locale ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.files_related_mph ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.files_folder_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.files ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.events_category_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.events_attendees_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.events ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.discussions_useful_by_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.discussions_followed_by_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.discussions_category_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.discussions_author_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.discussions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.categories ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.blog_posts_useful_by_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.blog_posts_category_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.blog_posts_author_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.blog_posts ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.blog_comments_useful_by_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.blog_comments_post_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.blog_comments_author_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.blog_comments ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.admin_users_roles_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.admin_users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.admin_roles ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.admin_permissions_role_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.admin_permissions_api_token_lnk ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.admin_permissions ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.upload_folders_parent_lnk_id_seq;
DROP TABLE IF EXISTS public.upload_folders_parent_lnk;
DROP SEQUENCE IF EXISTS public.upload_folders_id_seq;
DROP TABLE IF EXISTS public.upload_folders;
DROP SEQUENCE IF EXISTS public.up_users_role_lnk_id_seq;
DROP TABLE IF EXISTS public.up_users_role_lnk;
DROP SEQUENCE IF EXISTS public.up_users_id_seq;
DROP TABLE IF EXISTS public.up_users;
DROP SEQUENCE IF EXISTS public.up_roles_id_seq;
DROP TABLE IF EXISTS public.up_roles;
DROP SEQUENCE IF EXISTS public.up_permissions_role_lnk_id_seq;
DROP TABLE IF EXISTS public.up_permissions_role_lnk;
DROP SEQUENCE IF EXISTS public.up_permissions_id_seq;
DROP TABLE IF EXISTS public.up_permissions;
DROP SEQUENCE IF EXISTS public.strapi_workflows_stages_workflow_lnk_id_seq;
DROP TABLE IF EXISTS public.strapi_workflows_stages_workflow_lnk;
DROP SEQUENCE IF EXISTS public.strapi_workflows_stages_permissions_lnk_id_seq;
DROP TABLE IF EXISTS public.strapi_workflows_stages_permissions_lnk;
DROP SEQUENCE IF EXISTS public.strapi_workflows_stages_id_seq;
DROP TABLE IF EXISTS public.strapi_workflows_stages;
DROP SEQUENCE IF EXISTS public.strapi_workflows_stage_required_to_publish_lnk_id_seq;
DROP TABLE IF EXISTS public.strapi_workflows_stage_required_to_publish_lnk;
DROP SEQUENCE IF EXISTS public.strapi_workflows_id_seq;
DROP TABLE IF EXISTS public.strapi_workflows;
DROP SEQUENCE IF EXISTS public.strapi_webhooks_id_seq;
DROP TABLE IF EXISTS public.strapi_webhooks;
DROP SEQUENCE IF EXISTS public.strapi_transfer_tokens_id_seq;
DROP TABLE IF EXISTS public.strapi_transfer_tokens;
DROP SEQUENCE IF EXISTS public.strapi_transfer_token_permissions_token_lnk_id_seq;
DROP TABLE IF EXISTS public.strapi_transfer_token_permissions_token_lnk;
DROP SEQUENCE IF EXISTS public.strapi_transfer_token_permissions_id_seq;
DROP TABLE IF EXISTS public.strapi_transfer_token_permissions;
DROP SEQUENCE IF EXISTS public.strapi_sessions_id_seq;
DROP TABLE IF EXISTS public.strapi_sessions;
DROP SEQUENCE IF EXISTS public.strapi_releases_id_seq;
DROP TABLE IF EXISTS public.strapi_releases;
DROP SEQUENCE IF EXISTS public.strapi_release_actions_release_lnk_id_seq;
DROP TABLE IF EXISTS public.strapi_release_actions_release_lnk;
DROP SEQUENCE IF EXISTS public.strapi_release_actions_id_seq;
DROP TABLE IF EXISTS public.strapi_release_actions;
DROP SEQUENCE IF EXISTS public.strapi_migrations_internal_id_seq;
DROP TABLE IF EXISTS public.strapi_migrations_internal;
DROP SEQUENCE IF EXISTS public.strapi_migrations_id_seq;
DROP TABLE IF EXISTS public.strapi_migrations;
DROP SEQUENCE IF EXISTS public.strapi_history_versions_id_seq;
DROP TABLE IF EXISTS public.strapi_history_versions;
DROP SEQUENCE IF EXISTS public.strapi_database_schema_id_seq;
DROP TABLE IF EXISTS public.strapi_database_schema;
DROP SEQUENCE IF EXISTS public.strapi_core_store_settings_id_seq;
DROP TABLE IF EXISTS public.strapi_core_store_settings;
DROP SEQUENCE IF EXISTS public.strapi_api_tokens_id_seq;
DROP SEQUENCE IF EXISTS public.strapi_api_tokens_admin_user_owner_lnk_id_seq;
DROP TABLE IF EXISTS public.strapi_api_tokens_admin_user_owner_lnk;
DROP TABLE IF EXISTS public.strapi_api_tokens;
DROP SEQUENCE IF EXISTS public.strapi_api_token_permissions_token_lnk_id_seq;
DROP TABLE IF EXISTS public.strapi_api_token_permissions_token_lnk;
DROP SEQUENCE IF EXISTS public.strapi_api_token_permissions_id_seq;
DROP TABLE IF EXISTS public.strapi_api_token_permissions;
DROP SEQUENCE IF EXISTS public.strapi_ai_metadata_jobs_id_seq;
DROP TABLE IF EXISTS public.strapi_ai_metadata_jobs;
DROP SEQUENCE IF EXISTS public.strapi_ai_localization_jobs_id_seq;
DROP TABLE IF EXISTS public.strapi_ai_localization_jobs;
DROP SEQUENCE IF EXISTS public.rewards_recipient_lnk_id_seq;
DROP TABLE IF EXISTS public.rewards_recipient_lnk;
DROP SEQUENCE IF EXISTS public.rewards_id_seq;
DROP TABLE IF EXISTS public.rewards;
DROP SEQUENCE IF EXISTS public.replies_useful_by_lnk_id_seq;
DROP TABLE IF EXISTS public.replies_useful_by_lnk;
DROP SEQUENCE IF EXISTS public.replies_id_seq;
DROP SEQUENCE IF EXISTS public.replies_discussion_lnk_id_seq;
DROP TABLE IF EXISTS public.replies_discussion_lnk;
DROP SEQUENCE IF EXISTS public.replies_author_lnk_id_seq;
DROP TABLE IF EXISTS public.replies_author_lnk;
DROP TABLE IF EXISTS public.replies;
DROP SEQUENCE IF EXISTS public.notifications_recipient_lnk_id_seq;
DROP TABLE IF EXISTS public.notifications_recipient_lnk;
DROP SEQUENCE IF EXISTS public.notifications_id_seq;
DROP SEQUENCE IF EXISTS public.notifications_discussion_lnk_id_seq;
DROP TABLE IF EXISTS public.notifications_discussion_lnk;
DROP SEQUENCE IF EXISTS public.notifications_blog_post_lnk_id_seq;
DROP TABLE IF EXISTS public.notifications_blog_post_lnk;
DROP SEQUENCE IF EXISTS public.notifications_actor_lnk_id_seq;
DROP TABLE IF EXISTS public.notifications_actor_lnk;
DROP TABLE IF EXISTS public.notifications;
DROP SEQUENCE IF EXISTS public.i18n_locale_id_seq;
DROP TABLE IF EXISTS public.i18n_locale;
DROP SEQUENCE IF EXISTS public.files_related_mph_id_seq;
DROP TABLE IF EXISTS public.files_related_mph;
DROP SEQUENCE IF EXISTS public.files_id_seq;
DROP SEQUENCE IF EXISTS public.files_folder_lnk_id_seq;
DROP TABLE IF EXISTS public.files_folder_lnk;
DROP TABLE IF EXISTS public.files;
DROP SEQUENCE IF EXISTS public.events_id_seq;
DROP SEQUENCE IF EXISTS public.events_category_lnk_id_seq;
DROP TABLE IF EXISTS public.events_category_lnk;
DROP SEQUENCE IF EXISTS public.events_attendees_lnk_id_seq;
DROP TABLE IF EXISTS public.events_attendees_lnk;
DROP TABLE IF EXISTS public.events;
DROP SEQUENCE IF EXISTS public.discussions_useful_by_lnk_id_seq;
DROP TABLE IF EXISTS public.discussions_useful_by_lnk;
DROP SEQUENCE IF EXISTS public.discussions_id_seq;
DROP SEQUENCE IF EXISTS public.discussions_followed_by_lnk_id_seq;
DROP TABLE IF EXISTS public.discussions_followed_by_lnk;
DROP SEQUENCE IF EXISTS public.discussions_category_lnk_id_seq;
DROP TABLE IF EXISTS public.discussions_category_lnk;
DROP SEQUENCE IF EXISTS public.discussions_author_lnk_id_seq;
DROP TABLE IF EXISTS public.discussions_author_lnk;
DROP TABLE IF EXISTS public.discussions;
DROP SEQUENCE IF EXISTS public.categories_id_seq;
DROP TABLE IF EXISTS public.categories;
DROP SEQUENCE IF EXISTS public.blog_posts_useful_by_lnk_id_seq;
DROP TABLE IF EXISTS public.blog_posts_useful_by_lnk;
DROP SEQUENCE IF EXISTS public.blog_posts_id_seq;
DROP SEQUENCE IF EXISTS public.blog_posts_category_lnk_id_seq;
DROP TABLE IF EXISTS public.blog_posts_category_lnk;
DROP SEQUENCE IF EXISTS public.blog_posts_author_lnk_id_seq;
DROP TABLE IF EXISTS public.blog_posts_author_lnk;
DROP TABLE IF EXISTS public.blog_posts;
DROP SEQUENCE IF EXISTS public.blog_comments_useful_by_lnk_id_seq;
DROP TABLE IF EXISTS public.blog_comments_useful_by_lnk;
DROP SEQUENCE IF EXISTS public.blog_comments_post_lnk_id_seq;
DROP TABLE IF EXISTS public.blog_comments_post_lnk;
DROP SEQUENCE IF EXISTS public.blog_comments_id_seq;
DROP SEQUENCE IF EXISTS public.blog_comments_author_lnk_id_seq;
DROP TABLE IF EXISTS public.blog_comments_author_lnk;
DROP TABLE IF EXISTS public.blog_comments;
DROP SEQUENCE IF EXISTS public.admin_users_roles_lnk_id_seq;
DROP TABLE IF EXISTS public.admin_users_roles_lnk;
DROP SEQUENCE IF EXISTS public.admin_users_id_seq;
DROP TABLE IF EXISTS public.admin_users;
DROP SEQUENCE IF EXISTS public.admin_roles_id_seq;
DROP TABLE IF EXISTS public.admin_roles;
DROP SEQUENCE IF EXISTS public.admin_permissions_role_lnk_id_seq;
DROP TABLE IF EXISTS public.admin_permissions_role_lnk;
DROP SEQUENCE IF EXISTS public.admin_permissions_id_seq;
DROP SEQUENCE IF EXISTS public.admin_permissions_api_token_lnk_id_seq;
DROP TABLE IF EXISTS public.admin_permissions_api_token_lnk;
DROP TABLE IF EXISTS public.admin_permissions;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_permissions (
    id integer NOT NULL,
    document_id character varying(255),
    action character varying(255),
    action_parameters jsonb,
    subject character varying(255),
    properties jsonb,
    conditions jsonb,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: admin_permissions_api_token_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_permissions_api_token_lnk (
    id integer NOT NULL,
    permission_id integer,
    api_token_id integer,
    permission_ord double precision
);


--
-- Name: admin_permissions_api_token_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_permissions_api_token_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_permissions_api_token_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_permissions_api_token_lnk_id_seq OWNED BY public.admin_permissions_api_token_lnk.id;


--
-- Name: admin_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_permissions_id_seq OWNED BY public.admin_permissions.id;


--
-- Name: admin_permissions_role_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_permissions_role_lnk (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_ord double precision
);


--
-- Name: admin_permissions_role_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_permissions_role_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_permissions_role_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_permissions_role_lnk_id_seq OWNED BY public.admin_permissions_role_lnk.id;


--
-- Name: admin_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_roles (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    code character varying(255),
    description character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: admin_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_roles_id_seq OWNED BY public.admin_roles.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_users (
    id integer NOT NULL,
    document_id character varying(255),
    firstname character varying(255),
    lastname character varying(255),
    username character varying(255),
    email character varying(255),
    password character varying(255),
    reset_password_token character varying(255),
    reset_password_token_expires_at timestamp(6) without time zone,
    registration_token character varying(255),
    is_active boolean,
    blocked boolean,
    prefered_language character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;


--
-- Name: admin_users_roles_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_users_roles_lnk (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    role_ord double precision,
    user_ord double precision
);


--
-- Name: admin_users_roles_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_users_roles_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_users_roles_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_users_roles_lnk_id_seq OWNED BY public.admin_users_roles_lnk.id;


--
-- Name: blog_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blog_comments (
    id integer NOT NULL,
    document_id character varying(255),
    content text,
    useful_base integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: blog_comments_author_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blog_comments_author_lnk (
    id integer NOT NULL,
    blog_comment_id integer,
    user_id integer,
    blog_comment_ord double precision
);


--
-- Name: blog_comments_author_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blog_comments_author_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blog_comments_author_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blog_comments_author_lnk_id_seq OWNED BY public.blog_comments_author_lnk.id;


--
-- Name: blog_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blog_comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blog_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blog_comments_id_seq OWNED BY public.blog_comments.id;


--
-- Name: blog_comments_post_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blog_comments_post_lnk (
    id integer NOT NULL,
    blog_comment_id integer,
    blog_post_id integer,
    blog_comment_ord double precision
);


--
-- Name: blog_comments_post_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blog_comments_post_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blog_comments_post_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blog_comments_post_lnk_id_seq OWNED BY public.blog_comments_post_lnk.id;


--
-- Name: blog_comments_useful_by_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blog_comments_useful_by_lnk (
    id integer NOT NULL,
    blog_comment_id integer,
    user_id integer,
    user_ord double precision,
    blog_comment_ord double precision
);


--
-- Name: blog_comments_useful_by_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blog_comments_useful_by_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blog_comments_useful_by_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blog_comments_useful_by_lnk_id_seq OWNED BY public.blog_comments_useful_by_lnk.id;


--
-- Name: blog_posts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blog_posts (
    id integer NOT NULL,
    document_id character varying(255),
    title character varying(255),
    content text,
    views integer,
    useful_base integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: blog_posts_author_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blog_posts_author_lnk (
    id integer NOT NULL,
    blog_post_id integer,
    user_id integer,
    blog_post_ord double precision
);


--
-- Name: blog_posts_author_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blog_posts_author_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blog_posts_author_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blog_posts_author_lnk_id_seq OWNED BY public.blog_posts_author_lnk.id;


--
-- Name: blog_posts_category_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blog_posts_category_lnk (
    id integer NOT NULL,
    blog_post_id integer,
    category_id integer
);


--
-- Name: blog_posts_category_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blog_posts_category_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blog_posts_category_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blog_posts_category_lnk_id_seq OWNED BY public.blog_posts_category_lnk.id;


--
-- Name: blog_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blog_posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blog_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blog_posts_id_seq OWNED BY public.blog_posts.id;


--
-- Name: blog_posts_useful_by_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blog_posts_useful_by_lnk (
    id integer NOT NULL,
    blog_post_id integer,
    user_id integer,
    user_ord double precision,
    blog_post_ord double precision
);


--
-- Name: blog_posts_useful_by_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blog_posts_useful_by_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blog_posts_useful_by_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blog_posts_useful_by_lnk_id_seq OWNED BY public.blog_posts_useful_by_lnk.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    slug character varying(255),
    description text,
    icon character varying(255),
    color character varying(255),
    site_section character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: discussions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.discussions (
    id integer NOT NULL,
    document_id character varying(255),
    title character varying(255),
    slug character varying(255),
    content text,
    type character varying(255),
    article character varying(255),
    pinned boolean,
    featured character varying(255),
    views integer,
    poll_options jsonb,
    poll_votes jsonb,
    useful_base integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: discussions_author_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.discussions_author_lnk (
    id integer NOT NULL,
    discussion_id integer,
    user_id integer,
    discussion_ord double precision
);


--
-- Name: discussions_author_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.discussions_author_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: discussions_author_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.discussions_author_lnk_id_seq OWNED BY public.discussions_author_lnk.id;


--
-- Name: discussions_category_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.discussions_category_lnk (
    id integer NOT NULL,
    discussion_id integer,
    category_id integer,
    discussion_ord double precision
);


--
-- Name: discussions_category_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.discussions_category_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: discussions_category_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.discussions_category_lnk_id_seq OWNED BY public.discussions_category_lnk.id;


--
-- Name: discussions_followed_by_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.discussions_followed_by_lnk (
    id integer NOT NULL,
    discussion_id integer,
    user_id integer,
    user_ord double precision,
    discussion_ord double precision
);


--
-- Name: discussions_followed_by_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.discussions_followed_by_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: discussions_followed_by_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.discussions_followed_by_lnk_id_seq OWNED BY public.discussions_followed_by_lnk.id;


--
-- Name: discussions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.discussions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: discussions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.discussions_id_seq OWNED BY public.discussions.id;


--
-- Name: discussions_useful_by_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.discussions_useful_by_lnk (
    id integer NOT NULL,
    discussion_id integer,
    user_id integer,
    user_ord double precision,
    discussion_ord double precision
);


--
-- Name: discussions_useful_by_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.discussions_useful_by_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: discussions_useful_by_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.discussions_useful_by_lnk_id_seq OWNED BY public.discussions_useful_by_lnk.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events (
    id integer NOT NULL,
    document_id character varying(255),
    title character varying(255),
    host character varying(255),
    starts_at timestamp(6) without time zone,
    going_base integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: events_attendees_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events_attendees_lnk (
    id integer NOT NULL,
    event_id integer,
    user_id integer,
    user_ord double precision,
    event_ord double precision
);


--
-- Name: events_attendees_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.events_attendees_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_attendees_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.events_attendees_lnk_id_seq OWNED BY public.events_attendees_lnk.id;


--
-- Name: events_category_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events_category_lnk (
    id integer NOT NULL,
    event_id integer,
    category_id integer
);


--
-- Name: events_category_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.events_category_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_category_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.events_category_lnk_id_seq OWNED BY public.events_category_lnk.id;


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- Name: files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.files (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    alternative_text text,
    caption text,
    focal_point jsonb,
    width integer,
    height integer,
    formats jsonb,
    hash character varying(255),
    ext character varying(255),
    mime character varying(255),
    size numeric(10,2),
    url text,
    preview_url text,
    provider character varying(255),
    provider_metadata jsonb,
    folder_path character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: files_folder_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.files_folder_lnk (
    id integer NOT NULL,
    file_id integer,
    folder_id integer,
    file_ord double precision
);


--
-- Name: files_folder_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.files_folder_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: files_folder_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.files_folder_lnk_id_seq OWNED BY public.files_folder_lnk.id;


--
-- Name: files_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;


--
-- Name: files_related_mph; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.files_related_mph (
    id integer NOT NULL,
    file_id integer,
    related_id integer,
    related_type character varying(255),
    field character varying(255),
    "order" double precision
);


--
-- Name: files_related_mph_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.files_related_mph_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: files_related_mph_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.files_related_mph_id_seq OWNED BY public.files_related_mph.id;


--
-- Name: i18n_locale; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.i18n_locale (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    code character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: i18n_locale_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.i18n_locale_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: i18n_locale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.i18n_locale_id_seq OWNED BY public.i18n_locale.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    document_id character varying(255),
    kind character varying(255),
    badge character varying(255),
    text character varying(255),
    read boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: notifications_actor_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications_actor_lnk (
    id integer NOT NULL,
    notification_id integer,
    user_id integer
);


--
-- Name: notifications_actor_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_actor_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_actor_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_actor_lnk_id_seq OWNED BY public.notifications_actor_lnk.id;


--
-- Name: notifications_blog_post_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications_blog_post_lnk (
    id integer NOT NULL,
    notification_id integer,
    blog_post_id integer
);


--
-- Name: notifications_blog_post_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_blog_post_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_blog_post_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_blog_post_lnk_id_seq OWNED BY public.notifications_blog_post_lnk.id;


--
-- Name: notifications_discussion_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications_discussion_lnk (
    id integer NOT NULL,
    notification_id integer,
    discussion_id integer
);


--
-- Name: notifications_discussion_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_discussion_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_discussion_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_discussion_lnk_id_seq OWNED BY public.notifications_discussion_lnk.id;


--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: notifications_recipient_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications_recipient_lnk (
    id integer NOT NULL,
    notification_id integer,
    user_id integer
);


--
-- Name: notifications_recipient_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_recipient_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_recipient_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_recipient_lnk_id_seq OWNED BY public.notifications_recipient_lnk.id;


--
-- Name: replies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.replies (
    id integer NOT NULL,
    document_id character varying(255),
    content text,
    is_best_answer boolean,
    verified boolean,
    useful_base integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: replies_author_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.replies_author_lnk (
    id integer NOT NULL,
    reply_id integer,
    user_id integer,
    reply_ord double precision
);


--
-- Name: replies_author_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.replies_author_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: replies_author_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.replies_author_lnk_id_seq OWNED BY public.replies_author_lnk.id;


--
-- Name: replies_discussion_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.replies_discussion_lnk (
    id integer NOT NULL,
    reply_id integer,
    discussion_id integer,
    reply_ord double precision
);


--
-- Name: replies_discussion_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.replies_discussion_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: replies_discussion_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.replies_discussion_lnk_id_seq OWNED BY public.replies_discussion_lnk.id;


--
-- Name: replies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.replies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: replies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.replies_id_seq OWNED BY public.replies.id;


--
-- Name: replies_useful_by_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.replies_useful_by_lnk (
    id integer NOT NULL,
    reply_id integer,
    user_id integer,
    user_ord double precision,
    reply_ord double precision
);


--
-- Name: replies_useful_by_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.replies_useful_by_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: replies_useful_by_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.replies_useful_by_lnk_id_seq OWNED BY public.replies_useful_by_lnk.id;


--
-- Name: rewards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rewards (
    id integer NOT NULL,
    document_id character varying(255),
    key character varying(255),
    points integer,
    reason character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: rewards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rewards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rewards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rewards_id_seq OWNED BY public.rewards.id;


--
-- Name: rewards_recipient_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rewards_recipient_lnk (
    id integer NOT NULL,
    reward_id integer,
    user_id integer
);


--
-- Name: rewards_recipient_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rewards_recipient_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rewards_recipient_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rewards_recipient_lnk_id_seq OWNED BY public.rewards_recipient_lnk.id;


--
-- Name: strapi_ai_localization_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_ai_localization_jobs (
    id integer NOT NULL,
    content_type character varying(255) NOT NULL,
    related_document_id character varying(255) NOT NULL,
    source_locale character varying(255) NOT NULL,
    target_locales jsonb NOT NULL,
    status character varying(255) NOT NULL,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone
);


--
-- Name: strapi_ai_localization_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_ai_localization_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_ai_localization_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_ai_localization_jobs_id_seq OWNED BY public.strapi_ai_localization_jobs.id;


--
-- Name: strapi_ai_metadata_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_ai_metadata_jobs (
    id integer NOT NULL,
    status character varying(255) NOT NULL,
    created_at timestamp(6) without time zone,
    completed_at timestamp(6) without time zone
);


--
-- Name: strapi_ai_metadata_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_ai_metadata_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_ai_metadata_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_ai_metadata_jobs_id_seq OWNED BY public.strapi_ai_metadata_jobs.id;


--
-- Name: strapi_api_token_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_api_token_permissions (
    id integer NOT NULL,
    document_id character varying(255),
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_api_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_api_token_permissions_id_seq OWNED BY public.strapi_api_token_permissions.id;


--
-- Name: strapi_api_token_permissions_token_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_api_token_permissions_token_lnk (
    id integer NOT NULL,
    api_token_permission_id integer,
    api_token_id integer,
    api_token_permission_ord double precision
);


--
-- Name: strapi_api_token_permissions_token_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_api_token_permissions_token_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_api_token_permissions_token_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_api_token_permissions_token_lnk_id_seq OWNED BY public.strapi_api_token_permissions_token_lnk.id;


--
-- Name: strapi_api_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_api_tokens (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    description character varying(255),
    kind character varying(255),
    type character varying(255),
    access_key character varying(255),
    encrypted_key text,
    last_used_at timestamp(6) without time zone,
    expires_at timestamp(6) without time zone,
    lifespan bigint,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: strapi_api_tokens_admin_user_owner_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_api_tokens_admin_user_owner_lnk (
    id integer NOT NULL,
    api_token_id integer,
    user_id integer,
    api_token_ord double precision
);


--
-- Name: strapi_api_tokens_admin_user_owner_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_api_tokens_admin_user_owner_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_api_tokens_admin_user_owner_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_api_tokens_admin_user_owner_lnk_id_seq OWNED BY public.strapi_api_tokens_admin_user_owner_lnk.id;


--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_api_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_api_tokens_id_seq OWNED BY public.strapi_api_tokens.id;


--
-- Name: strapi_core_store_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_core_store_settings (
    id integer NOT NULL,
    key character varying(255),
    value text,
    type character varying(255),
    environment character varying(255),
    tag character varying(255)
);


--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_core_store_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_core_store_settings_id_seq OWNED BY public.strapi_core_store_settings.id;


--
-- Name: strapi_database_schema; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_database_schema (
    id integer NOT NULL,
    schema json,
    "time" timestamp without time zone,
    hash character varying(255)
);


--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_database_schema_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_database_schema_id_seq OWNED BY public.strapi_database_schema.id;


--
-- Name: strapi_history_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_history_versions (
    id integer NOT NULL,
    content_type character varying(255) NOT NULL,
    related_document_id character varying(255),
    locale character varying(255),
    status character varying(255),
    data jsonb,
    schema jsonb,
    created_at timestamp(6) without time zone,
    created_by_id integer
);


--
-- Name: strapi_history_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_history_versions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_history_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_history_versions_id_seq OWNED BY public.strapi_history_versions.id;


--
-- Name: strapi_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_migrations (
    id integer NOT NULL,
    name character varying(255),
    "time" timestamp without time zone
);


--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_migrations_id_seq OWNED BY public.strapi_migrations.id;


--
-- Name: strapi_migrations_internal; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_migrations_internal (
    id integer NOT NULL,
    name character varying(255),
    "time" timestamp without time zone
);


--
-- Name: strapi_migrations_internal_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_migrations_internal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_migrations_internal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_migrations_internal_id_seq OWNED BY public.strapi_migrations_internal.id;


--
-- Name: strapi_release_actions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_release_actions (
    id integer NOT NULL,
    document_id character varying(255),
    type character varying(255),
    content_type character varying(255),
    entry_document_id character varying(255),
    locale character varying(255),
    is_entry_valid boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


--
-- Name: strapi_release_actions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_release_actions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_release_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_release_actions_id_seq OWNED BY public.strapi_release_actions.id;


--
-- Name: strapi_release_actions_release_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_release_actions_release_lnk (
    id integer NOT NULL,
    release_action_id integer,
    release_id integer,
    release_action_ord double precision
);


--
-- Name: strapi_release_actions_release_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_release_actions_release_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_release_actions_release_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_release_actions_release_lnk_id_seq OWNED BY public.strapi_release_actions_release_lnk.id;


--
-- Name: strapi_releases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_releases (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    released_at timestamp(6) without time zone,
    scheduled_at timestamp(6) without time zone,
    timezone character varying(255),
    status character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: strapi_releases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_releases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_releases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_releases_id_seq OWNED BY public.strapi_releases.id;


--
-- Name: strapi_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_sessions (
    id integer NOT NULL,
    document_id character varying(255),
    user_id character varying(255),
    session_id character varying(255),
    child_id character varying(255),
    device_id character varying(255),
    origin character varying(255),
    expires_at timestamp(6) without time zone,
    absolute_expires_at timestamp(6) without time zone,
    status character varying(255),
    type character varying(255),
    metadata jsonb,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: strapi_sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_sessions_id_seq OWNED BY public.strapi_sessions.id;


--
-- Name: strapi_transfer_token_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_transfer_token_permissions (
    id integer NOT NULL,
    document_id character varying(255),
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_transfer_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_transfer_token_permissions_id_seq OWNED BY public.strapi_transfer_token_permissions.id;


--
-- Name: strapi_transfer_token_permissions_token_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_transfer_token_permissions_token_lnk (
    id integer NOT NULL,
    transfer_token_permission_id integer,
    transfer_token_id integer,
    transfer_token_permission_ord double precision
);


--
-- Name: strapi_transfer_token_permissions_token_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_transfer_token_permissions_token_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_transfer_token_permissions_token_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_transfer_token_permissions_token_lnk_id_seq OWNED BY public.strapi_transfer_token_permissions_token_lnk.id;


--
-- Name: strapi_transfer_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_transfer_tokens (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    description character varying(255),
    access_key character varying(255),
    last_used_at timestamp(6) without time zone,
    expires_at timestamp(6) without time zone,
    lifespan bigint,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_transfer_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_transfer_tokens_id_seq OWNED BY public.strapi_transfer_tokens.id;


--
-- Name: strapi_webhooks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_webhooks (
    id integer NOT NULL,
    name character varying(255),
    url text,
    headers jsonb,
    events jsonb,
    enabled boolean
);


--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_webhooks_id_seq OWNED BY public.strapi_webhooks.id;


--
-- Name: strapi_workflows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_workflows (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    content_types jsonb,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: strapi_workflows_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_workflows_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_workflows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_workflows_id_seq OWNED BY public.strapi_workflows.id;


--
-- Name: strapi_workflows_stage_required_to_publish_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_workflows_stage_required_to_publish_lnk (
    id integer NOT NULL,
    workflow_id integer,
    workflow_stage_id integer
);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_workflows_stage_required_to_publish_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_workflows_stage_required_to_publish_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_workflows_stage_required_to_publish_lnk_id_seq OWNED BY public.strapi_workflows_stage_required_to_publish_lnk.id;


--
-- Name: strapi_workflows_stages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_workflows_stages (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    color character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: strapi_workflows_stages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_workflows_stages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_workflows_stages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_workflows_stages_id_seq OWNED BY public.strapi_workflows_stages.id;


--
-- Name: strapi_workflows_stages_permissions_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_workflows_stages_permissions_lnk (
    id integer NOT NULL,
    workflow_stage_id integer,
    permission_id integer,
    permission_ord double precision
);


--
-- Name: strapi_workflows_stages_permissions_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_workflows_stages_permissions_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_workflows_stages_permissions_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_workflows_stages_permissions_lnk_id_seq OWNED BY public.strapi_workflows_stages_permissions_lnk.id;


--
-- Name: strapi_workflows_stages_workflow_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_workflows_stages_workflow_lnk (
    id integer NOT NULL,
    workflow_stage_id integer,
    workflow_id integer,
    workflow_stage_ord double precision
);


--
-- Name: strapi_workflows_stages_workflow_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_workflows_stages_workflow_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_workflows_stages_workflow_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_workflows_stages_workflow_lnk_id_seq OWNED BY public.strapi_workflows_stages_workflow_lnk.id;


--
-- Name: up_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.up_permissions (
    id integer NOT NULL,
    document_id character varying(255),
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: up_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.up_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: up_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.up_permissions_id_seq OWNED BY public.up_permissions.id;


--
-- Name: up_permissions_role_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.up_permissions_role_lnk (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_ord double precision
);


--
-- Name: up_permissions_role_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.up_permissions_role_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: up_permissions_role_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.up_permissions_role_lnk_id_seq OWNED BY public.up_permissions_role_lnk.id;


--
-- Name: up_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.up_roles (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    description character varying(255),
    type character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: up_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.up_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: up_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.up_roles_id_seq OWNED BY public.up_roles.id;


--
-- Name: up_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.up_users (
    id integer NOT NULL,
    document_id character varying(255),
    username character varying(255),
    email character varying(255),
    provider character varying(255),
    password character varying(255),
    reset_password_token character varying(255),
    confirmation_token character varying(255),
    confirmed boolean,
    blocked boolean,
    display_name character varying(255),
    bio text,
    interests jsonb,
    community_role character varying(255),
    avatar_color character varying(255),
    subscriber boolean,
    expert_title character varying(255),
    points integer,
    month_points integer,
    month_key character varying(255),
    streak integer,
    badges jsonb,
    stats jsonb,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: up_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.up_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: up_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.up_users_id_seq OWNED BY public.up_users.id;


--
-- Name: up_users_role_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.up_users_role_lnk (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    user_ord double precision
);


--
-- Name: up_users_role_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.up_users_role_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: up_users_role_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.up_users_role_lnk_id_seq OWNED BY public.up_users_role_lnk.id;


--
-- Name: upload_folders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.upload_folders (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    path_id integer,
    path character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: upload_folders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.upload_folders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: upload_folders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.upload_folders_id_seq OWNED BY public.upload_folders.id;


--
-- Name: upload_folders_parent_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.upload_folders_parent_lnk (
    id integer NOT NULL,
    folder_id integer,
    inv_folder_id integer,
    folder_ord double precision
);


--
-- Name: upload_folders_parent_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.upload_folders_parent_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: upload_folders_parent_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.upload_folders_parent_lnk_id_seq OWNED BY public.upload_folders_parent_lnk.id;


--
-- Name: admin_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_id_seq'::regclass);


--
-- Name: admin_permissions_api_token_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions_api_token_lnk ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_api_token_lnk_id_seq'::regclass);


--
-- Name: admin_permissions_role_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions_role_lnk ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_role_lnk_id_seq'::regclass);


--
-- Name: admin_roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_roles ALTER COLUMN id SET DEFAULT nextval('public.admin_roles_id_seq'::regclass);


--
-- Name: admin_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);


--
-- Name: admin_users_roles_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users_roles_lnk ALTER COLUMN id SET DEFAULT nextval('public.admin_users_roles_lnk_id_seq'::regclass);


--
-- Name: blog_comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_comments ALTER COLUMN id SET DEFAULT nextval('public.blog_comments_id_seq'::regclass);


--
-- Name: blog_comments_author_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_comments_author_lnk ALTER COLUMN id SET DEFAULT nextval('public.blog_comments_author_lnk_id_seq'::regclass);


--
-- Name: blog_comments_post_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_comments_post_lnk ALTER COLUMN id SET DEFAULT nextval('public.blog_comments_post_lnk_id_seq'::regclass);


--
-- Name: blog_comments_useful_by_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_comments_useful_by_lnk ALTER COLUMN id SET DEFAULT nextval('public.blog_comments_useful_by_lnk_id_seq'::regclass);


--
-- Name: blog_posts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts ALTER COLUMN id SET DEFAULT nextval('public.blog_posts_id_seq'::regclass);


--
-- Name: blog_posts_author_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts_author_lnk ALTER COLUMN id SET DEFAULT nextval('public.blog_posts_author_lnk_id_seq'::regclass);


--
-- Name: blog_posts_category_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts_category_lnk ALTER COLUMN id SET DEFAULT nextval('public.blog_posts_category_lnk_id_seq'::regclass);


--
-- Name: blog_posts_useful_by_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts_useful_by_lnk ALTER COLUMN id SET DEFAULT nextval('public.blog_posts_useful_by_lnk_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: discussions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions ALTER COLUMN id SET DEFAULT nextval('public.discussions_id_seq'::regclass);


--
-- Name: discussions_author_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions_author_lnk ALTER COLUMN id SET DEFAULT nextval('public.discussions_author_lnk_id_seq'::regclass);


--
-- Name: discussions_category_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions_category_lnk ALTER COLUMN id SET DEFAULT nextval('public.discussions_category_lnk_id_seq'::regclass);


--
-- Name: discussions_followed_by_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions_followed_by_lnk ALTER COLUMN id SET DEFAULT nextval('public.discussions_followed_by_lnk_id_seq'::regclass);


--
-- Name: discussions_useful_by_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions_useful_by_lnk ALTER COLUMN id SET DEFAULT nextval('public.discussions_useful_by_lnk_id_seq'::regclass);


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- Name: events_attendees_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_attendees_lnk ALTER COLUMN id SET DEFAULT nextval('public.events_attendees_lnk_id_seq'::regclass);


--
-- Name: events_category_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_category_lnk ALTER COLUMN id SET DEFAULT nextval('public.events_category_lnk_id_seq'::regclass);


--
-- Name: files id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);


--
-- Name: files_folder_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files_folder_lnk ALTER COLUMN id SET DEFAULT nextval('public.files_folder_lnk_id_seq'::regclass);


--
-- Name: files_related_mph id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files_related_mph ALTER COLUMN id SET DEFAULT nextval('public.files_related_mph_id_seq'::regclass);


--
-- Name: i18n_locale id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.i18n_locale ALTER COLUMN id SET DEFAULT nextval('public.i18n_locale_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: notifications_actor_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications_actor_lnk ALTER COLUMN id SET DEFAULT nextval('public.notifications_actor_lnk_id_seq'::regclass);


--
-- Name: notifications_blog_post_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications_blog_post_lnk ALTER COLUMN id SET DEFAULT nextval('public.notifications_blog_post_lnk_id_seq'::regclass);


--
-- Name: notifications_discussion_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications_discussion_lnk ALTER COLUMN id SET DEFAULT nextval('public.notifications_discussion_lnk_id_seq'::regclass);


--
-- Name: notifications_recipient_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications_recipient_lnk ALTER COLUMN id SET DEFAULT nextval('public.notifications_recipient_lnk_id_seq'::regclass);


--
-- Name: replies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies ALTER COLUMN id SET DEFAULT nextval('public.replies_id_seq'::regclass);


--
-- Name: replies_author_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies_author_lnk ALTER COLUMN id SET DEFAULT nextval('public.replies_author_lnk_id_seq'::regclass);


--
-- Name: replies_discussion_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies_discussion_lnk ALTER COLUMN id SET DEFAULT nextval('public.replies_discussion_lnk_id_seq'::regclass);


--
-- Name: replies_useful_by_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies_useful_by_lnk ALTER COLUMN id SET DEFAULT nextval('public.replies_useful_by_lnk_id_seq'::regclass);


--
-- Name: rewards id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rewards ALTER COLUMN id SET DEFAULT nextval('public.rewards_id_seq'::regclass);


--
-- Name: rewards_recipient_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rewards_recipient_lnk ALTER COLUMN id SET DEFAULT nextval('public.rewards_recipient_lnk_id_seq'::regclass);


--
-- Name: strapi_ai_localization_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_ai_localization_jobs ALTER COLUMN id SET DEFAULT nextval('public.strapi_ai_localization_jobs_id_seq'::regclass);


--
-- Name: strapi_ai_metadata_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_ai_metadata_jobs ALTER COLUMN id SET DEFAULT nextval('public.strapi_ai_metadata_jobs_id_seq'::regclass);


--
-- Name: strapi_api_token_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_id_seq'::regclass);


--
-- Name: strapi_api_token_permissions_token_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_token_lnk_id_seq'::regclass);


--
-- Name: strapi_api_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_tokens_id_seq'::regclass);


--
-- Name: strapi_api_tokens_admin_user_owner_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_tokens_admin_user_owner_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_tokens_admin_user_owner_lnk_id_seq'::regclass);


--
-- Name: strapi_core_store_settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_core_store_settings ALTER COLUMN id SET DEFAULT nextval('public.strapi_core_store_settings_id_seq'::regclass);


--
-- Name: strapi_database_schema id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_database_schema ALTER COLUMN id SET DEFAULT nextval('public.strapi_database_schema_id_seq'::regclass);


--
-- Name: strapi_history_versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_history_versions ALTER COLUMN id SET DEFAULT nextval('public.strapi_history_versions_id_seq'::regclass);


--
-- Name: strapi_migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_migrations ALTER COLUMN id SET DEFAULT nextval('public.strapi_migrations_id_seq'::regclass);


--
-- Name: strapi_migrations_internal id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_migrations_internal ALTER COLUMN id SET DEFAULT nextval('public.strapi_migrations_internal_id_seq'::regclass);


--
-- Name: strapi_release_actions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_release_actions ALTER COLUMN id SET DEFAULT nextval('public.strapi_release_actions_id_seq'::regclass);


--
-- Name: strapi_release_actions_release_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_release_actions_release_lnk_id_seq'::regclass);


--
-- Name: strapi_releases id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_releases ALTER COLUMN id SET DEFAULT nextval('public.strapi_releases_id_seq'::regclass);


--
-- Name: strapi_sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_sessions ALTER COLUMN id SET DEFAULT nextval('public.strapi_sessions_id_seq'::regclass);


--
-- Name: strapi_transfer_token_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_id_seq'::regclass);


--
-- Name: strapi_transfer_token_permissions_token_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_token_lnk_id_seq'::regclass);


--
-- Name: strapi_transfer_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_tokens_id_seq'::regclass);


--
-- Name: strapi_webhooks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_webhooks ALTER COLUMN id SET DEFAULT nextval('public.strapi_webhooks_id_seq'::regclass);


--
-- Name: strapi_workflows id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_id_seq'::regclass);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_stage_required_to_publish_lnk_id_seq'::regclass);


--
-- Name: strapi_workflows_stages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_stages_id_seq'::regclass);


--
-- Name: strapi_workflows_stages_permissions_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_stages_permissions_lnk_id_seq'::regclass);


--
-- Name: strapi_workflows_stages_workflow_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_stages_workflow_lnk_id_seq'::regclass);


--
-- Name: up_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_permissions ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_id_seq'::regclass);


--
-- Name: up_permissions_role_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_permissions_role_lnk ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_role_lnk_id_seq'::regclass);


--
-- Name: up_roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_roles ALTER COLUMN id SET DEFAULT nextval('public.up_roles_id_seq'::regclass);


--
-- Name: up_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_users ALTER COLUMN id SET DEFAULT nextval('public.up_users_id_seq'::regclass);


--
-- Name: up_users_role_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_users_role_lnk ALTER COLUMN id SET DEFAULT nextval('public.up_users_role_lnk_id_seq'::regclass);


--
-- Name: upload_folders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_id_seq'::regclass);


--
-- Name: upload_folders_parent_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders_parent_lnk ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_parent_lnk_id_seq'::regclass);


--
-- Data for Name: admin_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.admin_permissions VALUES
	(1, 'o38h919oywrn2g0r6eeuasz6', 'plugin::content-manager.explorer.create', '{}', 'api::blog-comment.blog-comment', '{"fields": ["content", "author", "post", "usefulBase", "usefulBy"]}', '[]', '2026-10-27 15:00:28.396', '2026-10-27 15:00:28.396', '2026-10-27 15:00:28.396', NULL, NULL, NULL),
	(2, 'l8ccnrb27mjzkcedhhq60bvr', 'plugin::content-manager.explorer.create', '{}', 'api::blog-post.blog-post', '{"fields": ["title", "content", "author", "category", "views", "usefulBase", "usefulBy", "comments"]}', '[]', '2026-10-27 15:00:28.455', '2026-10-27 15:00:28.455', '2026-10-27 15:00:28.455', NULL, NULL, NULL),
	(3, 'yedznqc1m01vq2ys5fi5jadk', 'plugin::content-manager.explorer.create', '{}', 'api::category.category', '{"fields": ["name", "slug", "description", "icon", "color", "siteSection", "discussions"]}', '[]', '2026-10-27 15:00:28.471', '2026-10-27 15:00:28.471', '2026-10-27 15:00:28.471', NULL, NULL, NULL),
	(4, 't7imbns8n1yl45r4am007er9', 'plugin::content-manager.explorer.create', '{}', 'api::discussion.discussion', '{"fields": ["title", "slug", "content", "type", "author", "category", "replies", "article", "pinned", "featured", "views", "pollOptions", "pollVotes", "usefulBy", "followedBy", "usefulBase"]}', '[]', '2026-10-27 15:00:28.488', '2026-10-27 15:00:28.488', '2026-10-27 15:00:28.488', NULL, NULL, NULL),
	(5, 'ujsk6kfy60zbb8vlmx341bp3', 'plugin::content-manager.explorer.create', '{}', 'api::event.event', '{"fields": ["title", "host", "startsAt", "category", "goingBase", "attendees"]}', '[]', '2026-10-27 15:00:28.502', '2026-10-27 15:00:28.502', '2026-10-27 15:00:28.502', NULL, NULL, NULL),
	(6, 'bz1dpi3j20r0hf7cjpcxiz98', 'plugin::content-manager.explorer.create', '{}', 'api::notification.notification', '{"fields": ["recipient", "kind", "actor", "discussion", "blogPost", "badge", "text", "read"]}', '[]', '2026-10-27 15:00:28.517', '2026-10-27 15:00:28.517', '2026-10-27 15:00:28.517', NULL, NULL, NULL),
	(7, 'a3zjbs5nk7h1nx8eanc6387c', 'plugin::content-manager.explorer.create', '{}', 'api::reply.reply', '{"fields": ["content", "isBestAnswer", "author", "discussion", "verified", "usefulBy", "usefulBase"]}', '[]', '2026-10-27 15:00:28.531', '2026-10-27 15:00:28.531', '2026-10-27 15:00:28.531', NULL, NULL, NULL),
	(8, 'hvvedmxeeygnzkgcycjpjkdr', 'plugin::content-manager.explorer.create', '{}', 'api::reward.reward', '{"fields": ["key", "recipient", "points", "reason"]}', '[]', '2026-10-27 15:00:28.546', '2026-10-27 15:00:28.546', '2026-10-27 15:00:28.546', NULL, NULL, NULL),
	(9, 'zzaods3t61dtqvqgt1fjksb4', 'plugin::content-manager.explorer.read', '{}', 'api::blog-comment.blog-comment', '{"fields": ["content", "author", "post", "usefulBase", "usefulBy"]}', '[]', '2026-10-27 15:00:28.559', '2026-10-27 15:00:28.559', '2026-10-27 15:00:28.559', NULL, NULL, NULL),
	(10, 'kroai5q93b8nwyiv7gv6yjpi', 'plugin::content-manager.explorer.read', '{}', 'api::blog-post.blog-post', '{"fields": ["title", "content", "author", "category", "views", "usefulBase", "usefulBy", "comments"]}', '[]', '2026-10-27 15:00:28.571', '2026-10-27 15:00:28.571', '2026-10-27 15:00:28.571', NULL, NULL, NULL),
	(11, 'ev82yl2v4r9jj97ur8ef8xoj', 'plugin::content-manager.explorer.read', '{}', 'api::category.category', '{"fields": ["name", "slug", "description", "icon", "color", "siteSection", "discussions"]}', '[]', '2026-10-27 15:00:28.585', '2026-10-27 15:00:28.585', '2026-10-27 15:00:28.585', NULL, NULL, NULL),
	(12, 'x5e8or3d56z3g6rj9ubhvg1k', 'plugin::content-manager.explorer.read', '{}', 'api::discussion.discussion', '{"fields": ["title", "slug", "content", "type", "author", "category", "replies", "article", "pinned", "featured", "views", "pollOptions", "pollVotes", "usefulBy", "followedBy", "usefulBase"]}', '[]', '2026-10-27 15:00:28.6', '2026-10-27 15:00:28.6', '2026-10-27 15:00:28.6', NULL, NULL, NULL),
	(13, 'xna1yirt84fyub6quwn0i8gc', 'plugin::content-manager.explorer.read', '{}', 'api::event.event', '{"fields": ["title", "host", "startsAt", "category", "goingBase", "attendees"]}', '[]', '2026-10-27 15:00:28.617', '2026-10-27 15:00:28.617', '2026-10-27 15:00:28.617', NULL, NULL, NULL),
	(14, 'nttnt738t38hzkj1echddo7n', 'plugin::content-manager.explorer.read', '{}', 'api::notification.notification', '{"fields": ["recipient", "kind", "actor", "discussion", "blogPost", "badge", "text", "read"]}', '[]', '2026-10-27 15:00:28.631', '2026-10-27 15:00:28.631', '2026-10-27 15:00:28.631', NULL, NULL, NULL),
	(15, 'ry4voyd8fz5rbz7nw2pmin66', 'plugin::content-manager.explorer.read', '{}', 'api::reply.reply', '{"fields": ["content", "isBestAnswer", "author", "discussion", "verified", "usefulBy", "usefulBase"]}', '[]', '2026-10-27 15:00:28.645', '2026-10-27 15:00:28.645', '2026-10-27 15:00:28.645', NULL, NULL, NULL),
	(16, 'dlioif00mtb1evwqqpzxeiqx', 'plugin::content-manager.explorer.read', '{}', 'api::reward.reward', '{"fields": ["key", "recipient", "points", "reason"]}', '[]', '2026-10-27 15:00:28.661', '2026-10-27 15:00:28.661', '2026-10-27 15:00:28.661', NULL, NULL, NULL),
	(17, 'c9f8a5l2gns0ymsk9pzsskzp', 'plugin::content-manager.explorer.update', '{}', 'api::blog-comment.blog-comment', '{"fields": ["content", "author", "post", "usefulBase", "usefulBy"]}', '[]', '2026-10-27 15:00:28.676', '2026-10-27 15:00:28.676', '2026-10-27 15:00:28.676', NULL, NULL, NULL),
	(18, 'uvfa9igpnxvvj0emj9xkbf8s', 'plugin::content-manager.explorer.update', '{}', 'api::blog-post.blog-post', '{"fields": ["title", "content", "author", "category", "views", "usefulBase", "usefulBy", "comments"]}', '[]', '2026-10-27 15:00:28.69', '2026-10-27 15:00:28.69', '2026-10-27 15:00:28.69', NULL, NULL, NULL),
	(19, 's5953tnvj5axd715ef62e1em', 'plugin::content-manager.explorer.update', '{}', 'api::category.category', '{"fields": ["name", "slug", "description", "icon", "color", "siteSection", "discussions"]}', '[]', '2026-10-27 15:00:28.704', '2026-10-27 15:00:28.704', '2026-10-27 15:00:28.704', NULL, NULL, NULL),
	(20, 'l59scxr0hb99fnysg8znfxeq', 'plugin::content-manager.explorer.update', '{}', 'api::discussion.discussion', '{"fields": ["title", "slug", "content", "type", "author", "category", "replies", "article", "pinned", "featured", "views", "pollOptions", "pollVotes", "usefulBy", "followedBy", "usefulBase"]}', '[]', '2026-10-27 15:00:28.717', '2026-10-27 15:00:28.717', '2026-10-27 15:00:28.718', NULL, NULL, NULL),
	(21, 'c2gwjm53pgvoeotijepwi4ys', 'plugin::content-manager.explorer.update', '{}', 'api::event.event', '{"fields": ["title", "host", "startsAt", "category", "goingBase", "attendees"]}', '[]', '2026-10-27 15:00:28.734', '2026-10-27 15:00:28.734', '2026-10-27 15:00:28.734', NULL, NULL, NULL),
	(22, 'v8w2tnbiqhr5senud08jxgw2', 'plugin::content-manager.explorer.update', '{}', 'api::notification.notification', '{"fields": ["recipient", "kind", "actor", "discussion", "blogPost", "badge", "text", "read"]}', '[]', '2026-10-27 15:00:28.75', '2026-10-27 15:00:28.75', '2026-10-27 15:00:28.75', NULL, NULL, NULL),
	(23, 'stic228cpqtfn00tc6nrqizw', 'plugin::content-manager.explorer.update', '{}', 'api::reply.reply', '{"fields": ["content", "isBestAnswer", "author", "discussion", "verified", "usefulBy", "usefulBase"]}', '[]', '2026-10-27 15:00:28.766', '2026-10-27 15:00:28.766', '2026-10-27 15:00:28.766', NULL, NULL, NULL),
	(24, 'tgoxb80banlei9kdg32cja0j', 'plugin::content-manager.explorer.update', '{}', 'api::reward.reward', '{"fields": ["key", "recipient", "points", "reason"]}', '[]', '2026-10-27 15:00:28.782', '2026-10-27 15:00:28.782', '2026-10-27 15:00:28.782', NULL, NULL, NULL),
	(25, 'sm6yk9lih23bbtqr25kq922s', 'plugin::content-manager.explorer.delete', '{}', 'api::blog-comment.blog-comment', '{}', '[]', '2026-10-27 15:00:28.796', '2026-10-27 15:00:28.796', '2026-10-27 15:00:28.797', NULL, NULL, NULL),
	(26, 'sbdjlenjempeocgoz3nwgqf7', 'plugin::content-manager.explorer.delete', '{}', 'api::blog-post.blog-post', '{}', '[]', '2026-10-27 15:00:28.812', '2026-10-27 15:00:28.812', '2026-10-27 15:00:28.812', NULL, NULL, NULL),
	(27, 'nyqourkhdz7njtamngddpdgc', 'plugin::content-manager.explorer.delete', '{}', 'api::category.category', '{}', '[]', '2026-10-27 15:00:28.826', '2026-10-27 15:00:28.826', '2026-10-27 15:00:28.826', NULL, NULL, NULL),
	(28, 'y4or4631suo8xq749e9jhkif', 'plugin::content-manager.explorer.delete', '{}', 'api::discussion.discussion', '{}', '[]', '2026-10-27 15:00:28.84', '2026-10-27 15:00:28.84', '2026-10-27 15:00:28.84', NULL, NULL, NULL),
	(29, 'bry5c7upm0fzym2btupmx7qz', 'plugin::content-manager.explorer.delete', '{}', 'api::event.event', '{}', '[]', '2026-10-27 15:00:28.856', '2026-10-27 15:00:28.856', '2026-10-27 15:00:28.856', NULL, NULL, NULL),
	(30, 'boacftpou30zwq3c8mrhqj2g', 'plugin::content-manager.explorer.delete', '{}', 'api::notification.notification', '{}', '[]', '2026-10-27 15:00:28.871', '2026-10-27 15:00:28.871', '2026-10-27 15:00:28.871', NULL, NULL, NULL),
	(31, 'maqsvnldp1xxv0eo9ut8l0li', 'plugin::content-manager.explorer.delete', '{}', 'api::reply.reply', '{}', '[]', '2026-10-27 15:00:28.886', '2026-10-27 15:00:28.886', '2026-10-27 15:00:28.886', NULL, NULL, NULL),
	(32, 'honfcbnag8ugzv47uxl8fw5f', 'plugin::content-manager.explorer.delete', '{}', 'api::reward.reward', '{}', '[]', '2026-10-27 15:00:28.899', '2026-10-27 15:00:28.899', '2026-10-27 15:00:28.899', NULL, NULL, NULL),
	(178, 'y76e69lke34urypb6t8membo', 'admin::users.create', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.832', '2026-10-27 15:00:30.832', '2026-10-27 15:00:30.832', NULL, NULL, NULL),
	(33, 'jfiw3a7fevhu1p0lt2nx07mn', 'plugin::content-manager.explorer.publish', '{}', 'api::blog-comment.blog-comment', '{}', '[]', '2026-10-27 15:00:28.913', '2026-10-27 15:00:28.913', '2026-10-27 15:00:28.914', NULL, NULL, NULL),
	(34, 'n8h18wjtlol7jt0pranxltgn', 'plugin::content-manager.explorer.publish', '{}', 'api::blog-post.blog-post', '{}', '[]', '2026-10-27 15:00:28.932', '2026-10-27 15:00:28.932', '2026-10-27 15:00:28.933', NULL, NULL, NULL),
	(35, 'qktf6btdw4azu4krxxydl90b', 'plugin::content-manager.explorer.publish', '{}', 'api::category.category', '{}', '[]', '2026-10-27 15:00:28.946', '2026-10-27 15:00:28.946', '2026-10-27 15:00:28.946', NULL, NULL, NULL),
	(36, 'zupwqdgl5bcwtmqiple9gqmq', 'plugin::content-manager.explorer.publish', '{}', 'api::discussion.discussion', '{}', '[]', '2026-10-27 15:00:28.959', '2026-10-27 15:00:28.959', '2026-10-27 15:00:28.959', NULL, NULL, NULL),
	(37, 'gqtroqobytp7s7gw5edmds2l', 'plugin::content-manager.explorer.publish', '{}', 'api::event.event', '{}', '[]', '2026-10-27 15:00:28.971', '2026-10-27 15:00:28.971', '2026-10-27 15:00:28.971', NULL, NULL, NULL),
	(38, 'tgcljrsb69bj8fd42uau381t', 'plugin::content-manager.explorer.publish', '{}', 'api::notification.notification', '{}', '[]', '2026-10-27 15:00:28.984', '2026-10-27 15:00:28.984', '2026-10-27 15:00:28.984', NULL, NULL, NULL),
	(39, 'ykzm9b3i5zkx1abwmvs99sg5', 'plugin::content-manager.explorer.publish', '{}', 'api::reply.reply', '{}', '[]', '2026-10-27 15:00:28.996', '2026-10-27 15:00:28.996', '2026-10-27 15:00:28.996', NULL, NULL, NULL),
	(40, 'aar2yoiedpu786iwcqx8jac5', 'plugin::content-manager.explorer.publish', '{}', 'api::reward.reward', '{}', '[]', '2026-10-27 15:00:29.008', '2026-10-27 15:00:29.008', '2026-10-27 15:00:29.008', NULL, NULL, NULL),
	(41, 'wowbyl4a2e50lx7tjakjopkv', 'plugin::upload.read', '{}', NULL, '{}', '[]', '2026-10-27 15:00:29.019', '2026-10-27 15:00:29.019', '2026-10-27 15:00:29.02', NULL, NULL, NULL),
	(42, 'dojtp409qw4gmqxrc4r92w3l', 'plugin::upload.configure-view', '{}', NULL, '{}', '[]', '2026-10-27 15:00:29.032', '2026-10-27 15:00:29.032', '2026-10-27 15:00:29.032', NULL, NULL, NULL),
	(43, 'iitnxthdyeavjnpkxvxb47sn', 'plugin::upload.assets.create', '{}', NULL, '{}', '[]', '2026-10-27 15:00:29.045', '2026-10-27 15:00:29.045', '2026-10-27 15:00:29.045', NULL, NULL, NULL),
	(44, 'uebwqrat7tk1zurmhbwrg45e', 'plugin::upload.assets.update', '{}', NULL, '{}', '[]', '2026-10-27 15:00:29.057', '2026-10-27 15:00:29.057', '2026-10-27 15:00:29.058', NULL, NULL, NULL),
	(45, 'n7jzoisf10eovru9mlymq5jb', 'plugin::upload.assets.download', '{}', NULL, '{}', '[]', '2026-10-27 15:00:29.07', '2026-10-27 15:00:29.07', '2026-10-27 15:00:29.07', NULL, NULL, NULL),
	(46, 'alfekf26wvfsuvq04q8k8xc5', 'plugin::upload.assets.copy-link', '{}', NULL, '{}', '[]', '2026-10-27 15:00:29.083', '2026-10-27 15:00:29.083', '2026-10-27 15:00:29.083', NULL, NULL, NULL),
	(47, 'i8gryfhhyty2vsbo4r0p5dwa', 'plugin::content-manager.explorer.create', '{}', 'api::blog-comment.blog-comment', '{"fields": ["content", "author", "post", "usefulBase", "usefulBy"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.1', '2026-10-27 15:00:29.1', '2026-10-27 15:00:29.1', NULL, NULL, NULL),
	(48, 'm1q45ggkgiodckbzwxax2lbb', 'plugin::content-manager.explorer.create', '{}', 'api::blog-post.blog-post', '{"fields": ["title", "content", "author", "category", "views", "usefulBase", "usefulBy", "comments"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.115', '2026-10-27 15:00:29.115', '2026-10-27 15:00:29.115', NULL, NULL, NULL),
	(49, 'htgxpmeymb4tgori7chqtx3y', 'plugin::content-manager.explorer.create', '{}', 'api::category.category', '{"fields": ["name", "slug", "description", "icon", "color", "siteSection", "discussions"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.129', '2026-10-27 15:00:29.129', '2026-10-27 15:00:29.129', NULL, NULL, NULL),
	(50, 'oe632una6aldvscuyzztjpm8', 'plugin::content-manager.explorer.create', '{}', 'api::discussion.discussion', '{"fields": ["title", "slug", "content", "type", "author", "category", "replies", "article", "pinned", "featured", "views", "pollOptions", "pollVotes", "usefulBy", "followedBy", "usefulBase"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.142', '2026-10-27 15:00:29.142', '2026-10-27 15:00:29.143', NULL, NULL, NULL),
	(51, 'i13lkofkmdrj5h6rnr8cjyr8', 'plugin::content-manager.explorer.create', '{}', 'api::event.event', '{"fields": ["title", "host", "startsAt", "category", "goingBase", "attendees"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.155', '2026-10-27 15:00:29.155', '2026-10-27 15:00:29.155', NULL, NULL, NULL),
	(52, 'h3lxje151t293qs9m60cfj7j', 'plugin::content-manager.explorer.create', '{}', 'api::notification.notification', '{"fields": ["recipient", "kind", "actor", "discussion", "blogPost", "badge", "text", "read"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.168', '2026-10-27 15:00:29.168', '2026-10-27 15:00:29.168', NULL, NULL, NULL),
	(53, 'cvmib6se375788rxgja6fqtj', 'plugin::content-manager.explorer.create', '{}', 'api::reply.reply', '{"fields": ["content", "isBestAnswer", "author", "discussion", "verified", "usefulBy", "usefulBase"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.18', '2026-10-27 15:00:29.18', '2026-10-27 15:00:29.18', NULL, NULL, NULL),
	(54, 'bnzy7swydcb1gxsna66xhx4d', 'plugin::content-manager.explorer.create', '{}', 'api::reward.reward', '{"fields": ["key", "recipient", "points", "reason"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.193', '2026-10-27 15:00:29.193', '2026-10-27 15:00:29.194', NULL, NULL, NULL),
	(55, 'lmvuscoek5bdolem17hz7ovk', 'plugin::content-manager.explorer.read', '{}', 'api::blog-comment.blog-comment', '{"fields": ["content", "author", "post", "usefulBase", "usefulBy"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.206', '2026-10-27 15:00:29.206', '2026-10-27 15:00:29.206', NULL, NULL, NULL),
	(56, 'q5av1359u8jqd0tcag6k86zs', 'plugin::content-manager.explorer.read', '{}', 'api::blog-post.blog-post', '{"fields": ["title", "content", "author", "category", "views", "usefulBase", "usefulBy", "comments"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.218', '2026-10-27 15:00:29.218', '2026-10-27 15:00:29.218', NULL, NULL, NULL),
	(57, 'cpusque9c44y2i46ysjbttmz', 'plugin::content-manager.explorer.read', '{}', 'api::category.category', '{"fields": ["name", "slug", "description", "icon", "color", "siteSection", "discussions"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.233', '2026-10-27 15:00:29.233', '2026-10-27 15:00:29.233', NULL, NULL, NULL),
	(58, 'kauy1sv6axiydc9m8d4tz1yv', 'plugin::content-manager.explorer.read', '{}', 'api::discussion.discussion', '{"fields": ["title", "slug", "content", "type", "author", "category", "replies", "article", "pinned", "featured", "views", "pollOptions", "pollVotes", "usefulBy", "followedBy", "usefulBase"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.245', '2026-10-27 15:00:29.245', '2026-10-27 15:00:29.245', NULL, NULL, NULL),
	(59, 'c6intsww04zoeipzctrwrmtr', 'plugin::content-manager.explorer.read', '{}', 'api::event.event', '{"fields": ["title", "host", "startsAt", "category", "goingBase", "attendees"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.259', '2026-10-27 15:00:29.259', '2026-10-27 15:00:29.259', NULL, NULL, NULL),
	(60, 'qpz5uxcym35x4oay6v3ywyn5', 'plugin::content-manager.explorer.read', '{}', 'api::notification.notification', '{"fields": ["recipient", "kind", "actor", "discussion", "blogPost", "badge", "text", "read"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.271', '2026-10-27 15:00:29.271', '2026-10-27 15:00:29.271', NULL, NULL, NULL),
	(61, 'zbo7zrkh1hiuw28fhiqsn4s8', 'plugin::content-manager.explorer.read', '{}', 'api::reply.reply', '{"fields": ["content", "isBestAnswer", "author", "discussion", "verified", "usefulBy", "usefulBase"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.283', '2026-10-27 15:00:29.283', '2026-10-27 15:00:29.283', NULL, NULL, NULL),
	(62, 'btu9nov17v1so5pn7fqqmy74', 'plugin::content-manager.explorer.read', '{}', 'api::reward.reward', '{"fields": ["key", "recipient", "points", "reason"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.295', '2026-10-27 15:00:29.295', '2026-10-27 15:00:29.295', NULL, NULL, NULL),
	(63, 'w68eu9z6z938w05bldd0dhv0', 'plugin::content-manager.explorer.update', '{}', 'api::blog-comment.blog-comment', '{"fields": ["content", "author", "post", "usefulBase", "usefulBy"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.306', '2026-10-27 15:00:29.306', '2026-10-27 15:00:29.307', NULL, NULL, NULL),
	(64, 'gz1vw88y6wuchpwod0r6zf6u', 'plugin::content-manager.explorer.update', '{}', 'api::blog-post.blog-post', '{"fields": ["title", "content", "author", "category", "views", "usefulBase", "usefulBy", "comments"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.32', '2026-10-27 15:00:29.32', '2026-10-27 15:00:29.32', NULL, NULL, NULL),
	(65, 'itu719l114b8r1xb0ox9hrcc', 'plugin::content-manager.explorer.update', '{}', 'api::category.category', '{"fields": ["name", "slug", "description", "icon", "color", "siteSection", "discussions"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.331', '2026-10-27 15:00:29.331', '2026-10-27 15:00:29.331', NULL, NULL, NULL),
	(98, 'grf6bg11fbn850qoyiy5ekjr', 'plugin::content-manager.explorer.read', '{}', 'plugin::content-releases.release-action', '{"fields": ["type", "contentType", "entryDocumentId", "release", "isEntryValid"]}', '[]', '2026-10-27 15:00:29.791', '2026-10-27 15:00:29.791', '2026-10-27 15:00:29.791', NULL, NULL, NULL),
	(66, 'q1ca7sfln6rxrynrewjnm7xm', 'plugin::content-manager.explorer.update', '{}', 'api::discussion.discussion', '{"fields": ["title", "slug", "content", "type", "author", "category", "replies", "article", "pinned", "featured", "views", "pollOptions", "pollVotes", "usefulBy", "followedBy", "usefulBase"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.343', '2026-10-27 15:00:29.343', '2026-10-27 15:00:29.343', NULL, NULL, NULL),
	(67, 'y5dlocynli1wg7c3eduaz5fq', 'plugin::content-manager.explorer.update', '{}', 'api::event.event', '{"fields": ["title", "host", "startsAt", "category", "goingBase", "attendees"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.355', '2026-10-27 15:00:29.355', '2026-10-27 15:00:29.355', NULL, NULL, NULL),
	(68, 's94tvfbw9y1rmx5xtjl1mqwh', 'plugin::content-manager.explorer.update', '{}', 'api::notification.notification', '{"fields": ["recipient", "kind", "actor", "discussion", "blogPost", "badge", "text", "read"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.367', '2026-10-27 15:00:29.367', '2026-10-27 15:00:29.367', NULL, NULL, NULL),
	(69, 'oj6fypd964apz7tq1aztuvgk', 'plugin::content-manager.explorer.update', '{}', 'api::reply.reply', '{"fields": ["content", "isBestAnswer", "author", "discussion", "verified", "usefulBy", "usefulBase"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.379', '2026-10-27 15:00:29.379', '2026-10-27 15:00:29.379', NULL, NULL, NULL),
	(70, 'mss23pb7g5dokcpe3adorq8r', 'plugin::content-manager.explorer.update', '{}', 'api::reward.reward', '{"fields": ["key", "recipient", "points", "reason"]}', '["admin::is-creator"]', '2026-10-27 15:00:29.39', '2026-10-27 15:00:29.39', '2026-10-27 15:00:29.39', NULL, NULL, NULL),
	(71, 'o5je1nop0hvvzlm30898j65j', 'plugin::content-manager.explorer.delete', '{}', 'api::blog-comment.blog-comment', '{}', '["admin::is-creator"]', '2026-10-27 15:00:29.403', '2026-10-27 15:00:29.403', '2026-10-27 15:00:29.403', NULL, NULL, NULL),
	(72, 'luff4y3he7gwkpeg6cjtmyoo', 'plugin::content-manager.explorer.delete', '{}', 'api::blog-post.blog-post', '{}', '["admin::is-creator"]', '2026-10-27 15:00:29.415', '2026-10-27 15:00:29.415', '2026-10-27 15:00:29.415', NULL, NULL, NULL),
	(73, 'ctrg3ggu599dp5hkfgowigb2', 'plugin::content-manager.explorer.delete', '{}', 'api::category.category', '{}', '["admin::is-creator"]', '2026-10-27 15:00:29.428', '2026-10-27 15:00:29.428', '2026-10-27 15:00:29.428', NULL, NULL, NULL),
	(74, 'r4i8cskqfug6t94onivoktdz', 'plugin::content-manager.explorer.delete', '{}', 'api::discussion.discussion', '{}', '["admin::is-creator"]', '2026-10-27 15:00:29.441', '2026-10-27 15:00:29.441', '2026-10-27 15:00:29.442', NULL, NULL, NULL),
	(75, 'ldys3b8a66ldtnawhol2kwpp', 'plugin::content-manager.explorer.delete', '{}', 'api::event.event', '{}', '["admin::is-creator"]', '2026-10-27 15:00:29.459', '2026-10-27 15:00:29.459', '2026-10-27 15:00:29.459', NULL, NULL, NULL),
	(76, 'qlm0k47vhk5ngw4a2mfn885i', 'plugin::content-manager.explorer.delete', '{}', 'api::notification.notification', '{}', '["admin::is-creator"]', '2026-10-27 15:00:29.471', '2026-10-27 15:00:29.471', '2026-10-27 15:00:29.471', NULL, NULL, NULL),
	(77, 'p36r0pildd3dom7axo7vumt4', 'plugin::content-manager.explorer.delete', '{}', 'api::reply.reply', '{}', '["admin::is-creator"]', '2026-10-27 15:00:29.483', '2026-10-27 15:00:29.483', '2026-10-27 15:00:29.483', NULL, NULL, NULL),
	(78, 'ucw9x339d8zfpmdfzct53dx9', 'plugin::content-manager.explorer.delete', '{}', 'api::reward.reward', '{}', '["admin::is-creator"]', '2026-10-27 15:00:29.497', '2026-10-27 15:00:29.497', '2026-10-27 15:00:29.497', NULL, NULL, NULL),
	(79, 'hxfdrrh8qjnlfif0zg2fzy58', 'plugin::upload.read', '{}', NULL, '{}', '["admin::is-creator"]', '2026-10-27 15:00:29.511', '2026-10-27 15:00:29.511', '2026-10-27 15:00:29.511', NULL, NULL, NULL),
	(80, 's4fmnqkgrx70ubaftmohmcyi', 'plugin::upload.configure-view', '{}', NULL, '{}', '[]', '2026-10-27 15:00:29.525', '2026-10-27 15:00:29.525', '2026-10-27 15:00:29.525', NULL, NULL, NULL),
	(81, 'h474nok39lukf37klv47xcdz', 'plugin::upload.assets.create', '{}', NULL, '{}', '[]', '2026-10-27 15:00:29.537', '2026-10-27 15:00:29.537', '2026-10-27 15:00:29.537', NULL, NULL, NULL),
	(82, 'i62x957nywavpns3hwa2m03w', 'plugin::upload.assets.update', '{}', NULL, '{}', '["admin::is-creator"]', '2026-10-27 15:00:29.549', '2026-10-27 15:00:29.549', '2026-10-27 15:00:29.549', NULL, NULL, NULL),
	(83, 'd8qvhwi4v36jcxbdjop11ur4', 'plugin::upload.assets.download', '{}', NULL, '{}', '[]', '2026-10-27 15:00:29.562', '2026-10-27 15:00:29.562', '2026-10-27 15:00:29.562', NULL, NULL, NULL),
	(84, 'wecjl1jqjj9gaewl92vwgabb', 'plugin::upload.assets.copy-link', '{}', NULL, '{}', '[]', '2026-10-27 15:00:29.574', '2026-10-27 15:00:29.574', '2026-10-27 15:00:29.574', NULL, NULL, NULL),
	(85, 'dnrobje9rhzlkuywbx8qxboo', 'plugin::content-manager.explorer.create', '{}', 'plugin::users-permissions.user', '{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role", "displayName", "avatar", "bio", "discussions", "replies", "interests", "usefulDiscussions", "followedDiscussions", "usefulReplies", "communityRole", "avatarColor", "subscriber", "expertTitle", "points", "monthPoints", "monthKey", "streak", "badges", "stats", "blogPosts", "blogComments", "usefulBlogPosts", "usefulBlogComments", "events"]}', '[]', '2026-10-27 15:00:29.619', '2026-10-27 15:00:29.619', '2026-10-27 15:00:29.619', NULL, NULL, NULL),
	(86, 'lr44gsukwn3zxu9s09s3yy3a', 'plugin::content-manager.explorer.create', '{}', 'api::blog-comment.blog-comment', '{"fields": ["content", "author", "post", "usefulBase", "usefulBy"]}', '[]', '2026-10-27 15:00:29.633', '2026-10-27 15:00:29.633', '2026-10-27 15:00:29.633', NULL, NULL, NULL),
	(87, 'bl865ikhox7idw1kxpo4d172', 'plugin::content-manager.explorer.create', '{}', 'api::blog-post.blog-post', '{"fields": ["title", "content", "author", "category", "views", "usefulBase", "usefulBy", "comments"]}', '[]', '2026-10-27 15:00:29.647', '2026-10-27 15:00:29.647', '2026-10-27 15:00:29.648', NULL, NULL, NULL),
	(88, 'p64ijm1we1nlpwidedtet1tu', 'plugin::content-manager.explorer.create', '{}', 'api::category.category', '{"fields": ["name", "slug", "description", "icon", "color", "siteSection", "discussions"]}', '[]', '2026-10-27 15:00:29.661', '2026-10-27 15:00:29.661', '2026-10-27 15:00:29.661', NULL, NULL, NULL),
	(89, 'quh30sv6h7fw7qydcnqj47pg', 'plugin::content-manager.explorer.create', '{}', 'api::discussion.discussion', '{"fields": ["title", "slug", "content", "type", "author", "category", "replies", "article", "pinned", "featured", "views", "pollOptions", "pollVotes", "usefulBy", "followedBy", "usefulBase"]}', '[]', '2026-10-27 15:00:29.676', '2026-10-27 15:00:29.676', '2026-10-27 15:00:29.676', NULL, NULL, NULL),
	(90, 'p7a0fbvd8km6qjxceowcnaew', 'plugin::content-manager.explorer.create', '{}', 'api::event.event', '{"fields": ["title", "host", "startsAt", "category", "goingBase", "attendees"]}', '[]', '2026-10-27 15:00:29.69', '2026-10-27 15:00:29.69', '2026-10-27 15:00:29.691', NULL, NULL, NULL),
	(91, 'n7fffi06ia87vu6vj2ctn9wt', 'plugin::content-manager.explorer.create', '{}', 'api::notification.notification', '{"fields": ["recipient", "kind", "actor", "discussion", "blogPost", "badge", "text", "read"]}', '[]', '2026-10-27 15:00:29.702', '2026-10-27 15:00:29.702', '2026-10-27 15:00:29.702', NULL, NULL, NULL),
	(92, 'ew6rggughxfxzblcnaeuffpf', 'plugin::content-manager.explorer.create', '{}', 'api::reply.reply', '{"fields": ["content", "isBestAnswer", "author", "discussion", "verified", "usefulBy", "usefulBase"]}', '[]', '2026-10-27 15:00:29.714', '2026-10-27 15:00:29.714', '2026-10-27 15:00:29.714', NULL, NULL, NULL),
	(93, 'zq61yivva1lbst661khfugt2', 'plugin::content-manager.explorer.create', '{}', 'api::reward.reward', '{"fields": ["key", "recipient", "points", "reason"]}', '[]', '2026-10-27 15:00:29.726', '2026-10-27 15:00:29.726', '2026-10-27 15:00:29.726', NULL, NULL, NULL),
	(94, 'j61ik84jtkhaodgbvhnu056f', 'plugin::content-manager.explorer.read', '{}', 'plugin::upload.file', '{"fields": ["name", "alternativeText", "caption", "focalPoint", "width", "height", "formats", "hash", "ext", "mime", "size", "url", "previewUrl", "provider", "provider_metadata", "related", "folder", "folderPath"]}', '[]', '2026-10-27 15:00:29.738', '2026-10-27 15:00:29.738', '2026-10-27 15:00:29.739', NULL, NULL, NULL),
	(95, 't43yjplhuc2hwy4t1g18eiw4', 'plugin::content-manager.explorer.read', '{}', 'plugin::upload.folder', '{"fields": ["name", "pathId", "parent", "children", "files", "path"]}', '[]', '2026-10-27 15:00:29.752', '2026-10-27 15:00:29.752', '2026-10-27 15:00:29.752', NULL, NULL, NULL),
	(96, 'zm0fy3sv5xq2y2r6dmgg6tpp', 'plugin::content-manager.explorer.read', '{}', 'plugin::i18n.locale', '{"fields": ["name", "code"]}', '[]', '2026-10-27 15:00:29.766', '2026-10-27 15:00:29.766', '2026-10-27 15:00:29.766', NULL, NULL, NULL),
	(97, 'ccwk8axv8dh1c4s9fz566tz0', 'plugin::content-manager.explorer.read', '{}', 'plugin::content-releases.release', '{"fields": ["name", "releasedAt", "scheduledAt", "timezone", "status", "actions"]}', '[]', '2026-10-27 15:00:29.778', '2026-10-27 15:00:29.778', '2026-10-27 15:00:29.778', NULL, NULL, NULL),
	(99, 'pytjk73j7tqek48yfv8kko3k', 'plugin::content-manager.explorer.read', '{}', 'plugin::review-workflows.workflow', '{"fields": ["name", "stages", "stageRequiredToPublish", "contentTypes"]}', '[]', '2026-10-27 15:00:29.802', '2026-10-27 15:00:29.802', '2026-10-27 15:00:29.803', NULL, NULL, NULL);
INSERT INTO public.admin_permissions VALUES
	(100, 'kkp2bsook19mcu2586i5gnbs', 'plugin::content-manager.explorer.read', '{}', 'plugin::review-workflows.workflow-stage', '{"fields": ["name", "color", "workflow", "permissions"]}', '[]', '2026-10-27 15:00:29.815', '2026-10-27 15:00:29.815', '2026-10-27 15:00:29.816', NULL, NULL, NULL),
	(101, 'yjs3jlwjiu9r5zkfvif12f8o', 'plugin::content-manager.explorer.read', '{}', 'plugin::users-permissions.permission', '{"fields": ["action", "role"]}', '[]', '2026-10-27 15:00:29.829', '2026-10-27 15:00:29.829', '2026-10-27 15:00:29.829', NULL, NULL, NULL),
	(102, 'x5dqch9rs2l1hyn8orkhrifz', 'plugin::content-manager.explorer.read', '{}', 'plugin::users-permissions.role', '{"fields": ["name", "description", "type", "permissions", "users"]}', '[]', '2026-10-27 15:00:29.841', '2026-10-27 15:00:29.841', '2026-10-27 15:00:29.841', NULL, NULL, NULL),
	(103, 'jh4qdk78n18wj5jh2e4yiiii', 'plugin::content-manager.explorer.read', '{}', 'plugin::users-permissions.user', '{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role", "displayName", "avatar", "bio", "discussions", "replies", "interests", "usefulDiscussions", "followedDiscussions", "usefulReplies", "communityRole", "avatarColor", "subscriber", "expertTitle", "points", "monthPoints", "monthKey", "streak", "badges", "stats", "blogPosts", "blogComments", "usefulBlogPosts", "usefulBlogComments", "events"]}', '[]', '2026-10-27 15:00:29.852', '2026-10-27 15:00:29.852', '2026-10-27 15:00:29.852', NULL, NULL, NULL),
	(104, 'smei8rsikbdaw82w6gg3m7ub', 'plugin::content-manager.explorer.read', '{}', 'api::blog-comment.blog-comment', '{"fields": ["content", "author", "post", "usefulBase", "usefulBy"]}', '[]', '2026-10-27 15:00:29.866', '2026-10-27 15:00:29.866', '2026-10-27 15:00:29.866', NULL, NULL, NULL),
	(105, 'ibsp7i8ulwiv8e9oe9z8txem', 'plugin::content-manager.explorer.read', '{}', 'api::blog-post.blog-post', '{"fields": ["title", "content", "author", "category", "views", "usefulBase", "usefulBy", "comments"]}', '[]', '2026-10-27 15:00:29.878', '2026-10-27 15:00:29.878', '2026-10-27 15:00:29.878', NULL, NULL, NULL),
	(106, 'z9lc3qevka7254tb0y2ktkl6', 'plugin::content-manager.explorer.read', '{}', 'api::category.category', '{"fields": ["name", "slug", "description", "icon", "color", "siteSection", "discussions"]}', '[]', '2026-10-27 15:00:29.89', '2026-10-27 15:00:29.89', '2026-10-27 15:00:29.89', NULL, NULL, NULL),
	(107, 'rnng2jy8gw03p6ebvj0ba48j', 'plugin::content-manager.explorer.read', '{}', 'api::discussion.discussion', '{"fields": ["title", "slug", "content", "type", "author", "category", "replies", "article", "pinned", "featured", "views", "pollOptions", "pollVotes", "usefulBy", "followedBy", "usefulBase"]}', '[]', '2026-10-27 15:00:29.903', '2026-10-27 15:00:29.903', '2026-10-27 15:00:29.903', NULL, NULL, NULL),
	(108, 'blafy5hv4473vae4dmgoifko', 'plugin::content-manager.explorer.read', '{}', 'api::event.event', '{"fields": ["title", "host", "startsAt", "category", "goingBase", "attendees"]}', '[]', '2026-10-27 15:00:29.915', '2026-10-27 15:00:29.915', '2026-10-27 15:00:29.916', NULL, NULL, NULL),
	(109, 'tqv2q28jz58cgvasfj1r9kz9', 'plugin::content-manager.explorer.read', '{}', 'api::notification.notification', '{"fields": ["recipient", "kind", "actor", "discussion", "blogPost", "badge", "text", "read"]}', '[]', '2026-10-27 15:00:29.927', '2026-10-27 15:00:29.927', '2026-10-27 15:00:29.928', NULL, NULL, NULL),
	(110, 'ggtetc1iqzbmyd2axc8gtne3', 'plugin::content-manager.explorer.read', '{}', 'api::reply.reply', '{"fields": ["content", "isBestAnswer", "author", "discussion", "verified", "usefulBy", "usefulBase"]}', '[]', '2026-10-27 15:00:29.939', '2026-10-27 15:00:29.939', '2026-10-27 15:00:29.939', NULL, NULL, NULL),
	(111, 'x9aqjxx9l1eb6my0bfk1d8o4', 'plugin::content-manager.explorer.read', '{}', 'api::reward.reward', '{"fields": ["key", "recipient", "points", "reason"]}', '[]', '2026-10-27 15:00:29.952', '2026-10-27 15:00:29.952', '2026-10-27 15:00:29.952', NULL, NULL, NULL),
	(112, 'kand7hm850qu4535yijm8a1n', 'plugin::content-manager.explorer.read', '{}', 'admin::permission', '{"fields": ["action", "actionParameters", "subject", "properties", "conditions", "role", "apiToken"]}', '[]', '2026-10-27 15:00:29.965', '2026-10-27 15:00:29.965', '2026-10-27 15:00:29.965', NULL, NULL, NULL),
	(113, 'n8388sifigpnx1i8gu0tcong', 'plugin::content-manager.explorer.read', '{}', 'admin::user', '{"fields": ["firstname", "lastname", "username", "email", "password", "resetPasswordToken", "resetPasswordTokenExpiresAt", "registrationToken", "isActive", "roles", "apiTokens", "blocked", "preferedLanguage"]}', '[]', '2026-10-27 15:00:29.977', '2026-10-27 15:00:29.977', '2026-10-27 15:00:29.977', NULL, NULL, NULL),
	(114, 'rsfzoyjaucwj9qhnrwswi2m7', 'plugin::content-manager.explorer.read', '{}', 'admin::role', '{"fields": ["name", "code", "description", "users", "permissions"]}', '[]', '2026-10-27 15:00:29.989', '2026-10-27 15:00:29.989', '2026-10-27 15:00:29.989', NULL, NULL, NULL),
	(115, 'lffnsrmdcrx29ir71xf34uif', 'plugin::content-manager.explorer.read', '{}', 'admin::api-token', '{"fields": ["name", "description", "kind", "type", "accessKey", "encryptedKey", "lastUsedAt", "permissions", "adminPermissions", "adminUserOwner", "expiresAt", "lifespan"]}', '[]', '2026-10-27 15:00:30.002', '2026-10-27 15:00:30.002', '2026-10-27 15:00:30.002', NULL, NULL, NULL),
	(116, 'zftib0zhp9amepvzlpxmm0kw', 'plugin::content-manager.explorer.read', '{}', 'admin::api-token-permission', '{"fields": ["action", "token"]}', '[]', '2026-10-27 15:00:30.015', '2026-10-27 15:00:30.015', '2026-10-27 15:00:30.015', NULL, NULL, NULL),
	(117, 'tdlnep1ac6uve3wvmhrg3tmg', 'plugin::content-manager.explorer.read', '{}', 'admin::transfer-token', '{"fields": ["name", "description", "accessKey", "lastUsedAt", "permissions", "expiresAt", "lifespan"]}', '[]', '2026-10-27 15:00:30.026', '2026-10-27 15:00:30.026', '2026-10-27 15:00:30.027', NULL, NULL, NULL),
	(118, 's92tvfuw8y0f7fazhh2zozh1', 'plugin::content-manager.explorer.read', '{}', 'admin::transfer-token-permission', '{"fields": ["action", "token"]}', '[]', '2026-10-27 15:00:30.041', '2026-10-27 15:00:30.041', '2026-10-27 15:00:30.041', NULL, NULL, NULL),
	(119, 'qtt4jpu1xgyaq8q1euarhpu5', 'plugin::content-manager.explorer.read', '{}', 'admin::session', '{"fields": ["userId", "sessionId", "childId", "deviceId", "origin", "expiresAt", "absoluteExpiresAt", "status", "type", "metadata"]}', '[]', '2026-10-27 15:00:30.053', '2026-10-27 15:00:30.053', '2026-10-27 15:00:30.053', NULL, NULL, NULL),
	(120, 'icu87ewjtud1pz6nhjr58egf', 'plugin::content-manager.explorer.update', '{}', 'plugin::users-permissions.user', '{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role", "displayName", "avatar", "bio", "discussions", "replies", "interests", "usefulDiscussions", "followedDiscussions", "usefulReplies", "communityRole", "avatarColor", "subscriber", "expertTitle", "points", "monthPoints", "monthKey", "streak", "badges", "stats", "blogPosts", "blogComments", "usefulBlogPosts", "usefulBlogComments", "events"]}', '[]', '2026-10-27 15:00:30.065', '2026-10-27 15:00:30.065', '2026-10-27 15:00:30.065', NULL, NULL, NULL),
	(121, 'epiw0tqnm8j0q0t1j6h5r66v', 'plugin::content-manager.explorer.update', '{}', 'api::blog-comment.blog-comment', '{"fields": ["content", "author", "post", "usefulBase", "usefulBy"]}', '[]', '2026-10-27 15:00:30.077', '2026-10-27 15:00:30.077', '2026-10-27 15:00:30.077', NULL, NULL, NULL),
	(122, 'ewryk6unhr80y4rfhstm6zkb', 'plugin::content-manager.explorer.update', '{}', 'api::blog-post.blog-post', '{"fields": ["title", "content", "author", "category", "views", "usefulBase", "usefulBy", "comments"]}', '[]', '2026-10-27 15:00:30.088', '2026-10-27 15:00:30.088', '2026-10-27 15:00:30.089', NULL, NULL, NULL),
	(123, 'po28epwwsrovlpnhbse7s03k', 'plugin::content-manager.explorer.update', '{}', 'api::category.category', '{"fields": ["name", "slug", "description", "icon", "color", "siteSection", "discussions"]}', '[]', '2026-10-27 15:00:30.101', '2026-10-27 15:00:30.101', '2026-10-27 15:00:30.101', NULL, NULL, NULL),
	(124, 'rnhxyligzp84w1hy5kg7axvl', 'plugin::content-manager.explorer.update', '{}', 'api::discussion.discussion', '{"fields": ["title", "slug", "content", "type", "author", "category", "replies", "article", "pinned", "featured", "views", "pollOptions", "pollVotes", "usefulBy", "followedBy", "usefulBase"]}', '[]', '2026-10-27 15:00:30.114', '2026-10-27 15:00:30.114', '2026-10-27 15:00:30.114', NULL, NULL, NULL),
	(125, 'zb5xw2e24bs4nc4r0upludlu', 'plugin::content-manager.explorer.update', '{}', 'api::event.event', '{"fields": ["title", "host", "startsAt", "category", "goingBase", "attendees"]}', '[]', '2026-10-27 15:00:30.128', '2026-10-27 15:00:30.128', '2026-10-27 15:00:30.128', NULL, NULL, NULL),
	(177, 'cwkxktugqxg18j859ttwhvlq', 'admin::webhooks.delete', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.817', '2026-10-27 15:00:30.817', '2026-10-27 15:00:30.818', NULL, NULL, NULL),
	(126, 'myeh9np17mscd9w6s3vse4sf', 'plugin::content-manager.explorer.update', '{}', 'api::notification.notification', '{"fields": ["recipient", "kind", "actor", "discussion", "blogPost", "badge", "text", "read"]}', '[]', '2026-10-27 15:00:30.139', '2026-10-27 15:00:30.139', '2026-10-27 15:00:30.14', NULL, NULL, NULL),
	(127, 'fajup8r5alojv97yg0jgdryk', 'plugin::content-manager.explorer.update', '{}', 'api::reply.reply', '{"fields": ["content", "isBestAnswer", "author", "discussion", "verified", "usefulBy", "usefulBase"]}', '[]', '2026-10-27 15:00:30.152', '2026-10-27 15:00:30.152', '2026-10-27 15:00:30.152', NULL, NULL, NULL),
	(128, 'yuwfdwve9iuh8bgsdfkupab5', 'plugin::content-manager.explorer.update', '{}', 'api::reward.reward', '{"fields": ["key", "recipient", "points", "reason"]}', '[]', '2026-10-27 15:00:30.165', '2026-10-27 15:00:30.165', '2026-10-27 15:00:30.165', NULL, NULL, NULL),
	(129, 'mbztth9oa3gbnuz3915yl1bh', 'plugin::content-manager.explorer.delete', '{}', 'plugin::users-permissions.user', '{}', '[]', '2026-10-27 15:00:30.177', '2026-10-27 15:00:30.177', '2026-10-27 15:00:30.177', NULL, NULL, NULL),
	(130, 'dgt1qg1iv04wes6addn5hzcn', 'plugin::content-manager.explorer.delete', '{}', 'api::blog-comment.blog-comment', '{}', '[]', '2026-10-27 15:00:30.187', '2026-10-27 15:00:30.187', '2026-10-27 15:00:30.187', NULL, NULL, NULL),
	(131, 'fzkf4q54u2hsaih0hy4vomc4', 'plugin::content-manager.explorer.delete', '{}', 'api::blog-post.blog-post', '{}', '[]', '2026-10-27 15:00:30.199', '2026-10-27 15:00:30.199', '2026-10-27 15:00:30.199', NULL, NULL, NULL),
	(132, 'ow2lnfb94f3sama6wwba7lud', 'plugin::content-manager.explorer.delete', '{}', 'api::category.category', '{}', '[]', '2026-10-27 15:00:30.21', '2026-10-27 15:00:30.21', '2026-10-27 15:00:30.21', NULL, NULL, NULL),
	(133, 'a211ibew66kl6cj5vu9yvbem', 'plugin::content-manager.explorer.delete', '{}', 'api::discussion.discussion', '{}', '[]', '2026-10-27 15:00:30.221', '2026-10-27 15:00:30.221', '2026-10-27 15:00:30.221', NULL, NULL, NULL),
	(134, 'a4pfssaafvifiq76eot6pqgq', 'plugin::content-manager.explorer.delete', '{}', 'api::event.event', '{}', '[]', '2026-10-27 15:00:30.233', '2026-10-27 15:00:30.233', '2026-10-27 15:00:30.233', NULL, NULL, NULL),
	(135, 'pcs5l83va6wu0jbah06z1zum', 'plugin::content-manager.explorer.delete', '{}', 'api::notification.notification', '{}', '[]', '2026-10-27 15:00:30.245', '2026-10-27 15:00:30.245', '2026-10-27 15:00:30.245', NULL, NULL, NULL),
	(136, 'itqs39opkeh96mfjng5rtf77', 'plugin::content-manager.explorer.delete', '{}', 'api::reply.reply', '{}', '[]', '2026-10-27 15:00:30.257', '2026-10-27 15:00:30.257', '2026-10-27 15:00:30.257', NULL, NULL, NULL),
	(137, 'e7fg5188s0jbqcvps0olutnj', 'plugin::content-manager.explorer.delete', '{}', 'api::reward.reward', '{}', '[]', '2026-10-27 15:00:30.271', '2026-10-27 15:00:30.271', '2026-10-27 15:00:30.271', NULL, NULL, NULL),
	(138, 'sjs05mjtsgkqob8f8kis95kn', 'plugin::content-manager.explorer.publish', '{}', 'plugin::users-permissions.user', '{}', '[]', '2026-10-27 15:00:30.282', '2026-10-27 15:00:30.282', '2026-10-27 15:00:30.282', NULL, NULL, NULL),
	(139, 'lw5qm7pju0mygq2afvgpuonn', 'plugin::content-manager.explorer.publish', '{}', 'api::blog-comment.blog-comment', '{}', '[]', '2026-10-27 15:00:30.294', '2026-10-27 15:00:30.294', '2026-10-27 15:00:30.294', NULL, NULL, NULL),
	(140, 'ssbddtv5456nc1r88la11ed5', 'plugin::content-manager.explorer.publish', '{}', 'api::blog-post.blog-post', '{}', '[]', '2026-10-27 15:00:30.304', '2026-10-27 15:00:30.304', '2026-10-27 15:00:30.304', NULL, NULL, NULL),
	(141, 'ib95hso1p594yja438ygmiru', 'plugin::content-manager.explorer.publish', '{}', 'api::category.category', '{}', '[]', '2026-10-27 15:00:30.317', '2026-10-27 15:00:30.317', '2026-10-27 15:00:30.317', NULL, NULL, NULL),
	(142, 'h6prfptpibzo13vo41w9qdzx', 'plugin::content-manager.explorer.publish', '{}', 'api::discussion.discussion', '{}', '[]', '2026-10-27 15:00:30.329', '2026-10-27 15:00:30.329', '2026-10-27 15:00:30.329', NULL, NULL, NULL),
	(143, 'j3piwacxjjl3k4hrzha3x4g2', 'plugin::content-manager.explorer.publish', '{}', 'api::event.event', '{}', '[]', '2026-10-27 15:00:30.341', '2026-10-27 15:00:30.341', '2026-10-27 15:00:30.341', NULL, NULL, NULL),
	(144, 'v3czg4ljuzwan8rs6atpt644', 'plugin::content-manager.explorer.publish', '{}', 'api::notification.notification', '{}', '[]', '2026-10-27 15:00:30.354', '2026-10-27 15:00:30.354', '2026-10-27 15:00:30.354', NULL, NULL, NULL),
	(145, 'rdgfsdeoov0eh9bcvccsps3p', 'plugin::content-manager.explorer.publish', '{}', 'api::reply.reply', '{}', '[]', '2026-10-27 15:00:30.366', '2026-10-27 15:00:30.366', '2026-10-27 15:00:30.366', NULL, NULL, NULL),
	(146, 'eqjc85geka638vx2lgi3a1q4', 'plugin::content-manager.explorer.publish', '{}', 'api::reward.reward', '{}', '[]', '2026-10-27 15:00:30.377', '2026-10-27 15:00:30.377', '2026-10-27 15:00:30.377', NULL, NULL, NULL),
	(147, 'gdwxt7wfp0c7i5p975y0yybm', 'plugin::content-manager.single-types.configure-view', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.389', '2026-10-27 15:00:30.389', '2026-10-27 15:00:30.39', NULL, NULL, NULL),
	(148, 'xpz33tkw5wg1h9bailtu22w8', 'plugin::content-manager.collection-types.configure-view', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.401', '2026-10-27 15:00:30.401', '2026-10-27 15:00:30.401', NULL, NULL, NULL),
	(149, 'e3xd6lerk4azx9m6z2m9a0os', 'plugin::content-manager.components.configure-layout', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.415', '2026-10-27 15:00:30.415', '2026-10-27 15:00:30.415', NULL, NULL, NULL),
	(150, 'a87577sfpq66q16vfm1r99eg', 'plugin::content-type-builder.read', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.427', '2026-10-27 15:00:30.427', '2026-10-27 15:00:30.427', NULL, NULL, NULL),
	(151, 'mez3gi97q47s4726d6szgms7', 'plugin::email.settings.read', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.437', '2026-10-27 15:00:30.437', '2026-10-27 15:00:30.437', NULL, NULL, NULL),
	(152, 'o0fbwxqgiqqcwrfo1y7fjx5p', 'plugin::upload.read', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.449', '2026-10-27 15:00:30.449', '2026-10-27 15:00:30.449', NULL, NULL, NULL),
	(153, 'zi7ntz4kygygq9b0reatr748', 'plugin::upload.assets.create', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.462', '2026-10-27 15:00:30.462', '2026-10-27 15:00:30.462', NULL, NULL, NULL),
	(154, 'eipezfs71n3uqpvt3poexifp', 'plugin::upload.assets.update', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.473', '2026-10-27 15:00:30.473', '2026-10-27 15:00:30.473', NULL, NULL, NULL),
	(155, 'fej73epkr0o0hjgshfjs1hhx', 'plugin::upload.assets.download', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.491', '2026-10-27 15:00:30.491', '2026-10-27 15:00:30.492', NULL, NULL, NULL),
	(156, 'a3ngc95eqsifbhzd4b71v9jp', 'plugin::upload.assets.copy-link', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.506', '2026-10-27 15:00:30.506', '2026-10-27 15:00:30.506', NULL, NULL, NULL),
	(157, 'vs74hb8t9ha6wjwpy9xpw4ca', 'plugin::upload.configure-view', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.52', '2026-10-27 15:00:30.52', '2026-10-27 15:00:30.52', NULL, NULL, NULL),
	(158, 'jhwuv3hrxcgkoc7adsal55cm', 'plugin::upload.settings.read', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.535', '2026-10-27 15:00:30.535', '2026-10-27 15:00:30.535', NULL, NULL, NULL),
	(159, 'bp5mzxmi1fn8orss8omfd1n3', 'plugin::i18n.locale.create', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.553', '2026-10-27 15:00:30.553', '2026-10-27 15:00:30.554', NULL, NULL, NULL),
	(160, 'kspf01gchehfmp6igkxua3yk', 'plugin::i18n.locale.read', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.569', '2026-10-27 15:00:30.569', '2026-10-27 15:00:30.569', NULL, NULL, NULL),
	(161, 't1h77aa3iogznbshz6vf4n70', 'plugin::i18n.locale.update', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.583', '2026-10-27 15:00:30.583', '2026-10-27 15:00:30.583', NULL, NULL, NULL),
	(162, 'f66wabc0ggsvs5y9pe4av3k5', 'plugin::i18n.locale.delete', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.597', '2026-10-27 15:00:30.597', '2026-10-27 15:00:30.597', NULL, NULL, NULL),
	(163, 'p9nkaflebtv989ppa2xap8g6', 'plugin::users-permissions.roles.create', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.612', '2026-10-27 15:00:30.612', '2026-10-27 15:00:30.612', NULL, NULL, NULL),
	(164, 'pb4wesdvxsxv0kiat1wkp7eo', 'plugin::users-permissions.roles.read', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.628', '2026-10-27 15:00:30.628', '2026-10-27 15:00:30.628', NULL, NULL, NULL),
	(165, 'xw6lew9rnardo4l57vhgic8h', 'plugin::users-permissions.roles.update', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.642', '2026-10-27 15:00:30.642', '2026-10-27 15:00:30.643', NULL, NULL, NULL),
	(166, 'ujxslosw2on7reuovw63qc65', 'plugin::users-permissions.roles.delete', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.657', '2026-10-27 15:00:30.657', '2026-10-27 15:00:30.657', NULL, NULL, NULL),
	(167, 'osd498b1ihcme5y7mu61zfbd', 'plugin::users-permissions.providers.read', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.67', '2026-10-27 15:00:30.67', '2026-10-27 15:00:30.67', NULL, NULL, NULL),
	(168, 'jmjmz596toun9b3nn9ov90y9', 'plugin::users-permissions.providers.update', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.685', '2026-10-27 15:00:30.685', '2026-10-27 15:00:30.685', NULL, NULL, NULL),
	(169, 'hzjujnafde8kyb5u7vi8ld7w', 'plugin::users-permissions.email-templates.read', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.699', '2026-10-27 15:00:30.699', '2026-10-27 15:00:30.699', NULL, NULL, NULL),
	(170, 'l8ho87v5pvekqo8qdy21mzrt', 'plugin::users-permissions.email-templates.update', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.714', '2026-10-27 15:00:30.714', '2026-10-27 15:00:30.714', NULL, NULL, NULL),
	(171, 'icfyanlhutgczkmrl84fyhnr', 'plugin::users-permissions.advanced-settings.read', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.728', '2026-10-27 15:00:30.728', '2026-10-27 15:00:30.729', NULL, NULL, NULL),
	(172, 'liskaw91jsp0nj1us54lvasy', 'plugin::users-permissions.advanced-settings.update', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.746', '2026-10-27 15:00:30.746', '2026-10-27 15:00:30.746', NULL, NULL, NULL),
	(173, 'xsl8b4nbntvjd5ubgtmwhzfp', 'admin::marketplace.read', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.76', '2026-10-27 15:00:30.76', '2026-10-27 15:00:30.761', NULL, NULL, NULL),
	(174, 'deq4gu7f2wtf869tzaook97x', 'admin::webhooks.create', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.774', '2026-10-27 15:00:30.774', '2026-10-27 15:00:30.775', NULL, NULL, NULL),
	(175, 'k6sj6anmwk0o9n99jywt2fla', 'admin::webhooks.read', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.789', '2026-10-27 15:00:30.789', '2026-10-27 15:00:30.789', NULL, NULL, NULL),
	(176, 'zg51x09h6amy2nfy7usdkoor', 'admin::webhooks.update', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.803', '2026-10-27 15:00:30.803', '2026-10-27 15:00:30.803', NULL, NULL, NULL),
	(179, 'bedkytrdqmwi7jb1psux0d6f', 'admin::users.read', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.848', '2026-10-27 15:00:30.848', '2026-10-27 15:00:30.848', NULL, NULL, NULL),
	(180, 'za67xy87vhu8u2u242bqkb56', 'admin::users.update', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.864', '2026-10-27 15:00:30.864', '2026-10-27 15:00:30.864', NULL, NULL, NULL),
	(181, 's0kjbuk0ay4xtpb8aitw0uhs', 'admin::users.delete', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.88', '2026-10-27 15:00:30.88', '2026-10-27 15:00:30.88', NULL, NULL, NULL),
	(182, 'nee7qlhimh6haxahxx19byr9', 'admin::roles.create', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.895', '2026-10-27 15:00:30.895', '2026-10-27 15:00:30.895', NULL, NULL, NULL),
	(183, 'hf0txbnhshkn55nacc5jhqfx', 'admin::roles.read', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.909', '2026-10-27 15:00:30.909', '2026-10-27 15:00:30.909', NULL, NULL, NULL),
	(184, 'js3zw5gjhrpbnlin9mupo886', 'admin::roles.update', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.923', '2026-10-27 15:00:30.923', '2026-10-27 15:00:30.923', NULL, NULL, NULL),
	(185, 'p3p9xu80lhebnpnl0qq7astt', 'admin::roles.delete', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.936', '2026-10-27 15:00:30.936', '2026-10-27 15:00:30.936', NULL, NULL, NULL),
	(186, 'hf9odnfz1r45rlw2nn7wjv9p', 'admin::api-tokens.access', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.95', '2026-10-27 15:00:30.95', '2026-10-27 15:00:30.951', NULL, NULL, NULL),
	(187, 'pf3vp0wp98u8cc5py15lhz25', 'admin::admin-tokens.access', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.965', '2026-10-27 15:00:30.965', '2026-10-27 15:00:30.965', NULL, NULL, NULL),
	(188, 'x0cpp2s4kq1czrrp2fepmkfj', 'admin::admin-tokens.create', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.98', '2026-10-27 15:00:30.98', '2026-10-27 15:00:30.98', NULL, NULL, NULL),
	(189, 'oo0sljyrpk661p5t8zdf8c1z', 'admin::admin-tokens.read', '{}', NULL, '{}', '[]', '2026-10-27 15:00:30.993', '2026-10-27 15:00:30.993', '2026-10-27 15:00:30.993', NULL, NULL, NULL),
	(190, 'z3at8ovqogrsz2mf9ktpfyor', 'admin::admin-tokens.update', '{}', NULL, '{}', '[]', '2026-10-27 15:00:31.008', '2026-10-27 15:00:31.008', '2026-10-27 15:00:31.008', NULL, NULL, NULL),
	(191, 't1ukhr0gc3hh165kzjbm4fkg', 'admin::admin-tokens.regenerate', '{}', NULL, '{}', '[]', '2026-10-27 15:00:31.022', '2026-10-27 15:00:31.022', '2026-10-27 15:00:31.022', NULL, NULL, NULL),
	(192, 'omi8f4srm3s2u5ho4rx2lmi3', 'admin::admin-tokens.delete', '{}', NULL, '{}', '[]', '2026-10-27 15:00:31.039', '2026-10-27 15:00:31.039', '2026-10-27 15:00:31.039', NULL, NULL, NULL),
	(193, 'r8khrlzimkxul9et45eu8i7c', 'admin::api-tokens.create', '{}', NULL, '{}', '[]', '2026-10-27 15:00:31.055', '2026-10-27 15:00:31.055', '2026-10-27 15:00:31.056', NULL, NULL, NULL),
	(194, 'rdez613s83iuegmqo2arzbtp', 'admin::api-tokens.read', '{}', NULL, '{}', '[]', '2026-10-27 15:00:31.072', '2026-10-27 15:00:31.072', '2026-10-27 15:00:31.072', NULL, NULL, NULL),
	(195, 'cfxggrcd39aa5v0cog3tmdie', 'admin::api-tokens.update', '{}', NULL, '{}', '[]', '2026-10-27 15:00:31.09', '2026-10-27 15:00:31.09', '2026-10-27 15:00:31.09', NULL, NULL, NULL),
	(196, 'zk7fml7mtz39io11xoqf8ajd', 'admin::api-tokens.regenerate', '{}', NULL, '{}', '[]', '2026-10-27 15:00:31.107', '2026-10-27 15:00:31.107', '2026-10-27 15:00:31.107', NULL, NULL, NULL),
	(197, 'eyf4zo40zhsvmsvt3e2ua8mg', 'admin::api-tokens.delete', '{}', NULL, '{}', '[]', '2026-10-27 15:00:31.12', '2026-10-27 15:00:31.12', '2026-10-27 15:00:31.121', NULL, NULL, NULL),
	(198, 'qn47cq13mzmxua7un2vs95p7', 'admin::project-settings.update', '{}', NULL, '{}', '[]', '2026-10-27 15:00:31.137', '2026-10-27 15:00:31.137', '2026-10-27 15:00:31.137', NULL, NULL, NULL),
	(199, 'd025jhmmutllienpf978hxew', 'admin::project-settings.read', '{}', NULL, '{}', '[]', '2026-10-27 15:00:31.152', '2026-10-27 15:00:31.152', '2026-10-27 15:00:31.152', NULL, NULL, NULL),
	(200, 'scd4fbarnh6gbnuvgwsyz217', 'admin::debug-dump.read', '{}', NULL, '{}', '[]', '2026-10-27 15:00:31.166', '2026-10-27 15:00:31.166', '2026-10-27 15:00:31.166', NULL, NULL, NULL);
INSERT INTO public.admin_permissions VALUES
	(201, 'i2cgnbeklwues1wdev5gnfd1', 'admin::transfer.tokens.access', '{}', NULL, '{}', '[]', '2026-10-27 15:00:31.18', '2026-10-27 15:00:31.18', '2026-10-27 15:00:31.18', NULL, NULL, NULL),
	(202, 'mj1ulscwmttlnkvorpfyucxj', 'admin::transfer.tokens.create', '{}', NULL, '{}', '[]', '2026-10-27 15:00:31.194', '2026-10-27 15:00:31.194', '2026-10-27 15:00:31.194', NULL, NULL, NULL),
	(203, 'vpt0zppmx22o94ene6adhtwp', 'admin::transfer.tokens.read', '{}', NULL, '{}', '[]', '2026-10-27 15:00:31.206', '2026-10-27 15:00:31.206', '2026-10-27 15:00:31.206', NULL, NULL, NULL),
	(204, 'lg6mxmcv2w7ahw28st1xyhpw', 'admin::transfer.tokens.update', '{}', NULL, '{}', '[]', '2026-10-27 15:00:31.219', '2026-10-27 15:00:31.219', '2026-10-27 15:00:31.219', NULL, NULL, NULL),
	(205, 'dj398gwmptv35r365qs9zk9a', 'admin::transfer.tokens.regenerate', '{}', NULL, '{}', '[]', '2026-10-27 15:00:31.232', '2026-10-27 15:00:31.232', '2026-10-27 15:00:31.232', NULL, NULL, NULL),
	(206, 'pwan3pguszj5zwrz6urkkqzt', 'admin::transfer.tokens.delete', '{}', NULL, '{}', '[]', '2026-10-27 15:00:31.246', '2026-10-27 15:00:31.246', '2026-10-27 15:00:31.246', NULL, NULL, NULL);


--
-- Data for Name: admin_permissions_role_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.admin_permissions_role_lnk VALUES
	(1, 1, 2, 1),
	(2, 2, 2, 2),
	(3, 3, 2, 3),
	(4, 4, 2, 4),
	(5, 5, 2, 5),
	(6, 6, 2, 6),
	(7, 7, 2, 7),
	(8, 8, 2, 8),
	(9, 9, 2, 9),
	(10, 10, 2, 10),
	(11, 11, 2, 11),
	(12, 12, 2, 12),
	(13, 13, 2, 13),
	(14, 14, 2, 14),
	(15, 15, 2, 15),
	(16, 16, 2, 16),
	(17, 17, 2, 17),
	(18, 18, 2, 18),
	(19, 19, 2, 19),
	(20, 20, 2, 20),
	(21, 21, 2, 21),
	(22, 22, 2, 22),
	(23, 23, 2, 23),
	(24, 24, 2, 24),
	(25, 25, 2, 25),
	(26, 26, 2, 26),
	(27, 27, 2, 27),
	(28, 28, 2, 28),
	(29, 29, 2, 29),
	(30, 30, 2, 30),
	(31, 31, 2, 31),
	(32, 32, 2, 32),
	(33, 33, 2, 33),
	(34, 34, 2, 34),
	(35, 35, 2, 35),
	(36, 36, 2, 36),
	(37, 37, 2, 37),
	(38, 38, 2, 38),
	(39, 39, 2, 39),
	(40, 40, 2, 40),
	(41, 41, 2, 41),
	(42, 42, 2, 42),
	(43, 43, 2, 43),
	(44, 44, 2, 44),
	(45, 45, 2, 45),
	(46, 46, 2, 46),
	(47, 47, 3, 1),
	(48, 48, 3, 2),
	(49, 49, 3, 3),
	(50, 50, 3, 4),
	(51, 51, 3, 5),
	(52, 52, 3, 6),
	(53, 53, 3, 7),
	(54, 54, 3, 8),
	(55, 55, 3, 9),
	(56, 56, 3, 10),
	(57, 57, 3, 11),
	(58, 58, 3, 12),
	(59, 59, 3, 13),
	(60, 60, 3, 14),
	(61, 61, 3, 15),
	(62, 62, 3, 16),
	(63, 63, 3, 17),
	(64, 64, 3, 18),
	(65, 65, 3, 19),
	(66, 66, 3, 20),
	(67, 67, 3, 21),
	(68, 68, 3, 22),
	(69, 69, 3, 23),
	(70, 70, 3, 24),
	(71, 71, 3, 25),
	(72, 72, 3, 26),
	(73, 73, 3, 27),
	(74, 74, 3, 28),
	(75, 75, 3, 29),
	(76, 76, 3, 30),
	(77, 77, 3, 31),
	(78, 78, 3, 32),
	(79, 79, 3, 33),
	(80, 80, 3, 34),
	(81, 81, 3, 35),
	(82, 82, 3, 36),
	(83, 83, 3, 37),
	(84, 84, 3, 38),
	(85, 85, 1, 1),
	(86, 86, 1, 2),
	(87, 87, 1, 3),
	(88, 88, 1, 4),
	(89, 89, 1, 5),
	(90, 90, 1, 6),
	(91, 91, 1, 7),
	(92, 92, 1, 8),
	(93, 93, 1, 9),
	(94, 94, 1, 10),
	(95, 95, 1, 11),
	(96, 96, 1, 12),
	(97, 97, 1, 13),
	(98, 98, 1, 14),
	(99, 99, 1, 15),
	(100, 100, 1, 16);
INSERT INTO public.admin_permissions_role_lnk VALUES
	(101, 101, 1, 17),
	(102, 102, 1, 18),
	(103, 103, 1, 19),
	(104, 104, 1, 20),
	(105, 105, 1, 21),
	(106, 106, 1, 22),
	(107, 107, 1, 23),
	(108, 108, 1, 24),
	(109, 109, 1, 25),
	(110, 110, 1, 26),
	(111, 111, 1, 27),
	(112, 112, 1, 28),
	(113, 113, 1, 29),
	(114, 114, 1, 30),
	(115, 115, 1, 31),
	(116, 116, 1, 32),
	(117, 117, 1, 33),
	(118, 118, 1, 34),
	(119, 119, 1, 35),
	(120, 120, 1, 36),
	(121, 121, 1, 37),
	(122, 122, 1, 38),
	(123, 123, 1, 39),
	(124, 124, 1, 40),
	(125, 125, 1, 41),
	(126, 126, 1, 42),
	(127, 127, 1, 43),
	(128, 128, 1, 44),
	(129, 129, 1, 45),
	(130, 130, 1, 46),
	(131, 131, 1, 47),
	(132, 132, 1, 48),
	(133, 133, 1, 49),
	(134, 134, 1, 50),
	(135, 135, 1, 51),
	(136, 136, 1, 52),
	(137, 137, 1, 53),
	(138, 138, 1, 54),
	(139, 139, 1, 55),
	(140, 140, 1, 56),
	(141, 141, 1, 57),
	(142, 142, 1, 58),
	(143, 143, 1, 59),
	(144, 144, 1, 60),
	(145, 145, 1, 61),
	(146, 146, 1, 62),
	(147, 147, 1, 63),
	(148, 148, 1, 64),
	(149, 149, 1, 65),
	(150, 150, 1, 66),
	(151, 151, 1, 67),
	(152, 152, 1, 68),
	(153, 153, 1, 69),
	(154, 154, 1, 70),
	(155, 155, 1, 71),
	(156, 156, 1, 72),
	(157, 157, 1, 73),
	(158, 158, 1, 74),
	(159, 159, 1, 75),
	(160, 160, 1, 76),
	(161, 161, 1, 77),
	(162, 162, 1, 78),
	(163, 163, 1, 79),
	(164, 164, 1, 80),
	(165, 165, 1, 81),
	(166, 166, 1, 82),
	(167, 167, 1, 83),
	(168, 168, 1, 84),
	(169, 169, 1, 85),
	(170, 170, 1, 86),
	(171, 171, 1, 87),
	(172, 172, 1, 88),
	(173, 173, 1, 89),
	(174, 174, 1, 90),
	(175, 175, 1, 91),
	(176, 176, 1, 92),
	(177, 177, 1, 93),
	(178, 178, 1, 94),
	(179, 179, 1, 95),
	(180, 180, 1, 96),
	(181, 181, 1, 97),
	(182, 182, 1, 98),
	(183, 183, 1, 99),
	(184, 184, 1, 100),
	(185, 185, 1, 101),
	(186, 186, 1, 102),
	(187, 187, 1, 103),
	(188, 188, 1, 104),
	(189, 189, 1, 105),
	(190, 190, 1, 106),
	(191, 191, 1, 107),
	(192, 192, 1, 108),
	(193, 193, 1, 109),
	(194, 194, 1, 110),
	(195, 195, 1, 111),
	(196, 196, 1, 112),
	(197, 197, 1, 113),
	(198, 198, 1, 114),
	(199, 199, 1, 115),
	(200, 200, 1, 116);
INSERT INTO public.admin_permissions_role_lnk VALUES
	(201, 201, 1, 117),
	(202, 202, 1, 118),
	(203, 203, 1, 119),
	(204, 204, 1, 120),
	(205, 205, 1, 121),
	(206, 206, 1, 122);


--
-- Data for Name: admin_roles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.admin_roles VALUES
	(1, 'uebiqsqdjwd79o9ofid9slgh', 'Super Admin', 'strapi-super-admin', 'Super Admins can access and manage all features and settings.', '2026-10-27 15:00:28.291', '2026-10-27 15:00:28.291', '2026-10-27 15:00:28.291', NULL, NULL, NULL),
	(2, 'iekp04un86b3wni9xomqxxmc', 'Editor', 'strapi-editor', 'Editors can manage and publish contents including those of other users.', '2026-10-27 15:00:28.35', '2026-10-27 15:00:28.35', '2026-10-27 15:00:28.35', NULL, NULL, NULL),
	(3, 'v17cfhxh1uruflgv2yv5ngdl', 'Author', 'strapi-author', 'Authors can manage the content they have created.', '2026-10-27 15:00:28.366', '2026-10-27 15:00:28.366', '2026-10-27 15:00:28.366', NULL, NULL, NULL);


--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: admin_users_roles_lnk; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: blog_comments; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.blog_comments VALUES
	(1, 'r45o0pgqrxpj7uacxnpluzto', 'Merci Vincent, ça me conforte dans mon choix. Le point 3 est celui qui me fait le plus peur !', 9, '2026-10-24 15:17:35.487', '2026-10-27 15:00:37.967', '2026-10-27 15:00:37.905', NULL, NULL, NULL),
	(2, 'fud5n15s1h8t5mi4grq3o0ie', 'Tout est juste. J''ajouterais : garder une épargne de précaution à côté, sinon on finit par vendre au pire moment. @Thomas_PEA, ça vaut pour toi aussi !', 14, '2026-10-24 15:34:35.487', '2026-10-27 15:00:38.056', '2026-10-27 15:00:37.979', NULL, NULL, NULL),
	(3, 'zeln0er2v5r61cafagz96lqq', 'Le deuxième point est trop souvent oublié. Merci pour ce partage.', 11, '2026-10-21 15:17:35.487', '2026-10-27 15:00:38.119', '2026-10-27 15:00:38.098', NULL, NULL, NULL),
	(4, 'j2pexmsto3ca1jtou8slgfly', 'Merci, c''est exactement le genre de retour qu''on ne trouve nulle part ailleurs.', 6, '2026-10-21 15:34:35.487', '2026-10-27 15:00:38.196', '2026-10-27 15:00:38.128', NULL, NULL, NULL),
	(5, 'lw2ust0lekngdysway0ewabs', 'Très utile, je garde ça pour dans quelques années. Les retraits programmés, c''est intéressant fiscalement ?', 4, '2026-10-25 15:17:35.487', '2026-10-27 15:00:38.28', '2026-10-27 15:00:38.254', NULL, NULL, NULL),
	(6, 'mre27c5zomqpsutc95ihxg3j', '@Bertrand59 Seule la part de gains contenue dans chaque retrait est imposable, pas le capital versé. Et après huit ans de contrat, un abattement annuel s''applique en plus sur ces gains.', 12, '2026-10-25 15:34:35.487', '2026-10-27 15:00:38.327', '2026-10-27 15:00:38.3', NULL, NULL, NULL),
	(7, 'mw4pjf10jk0jisvjwf6ee7xh', 'Merci pour le point sur le diagnostic énergétique, je l''avais sous-estimé.', 5, '2026-10-18 15:17:35.487', '2026-10-27 15:00:38.424', '2026-10-27 15:00:38.396', NULL, NULL, NULL),
	(8, 'pqso2ldmqls7v66mnp1j7dud', 'Bravo, c''est exactement ce qu''il faut faire. La vérification du relevé de carrière est souvent négligée.', 7, '2026-10-15 15:17:35.487', '2026-10-27 15:00:38.485', '2026-10-27 15:00:38.468', NULL, NULL, NULL);


--
-- Data for Name: blog_comments_author_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.blog_comments_author_lnk VALUES
	(1, 1, 13, 1),
	(2, 2, 4, 1),
	(3, 3, 12, 1),
	(4, 4, 15, 1),
	(5, 5, 10, 1),
	(6, 6, 6, 1),
	(7, 7, 16, 1),
	(8, 8, 5, 1);


--
-- Data for Name: blog_comments_post_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.blog_comments_post_lnk VALUES
	(1, 1, 1, 1),
	(2, 2, 1, 2),
	(3, 3, 2, 1),
	(4, 4, 2, 2),
	(5, 5, 3, 1),
	(6, 6, 3, 2),
	(7, 7, 4, 1),
	(8, 8, 5, 1);


--
-- Data for Name: blog_comments_useful_by_lnk; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: blog_posts; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.blog_posts VALUES
	(1, 'ymuqsj83a2u7y05mj4jmjix0', 'Dix ans d''investissement passif : ce que j''ai appris', 'J''ai commencé à investir en 2015, un peu par hasard, après avoir lu un dossier du Revenu sur les ETF. Dix ans plus tard, voici ce que je retiens.

**1. La régularité bat le talent.** Je verse la même somme chaque mois, quoi qu''il arrive. Je n''ai jamais réussi à deviner le bon moment pour entrer ou sortir, et je ne connais personne qui y arrive durablement.

**2. Les frais comptent plus qu''on ne le croit.** Un point de frais par an, sur vingt ans, c''est une part importante de la performance qui part ailleurs.

**3. Le plus dur, c''est de ne rien faire.** Lors des fortes baisses, j''ai eu envie de tout vendre. Ne pas toucher à mon portefeuille a été ma meilleure décision.

Ce qui n''a pas marché pour moi :
- ajouter des lignes « pour diversifier » alors que mon ETF l''était déjà
- regarder mon portefeuille tous les jours

Je ne dis pas que c''est la bonne méthode pour tout le monde : c''est la mienne, et elle me laisse dormir tranquille.', 1420, 58, '2026-10-24 15:00:35.487', '2026-10-27 15:00:37.892', '2026-10-27 15:00:37.847', NULL, NULL, NULL),
	(2, 'urom3vpnhozl711b9ttomuj0', 'Mes trois pires erreurs en Bourse (et ce qu''elles m''ont appris)', 'Quarante ans de Bourse, ça laisse des souvenirs. Pas tous bons. Je partage ici mes trois plus belles erreurs, en espérant que les plus jeunes les évitent.

**Acheter une valeur parce que tout le monde en parlait.** À la fin des années 1990, j''ai acheté des valeurs technologiques au plus haut, sur la foi des conversations de bureau. J''ai mis des années à m''en remettre.

**Tout miser sur une seule entreprise.** J''ai longtemps gardé une grosse part de mon portefeuille en actions de l''entreprise où je travaillais. Le jour où elle a traversé une crise, mon salaire et mon épargne étaient menacés en même temps.

**Vendre dans la panique.** En 2008, j''ai vendu une partie de mes actions près du point bas, et j''ai raté une bonne partie du rebond.

Ce que j''en retiens : diversifier, ne jamais investir l''argent dont on aura besoin à court terme, et se méfier de ses émotions plus que des marchés.', 2210, 73, '2026-10-21 15:00:35.487', '2026-10-27 15:00:38.089', '2026-10-27 15:00:38.069', NULL, NULL, NULL),
	(3, 'uz2xs5mecat9ekhkf9cabv64', 'Première année de retraite : comment nous avons revu notre budget', 'Il y a un an, mon mari et moi avons pris notre retraite à quelques mois d''intervalle. Voici comment nous avons réorganisé notre budget.

Nous avons d''abord listé toutes nos dépenses de l''année précédente, poste par poste. Surprise : certaines ont baissé (transports, repas à l''extérieur), d''autres ont augmenté (loisirs, aide aux petits-enfants, santé).

**Nos trois décisions :**
- garder l''équivalent de six mois de dépenses sur nos livrets
- faire des retraits programmés sur notre assurance-vie pour compléter les pensions
- revoir tous nos contrats d''assurance, qui n''étaient plus adaptés

Un an après, nous sommes sereins. Le plus important a été d''en parler à deux, chiffres sur la table.', 880, 31, '2026-10-25 15:00:35.487', '2026-10-27 15:00:38.23', '2026-10-27 15:00:38.211', NULL, NULL, NULL),
	(5, 'xs78gkdcbmkehwlkx0z70aff', 'Aider ses parents à préparer leur retraite : notre méthode en famille', 'Mes parents partent à la retraite l''an prochain. Ils se sentaient un peu perdus, alors nous avons pris le sujet en main ensemble, en trois étapes.

**1. Rassembler les informations.** Relevés de carrière, contrats d''épargne, assurances : nous avons tout réuni dans un même dossier.

**2. Vérifier les relevés de carrière.** Nous y avons trouvé deux périodes manquantes, que mes parents ont fait corriger auprès de leur caisse.

**3. Faire une simulation.** Le simulateur officiel leur a donné une première estimation de leurs pensions. Ils ont ensuite pris rendez-vous avec un conseiller pour affiner.

Le plus précieux, finalement : en parler tôt, sans tabou.', 540, 19, '2026-10-15 15:00:35.487', '2026-10-27 15:00:38.457', '2026-10-27 15:00:38.44', NULL, NULL, NULL),
	(4, 'ku0iqcfgvdfq7lzujfqh7b1b', 'Mon troisième investissement locatif, du compromis à la première location', 'Après deux studios, j''ai acheté l''an dernier un deux-pièces dans une ville moyenne. Je raconte les étapes, avec ce que je referais et ce que je changerais.

**La recherche.** Trois mois de visites. J''ai écarté tous les biens au diagnostic énergétique médiocre : les travaux de rénovation et les restrictions de location à venir m''auraient coûté cher.

**Le financement.** J''ai fait jouer la concurrence entre trois banques, avec l''aide d''un courtier. L''assurance emprunteur a fait une vraie différence sur le coût total.

**La mise en location.** Une annonce avec de bonnes photos, des visites groupées, un dossier complet exigé : le logement a été loué en dix jours.

Ce que je changerais : prévoir une marge plus large pour les petits travaux, qui ont dépassé mon budget.', 960, 27, '2026-10-18 15:00:35.487', '2026-10-27 15:00:38.376', '2026-10-27 15:00:38.347', NULL, NULL, NULL);


--
-- Data for Name: blog_posts_author_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.blog_posts_author_lnk VALUES
	(1, 1, 3, 1),
	(2, 2, 4, 1),
	(3, 3, 5, 1),
	(4, 4, 9, 1),
	(5, 5, 17, 1);


--
-- Data for Name: blog_posts_category_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.blog_posts_category_lnk VALUES
	(1, 1, 1),
	(2, 2, 1),
	(3, 3, 7),
	(4, 4, 5),
	(5, 5, 7);


--
-- Data for Name: blog_posts_useful_by_lnk; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.categories VALUES
	(1, 'cgv5cf3ah0yba91r8n8943kv', 'Bourse & actions', 'bourse', 'Actions, ETF, PEA, compte-titres : stratégies et retours d''expérience.', 'candles', '#007aff', 'Réussir en Bourse', '2026-10-27 15:00:32.22', '2026-10-27 15:00:32.22', '2026-10-27 15:00:32.212', NULL, NULL, NULL),
	(2, 'ikk6tl3un6gr5ynmsnssq41g', 'Économie', 'economie', 'Conjoncture, taux, inflation, emploi : l''actualité économique en France, en Europe et dans le monde.', 'globe', '#3d5a80', 'Économie', '2026-10-27 15:00:32.281', '2026-10-27 15:00:32.281', '2026-10-27 15:00:32.276', NULL, NULL, NULL),
	(3, 'jqdq0tqm5tqchj31ccyntenp', 'Épargne & placements', 'epargne', 'Livrets, fonds euros, obligations, comptes à terme.', 'piggy', '#34c759', 'Diversifier vos placements', '2026-10-27 15:00:32.298', '2026-10-27 15:00:32.298', '2026-10-27 15:00:32.294', NULL, NULL, NULL),
	(4, 'bl4rp76kqgu9j7taqvba4g8p', 'Assurance-vie', 'assurance-vie', 'Choisir son contrat, arbitrer, transmettre.', 'umbrella', '#30b0c7', 'Diversifier vos placements', '2026-10-27 15:00:32.315', '2026-10-27 15:00:32.315', '2026-10-27 15:00:32.31', NULL, NULL, NULL),
	(5, 'ezw52opfjwgsm5jgfm0tanqe', 'Immobilier & SCPI', 'immobilier', 'Résidence principale, locatif, SCPI, crédit immobilier.', 'building', '#ff9500', 'Investir dans l''immobilier', '2026-10-27 15:00:32.332', '2026-10-27 15:00:32.332', '2026-10-27 15:00:32.329', NULL, NULL, NULL),
	(6, 'rk319rd86ca5ycs7tmzmz0q4', 'Impôts & fiscalité', 'impots', 'Déclaration, niches fiscales, IFI : payer le juste impôt.', 'receipt', '#5856d6', 'Réduire vos impôts', '2026-10-27 15:00:32.349', '2026-10-27 15:00:32.349', '2026-10-27 15:00:32.344', NULL, NULL, NULL),
	(7, 'cwzp7gzwbj3mjdlpsh9q8b0u', 'Retraite', 'retraite', 'PER, rachat de trimestres, cumul emploi-retraite.', 'armchair', '#ff2d55', 'Diversifier vos placements', '2026-10-27 15:00:32.367', '2026-10-27 15:00:32.367', '2026-10-27 15:00:32.362', NULL, NULL, NULL),
	(8, 'mheoqreldeioh427t4v3y2km', 'Famille & transmission', 'transmission', 'Donation, succession, protection du conjoint.', 'family', '#af52de', 'Préparer une succession', '2026-10-27 15:00:32.387', '2026-10-27 15:00:32.387', '2026-10-27 15:00:32.383', NULL, NULL, NULL),
	(9, 'm3ilvjdceqjtu2urzedeo2sv', 'Or, cryptos & alternatifs', 'alternatifs', 'Or physique, cryptoactifs, forêts, private equity.', 'gem', '#00c7be', 'Diversifier vos placements', '2026-10-27 15:00:32.405', '2026-10-27 15:00:32.405', '2026-10-27 15:00:32.4', NULL, NULL, NULL),
	(10, 'zskaxk527f13jq809fhxgrix', 'Budget & conso', 'budget', 'Banques, crédits, assurances, bons plans.', 'wallet', '#8e8e93', 'Vie pratique', '2026-10-27 15:00:32.418', '2026-10-27 15:00:32.418', '2026-10-27 15:00:32.415', NULL, NULL, NULL),
	(11, 'misobrl3gqe0h9j7ytynj9o3', 'Le Café du Revenu', 'cafe', 'Présentations, discussions libres, idées pour la rédaction.', 'coffee', '#a2845e', NULL, '2026-10-27 15:00:32.434', '2026-10-27 15:00:32.434', '2026-10-27 15:00:32.431', NULL, NULL, NULL);


--
-- Data for Name: discussions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.discussions VALUES
	(1, 'vtq7pm21a3j6ubv4gvm3yfjy', 'Sondage de la semaine : quel est votre placement prioritaire pour les 12 prochains mois ?', 'sondage-de-la-semaine-quel-est-votre-placement-prioritaire-pour-les-12-prochains', 'Votez puis expliquez votre choix en commentaire : les résultats seront commentés dans le prochain numéro.', 'poll', NULL, false, 'poll', 1460, '["Assurance-vie", "Actions / PEA", "Immobilier / SCPI", "Livrets et épargne sans risque", "Or", "Rembourser mes crédits"]', '{"counts": [214, 268, 87, 141, 64, 39], "voters": {}}', 28, '2026-10-26 19:00:35.487', '2026-10-27 15:00:35.535', '2026-10-27 15:00:35.498', NULL, NULL, NULL),
	(2, 'zu3y6e81mbabff6jganfzi1n', 'Combien de lignes avez-vous dans votre PEA ?', 'combien-de-lignes-avez-vous-dans-votre-pea', 'Petit sondage par curiosité. Moi j''en ai 14, et je me demande si ce n''est pas trop !', 'poll', NULL, false, NULL, 820, '["1 à 3", "4 à 10", "11 à 20", "Plus de 20"]', '{"counts": [162, 121, 70, 28], "voters": {}}', 11, '2026-10-24 07:00:35.487', '2026-10-27 15:00:35.74', '2026-10-27 15:00:35.71', NULL, NULL, NULL),
	(3, 'hj6r4yvpd2889gr5sxs4lc2j', 'Bienvenue dans la Communauté du Revenu ! Présentez-vous ici', 'bienvenue-dans-la-communaute-du-revenu-presentez-vous-ici', 'Bonjour à toutes et à tous,

Cet espace est le vôtre : posez vos questions, partagez vos expériences, aidez les autres membres. Les journalistes du Revenu passent chaque jour et répondent aux questions les plus utiles.

**Pour bien démarrer :**
- Présentez-vous en une phrase en réponse à ce message
- Choisissez les espaces qui vous intéressent
- Marquez « Utile » les réponses qui vous aident : c''est ce qui fait remonter les meilleures contributions

Bienvenue !', 'discussion', NULL, true, NULL, 2140, NULL, NULL, 64, '2026-10-18 15:00:35.487', '2026-10-27 15:00:35.856', '2026-10-27 15:00:35.823', NULL, NULL, NULL),
	(4, 'jl036kbjhy1rb3xa6abt3gas', 'Question de la semaine : quel est le meilleur conseil d''argent que vous ayez reçu ?', 'question-de-la-semaine-quel-est-le-meilleur-conseil-d-argent-que-vous-ayez-recu', 'Chaque semaine, la rédaction pose une question à la communauté. Les réponses les plus inspirantes pourront être reprises, avec votre accord, dans la newsletter.

Alors : quel conseil d''argent a changé votre vie ? Qui vous l''a donné ?', 'discussion', NULL, false, 'question', 980, NULL, NULL, 41, '2026-10-26 09:00:35.487', '2026-10-27 15:00:36.004', '2026-10-27 15:00:35.987', NULL, NULL, NULL),
	(5, 'bs70nismjwfx6r1lvccyaxjs', 'Ouvrir un PEA avec 5 000 € : par où commencer ?', 'ouvrir-un-pea-avec-5-000-par-ou-commencer', 'Bonjour, je viens d''ouvrir un PEA en ligne et j''ai 5 000 € à y placer. Je ne connais pas grand-chose aux actions.

Vaut-il mieux tout investir d''un coup ou étaler ? Et sur quoi : des ETF, quelques actions ?', 'question', NULL, false, NULL, 1210, NULL, NULL, 19, '2026-10-25 13:00:35.487', '2026-10-27 15:00:36.179', '2026-10-27 15:00:36.16', NULL, NULL, NULL),
	(6, 'wnxbe5y0g0u3iou4is3oy14w', 'J''ai 25 ans et 10 000 € de côté : je fais quoi ?', 'j-ai-25-ans-et-10-000-de-cote-je-fais-quoi', 'Premier CDI depuis un an, j''ai réussi à mettre 10 000 € de côté sur un livret. Pas de projet immobilier avant quatre ou cinq ans.

Je me sens un peu perdu entre PEA, assurance-vie, PER… Comment auriez-vous réparti à mon âge ?', 'question', NULL, false, NULL, 1890, NULL, NULL, 33, '2026-10-27 01:00:35.487', '2026-10-27 15:00:36.34', '2026-10-27 15:00:36.313', NULL, NULL, NULL),
	(7, 'ez8q0hdjzavkp42b4oydew0k', 'Assurance-vie après 70 ans : est-ce encore intéressant ?', 'assurance-vie-apres-70-ans-est-ce-encore-interessant', 'J''ai 71 ans et je me demande s''il est encore utile de verser sur une assurance-vie, notamment pour la transmission à mes petits-enfants. On m''a dit que la fiscalité était moins avantageuse après 70 ans ?', 'question', NULL, false, NULL, 1340, NULL, NULL, 24, '2026-10-24 15:00:35.487', '2026-10-27 15:00:36.498', '2026-10-27 15:00:36.48', NULL, NULL, NULL),
	(8, 'ddecy6ujtvsvtlk49w53rya4', 'SCPI : vous avez renforcé ces derniers mois ou vous attendez ?', 'scpi-vous-avez-renforce-ces-derniers-mois-ou-vous-attendez', 'Après les baisses de prix de parts de certaines SCPI, je vois deux écoles autour de moi : ceux qui en profitent pour renforcer et ceux qui ne veulent plus en entendre parler.

Et vous, comment avez-vous réagi ?', 'discussion', NULL, false, NULL, 760, NULL, NULL, 15, '2026-10-26 03:00:35.487', '2026-10-27 15:00:36.614', '2026-10-27 15:00:36.594', NULL, NULL, NULL),
	(9, 'v3o6a01ts30lgl0w4ngi81fz', 'Frais réels ou abattement de 10 % : comment savoir ce qui est le plus avantageux ?', 'frais-reels-ou-abattement-de-10-comment-savoir-ce-qui-est-le-plus-avantageux', 'Je fais 35 km aller-retour par jour en voiture pour aller travailler. Est-ce que je devrais passer aux frais réels ?', 'question', NULL, false, NULL, 910, NULL, NULL, 12, '2026-10-23 15:00:35.487', '2026-10-27 15:00:36.735', '2026-10-27 15:00:36.715', NULL, NULL, NULL),
	(10, 'oq6kpklnda1p64g4mz1botll', 'Donation aux enfants : faut-il le faire maintenant ou attendre ?', 'donation-aux-enfants-faut-il-le-faire-maintenant-ou-attendre', 'Nos enfants ont 19, 22 et 25 ans. Nous pensons à leur donner une partie de notre épargne pour les aider à démarrer. Est-ce le bon moment ? Quels pièges éviter ?', 'question', NULL, false, NULL, 690, NULL, NULL, 17, '2026-10-25 23:00:35.487', '2026-10-27 15:00:36.828', '2026-10-27 15:00:36.808', NULL, NULL, NULL),
	(11, 'n4jx3t3oe8kljaa6xmfmpyzf', 'PER : vos retours d''expérience après quelques années ?', 'per-vos-retours-d-experience-apres-quelques-annees', 'J''ai ouvert un PER il y a trois ans pour la déduction fiscale. Je m''interroge sur les frais et la sortie. Vos retours ?', 'discussion', NULL, false, NULL, 540, NULL, NULL, 9, '2026-10-25 03:00:35.487', '2026-10-27 15:00:36.974', '2026-10-27 15:00:36.953', NULL, NULL, NULL),
	(12, 'qwdcwhtof6ic9i4tkpj56bbr', 'Or physique : pièces ou lingots, que privilégiez-vous ?', 'or-physique-pieces-ou-lingots-que-privilegiez-vous', 'Je commence à acheter un peu d''or physique. Pièces ou petits lingots ? Et où les stockez-vous ?', 'discussion', NULL, false, NULL, 470, NULL, NULL, 8, '2026-10-23 01:00:35.487', '2026-10-27 15:00:37.164', '2026-10-27 15:00:37.09', NULL, NULL, NULL),
	(13, 'kastd95xod78uqab0h79mm0z', 'Changer de banque : vos retours sur la mobilité bancaire ?', 'changer-de-banque-vos-retours-sur-la-mobilite-bancaire', 'Je veux quitter ma banque traditionnelle pour une banque en ligne. Le service de mobilité fonctionne-t-il vraiment bien ?', 'question', NULL, false, NULL, 210, NULL, NULL, 6, '2026-10-27 07:00:35.487', '2026-10-27 15:00:37.264', '2026-10-27 15:00:37.243', NULL, NULL, NULL),
	(14, 'vizig7etv3ba1jbhx2k0juut', 'Quel sujet aimeriez-vous voir traité par la rédaction ?', 'quel-sujet-aimeriez-vous-voir-traite-par-la-redaction', 'La rédaction lit ce forum, profitons-en ! Moi j''aimerais un dossier complet sur la succession dans les familles recomposées.', 'discussion', NULL, false, NULL, 640, NULL, NULL, 22, '2026-10-26 13:00:35.487', '2026-10-27 15:00:37.343', '2026-10-27 15:00:37.314', NULL, NULL, NULL),
	(15, 'npe26yvbkbai4j43955giyne', 'Location meublée : micro-BIC ou régime réel ?', 'location-meublee-micro-bic-ou-regime-reel', 'Je loue un studio meublé depuis deux mois. Je ne sais pas quel régime choisir pour ma première déclaration. Comment avez-vous fait votre choix ?', 'question', NULL, false, NULL, 96, NULL, NULL, 3, '2026-10-27 10:00:35.487', '2026-10-27 15:00:37.467', '2026-10-27 15:00:37.447', NULL, NULL, NULL),
	(16, 'mvo0pq4uemmw0x3p9j3nz1w6', 'Dividendes sur un compte-titres : flat tax ou barème ?', 'dividendes-sur-un-compte-titres-flat-tax-ou-bareme', 'Je perçois des dividendes sur un compte-titres ordinaire. Flat tax ou barème progressif : qu''avez-vous choisi et pourquoi ?', 'question', NULL, false, NULL, 58, NULL, NULL, 2, '2026-10-27 12:00:35.487', '2026-10-27 15:00:37.504', '2026-10-27 15:00:37.486', NULL, NULL, NULL),
	(17, 'aaw7obqbmtin3xbcdguxx0ql', 'Rachat de trimestres : est-ce que ça vaut vraiment le coup ?', 'rachat-de-trimestres-est-ce-que-ca-vaut-vraiment-le-coup', 'Une amie a racheté des trimestres pour partir plus tôt. Le coût m''a paru énorme. Quelqu''un a fait le calcul ?', 'question', NULL, false, NULL, 610, NULL, NULL, 7, '2026-10-22 05:00:35.487', '2026-10-27 15:00:37.539', '2026-10-27 15:00:37.521', NULL, NULL, NULL),
	(18, 'e6ea1dcl5l5qter52wvekbq9', 'Fonds euros : quelle part gardez-vous dans votre contrat ?', 'fonds-euros-quelle-part-gardez-vous-dans-votre-contrat', 'Suite à l''article du Revenu sur les rendements des fonds euros, je me demande quelle part vous conservez en fonds euros et en unités de compte.', 'discussion', 'Fonds euros : les rendements servis par les assureurs', false, NULL, 530, NULL, NULL, 14, '2026-10-26 21:00:35.487', '2026-10-27 15:00:37.6', '2026-10-27 15:00:37.581', NULL, NULL, NULL),
	(19, 'zfzqt3nw1ljyklxvkizlm32t', 'Crédit immobilier : renégocier ou faire racheter son prêt ?', 'credit-immobilier-renegocier-ou-faire-racheter-son-pret', 'Mon taux actuel est plus élevé que les offres du moment. Vaut-il mieux renégocier avec ma banque ou passer par un rachat de crédit ? Vos expériences ?', 'question', NULL, false, NULL, 41, NULL, NULL, 1, '2026-10-27 13:00:35.487', '2026-10-27 15:00:37.719', '2026-10-27 15:00:37.701', NULL, NULL, NULL),
	(20, 'l9iml79vbtaxnyzw45aru8ek', 'Taux de la BCE : suivez-vous ses décisions pour vos placements ?', 'taux-de-la-bce-suivez-vous-ses-decisions-pour-vos-placements', 'Je découvre que les décisions de la Banque centrale européenne pèsent à la fois sur les crédits immobiliers, la rémunération de l''épargne et les marchés. Est-ce que vous les suivez, et est-ce qu''elles changent vos choix ?', 'discussion', NULL, false, NULL, 720, NULL, NULL, 13, '2026-10-26 11:00:35.487', '2026-10-27 15:00:37.756', '2026-10-27 15:00:37.737', NULL, NULL, NULL);


--
-- Data for Name: discussions_author_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.discussions_author_lnk VALUES
	(1, 1, 1, 1),
	(2, 2, 4, 1),
	(3, 3, 1, 2),
	(4, 4, 1, 3),
	(5, 5, 13, 1),
	(6, 6, 15, 1),
	(7, 7, 5, 1),
	(8, 8, 9, 1),
	(9, 9, 14, 1),
	(10, 10, 6, 1),
	(11, 11, 10, 1),
	(12, 12, 11, 1),
	(13, 13, 7, 1),
	(14, 14, 8, 1),
	(15, 15, 16, 1),
	(16, 16, 12, 1),
	(17, 17, 5, 2),
	(18, 18, 3, 1),
	(19, 19, 9, 2),
	(20, 20, 10, 2);


--
-- Data for Name: discussions_category_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.discussions_category_lnk VALUES
	(1, 1, 3, 1),
	(2, 2, 1, 1),
	(3, 3, 11, 1),
	(4, 4, 11, 2),
	(5, 5, 1, 2),
	(6, 6, 3, 2),
	(7, 7, 4, 1),
	(8, 8, 5, 1),
	(9, 9, 6, 1),
	(10, 10, 8, 1),
	(11, 11, 7, 1),
	(12, 12, 9, 1),
	(13, 13, 10, 1),
	(14, 14, 11, 3),
	(15, 15, 6, 2),
	(16, 16, 1, 3),
	(17, 17, 7, 2),
	(18, 18, 4, 2),
	(19, 19, 5, 2),
	(20, 20, 2, 1);


--
-- Data for Name: discussions_followed_by_lnk; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: discussions_useful_by_lnk; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.events VALUES
	(1, 'ety09xccuhqh9f7a59pg1hfq', 'Le Revenu répond : vos questions sur l''assurance-vie', 'La rédaction du Revenu', '2027-04-28 18:30:00', 142, '2026-10-27 15:00:38.506', '2026-10-27 15:00:38.506', '2026-10-27 15:00:38.499', NULL, NULL, NULL),
	(2, 'z4ijog2bbyso8owprsy4oaax', 'Atelier débutants : construire son premier portefeuille', 'La rédaction et des membres experts', '2027-05-05 19:00:00', 87, '2026-10-27 15:00:38.54', '2026-10-27 15:00:38.54', '2026-10-27 15:00:38.534', NULL, NULL, NULL),
	(3, 't1mzsgzqwxy5u42zbj3v2dkj', 'Le Revenu répond : préparer sa retraite', 'La rédaction du Revenu', '2027-05-12 18:30:00', 63, '2026-10-27 15:00:38.599', '2026-10-27 15:00:38.599', '2026-10-27 15:00:38.594', NULL, NULL, NULL);


--
-- Data for Name: events_attendees_lnk; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: events_category_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.events_category_lnk VALUES
	(1, 1, 4),
	(2, 2, 1),
	(3, 3, 7);


--
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: files_folder_lnk; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: files_related_mph; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: i18n_locale; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.i18n_locale VALUES
	(1, 'lw2imbgfqkisefkz31s0a5ae', 'English (en)', 'en', '2026-10-27 15:00:27.868', '2026-10-27 15:00:27.868', '2026-10-27 15:00:27.869', NULL, NULL, NULL);


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.notifications VALUES
	(1, 'zziqehji53ibnixrx48syhpc', 'reply', NULL, 'a répondu dans une discussion que vous suivez', false, '2026-10-27 14:25:35.487', '2026-10-27 15:00:38.663', '2026-10-27 15:00:38.625', NULL, NULL, NULL),
	(2, 'y1766bsmw4lgkahk508y6v9o', 'like', NULL, 'et 4 autres membres ont trouvé votre réponse utile', false, '2026-10-27 13:30:35.487', '2026-10-27 15:00:38.686', '2026-10-27 15:00:38.672', NULL, NULL, NULL),
	(3, 'gmv2x86qppnfb52h80nm5bl6', 'mention', NULL, 'vous a mentionnée dans « PER : vos retours d''expérience… »', false, '2026-10-27 11:00:35.487', '2026-10-27 15:00:38.709', '2026-10-27 15:00:38.694', NULL, NULL, NULL),
	(4, 'ohgodd6n4v0ak29ck1db0mj3', 'badge', 'citoyen', 'Nouveau badge : Votre avis compte', true, '2026-10-26 13:00:35.487', '2026-10-27 15:00:38.728', '2026-10-27 15:00:38.718', NULL, NULL, NULL),
	(5, 'vegsda3g5wsdcqq8hiu9dvin', 'event', NULL, 'Rappel : « Le Revenu répond » sur l''assurance-vie dans 3 jours', true, '2026-10-26 09:00:35.487', '2026-10-27 15:00:38.746', '2026-10-27 15:00:38.736', NULL, NULL, NULL);


--
-- Data for Name: notifications_actor_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.notifications_actor_lnk VALUES
	(1, 1, 1),
	(2, 2, 5),
	(3, 3, 3);


--
-- Data for Name: notifications_blog_post_lnk; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: notifications_discussion_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.notifications_discussion_lnk VALUES
	(1, 1, 18),
	(2, 2, 18),
	(3, 3, 11);


--
-- Data for Name: notifications_recipient_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.notifications_recipient_lnk VALUES
	(1, 1, 17),
	(2, 2, 17),
	(3, 3, 17),
	(4, 4, 17),
	(5, 5, 17);


--
-- Data for Name: replies; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.replies VALUES
	(1, 'ovcmxvwhganx6cl720xwlc1o', 'PEA sans hésiter, versement programmé chaque mois sur un ETF monde.', false, false, 11, '2026-10-26 19:17:35.487', '2026-10-27 15:00:35.586', '2026-10-27 15:00:35.549', NULL, NULL, NULL),
	(2, 'fevpejcnffi1qv7otjy87uza', 'Assurance-vie, pour la souplesse et la transmission.', false, false, 8, '2026-10-26 19:34:35.487', '2026-10-27 15:00:35.659', '2026-10-27 15:00:35.595', NULL, NULL, NULL),
	(3, 'k5ewetcznz5jlyyckpvwqn5j', 'Un peu d''or, comme toujours. Ça ne rapporte rien mais ça rassure !', false, false, 5, '2026-10-26 19:51:35.487', '2026-10-27 15:00:35.696', '2026-10-27 15:00:35.671', NULL, NULL, NULL),
	(4, 'khv802hjoeuc4uvh8l49c34w', 'Une seule ligne ici : un ETF monde. Ennuyeux mais efficace.', false, false, 9, '2026-10-24 07:17:35.487', '2026-10-27 15:00:35.769', '2026-10-27 15:00:35.751', NULL, NULL, NULL),
	(5, 'ggsysfnkubjkiehgyfpyfrou', 'Une vingtaine, toutes à dividendes. Je suis tout l''inverse de Vincent !', false, false, 6, '2026-10-24 07:34:35.487', '2026-10-27 15:00:35.804', '2026-10-27 15:00:35.78', NULL, NULL, NULL),
	(6, 'p7zrclvckgh2ljzbx89xvqtq', 'Bonjour ! Abonnée au magazine depuis 6 ans, ravie de pouvoir enfin échanger avec d''autres lecteurs.', false, false, 12, '2026-10-18 15:17:35.487', '2026-10-27 15:00:35.884', '2026-10-27 15:00:35.867', NULL, NULL, NULL),
	(7, 'rrtg9iqd0vmqgmu1n7or2kss', 'Salut tout le monde, Hugo, 25 ans. Premier CDI et premier salaire à placer : je suis là pour apprendre !', false, false, 18, '2026-10-18 15:34:35.487', '2026-10-27 15:00:35.917', '2026-10-27 15:00:35.895', NULL, NULL, NULL),
	(8, 'ox98i54fhs2t71hi79fkycpi', 'Bienvenue aux jeunes ! N''hésitez pas à poser des questions, même basiques. On est tous passés par là.', false, false, 25, '2026-10-18 15:51:35.487', '2026-10-27 15:00:35.944', '2026-10-27 15:00:35.928', NULL, NULL, NULL),
	(9, 'vozv0kqpee8ls6b5cfvf99mz', 'Hello, Hélène. Je viens de mettre un studio en location meublée et j''ai mille questions sur la fiscalité.', false, false, 7, '2026-10-18 16:08:35.487', '2026-10-27 15:00:35.972', '2026-10-27 15:00:35.955', NULL, NULL, NULL),
	(10, 'w1f1x7d55xesniz9eomxc7ec', 'Mon père : « N''investis jamais l''argent dont tu auras besoin dans les cinq ans. » Ça m''a évité bien des ventes en catastrophe.', false, false, 31, '2026-10-26 09:17:35.487', '2026-10-27 15:00:36.032', '2026-10-27 15:00:36.015', NULL, NULL, NULL),
	(11, 'aqnskcy96zuppio0fv9t5o18', '« Le temps passé sur le marché compte plus que le moment où on y entre. » Investir tous les mois, sans se poser de questions.', false, false, 22, '2026-10-26 09:34:35.487', '2026-10-27 15:00:36.063', '2026-10-27 15:00:36.043', NULL, NULL, NULL),
	(12, 'buozklx5ypf47febrpa2jwuh', 'Faire le tour de ses contrats une fois par an. J''économise plusieurs centaines d''euros par an sur mes assurances grâce à ça.', false, false, 17, '2026-10-26 09:51:35.487', '2026-10-27 15:00:36.09', '2026-10-27 15:00:36.074', NULL, NULL, NULL),
	(13, 'z5ghyn79nxicjrwz0796643d', 'Ma notaire : « Une succession se prépare de son vivant, pas après. » On a tout réorganisé ensuite.', false, false, 14, '2026-10-26 10:08:35.487', '2026-10-27 15:00:36.115', '2026-10-27 15:00:36.099', NULL, NULL, NULL),
	(14, 'hg5lduf82gal94xs97cctzek', 'Se constituer une épargne de précaution avant d''investir. Simple, mais je ne l''aurais pas fait spontanément.', false, false, 9, '2026-10-26 10:25:35.487', '2026-10-27 15:00:36.143', '2026-10-27 15:00:36.125', NULL, NULL, NULL),
	(15, 'lgqzzybfpnf8cw3rh8bv3269', 'Première chose : vous avez bien une épargne de précaution à côté ? Le PEA, c''est de l''argent qu''on oublie au moins cinq ans.', false, false, 14, '2026-10-25 13:17:35.487', '2026-10-27 15:00:36.209', '2026-10-27 15:00:36.191', NULL, NULL, NULL),
	(16, 'cswk2obauf8jtbazkhzibcqg', 'Mon expérience : pour débuter, un ETF éligible au PEA qui réplique un indice mondial fait très bien le travail. Une seule ligne, des frais faibles, une large diversification.

Pour l''entrée : investir une partie maintenant puis programmer un versement mensuel. On lisse son point d''entrée et on prend l''habitude.

Rappel utile : le PEA est plafonné à 150 000 € de versements, et après cinq ans les gains sont exonérés d''impôt sur le revenu (les prélèvements sociaux restent dus).', true, true, 47, '2026-10-25 13:34:35.487', '2026-10-27 15:00:36.238', '2026-10-27 15:00:36.219', NULL, NULL, NULL),
	(17, 'ch9z03z7gi5gn7jgbszy71p9', 'Merci beaucoup, c''est très clair ! Oui, j''ai trois mois de salaire sur un livret à côté.', false, false, 3, '2026-10-25 13:51:35.487', '2026-10-27 15:00:36.269', '2026-10-27 15:00:36.251', NULL, NULL, NULL),
	(18, 'n62b9rmute1l8u7lc1kxs2ou', 'Très bonne réponse de @Vincent_ETF. Nous avons consacré un dossier aux ETF : comparez surtout les frais courants et la taille du fonds avant de choisir. Et gardez la tête froide les jours de baisse : c''est là que la régularité paie.', false, false, 29, '2026-10-25 14:08:35.487', '2026-10-27 15:00:36.296', '2026-10-27 15:00:36.279', NULL, NULL, NULL),
	(19, 'k10ygky6eht0s8vugknaxn6v', 'Garde déjà trois à six mois de dépenses sur ton livret. Le reste peut travailler.', false, false, 21, '2026-10-27 01:17:35.487', '2026-10-27 15:00:36.373', '2026-10-27 15:00:36.355', NULL, NULL, NULL),
	(20, 'qx7qoyc78i6108egr2s0llb6', 'À 25 ans, ouvrir un PEA et une assurance-vie tôt, même avec peu, c''est surtout prendre date pour la fiscalité. L''antériorité compte.', false, false, 26, '2026-10-27 01:34:35.487', '2026-10-27 15:00:36.406', '2026-10-27 15:00:36.386', NULL, NULL, NULL),
	(21, 'ur66dkh8er2enfc05ngmnj16', 'Le PER peut attendre à mon avis : l''argent est bloqué jusqu''à la retraite (sauf achat de la résidence principale) et l''avantage fiscal est faible si ton taux d''imposition est bas.', false, false, 19, '2026-10-27 01:51:35.487', '2026-10-27 15:00:36.432', '2026-10-27 15:00:36.416', NULL, NULL, NULL),
	(22, 'xx6j1e7wfzwk3s33gett6rzv', 'Pareil que les autres. Et surtout : automatise tes versements, c''est ce qui fait la différence sur vingt ans.', false, false, 12, '2026-10-27 02:08:35.487', '2026-10-27 15:00:36.464', '2026-10-27 15:00:36.444', NULL, NULL, NULL),
	(23, 'zrsw19l0yffwydlv4py1ppa8', 'Oui, mais ça reste souvent intéressant. Pour les versements après 70 ans, l''abattement est de 30 500 € au total (tous bénéficiaires confondus) et il ne porte que sur les primes versées : les gains, eux, sont exonérés de droits de succession. Sur une longue durée, ça peut peser lourd.', true, true, 38, '2026-10-24 15:17:35.487', '2026-10-27 15:00:36.528', '2026-10-27 15:00:36.511', NULL, NULL, NULL),
	(24, 'zc7ow7ppar3azj3nj8d9m6tr', 'Merci ! Je ne savais pas que les gains étaient exonérés. Je vais en parler à mon conseiller.', false, false, 4, '2026-10-24 15:34:35.487', '2026-10-27 15:00:36.553', '2026-10-27 15:00:36.538', NULL, NULL, NULL),
	(25, 'upsqcmu9bckb1rl6sgvtpt3z', 'Précision utile : pour les primes versées avant 70 ans, l''abattement est de 152 500 € par bénéficiaire. Les deux régimes peuvent se combiner sur un même contrat.', false, false, 27, '2026-10-24 15:51:35.487', '2026-10-27 15:00:36.578', '2026-10-27 15:00:36.562', NULL, NULL, NULL),
	(26, 'bb4erm0om0j0yhxzdf237zrp', 'J''attends. J''ai été échaudée par les délais de revente sur une de mes SCPI.', false, false, 6, '2026-10-26 03:17:35.487', '2026-10-27 15:00:36.645', '2026-10-27 15:00:36.627', NULL, NULL, NULL),
	(27, 'e17lzcgnvk8jqd785p8pgb5v', 'J''ai renforcé, mais uniquement sur des SCPI récentes, sans immobilier de bureaux acheté au plus haut.', false, false, 13, '2026-10-26 03:34:35.487', '2026-10-27 15:00:36.673', '2026-10-27 15:00:36.655', NULL, NULL, NULL),
	(28, 'oc2er7wbco29g298r73fffi6', 'C''est aussi mon approche. Je regarde maintenant de près le taux d''occupation et la diversification géographique.', false, false, 5, '2026-10-26 03:51:35.487', '2026-10-27 15:00:36.698', '2026-10-27 15:00:36.681', NULL, NULL, NULL),
	(29, 'k81gue772vibnqrhduuadm9j', 'Faites le calcul simplement : additionnez vos frais (barème kilométrique selon la puissance de la voiture, repas, etc.) et comparez avec 10 % de votre salaire. Si vos frais dépassent, les frais réels sont gagnants. Attention : il faut garder les justificatifs.', false, false, 22, '2026-10-23 15:17:35.487', '2026-10-27 15:00:36.765', '2026-10-27 15:00:36.747', NULL, NULL, NULL),
	(30, 'zpurvp30gcu5zvwauxn4q9ot', 'Je viens de faire le calcul et je gagne quelques centaines d''euros. Merci !', false, false, 2, '2026-10-23 15:34:35.487', '2026-10-27 15:00:36.792', '2026-10-27 15:00:36.775', NULL, NULL, NULL),
	(31, 'qg68bzn4n8piazp8ooxxkmc1', 'Chaque parent peut donner 100 000 € par enfant en franchise de droits, et cet abattement se renouvelle tous les quinze ans. Plus on commence tôt, plus on peut en profiter plusieurs fois.', false, false, 16, '2026-10-25 23:17:35.487', '2026-10-27 15:00:36.863', '2026-10-27 15:00:36.843', NULL, NULL, NULL),
	(32, 'ek3rxk7g0l7e1kr7gobjuf9c', 'Le piège classique : donner trop et se retrouver juste soi-même. Gardez de quoi vivre confortablement !', false, false, 11, '2026-10-25 23:34:35.487', '2026-10-27 15:00:36.895', '2026-10-27 15:00:36.876', NULL, NULL, NULL),
	(38, 'wsxrgc2g6rrgvdms0c4jdqwb', 'Attention aux frais de garde et à la prime à l''achat, ça varie beaucoup d''un vendeur à l''autre.', false, false, 9, '2026-10-23 01:34:35.487', '2026-10-27 15:00:37.225', '2026-10-27 15:00:37.208', NULL, NULL, NULL),
	(33, 'jov4qis17sy7svq680n179lu', 'J''ajoute un point de forme : une donation qui porte sur un bien immobilier passe obligatoirement devant notaire. Pour une somme d''argent, un don manuel suffit, mais il doit être déclaré à l''administration fiscale.', false, false, 13, '2026-10-25 23:51:35.487', '2026-10-27 15:00:36.931', '2026-10-27 15:00:36.911', NULL, NULL, NULL),
	(34, 'a67ng1cug21g2zrcqt5xv9ig', 'Le point clé pour moi : les frais. Un PER en ligne avec des ETF, c''est très différent d''un PER bancaire avec 3 % de frais d''entrée.', false, false, 10, '2026-10-25 03:17:35.487', '2026-10-27 15:00:37.002', '2026-10-27 15:00:36.985', NULL, NULL, NULL),
	(35, 'mizq1sybea79cb7xa88w995y', 'Pensez aussi à la fiscalité à la sortie : ce que vous déduisez aujourd''hui sera imposé plus tard.', false, false, 8, '2026-10-25 03:34:35.487', '2026-10-27 15:00:37.042', '2026-10-27 15:00:37.024', NULL, NULL, NULL),
	(37, 'wyryt4vtudc7ng8i57btjxta', 'Pièces, pour pouvoir revendre par petites quantités si besoin.', false, false, 7, '2026-10-23 01:17:35.487', '2026-10-27 15:00:37.195', '2026-10-27 15:00:37.176', NULL, NULL, NULL),
	(39, 'sh393m30inmmvdkatgq6nc5q', 'Très bien chez moi, tous les prélèvements ont été transférés en quelques semaines. Gardez l''ancien compte ouvert un mois ou deux par sécurité.', false, false, 4, '2026-10-27 07:17:35.487', '2026-10-27 15:00:37.296', '2026-10-27 15:00:37.276', NULL, NULL, NULL),
	(42, 'ki3x1nypu9r9ixbgw6y5d89q', 'Merci pour ces idées, nous les notons toutes. Les familles recomposées sont justement au programme d''un prochain numéro.', false, false, 19, '2026-10-26 13:51:35.487', '2026-10-27 15:00:37.43', '2026-10-27 15:00:37.413', NULL, NULL, NULL),
	(44, 'y70avmgydwr9l0vlz25uthfv', 'Environ 60 % en fonds euros, à mon âge je privilégie la sécurité.', false, false, 6, '2026-10-26 21:17:35.487', '2026-10-27 15:00:37.634', '2026-10-27 15:00:37.618', NULL, NULL, NULL),
	(36, 'g7q2lh3f235yqjxf5xo85hvw', 'Un point que je vois souvent négligé : si vous avez déduit vos versements, la part de capital correspondante sera imposée à la sortie, et les gains aussi. Comparez votre taux marginal d''imposition actuel avec celui que vous anticipez à la retraite : c''est lui qui dit si la déduction est vraiment avantageuse.', false, false, 15, '2026-10-25 03:51:35.487', '2026-10-27 15:00:37.07', '2026-10-27 15:00:37.053', NULL, NULL, NULL),
	(40, 'x3yruu4lfmjxfkp215o4tubf', 'Un comparatif des SCPI par type d''actifs, avec le recul sur les dernières années.', false, false, 9, '2026-10-26 13:17:35.487', '2026-10-27 15:00:37.376', '2026-10-27 15:00:37.357', NULL, NULL, NULL),
	(41, 'fi76zcb3m89rkbde3w7uuy4g', 'Un guide pas à pas de la déclaration en location meublée !', false, false, 12, '2026-10-26 13:34:35.487', '2026-10-27 15:00:37.403', '2026-10-27 15:00:37.386', NULL, NULL, NULL),
	(45, 'fbyvm6iqrwvmaccvwff03an3', 'Autour de 35 % chez moi, le reste en unités de compte diversifiées. Je rééquilibre une fois par an.', false, false, 9, '2026-10-26 21:34:35.487', '2026-10-27 15:00:37.66', '2026-10-27 15:00:37.644', NULL, NULL, NULL),
	(48, 'f5wngzlrxvsjlgma0kris5lw', 'Moi, c''est pour les livrets et les comptes à terme : leur rémunération finit toujours par suivre le mouvement.', false, false, 5, '2026-10-26 11:34:35.487', '2026-10-27 15:00:37.831', '2026-10-27 15:00:37.809', NULL, NULL, NULL),
	(43, 'g2wavq7lhv7v5oebm6fvkis2', 'Ça dépend énormément de votre situation. Demandez une simulation à votre caisse de retraite : elle calcule le coût et le gain de pension. Le rachat est déductible du revenu imposable, ce qui adoucit l''addition.', false, false, 8, '2026-10-22 05:17:35.487', '2026-10-27 15:00:37.565', '2026-10-27 15:00:37.55', NULL, NULL, NULL),
	(46, 'p1nplwohhc7y0lqtruhtnxpg', '20 % seulement, j''ai un horizon long.', false, false, 3, '2026-10-26 21:51:35.487', '2026-10-27 15:00:37.685', '2026-10-27 15:00:37.67', NULL, NULL, NULL),
	(47, 'nn5jlqxbjkcy6kq84ojgbp87', 'Je les suis de loin : j''investis tous les mois quoi qu''il arrive. Je regarde surtout l''effet sur les fonds euros, qui réagissent avec retard aux variations de taux.', false, false, 9, '2026-10-26 11:17:35.487', '2026-10-27 15:00:37.797', '2026-10-27 15:00:37.777', NULL, NULL, NULL);


--
-- Data for Name: replies_author_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.replies_author_lnk VALUES
	(1, 1, 3, 1),
	(2, 2, 5, 1),
	(3, 3, 11, 1),
	(4, 4, 3, 2),
	(5, 5, 12, 1),
	(6, 6, 8, 1),
	(7, 7, 15, 1),
	(8, 8, 4, 1),
	(9, 9, 16, 1),
	(10, 10, 4, 2),
	(11, 11, 3, 3),
	(12, 12, 7, 1),
	(13, 13, 6, 1),
	(14, 14, 15, 2),
	(15, 15, 4, 3),
	(16, 16, 3, 4),
	(17, 17, 13, 1),
	(18, 18, 1, 1),
	(19, 19, 7, 2),
	(20, 20, 3, 5),
	(21, 21, 4, 4),
	(22, 22, 8, 2),
	(23, 23, 6, 2),
	(24, 24, 5, 2),
	(25, 25, 1, 2),
	(26, 26, 16, 2),
	(27, 27, 4, 5),
	(28, 28, 9, 1),
	(29, 29, 10, 1),
	(30, 30, 14, 1),
	(31, 31, 5, 3),
	(32, 32, 4, 6),
	(33, 33, 19, 1),
	(34, 34, 3, 6),
	(35, 35, 5, 4),
	(36, 36, 18, 1),
	(37, 37, 4, 7),
	(38, 38, 7, 3),
	(39, 39, 8, 3),
	(40, 40, 9, 2),
	(41, 41, 16, 3),
	(42, 42, 1, 3),
	(43, 43, 10, 2),
	(44, 44, 5, 5),
	(45, 45, 17, 1),
	(46, 46, 13, 2),
	(47, 47, 3, 7),
	(48, 48, 5, 6);


--
-- Data for Name: replies_discussion_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.replies_discussion_lnk VALUES
	(1, 1, 1, 1),
	(2, 2, 1, 2),
	(3, 3, 1, 3),
	(4, 4, 2, 1),
	(5, 5, 2, 2),
	(6, 6, 3, 1),
	(7, 7, 3, 2),
	(8, 8, 3, 3),
	(9, 9, 3, 4),
	(10, 10, 4, 1),
	(11, 11, 4, 2),
	(12, 12, 4, 3),
	(13, 13, 4, 4),
	(14, 14, 4, 5),
	(15, 15, 5, 1),
	(16, 16, 5, 2),
	(17, 17, 5, 3),
	(18, 18, 5, 4),
	(19, 19, 6, 1),
	(20, 20, 6, 2),
	(21, 21, 6, 3),
	(22, 22, 6, 4),
	(23, 23, 7, 1),
	(24, 24, 7, 2),
	(25, 25, 7, 3),
	(26, 26, 8, 1),
	(27, 27, 8, 2),
	(28, 28, 8, 3),
	(29, 29, 9, 1),
	(30, 30, 9, 2),
	(31, 31, 10, 1),
	(32, 32, 10, 2),
	(33, 33, 10, 3),
	(34, 34, 11, 1),
	(35, 35, 11, 2),
	(36, 36, 11, 3),
	(37, 37, 12, 1),
	(38, 38, 12, 2),
	(39, 39, 13, 1),
	(40, 40, 14, 1),
	(41, 41, 14, 2),
	(42, 42, 14, 3),
	(43, 43, 17, 1),
	(44, 44, 18, 1),
	(45, 45, 18, 2),
	(46, 46, 18, 3),
	(47, 47, 20, 1),
	(48, 48, 20, 2);


--
-- Data for Name: replies_useful_by_lnk; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: rewards; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: rewards_recipient_lnk; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: strapi_ai_localization_jobs; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: strapi_ai_metadata_jobs; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: strapi_core_store_settings; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.strapi_core_store_settings VALUES
	(1, 'strapi_unidirectional-join-table-repair-ran', 'true', 'boolean', NULL, NULL),
	(2, 'strapi_content_types_schema', '{"plugin::upload.file":{"collectionName":"files","info":{"singularName":"file","pluralName":"files","displayName":"File","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false,"required":true},"alternativeText":{"type":"text","configurable":false},"caption":{"type":"text","configurable":false},"focalPoint":{"type":"json","configurable":false},"width":{"type":"integer","configurable":false},"height":{"type":"integer","configurable":false},"formats":{"type":"json","configurable":false},"hash":{"type":"string","configurable":false,"required":true},"ext":{"type":"string","configurable":false},"mime":{"type":"string","configurable":false,"required":true},"size":{"type":"decimal","configurable":false,"required":true},"url":{"type":"text","configurable":false,"required":true},"previewUrl":{"type":"text","configurable":false},"provider":{"type":"string","configurable":false,"required":true},"provider_metadata":{"type":"json","configurable":false},"related":{"type":"relation","relation":"morphToMany","configurable":false},"folder":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"files","private":true},"folderPath":{"type":"string","minLength":1,"required":true,"private":true,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"files"}}},"indexes":[{"name":"upload_files_folder_path_index","columns":["folder_path"],"type":null},{"name":"upload_files_created_at_index","columns":["created_at"],"type":null},{"name":"upload_files_updated_at_index","columns":["updated_at"],"type":null},{"name":"upload_files_name_index","columns":["name"],"type":null},{"name":"upload_files_size_index","columns":["size"],"type":null},{"name":"upload_files_ext_index","columns":["ext"],"type":null}],"plugin":"upload","globalId":"UploadFile","uid":"plugin::upload.file","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"files","info":{"singularName":"file","pluralName":"files","displayName":"File","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false,"required":true},"alternativeText":{"type":"text","configurable":false},"caption":{"type":"text","configurable":false},"focalPoint":{"type":"json","configurable":false},"width":{"type":"integer","configurable":false},"height":{"type":"integer","configurable":false},"formats":{"type":"json","configurable":false},"hash":{"type":"string","configurable":false,"required":true},"ext":{"type":"string","configurable":false},"mime":{"type":"string","configurable":false,"required":true},"size":{"type":"decimal","configurable":false,"required":true},"url":{"type":"text","configurable":false,"required":true},"previewUrl":{"type":"text","configurable":false},"provider":{"type":"string","configurable":false,"required":true},"provider_metadata":{"type":"json","configurable":false},"related":{"type":"relation","relation":"morphToMany","configurable":false},"folder":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"files","private":true},"folderPath":{"type":"string","minLength":1,"required":true,"private":true,"searchable":false}},"indexes":[{"name":"upload_files_folder_path_index","columns":["folder_path"],"type":null},{"name":"upload_files_created_at_index","columns":["created_at"],"type":null},{"name":"upload_files_updated_at_index","columns":["updated_at"],"type":null},{"name":"upload_files_name_index","columns":["name"],"type":null},{"name":"upload_files_size_index","columns":["size"],"type":null},{"name":"upload_files_ext_index","columns":["ext"],"type":null}],"kind":"collectionType"},"modelName":"file"},"plugin::upload.folder":{"collectionName":"upload_folders","info":{"singularName":"folder","pluralName":"folders","displayName":"Folder"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"required":true},"pathId":{"type":"integer","unique":true,"required":true},"parent":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"children"},"children":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","mappedBy":"parent"},"files":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","mappedBy":"folder"},"path":{"type":"string","minLength":1,"required":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"upload_folders"}}},"indexes":[{"name":"upload_folders_path_id_index","columns":["path_id"],"type":"unique"},{"name":"upload_folders_path_index","columns":["path"],"type":"unique"}],"plugin":"upload","globalId":"UploadFolder","uid":"plugin::upload.folder","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"upload_folders","info":{"singularName":"folder","pluralName":"folders","displayName":"Folder"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"required":true},"pathId":{"type":"integer","unique":true,"required":true},"parent":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"children"},"children":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","mappedBy":"parent"},"files":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","mappedBy":"folder"},"path":{"type":"string","minLength":1,"required":true}},"indexes":[{"name":"upload_folders_path_id_index","columns":["path_id"],"type":"unique"},{"name":"upload_folders_path_index","columns":["path"],"type":"unique"}],"kind":"collectionType"},"modelName":"folder"},"plugin::i18n.locale":{"info":{"singularName":"locale","pluralName":"locales","collectionName":"locales","displayName":"Locale","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"max":50,"configurable":false},"code":{"type":"string","unique":true,"configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::i18n.locale","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"i18n_locale"}}},"plugin":"i18n","collectionName":"i18n_locale","globalId":"I18NLocale","uid":"plugin::i18n.locale","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"i18n_locale","info":{"singularName":"locale","pluralName":"locales","collectionName":"locales","displayName":"Locale","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"max":50,"configurable":false},"code":{"type":"string","unique":true,"configurable":false}},"kind":"collectionType"},"modelName":"locale"},"plugin::content-releases.release":{"collectionName":"strapi_releases","info":{"singularName":"release","pluralName":"releases","displayName":"Release"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true},"releasedAt":{"type":"datetime"},"scheduledAt":{"type":"datetime"},"timezone":{"type":"string"},"status":{"type":"enumeration","enum":["ready","blocked","failed","done","empty"],"required":true},"actions":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release-action","mappedBy":"release"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_releases"}}},"plugin":"content-releases","globalId":"ContentReleasesRelease","uid":"plugin::content-releases.release","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_releases","info":{"singularName":"release","pluralName":"releases","displayName":"Release"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true},"releasedAt":{"type":"datetime"},"scheduledAt":{"type":"datetime"},"timezone":{"type":"string"},"status":{"type":"enumeration","enum":["ready","blocked","failed","done","empty"],"required":true},"actions":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release-action","mappedBy":"release"}},"kind":"collectionType"},"modelName":"release"},"plugin::content-releases.release-action":{"collectionName":"strapi_release_actions","info":{"singularName":"release-action","pluralName":"release-actions","displayName":"Release Action"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"type":{"type":"enumeration","enum":["publish","unpublish"],"required":true},"contentType":{"type":"string","required":true},"entryDocumentId":{"type":"string"},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"release":{"type":"relation","relation":"manyToOne","target":"plugin::content-releases.release","inversedBy":"actions"},"isEntryValid":{"type":"boolean"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release-action","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_release_actions"}}},"plugin":"content-releases","globalId":"ContentReleasesReleaseAction","uid":"plugin::content-releases.release-action","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_release_actions","info":{"singularName":"release-action","pluralName":"release-actions","displayName":"Release Action"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"type":{"type":"enumeration","enum":["publish","unpublish"],"required":true},"contentType":{"type":"string","required":true},"entryDocumentId":{"type":"string"},"locale":{"type":"string"},"release":{"type":"relation","relation":"manyToOne","target":"plugin::content-releases.release","inversedBy":"actions"},"isEntryValid":{"type":"boolean"}},"kind":"collectionType"},"modelName":"release-action"},"plugin::review-workflows.workflow":{"collectionName":"strapi_workflows","info":{"name":"Workflow","description":"","singularName":"workflow","pluralName":"workflows","displayName":"Workflow"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true,"unique":true},"stages":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToMany","mappedBy":"workflow"},"stageRequiredToPublish":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToOne","required":false},"contentTypes":{"type":"json","required":true,"default":"[]"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::review-workflows.workflow","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_workflows"}}},"plugin":"review-workflows","globalId":"ReviewWorkflowsWorkflow","uid":"plugin::review-workflows.workflow","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_workflows","info":{"name":"Workflow","description":"","singularName":"workflow","pluralName":"workflows","displayName":"Workflow"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true,"unique":true},"stages":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToMany","mappedBy":"workflow"},"stageRequiredToPublish":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToOne","required":false},"contentTypes":{"type":"json","required":true,"default":"[]"}},"kind":"collectionType"},"modelName":"workflow"},"plugin::review-workflows.workflow-stage":{"collectionName":"strapi_workflows_stages","info":{"name":"Workflow Stage","description":"","singularName":"workflow-stage","pluralName":"workflow-stages","displayName":"Stages"},"options":{"version":"1.1.0","draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false},"color":{"type":"string","configurable":false,"default":"#4945FF"},"workflow":{"type":"relation","target":"plugin::review-workflows.workflow","relation":"manyToOne","inversedBy":"stages","configurable":false},"permissions":{"type":"relation","target":"admin::permission","relation":"manyToMany","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::review-workflows.workflow-stage","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_workflows_stages"}}},"plugin":"review-workflows","globalId":"ReviewWorkflowsWorkflowStage","uid":"plugin::review-workflows.workflow-stage","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_workflows_stages","info":{"name":"Workflow Stage","description":"","singularName":"workflow-stage","pluralName":"workflow-stages","displayName":"Stages"},"options":{"version":"1.1.0"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false},"color":{"type":"string","configurable":false,"default":"#4945FF"},"workflow":{"type":"relation","target":"plugin::review-workflows.workflow","relation":"manyToOne","inversedBy":"stages","configurable":false},"permissions":{"type":"relation","target":"admin::permission","relation":"manyToMany","configurable":false}},"kind":"collectionType"},"modelName":"workflow-stage"},"plugin::users-permissions.permission":{"collectionName":"up_permissions","info":{"name":"permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","required":true,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"permissions","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"up_permissions"}}},"plugin":"users-permissions","globalId":"UsersPermissionsPermission","uid":"plugin::users-permissions.permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"up_permissions","info":{"name":"permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","required":true,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"permissions","configurable":false}},"kind":"collectionType"},"modelName":"permission","options":{"draftAndPublish":false}},"plugin::users-permissions.role":{"collectionName":"up_roles","info":{"name":"role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":3,"required":true,"configurable":false},"description":{"type":"string","configurable":false},"type":{"type":"string","unique":true,"configurable":false},"permissions":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","mappedBy":"role","configurable":false},"users":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","mappedBy":"role","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.role","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"up_roles"}}},"plugin":"users-permissions","globalId":"UsersPermissionsRole","uid":"plugin::users-permissions.role","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"up_roles","info":{"name":"role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":3,"required":true,"configurable":false},"description":{"type":"string","configurable":false},"type":{"type":"string","unique":true,"configurable":false},"permissions":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","mappedBy":"role","configurable":false},"users":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","mappedBy":"role","configurable":false}},"kind":"collectionType"},"modelName":"role","options":{"draftAndPublish":false}},"plugin::users-permissions.user":{"collectionName":"up_users","info":{"name":"user","description":"","singularName":"user","pluralName":"users","displayName":"User"},"options":{"draftAndPublish":false},"attributes":{"username":{"type":"string","minLength":3,"unique":true,"configurable":false,"required":true},"email":{"type":"email","minLength":6,"configurable":false,"required":true},"provider":{"type":"string","configurable":false},"password":{"type":"password","minLength":6,"configurable":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmed":{"type":"boolean","default":false,"configurable":false},"blocked":{"type":"boolean","default":false,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"users","configurable":false},"displayName":{"type":"string"},"avatar":{"type":"media","multiple":false,"allowedTypes":["images","files","videos","audios"]},"bio":{"type":"text"},"discussions":{"type":"relation","relation":"oneToMany","target":"api::discussion.discussion","mappedBy":"author"},"replies":{"type":"relation","relation":"oneToMany","target":"api::reply.reply","mappedBy":"author"},"interests":{"type":"json"},"usefulDiscussions":{"type":"relation","relation":"manyToMany","target":"api::discussion.discussion","mappedBy":"usefulBy"},"followedDiscussions":{"type":"relation","relation":"manyToMany","target":"api::discussion.discussion","mappedBy":"followedBy"},"usefulReplies":{"type":"relation","relation":"manyToMany","target":"api::reply.reply","mappedBy":"usefulBy"},"communityRole":{"type":"enumeration","enum":["member","redaction","moderator"],"default":"member","required":true},"avatarColor":{"type":"string","default":"var(--av-3)","maxLength":30},"subscriber":{"type":"boolean","default":false},"expertTitle":{"type":"string","maxLength":80},"points":{"type":"integer","default":0,"min":0},"monthPoints":{"type":"integer","default":0,"min":0},"monthKey":{"type":"string","maxLength":7},"streak":{"type":"integer","default":0,"min":0},"badges":{"type":"json"},"stats":{"type":"json"},"blogPosts":{"type":"relation","relation":"oneToMany","target":"api::blog-post.blog-post","mappedBy":"author"},"blogComments":{"type":"relation","relation":"oneToMany","target":"api::blog-comment.blog-comment","mappedBy":"author"},"usefulBlogPosts":{"type":"relation","relation":"manyToMany","target":"api::blog-post.blog-post","mappedBy":"usefulBy"},"usefulBlogComments":{"type":"relation","relation":"manyToMany","target":"api::blog-comment.blog-comment","mappedBy":"usefulBy"},"events":{"type":"relation","relation":"manyToMany","target":"api::event.event","mappedBy":"attendees"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"up_users"}}},"config":{"attributes":{"resetPasswordToken":{"hidden":true},"confirmationToken":{"hidden":true},"provider":{"hidden":true}}},"plugin":"users-permissions","globalId":"UsersPermissionsUser","kind":"collectionType","pluginOptions":{},"__filename__":"schema.json","uid":"plugin::users-permissions.user","modelType":"contentType","__schema__":{"collectionName":"up_users","info":{"name":"user","description":"","singularName":"user","pluralName":"users","displayName":"User"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"username":{"type":"string","minLength":3,"unique":true,"configurable":false,"required":true},"email":{"type":"email","minLength":6,"configurable":false,"required":true},"provider":{"type":"string","configurable":false},"password":{"type":"password","minLength":6,"configurable":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmed":{"type":"boolean","default":false,"configurable":false},"blocked":{"type":"boolean","default":false,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"users","configurable":false},"displayName":{"type":"string"},"avatar":{"type":"media","multiple":false,"allowedTypes":["images","files","videos","audios"]},"bio":{"type":"text"},"discussions":{"type":"relation","relation":"oneToMany","target":"api::discussion.discussion","mappedBy":"author"},"replies":{"type":"relation","relation":"oneToMany","target":"api::reply.reply","mappedBy":"author"},"interests":{"type":"json"},"usefulDiscussions":{"type":"relation","relation":"manyToMany","target":"api::discussion.discussion","mappedBy":"usefulBy"},"followedDiscussions":{"type":"relation","relation":"manyToMany","target":"api::discussion.discussion","mappedBy":"followedBy"},"usefulReplies":{"type":"relation","relation":"manyToMany","target":"api::reply.reply","mappedBy":"usefulBy"},"communityRole":{"type":"enumeration","enum":["member","redaction","moderator"],"default":"member","required":true},"avatarColor":{"type":"string","default":"var(--av-3)","maxLength":30},"subscriber":{"type":"boolean","default":false},"expertTitle":{"type":"string","maxLength":80},"points":{"type":"integer","default":0,"min":0},"monthPoints":{"type":"integer","default":0,"min":0},"monthKey":{"type":"string","maxLength":7},"streak":{"type":"integer","default":0,"min":0},"badges":{"type":"json"},"stats":{"type":"json"},"blogPosts":{"type":"relation","relation":"oneToMany","target":"api::blog-post.blog-post","mappedBy":"author"},"blogComments":{"type":"relation","relation":"oneToMany","target":"api::blog-comment.blog-comment","mappedBy":"author"},"usefulBlogPosts":{"type":"relation","relation":"manyToMany","target":"api::blog-post.blog-post","mappedBy":"usefulBy"},"usefulBlogComments":{"type":"relation","relation":"manyToMany","target":"api::blog-comment.blog-comment","mappedBy":"usefulBy"},"events":{"type":"relation","relation":"manyToMany","target":"api::event.event","mappedBy":"attendees"}},"kind":"collectionType"},"modelName":"user"},"api::blog-comment.blog-comment":{"kind":"collectionType","collectionName":"blog_comments","info":{"singularName":"blog-comment","pluralName":"blog-comments","displayName":"Blog comment","description":"Commentaire d''un membre sous un billet"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"content":{"type":"text","required":true,"maxLength":10000},"author":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"blogComments"},"post":{"type":"relation","relation":"manyToOne","target":"api::blog-post.blog-post","inversedBy":"comments"},"usefulBase":{"type":"integer","default":0,"min":0,"required":true},"usefulBy":{"type":"relation","relation":"manyToMany","target":"plugin::users-permissions.user","inversedBy":"usefulBlogComments"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::blog-comment.blog-comment","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"blog_comments"}}},"apiName":"blog-comment","globalId":"BlogComment","uid":"api::blog-comment.blog-comment","modelType":"contentType","__schema__":{"collectionName":"blog_comments","info":{"singularName":"blog-comment","pluralName":"blog-comments","displayName":"Blog comment","description":"Commentaire d''un membre sous un billet"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"content":{"type":"text","required":true,"maxLength":10000},"author":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"blogComments"},"post":{"type":"relation","relation":"manyToOne","target":"api::blog-post.blog-post","inversedBy":"comments"},"usefulBase":{"type":"integer","default":0,"min":0,"required":true},"usefulBy":{"type":"relation","relation":"manyToMany","target":"plugin::users-permissions.user","inversedBy":"usefulBlogComments"}},"kind":"collectionType"},"modelName":"blog-comment","actions":{},"lifecycles":{}},"api::blog-post.blog-post":{"kind":"collectionType","collectionName":"blog_posts","info":{"singularName":"blog-post","pluralName":"blog-posts","displayName":"Blog post","description":"Billet de blog publié par un membre"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"title":{"type":"string","required":true,"minLength":10,"maxLength":120},"content":{"type":"text","required":true,"minLength":60,"maxLength":20000},"author":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"blogPosts"},"category":{"type":"relation","relation":"manyToOne","target":"api::category.category"},"views":{"type":"integer","default":0,"min":0,"required":true},"usefulBase":{"type":"integer","default":0,"min":0,"required":true},"usefulBy":{"type":"relation","relation":"manyToMany","target":"plugin::users-permissions.user","inversedBy":"usefulBlogPosts"},"comments":{"type":"relation","relation":"oneToMany","target":"api::blog-comment.blog-comment","mappedBy":"post"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::blog-post.blog-post","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"blog_posts"}}},"apiName":"blog-post","globalId":"BlogPost","uid":"api::blog-post.blog-post","modelType":"contentType","__schema__":{"collectionName":"blog_posts","info":{"singularName":"blog-post","pluralName":"blog-posts","displayName":"Blog post","description":"Billet de blog publié par un membre"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"title":{"type":"string","required":true,"minLength":10,"maxLength":120},"content":{"type":"text","required":true,"minLength":60,"maxLength":20000},"author":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"blogPosts"},"category":{"type":"relation","relation":"manyToOne","target":"api::category.category"},"views":{"type":"integer","default":0,"min":0,"required":true},"usefulBase":{"type":"integer","default":0,"min":0,"required":true},"usefulBy":{"type":"relation","relation":"manyToMany","target":"plugin::users-permissions.user","inversedBy":"usefulBlogPosts"},"comments":{"type":"relation","relation":"oneToMany","target":"api::blog-comment.blog-comment","mappedBy":"post"}},"kind":"collectionType"},"modelName":"blog-post","actions":{},"lifecycles":{}},"api::category.category":{"kind":"collectionType","collectionName":"categories","info":{"singularName":"category","pluralName":"categories","displayName":"Category","description":"Espace thématique de la communauté"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"name":{"type":"string","required":true,"unique":true,"minLength":2,"maxLength":60},"slug":{"type":"uid","targetField":"name","required":true},"description":{"type":"text","maxLength":300},"icon":{"type":"string","required":true,"default":"coffee","maxLength":30},"color":{"type":"string","required":true,"default":"#8e8e93","regex":"^#[0-9a-fA-F]{6}$"},"siteSection":{"type":"string","maxLength":80},"discussions":{"type":"relation","relation":"oneToMany","target":"api::discussion.discussion","mappedBy":"category"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::category.category","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"categories"}}},"apiName":"category","globalId":"Category","uid":"api::category.category","modelType":"contentType","__schema__":{"collectionName":"categories","info":{"singularName":"category","pluralName":"categories","displayName":"Category","description":"Espace thématique de la communauté"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"name":{"type":"string","required":true,"unique":true,"minLength":2,"maxLength":60},"slug":{"type":"uid","targetField":"name","required":true},"description":{"type":"text","maxLength":300},"icon":{"type":"string","required":true,"default":"coffee","maxLength":30},"color":{"type":"string","required":true,"default":"#8e8e93","regex":"^#[0-9a-fA-F]{6}$"},"siteSection":{"type":"string","maxLength":80},"discussions":{"type":"relation","relation":"oneToMany","target":"api::discussion.discussion","mappedBy":"category"}},"kind":"collectionType"},"modelName":"category","actions":{},"lifecycles":{}},"api::discussion.discussion":{"kind":"collectionType","collectionName":"discussions","info":{"singularName":"discussion","pluralName":"discussions","displayName":"Discussion","description":"Question ou discussion ouverte par un membre"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"title":{"type":"string","required":true,"minLength":10,"maxLength":160},"slug":{"type":"uid","targetField":"title","required":true},"content":{"type":"text","maxLength":10000},"type":{"type":"enumeration","required":true,"default":"discussion","enum":["question","discussion","poll"]},"author":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","required":true,"inversedBy":"discussions"},"category":{"type":"relation","relation":"manyToOne","target":"api::category.category","required":true,"inversedBy":"discussions"},"replies":{"type":"relation","relation":"oneToMany","target":"api::reply.reply","mappedBy":"discussion"},"article":{"type":"string","maxLength":200},"pinned":{"type":"boolean","default":false,"required":true},"featured":{"type":"enumeration","enum":["question","poll"]},"views":{"type":"integer","default":0,"min":0,"required":true},"pollOptions":{"type":"json"},"pollVotes":{"type":"json"},"usefulBy":{"type":"relation","relation":"manyToMany","target":"plugin::users-permissions.user","inversedBy":"usefulDiscussions"},"followedBy":{"type":"relation","relation":"manyToMany","target":"plugin::users-permissions.user","inversedBy":"followedDiscussions"},"usefulBase":{"type":"integer","default":0,"min":0,"required":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::discussion.discussion","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"discussions"}}},"apiName":"discussion","globalId":"Discussion","uid":"api::discussion.discussion","modelType":"contentType","__schema__":{"collectionName":"discussions","info":{"singularName":"discussion","pluralName":"discussions","displayName":"Discussion","description":"Question ou discussion ouverte par un membre"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"title":{"type":"string","required":true,"minLength":10,"maxLength":160},"slug":{"type":"uid","targetField":"title","required":true},"content":{"type":"text","maxLength":10000},"type":{"type":"enumeration","required":true,"default":"discussion","enum":["question","discussion","poll"]},"author":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","required":true,"inversedBy":"discussions"},"category":{"type":"relation","relation":"manyToOne","target":"api::category.category","required":true,"inversedBy":"discussions"},"replies":{"type":"relation","relation":"oneToMany","target":"api::reply.reply","mappedBy":"discussion"},"article":{"type":"string","maxLength":200},"pinned":{"type":"boolean","default":false,"required":true},"featured":{"type":"enumeration","enum":["question","poll"]},"views":{"type":"integer","default":0,"min":0,"required":true},"pollOptions":{"type":"json"},"pollVotes":{"type":"json"},"usefulBy":{"type":"relation","relation":"manyToMany","target":"plugin::users-permissions.user","inversedBy":"usefulDiscussions"},"followedBy":{"type":"relation","relation":"manyToMany","target":"plugin::users-permissions.user","inversedBy":"followedDiscussions"},"usefulBase":{"type":"integer","default":0,"min":0,"required":true}},"kind":"collectionType"},"modelName":"discussion","actions":{},"lifecycles":{}},"api::event.event":{"kind":"collectionType","collectionName":"events","info":{"singularName":"event","pluralName":"events","displayName":"Event","description":"Rendez-vous de la communauté, programmé par la rédaction"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"title":{"type":"string","required":true,"maxLength":160},"host":{"type":"string","required":true,"maxLength":120},"startsAt":{"type":"datetime","required":true},"category":{"type":"relation","relation":"manyToOne","target":"api::category.category"},"goingBase":{"type":"integer","default":0,"min":0,"required":true},"attendees":{"type":"relation","relation":"manyToMany","target":"plugin::users-permissions.user","inversedBy":"events"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::event.event","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"events"}}},"apiName":"event","globalId":"Event","uid":"api::event.event","modelType":"contentType","__schema__":{"collectionName":"events","info":{"singularName":"event","pluralName":"events","displayName":"Event","description":"Rendez-vous de la communauté, programmé par la rédaction"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"title":{"type":"string","required":true,"maxLength":160},"host":{"type":"string","required":true,"maxLength":120},"startsAt":{"type":"datetime","required":true},"category":{"type":"relation","relation":"manyToOne","target":"api::category.category"},"goingBase":{"type":"integer","default":0,"min":0,"required":true},"attendees":{"type":"relation","relation":"manyToMany","target":"plugin::users-permissions.user","inversedBy":"events"}},"kind":"collectionType"},"modelName":"event","actions":{},"lifecycles":{}},"api::notification.notification":{"kind":"collectionType","collectionName":"notifications","info":{"singularName":"notification","pluralName":"notifications","displayName":"Notification","description":"Avis adressé à un membre (réponse, « Utile », mention, badge…)"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"recipient":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user"},"kind":{"type":"enumeration","required":true,"enum":["reply","like","mention","badge","solution","level","event"]},"actor":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user"},"discussion":{"type":"relation","relation":"manyToOne","target":"api::discussion.discussion"},"blogPost":{"type":"relation","relation":"manyToOne","target":"api::blog-post.blog-post"},"badge":{"type":"string","maxLength":40},"text":{"type":"string","required":true,"maxLength":200},"read":{"type":"boolean","default":false,"required":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::notification.notification","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"notifications"}}},"apiName":"notification","globalId":"Notification","uid":"api::notification.notification","modelType":"contentType","__schema__":{"collectionName":"notifications","info":{"singularName":"notification","pluralName":"notifications","displayName":"Notification","description":"Avis adressé à un membre (réponse, « Utile », mention, badge…)"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"recipient":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user"},"kind":{"type":"enumeration","required":true,"enum":["reply","like","mention","badge","solution","level","event"]},"actor":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user"},"discussion":{"type":"relation","relation":"manyToOne","target":"api::discussion.discussion"},"blogPost":{"type":"relation","relation":"manyToOne","target":"api::blog-post.blog-post"},"badge":{"type":"string","maxLength":40},"text":{"type":"string","required":true,"maxLength":200},"read":{"type":"boolean","default":false,"required":true}},"kind":"collectionType"},"modelName":"notification","actions":{},"lifecycles":{}},"api::reply.reply":{"kind":"collectionType","collectionName":"replies","info":{"singularName":"reply","pluralName":"replies","displayName":"Reply","description":"Réponse d''un membre à une discussion"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"content":{"type":"text","required":true,"minLength":1},"isBestAnswer":{"type":"boolean","default":false,"required":true},"author":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","required":true,"inversedBy":"replies"},"discussion":{"type":"relation","relation":"manyToOne","target":"api::discussion.discussion","required":true,"inversedBy":"replies"},"verified":{"type":"boolean","default":false,"required":true},"usefulBy":{"type":"relation","relation":"manyToMany","target":"plugin::users-permissions.user","inversedBy":"usefulReplies"},"usefulBase":{"type":"integer","default":0,"min":0,"required":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::reply.reply","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"replies"}}},"apiName":"reply","globalId":"Reply","uid":"api::reply.reply","modelType":"contentType","__schema__":{"collectionName":"replies","info":{"singularName":"reply","pluralName":"replies","displayName":"Reply","description":"Réponse d''un membre à une discussion"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"content":{"type":"text","required":true,"minLength":1},"isBestAnswer":{"type":"boolean","default":false,"required":true},"author":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","required":true,"inversedBy":"replies"},"discussion":{"type":"relation","relation":"manyToOne","target":"api::discussion.discussion","required":true,"inversedBy":"replies"},"verified":{"type":"boolean","default":false,"required":true},"usefulBy":{"type":"relation","relation":"manyToMany","target":"plugin::users-permissions.user","inversedBy":"usefulReplies"},"usefulBase":{"type":"integer","default":0,"min":0,"required":true}},"kind":"collectionType"},"modelName":"reply","actions":{},"lifecycles":{}},"api::reward.reward":{"kind":"collectionType","collectionName":"rewards","info":{"singularName":"reward","pluralName":"rewards","displayName":"Reward","description":"Historique des points versés ; la clé empêche de verser deux fois la même récompense"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"key":{"type":"string","unique":true,"maxLength":160},"recipient":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user"},"points":{"type":"integer","required":true},"reason":{"type":"string","required":true,"maxLength":120},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::reward.reward","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"rewards"}}},"apiName":"reward","globalId":"Reward","uid":"api::reward.reward","modelType":"contentType","__schema__":{"collectionName":"rewards","info":{"singularName":"reward","pluralName":"rewards","displayName":"Reward","description":"Historique des points versés ; la clé empêche de verser deux fois la même récompense"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"key":{"type":"string","unique":true,"maxLength":160},"recipient":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user"},"points":{"type":"integer","required":true},"reason":{"type":"string","required":true,"maxLength":120}},"kind":"collectionType"},"modelName":"reward","actions":{},"lifecycles":{}},"admin::permission":{"collectionName":"admin_permissions","info":{"name":"Permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"actionParameters":{"type":"json","configurable":false,"required":false,"default":{}},"subject":{"type":"string","minLength":1,"configurable":false,"required":false},"properties":{"type":"json","configurable":false,"required":false,"default":{}},"conditions":{"type":"json","configurable":false,"required":false,"default":[]},"role":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::role","required":false},"apiToken":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"adminPermissions","target":"admin::api-token","required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"admin_permissions"}}},"plugin":"admin","globalId":"AdminPermission","uid":"admin::permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"admin_permissions","info":{"name":"Permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"actionParameters":{"type":"json","configurable":false,"required":false,"default":{}},"subject":{"type":"string","minLength":1,"configurable":false,"required":false},"properties":{"type":"json","configurable":false,"required":false,"default":{}},"conditions":{"type":"json","configurable":false,"required":false,"default":[]},"role":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::role","required":false},"apiToken":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"adminPermissions","target":"admin::api-token","required":false}},"kind":"collectionType"},"modelName":"permission"},"admin::user":{"collectionName":"admin_users","info":{"name":"User","description":"","singularName":"user","pluralName":"users","displayName":"User"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"firstname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"lastname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"username":{"type":"string","unique":false,"configurable":false,"required":false},"email":{"type":"email","minLength":6,"configurable":false,"required":true,"unique":true,"private":true},"password":{"type":"password","minLength":6,"configurable":false,"required":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"resetPasswordTokenExpiresAt":{"type":"datetime","configurable":false,"private":true,"searchable":false},"registrationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"isActive":{"type":"boolean","default":false,"configurable":false,"private":true},"roles":{"configurable":false,"private":true,"type":"relation","relation":"manyToMany","inversedBy":"users","target":"admin::role","collectionName":"strapi_users_roles"},"apiTokens":{"configurable":false,"private":true,"type":"relation","relation":"oneToMany","mappedBy":"adminUserOwner","target":"admin::api-token"},"blocked":{"type":"boolean","default":false,"configurable":false,"private":true},"preferedLanguage":{"type":"string","configurable":false,"required":false,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::user","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"admin_users"}}},"config":{"attributes":{"resetPasswordToken":{"hidden":true},"registrationToken":{"hidden":true}}},"plugin":"admin","globalId":"AdminUser","uid":"admin::user","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"admin_users","info":{"name":"User","description":"","singularName":"user","pluralName":"users","displayName":"User"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"firstname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"lastname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"username":{"type":"string","unique":false,"configurable":false,"required":false},"email":{"type":"email","minLength":6,"configurable":false,"required":true,"unique":true,"private":true},"password":{"type":"password","minLength":6,"configurable":false,"required":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"resetPasswordTokenExpiresAt":{"type":"datetime","configurable":false,"private":true,"searchable":false},"registrationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"isActive":{"type":"boolean","default":false,"configurable":false,"private":true},"roles":{"configurable":false,"private":true,"type":"relation","relation":"manyToMany","inversedBy":"users","target":"admin::role","collectionName":"strapi_users_roles"},"apiTokens":{"configurable":false,"private":true,"type":"relation","relation":"oneToMany","mappedBy":"adminUserOwner","target":"admin::api-token"},"blocked":{"type":"boolean","default":false,"configurable":false,"private":true},"preferedLanguage":{"type":"string","configurable":false,"required":false,"searchable":false}},"kind":"collectionType"},"modelName":"user","options":{"draftAndPublish":false}},"admin::role":{"collectionName":"admin_roles","info":{"name":"Role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"code":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"description":{"type":"string","configurable":false},"users":{"configurable":false,"type":"relation","relation":"manyToMany","mappedBy":"roles","target":"admin::user"},"permissions":{"configurable":false,"type":"relation","relation":"oneToMany","mappedBy":"role","target":"admin::permission"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::role","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"admin_roles"}}},"plugin":"admin","globalId":"AdminRole","uid":"admin::role","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"admin_roles","info":{"name":"Role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"code":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"description":{"type":"string","configurable":false},"users":{"configurable":false,"type":"relation","relation":"manyToMany","mappedBy":"roles","target":"admin::user"},"permissions":{"configurable":false,"type":"relation","relation":"oneToMany","mappedBy":"role","target":"admin::permission"}},"kind":"collectionType"},"modelName":"role"},"admin::api-token":{"collectionName":"strapi_api_tokens","info":{"name":"Api Token","singularName":"api-token","pluralName":"api-tokens","displayName":"Api Token","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"kind":{"type":"enumeration","enum":["content-api","admin"],"configurable":false,"required":true,"default":"content-api"},"type":{"type":"enumeration","enum":["read-only","full-access","custom"],"configurable":false,"required":false,"default":"read-only"},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true,"searchable":false},"encryptedKey":{"type":"text","minLength":1,"configurable":false,"required":false,"searchable":false},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::api-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"adminPermissions":{"type":"relation","target":"admin::permission","relation":"oneToMany","mappedBy":"apiToken","configurable":false,"required":false},"adminUserOwner":{"type":"relation","target":"admin::user","relation":"manyToOne","inversedBy":"apiTokens","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::api-token","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_api_tokens"}}},"plugin":"admin","globalId":"AdminApiToken","uid":"admin::api-token","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_api_tokens","info":{"name":"Api Token","singularName":"api-token","pluralName":"api-tokens","displayName":"Api Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"kind":{"type":"enumeration","enum":["content-api","admin"],"configurable":false,"required":true,"default":"content-api"},"type":{"type":"enumeration","enum":["read-only","full-access","custom"],"configurable":false,"required":false,"default":"read-only"},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true,"searchable":false},"encryptedKey":{"type":"text","minLength":1,"configurable":false,"required":false,"searchable":false},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::api-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"adminPermissions":{"type":"relation","target":"admin::permission","relation":"oneToMany","mappedBy":"apiToken","configurable":false,"required":false},"adminUserOwner":{"type":"relation","target":"admin::user","relation":"manyToOne","inversedBy":"apiTokens","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false}},"kind":"collectionType"},"modelName":"api-token"},"admin::api-token-permission":{"collectionName":"strapi_api_token_permissions","info":{"name":"API Token Permission","description":"","singularName":"api-token-permission","pluralName":"api-token-permissions","displayName":"API Token Permission"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::api-token"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::api-token-permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_api_token_permissions"}}},"plugin":"admin","globalId":"AdminApiTokenPermission","uid":"admin::api-token-permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_api_token_permissions","info":{"name":"API Token Permission","description":"","singularName":"api-token-permission","pluralName":"api-token-permissions","displayName":"API Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::api-token"}},"kind":"collectionType"},"modelName":"api-token-permission"},"admin::transfer-token":{"collectionName":"strapi_transfer_tokens","info":{"name":"Transfer Token","singularName":"transfer-token","pluralName":"transfer-tokens","displayName":"Transfer Token","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::transfer-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::transfer-token","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_transfer_tokens"}}},"plugin":"admin","globalId":"AdminTransferToken","uid":"admin::transfer-token","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_transfer_tokens","info":{"name":"Transfer Token","singularName":"transfer-token","pluralName":"transfer-tokens","displayName":"Transfer Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::transfer-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false}},"kind":"collectionType"},"modelName":"transfer-token"},"admin::transfer-token-permission":{"collectionName":"strapi_transfer_token_permissions","info":{"name":"Transfer Token Permission","description":"","singularName":"transfer-token-permission","pluralName":"transfer-token-permissions","displayName":"Transfer Token Permission"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::transfer-token"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::transfer-token-permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_transfer_token_permissions"}}},"plugin":"admin","globalId":"AdminTransferTokenPermission","uid":"admin::transfer-token-permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_transfer_token_permissions","info":{"name":"Transfer Token Permission","description":"","singularName":"transfer-token-permission","pluralName":"transfer-token-permissions","displayName":"Transfer Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::transfer-token"}},"kind":"collectionType"},"modelName":"transfer-token-permission"},"admin::session":{"collectionName":"strapi_sessions","info":{"name":"Session","description":"Session Manager storage","singularName":"session","pluralName":"sessions","displayName":"Session"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false},"i18n":{"localized":false}},"attributes":{"userId":{"type":"string","required":true,"configurable":false,"private":true,"searchable":false},"sessionId":{"type":"string","unique":true,"required":true,"configurable":false,"private":true,"searchable":false},"childId":{"type":"string","configurable":false,"private":true,"searchable":false},"deviceId":{"type":"string","required":true,"configurable":false,"private":true,"searchable":false},"origin":{"type":"string","required":true,"configurable":false,"private":true,"searchable":false},"expiresAt":{"type":"datetime","required":true,"configurable":false,"private":true,"searchable":false},"absoluteExpiresAt":{"type":"datetime","configurable":false,"private":true,"searchable":false},"status":{"type":"string","configurable":false,"private":true,"searchable":false},"type":{"type":"string","configurable":false,"private":true,"searchable":false},"metadata":{"type":"json","configurable":false,"private":true,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::session","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_sessions"}}},"plugin":"admin","globalId":"AdminSession","uid":"admin::session","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_sessions","info":{"name":"Session","description":"Session Manager storage","singularName":"session","pluralName":"sessions","displayName":"Session"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false},"i18n":{"localized":false}},"attributes":{"userId":{"type":"string","required":true,"configurable":false,"private":true,"searchable":false},"sessionId":{"type":"string","unique":true,"required":true,"configurable":false,"private":true,"searchable":false},"childId":{"type":"string","configurable":false,"private":true,"searchable":false},"deviceId":{"type":"string","required":true,"configurable":false,"private":true,"searchable":false},"origin":{"type":"string","required":true,"configurable":false,"private":true,"searchable":false},"expiresAt":{"type":"datetime","required":true,"configurable":false,"private":true,"searchable":false},"absoluteExpiresAt":{"type":"datetime","configurable":false,"private":true,"searchable":false},"status":{"type":"string","configurable":false,"private":true,"searchable":false},"type":{"type":"string","configurable":false,"private":true,"searchable":false},"metadata":{"type":"json","configurable":false,"private":true,"searchable":false}},"kind":"collectionType"},"modelName":"session"}}', 'object', NULL, NULL),
	(4, 'plugin_content_manager_configuration_content_types::plugin::content-releases.release', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"releasedAt":{"edit":{"label":"releasedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"releasedAt","searchable":true,"sortable":true}},"scheduledAt":{"edit":{"label":"scheduledAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"scheduledAt","searchable":true,"sortable":true}},"timezone":{"edit":{"label":"timezone","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"timezone","searchable":true,"sortable":true}},"status":{"edit":{"label":"status","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"status","searchable":true,"sortable":true}},"actions":{"edit":{"label":"actions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"contentType"},"list":{"label":"actions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","releasedAt","scheduledAt"],"edit":[[{"name":"name","size":6},{"name":"releasedAt","size":6}],[{"name":"scheduledAt","size":6},{"name":"timezone","size":6}],[{"name":"status","size":6},{"name":"actions","size":6}]]},"uid":"plugin::content-releases.release"}', 'object', NULL, NULL),
	(3, 'plugin_content_manager_configuration_content_types::plugin::upload.file', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"alternativeText":{"edit":{"label":"alternativeText","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"alternativeText","searchable":true,"sortable":true}},"caption":{"edit":{"label":"caption","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"caption","searchable":true,"sortable":true}},"focalPoint":{"edit":{"label":"focalPoint","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"focalPoint","searchable":false,"sortable":false}},"width":{"edit":{"label":"width","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"width","searchable":true,"sortable":true}},"height":{"edit":{"label":"height","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"height","searchable":true,"sortable":true}},"formats":{"edit":{"label":"formats","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"formats","searchable":false,"sortable":false}},"hash":{"edit":{"label":"hash","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"hash","searchable":true,"sortable":true}},"ext":{"edit":{"label":"ext","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"ext","searchable":true,"sortable":true}},"mime":{"edit":{"label":"mime","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"mime","searchable":true,"sortable":true}},"size":{"edit":{"label":"size","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"size","searchable":true,"sortable":true}},"url":{"edit":{"label":"url","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"url","searchable":true,"sortable":true}},"previewUrl":{"edit":{"label":"previewUrl","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"previewUrl","searchable":true,"sortable":true}},"provider":{"edit":{"label":"provider","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"provider","searchable":true,"sortable":true}},"provider_metadata":{"edit":{"label":"provider_metadata","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"provider_metadata","searchable":false,"sortable":false}},"folder":{"edit":{"label":"folder","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"folder","searchable":true,"sortable":true}},"folderPath":{"edit":{"label":"folderPath","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"folderPath","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","alternativeText","caption"],"edit":[[{"name":"name","size":6},{"name":"alternativeText","size":6}],[{"name":"caption","size":6}],[{"name":"focalPoint","size":12}],[{"name":"width","size":4},{"name":"height","size":4}],[{"name":"formats","size":12}],[{"name":"hash","size":6},{"name":"ext","size":6}],[{"name":"mime","size":6},{"name":"size","size":4}],[{"name":"url","size":6},{"name":"previewUrl","size":6}],[{"name":"provider","size":6}],[{"name":"provider_metadata","size":12}],[{"name":"folder","size":6},{"name":"folderPath","size":6}]]},"uid":"plugin::upload.file"}', 'object', NULL, NULL),
	(5, 'plugin_content_manager_configuration_content_types::plugin::content-releases.release-action', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"contentType","defaultSortBy":"contentType","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"contentType":{"edit":{"label":"contentType","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"contentType","searchable":true,"sortable":true}},"entryDocumentId":{"edit":{"label":"entryDocumentId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"entryDocumentId","searchable":true,"sortable":true}},"release":{"edit":{"label":"release","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"release","searchable":true,"sortable":true}},"isEntryValid":{"edit":{"label":"isEntryValid","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isEntryValid","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","type","contentType","entryDocumentId"],"edit":[[{"name":"type","size":6},{"name":"contentType","size":6}],[{"name":"entryDocumentId","size":6},{"name":"release","size":6}],[{"name":"isEntryValid","size":4}]]},"uid":"plugin::content-releases.release-action"}', 'object', NULL, NULL),
	(6, 'plugin_content_manager_configuration_content_types::plugin::review-workflows.workflow', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"stages":{"edit":{"label":"stages","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"stages","searchable":false,"sortable":false}},"stageRequiredToPublish":{"edit":{"label":"stageRequiredToPublish","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"stageRequiredToPublish","searchable":true,"sortable":true}},"contentTypes":{"edit":{"label":"contentTypes","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"contentTypes","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","stages","stageRequiredToPublish"],"edit":[[{"name":"name","size":6},{"name":"stages","size":6}],[{"name":"stageRequiredToPublish","size":6}],[{"name":"contentTypes","size":12}]]},"uid":"plugin::review-workflows.workflow"}', 'object', NULL, NULL),
	(7, 'plugin_content_manager_configuration_content_types::plugin::review-workflows.workflow-stage', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"color":{"edit":{"label":"color","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"color","searchable":true,"sortable":true}},"workflow":{"edit":{"label":"workflow","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"workflow","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","color","workflow"],"edit":[[{"name":"name","size":6},{"name":"color","size":6}],[{"name":"workflow","size":6},{"name":"permissions","size":6}]]},"uid":"plugin::review-workflows.workflow-stage"}', 'object', NULL, NULL),
	(8, 'plugin_content_manager_configuration_content_types::plugin::users-permissions.permission', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","role","createdAt"],"edit":[[{"name":"action","size":6},{"name":"role","size":6}]]},"uid":"plugin::users-permissions.permission"}', 'object', NULL, NULL),
	(9, 'plugin_content_manager_configuration_content_types::plugin::upload.folder', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"pathId":{"edit":{"label":"pathId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"pathId","searchable":true,"sortable":true}},"parent":{"edit":{"label":"parent","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"parent","searchable":true,"sortable":true}},"children":{"edit":{"label":"children","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"children","searchable":false,"sortable":false}},"files":{"edit":{"label":"files","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"files","searchable":false,"sortable":false}},"path":{"edit":{"label":"path","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"path","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","pathId","parent"],"edit":[[{"name":"name","size":6},{"name":"pathId","size":4}],[{"name":"parent","size":6},{"name":"children","size":6}],[{"name":"files","size":6},{"name":"path","size":6}]]},"uid":"plugin::upload.folder"}', 'object', NULL, NULL),
	(10, 'plugin_content_manager_configuration_content_types::plugin::i18n.locale', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","code","createdAt"],"edit":[[{"name":"name","size":6},{"name":"code","size":6}]]},"uid":"plugin::i18n.locale"}', 'object', NULL, NULL),
	(11, 'plugin_content_manager_configuration_content_types::plugin::users-permissions.role', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"users":{"edit":{"label":"users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"users","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","type"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"type","size":6},{"name":"permissions","size":6}],[{"name":"users","size":6}]]},"uid":"plugin::users-permissions.role"}', 'object', NULL, NULL),
	(14, 'plugin_content_manager_configuration_content_types::api::blog-post.blog-post', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"title","defaultSortBy":"title","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"title":{"edit":{"label":"title","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"title","searchable":true,"sortable":true}},"content":{"edit":{"label":"content","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"content","searchable":true,"sortable":true}},"author":{"edit":{"label":"author","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"author","searchable":true,"sortable":true}},"category":{"edit":{"label":"category","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"category","searchable":true,"sortable":true}},"views":{"edit":{"label":"views","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"views","searchable":true,"sortable":true}},"usefulBase":{"edit":{"label":"usefulBase","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"usefulBase","searchable":true,"sortable":true}},"usefulBy":{"edit":{"label":"usefulBy","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"usefulBy","searchable":false,"sortable":false}},"comments":{"edit":{"label":"comments","description":"","placeholder":"","visible":true,"editable":true,"mainField":"documentId"},"list":{"label":"comments","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","title","content","author"],"edit":[[{"name":"title","size":6},{"name":"content","size":6}],[{"name":"author","size":6},{"name":"category","size":6}],[{"name":"views","size":4},{"name":"usefulBase","size":4}],[{"name":"usefulBy","size":6},{"name":"comments","size":6}]]},"uid":"api::blog-post.blog-post"}', 'object', NULL, NULL),
	(15, 'plugin_content_manager_configuration_content_types::api::category.category', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"slug":{"edit":{"label":"slug","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"slug","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"icon":{"edit":{"label":"icon","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"icon","searchable":true,"sortable":true}},"color":{"edit":{"label":"color","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"color","searchable":true,"sortable":true}},"siteSection":{"edit":{"label":"siteSection","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"siteSection","searchable":true,"sortable":true}},"discussions":{"edit":{"label":"discussions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"discussions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","slug","description"],"edit":[[{"name":"name","size":6},{"name":"slug","size":6}],[{"name":"description","size":6},{"name":"icon","size":6}],[{"name":"color","size":6},{"name":"siteSection","size":6}],[{"name":"discussions","size":6}]]},"uid":"api::category.category"}', 'object', NULL, NULL),
	(16, 'plugin_content_manager_configuration_content_types::api::discussion.discussion', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"title","defaultSortBy":"title","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"title":{"edit":{"label":"title","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"title","searchable":true,"sortable":true}},"slug":{"edit":{"label":"slug","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"slug","searchable":true,"sortable":true}},"content":{"edit":{"label":"content","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"content","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"author":{"edit":{"label":"author","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"author","searchable":true,"sortable":true}},"category":{"edit":{"label":"category","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"category","searchable":true,"sortable":true}},"replies":{"edit":{"label":"replies","description":"","placeholder":"","visible":true,"editable":true,"mainField":"documentId"},"list":{"label":"replies","searchable":false,"sortable":false}},"article":{"edit":{"label":"article","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"article","searchable":true,"sortable":true}},"pinned":{"edit":{"label":"pinned","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"pinned","searchable":true,"sortable":true}},"featured":{"edit":{"label":"featured","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"featured","searchable":true,"sortable":true}},"views":{"edit":{"label":"views","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"views","searchable":true,"sortable":true}},"pollOptions":{"edit":{"label":"pollOptions","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"pollOptions","searchable":false,"sortable":false}},"pollVotes":{"edit":{"label":"pollVotes","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"pollVotes","searchable":false,"sortable":false}},"usefulBy":{"edit":{"label":"usefulBy","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"usefulBy","searchable":false,"sortable":false}},"followedBy":{"edit":{"label":"followedBy","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"followedBy","searchable":false,"sortable":false}},"usefulBase":{"edit":{"label":"usefulBase","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"usefulBase","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","title","slug","content"],"edit":[[{"name":"title","size":6},{"name":"slug","size":6}],[{"name":"content","size":6},{"name":"type","size":6}],[{"name":"author","size":6},{"name":"category","size":6}],[{"name":"replies","size":6},{"name":"article","size":6}],[{"name":"pinned","size":4},{"name":"featured","size":6}],[{"name":"views","size":4}],[{"name":"pollOptions","size":12}],[{"name":"pollVotes","size":12}],[{"name":"usefulBy","size":6},{"name":"followedBy","size":6}],[{"name":"usefulBase","size":4}]]},"uid":"api::discussion.discussion"}', 'object', NULL, NULL),
	(19, 'plugin_content_manager_configuration_content_types::api::reply.reply', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"documentId","defaultSortBy":"documentId","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"content":{"edit":{"label":"content","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"content","searchable":true,"sortable":true}},"isBestAnswer":{"edit":{"label":"isBestAnswer","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isBestAnswer","searchable":true,"sortable":true}},"author":{"edit":{"label":"author","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"author","searchable":true,"sortable":true}},"discussion":{"edit":{"label":"discussion","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"discussion","searchable":true,"sortable":true}},"verified":{"edit":{"label":"verified","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"verified","searchable":true,"sortable":true}},"usefulBy":{"edit":{"label":"usefulBy","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"usefulBy","searchable":false,"sortable":false}},"usefulBase":{"edit":{"label":"usefulBase","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"usefulBase","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","content","isBestAnswer","author"],"edit":[[{"name":"content","size":6},{"name":"isBestAnswer","size":4}],[{"name":"author","size":6},{"name":"discussion","size":6}],[{"name":"verified","size":4},{"name":"usefulBy","size":6}],[{"name":"usefulBase","size":4}]]},"uid":"api::reply.reply"}', 'object', NULL, NULL),
	(22, 'plugin_content_manager_configuration_content_types::admin::role', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"users":{"edit":{"label":"users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"firstname"},"list":{"label":"users","searchable":false,"sortable":false}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","code","description"],"edit":[[{"name":"name","size":6},{"name":"code","size":6}],[{"name":"description","size":6},{"name":"users","size":6}],[{"name":"permissions","size":6}]]},"uid":"admin::role"}', 'object', NULL, NULL),
	(36, 'core_admin_auth', '{"providers":{"autoRegister":false,"defaultRole":null,"ssoLockedRoles":null}}', 'object', NULL, NULL),
	(13, 'plugin_content_manager_configuration_content_types::api::blog-comment.blog-comment', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"documentId","defaultSortBy":"documentId","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"content":{"edit":{"label":"content","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"content","searchable":true,"sortable":true}},"author":{"edit":{"label":"author","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"author","searchable":true,"sortable":true}},"post":{"edit":{"label":"post","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"post","searchable":true,"sortable":true}},"usefulBase":{"edit":{"label":"usefulBase","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"usefulBase","searchable":true,"sortable":true}},"usefulBy":{"edit":{"label":"usefulBy","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"usefulBy","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","content","author","post"],"edit":[[{"name":"content","size":6},{"name":"author","size":6}],[{"name":"post","size":6},{"name":"usefulBase","size":4}],[{"name":"usefulBy","size":6}]]},"uid":"api::blog-comment.blog-comment"}', 'object', NULL, NULL),
	(17, 'plugin_content_manager_configuration_content_types::api::event.event', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"title","defaultSortBy":"title","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"title":{"edit":{"label":"title","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"title","searchable":true,"sortable":true}},"host":{"edit":{"label":"host","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"host","searchable":true,"sortable":true}},"startsAt":{"edit":{"label":"startsAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"startsAt","searchable":true,"sortable":true}},"category":{"edit":{"label":"category","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"category","searchable":true,"sortable":true}},"goingBase":{"edit":{"label":"goingBase","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"goingBase","searchable":true,"sortable":true}},"attendees":{"edit":{"label":"attendees","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"attendees","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","title","host","startsAt"],"edit":[[{"name":"title","size":6},{"name":"host","size":6}],[{"name":"startsAt","size":6},{"name":"category","size":6}],[{"name":"goingBase","size":4},{"name":"attendees","size":6}]]},"uid":"api::event.event"}', 'object', NULL, NULL),
	(21, 'plugin_content_manager_configuration_content_types::admin::permission', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"actionParameters":{"edit":{"label":"actionParameters","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"actionParameters","searchable":false,"sortable":false}},"subject":{"edit":{"label":"subject","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"subject","searchable":true,"sortable":true}},"properties":{"edit":{"label":"properties","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"properties","searchable":false,"sortable":false}},"conditions":{"edit":{"label":"conditions","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"conditions","searchable":false,"sortable":false}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"apiToken":{"edit":{"label":"apiToken","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"apiToken","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","subject","role"],"edit":[[{"name":"action","size":6}],[{"name":"actionParameters","size":12}],[{"name":"subject","size":6}],[{"name":"properties","size":12}],[{"name":"conditions","size":12}],[{"name":"role","size":6},{"name":"apiToken","size":6}]]},"uid":"admin::permission"}', 'object', NULL, NULL),
	(12, 'plugin_content_manager_configuration_content_types::plugin::users-permissions.user', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"username","defaultSortBy":"username","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"username":{"edit":{"label":"username","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"username","searchable":true,"sortable":true}},"email":{"edit":{"label":"email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"email","searchable":true,"sortable":true}},"provider":{"edit":{"label":"provider","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"provider","searchable":true,"sortable":true}},"password":{"edit":{"label":"password","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"password","searchable":true,"sortable":true}},"resetPasswordToken":{"edit":{"label":"resetPasswordToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"resetPasswordToken","searchable":true,"sortable":true}},"confirmationToken":{"edit":{"label":"confirmationToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"confirmationToken","searchable":true,"sortable":true}},"confirmed":{"edit":{"label":"confirmed","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"confirmed","searchable":true,"sortable":true}},"blocked":{"edit":{"label":"blocked","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"blocked","searchable":true,"sortable":true}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"displayName":{"edit":{"label":"displayName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"displayName","searchable":true,"sortable":true}},"avatar":{"edit":{"label":"avatar","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"avatar","searchable":false,"sortable":false}},"bio":{"edit":{"label":"bio","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"bio","searchable":true,"sortable":true}},"discussions":{"edit":{"label":"discussions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"discussions","searchable":false,"sortable":false}},"replies":{"edit":{"label":"replies","description":"","placeholder":"","visible":true,"editable":true,"mainField":"documentId"},"list":{"label":"replies","searchable":false,"sortable":false}},"interests":{"edit":{"label":"interests","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"interests","searchable":false,"sortable":false}},"usefulDiscussions":{"edit":{"label":"usefulDiscussions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"usefulDiscussions","searchable":false,"sortable":false}},"followedDiscussions":{"edit":{"label":"followedDiscussions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"followedDiscussions","searchable":false,"sortable":false}},"usefulReplies":{"edit":{"label":"usefulReplies","description":"","placeholder":"","visible":true,"editable":true,"mainField":"documentId"},"list":{"label":"usefulReplies","searchable":false,"sortable":false}},"communityRole":{"edit":{"label":"communityRole","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"communityRole","searchable":true,"sortable":true}},"avatarColor":{"edit":{"label":"avatarColor","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"avatarColor","searchable":true,"sortable":true}},"subscriber":{"edit":{"label":"subscriber","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"subscriber","searchable":true,"sortable":true}},"expertTitle":{"edit":{"label":"expertTitle","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expertTitle","searchable":true,"sortable":true}},"points":{"edit":{"label":"points","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"points","searchable":true,"sortable":true}},"monthPoints":{"edit":{"label":"monthPoints","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"monthPoints","searchable":true,"sortable":true}},"monthKey":{"edit":{"label":"monthKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"monthKey","searchable":true,"sortable":true}},"streak":{"edit":{"label":"streak","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"streak","searchable":true,"sortable":true}},"badges":{"edit":{"label":"badges","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"badges","searchable":false,"sortable":false}},"stats":{"edit":{"label":"stats","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"stats","searchable":false,"sortable":false}},"blogPosts":{"edit":{"label":"blogPosts","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"blogPosts","searchable":false,"sortable":false}},"blogComments":{"edit":{"label":"blogComments","description":"","placeholder":"","visible":true,"editable":true,"mainField":"documentId"},"list":{"label":"blogComments","searchable":false,"sortable":false}},"usefulBlogPosts":{"edit":{"label":"usefulBlogPosts","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"usefulBlogPosts","searchable":false,"sortable":false}},"usefulBlogComments":{"edit":{"label":"usefulBlogComments","description":"","placeholder":"","visible":true,"editable":true,"mainField":"documentId"},"list":{"label":"usefulBlogComments","searchable":false,"sortable":false}},"events":{"edit":{"label":"events","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"events","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","username","email","confirmed"],"edit":[[{"name":"username","size":6},{"name":"email","size":6}],[{"name":"password","size":6},{"name":"confirmed","size":4}],[{"name":"blocked","size":4},{"name":"role","size":6}],[{"name":"displayName","size":6},{"name":"avatar","size":6}],[{"name":"bio","size":6},{"name":"discussions","size":6}],[{"name":"replies","size":6}],[{"name":"interests","size":12}],[{"name":"usefulDiscussions","size":6},{"name":"followedDiscussions","size":6}],[{"name":"usefulReplies","size":6},{"name":"communityRole","size":6}],[{"name":"avatarColor","size":6},{"name":"subscriber","size":4}],[{"name":"expertTitle","size":6},{"name":"points","size":4}],[{"name":"monthPoints","size":4},{"name":"monthKey","size":6}],[{"name":"streak","size":4}],[{"name":"badges","size":12}],[{"name":"stats","size":12}],[{"name":"blogPosts","size":6},{"name":"blogComments","size":6}],[{"name":"usefulBlogPosts","size":6},{"name":"usefulBlogComments","size":6}],[{"name":"events","size":6}]]},"uid":"plugin::users-permissions.user"}', 'object', NULL, NULL),
	(18, 'plugin_content_manager_configuration_content_types::api::notification.notification', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"badge","defaultSortBy":"badge","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"recipient":{"edit":{"label":"recipient","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"recipient","searchable":true,"sortable":true}},"kind":{"edit":{"label":"kind","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"kind","searchable":true,"sortable":true}},"actor":{"edit":{"label":"actor","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"actor","searchable":true,"sortable":true}},"discussion":{"edit":{"label":"discussion","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"discussion","searchable":true,"sortable":true}},"blogPost":{"edit":{"label":"blogPost","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"blogPost","searchable":true,"sortable":true}},"badge":{"edit":{"label":"badge","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"badge","searchable":true,"sortable":true}},"text":{"edit":{"label":"text","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"text","searchable":true,"sortable":true}},"read":{"edit":{"label":"read","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"read","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","recipient","kind","actor"],"edit":[[{"name":"recipient","size":6},{"name":"kind","size":6}],[{"name":"actor","size":6},{"name":"discussion","size":6}],[{"name":"blogPost","size":6},{"name":"badge","size":6}],[{"name":"text","size":6},{"name":"read","size":4}]]},"uid":"api::notification.notification"}', 'object', NULL, NULL),
	(20, 'plugin_content_manager_configuration_content_types::api::reward.reward', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"key","defaultSortBy":"key","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"key":{"edit":{"label":"key","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"key","searchable":true,"sortable":true}},"recipient":{"edit":{"label":"recipient","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"recipient","searchable":true,"sortable":true}},"points":{"edit":{"label":"points","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"points","searchable":true,"sortable":true}},"reason":{"edit":{"label":"reason","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"reason","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","key","recipient","points"],"edit":[[{"name":"key","size":6},{"name":"recipient","size":6}],[{"name":"points","size":4},{"name":"reason","size":6}]]},"uid":"api::reward.reward"}', 'object', NULL, NULL),
	(24, 'plugin_content_manager_configuration_content_types::admin::api-token-permission', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"token":{"edit":{"label":"token","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"token","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","token","createdAt"],"edit":[[{"name":"action","size":6},{"name":"token","size":6}]]},"uid":"admin::api-token-permission"}', 'object', NULL, NULL),
	(27, 'plugin_content_manager_configuration_content_types::admin::api-token', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"kind":{"edit":{"label":"kind","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"kind","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"accessKey":{"edit":{"label":"accessKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"accessKey","searchable":true,"sortable":true}},"encryptedKey":{"edit":{"label":"encryptedKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"encryptedKey","searchable":true,"sortable":true}},"lastUsedAt":{"edit":{"label":"lastUsedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastUsedAt","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"adminPermissions":{"edit":{"label":"adminPermissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"adminPermissions","searchable":false,"sortable":false}},"adminUserOwner":{"edit":{"label":"adminUserOwner","description":"","placeholder":"","visible":true,"editable":true,"mainField":"firstname"},"list":{"label":"adminUserOwner","searchable":true,"sortable":true}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"lifespan":{"edit":{"label":"lifespan","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lifespan","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","kind"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"kind","size":6},{"name":"type","size":6}],[{"name":"accessKey","size":6},{"name":"encryptedKey","size":6}],[{"name":"lastUsedAt","size":6},{"name":"permissions","size":6}],[{"name":"adminPermissions","size":6},{"name":"adminUserOwner","size":6}],[{"name":"expiresAt","size":6},{"name":"lifespan","size":4}]]},"uid":"admin::api-token"}', 'object', NULL, NULL),
	(23, 'plugin_content_manager_configuration_content_types::admin::user', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"firstname","defaultSortBy":"firstname","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"firstname":{"edit":{"label":"firstname","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"firstname","searchable":true,"sortable":true}},"lastname":{"edit":{"label":"lastname","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastname","searchable":true,"sortable":true}},"username":{"edit":{"label":"username","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"username","searchable":true,"sortable":true}},"email":{"edit":{"label":"email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"email","searchable":true,"sortable":true}},"password":{"edit":{"label":"password","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"password","searchable":true,"sortable":true}},"resetPasswordToken":{"edit":{"label":"resetPasswordToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"resetPasswordToken","searchable":true,"sortable":true}},"resetPasswordTokenExpiresAt":{"edit":{"label":"resetPasswordTokenExpiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"resetPasswordTokenExpiresAt","searchable":true,"sortable":true}},"registrationToken":{"edit":{"label":"registrationToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"registrationToken","searchable":true,"sortable":true}},"isActive":{"edit":{"label":"isActive","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isActive","searchable":true,"sortable":true}},"roles":{"edit":{"label":"roles","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"roles","searchable":false,"sortable":false}},"apiTokens":{"edit":{"label":"apiTokens","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"apiTokens","searchable":false,"sortable":false}},"blocked":{"edit":{"label":"blocked","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"blocked","searchable":true,"sortable":true}},"preferedLanguage":{"edit":{"label":"preferedLanguage","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"preferedLanguage","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","firstname","lastname","username"],"edit":[[{"name":"firstname","size":6},{"name":"lastname","size":6}],[{"name":"username","size":6},{"name":"email","size":6}],[{"name":"password","size":6},{"name":"resetPasswordTokenExpiresAt","size":6}],[{"name":"isActive","size":4},{"name":"roles","size":6}],[{"name":"apiTokens","size":6},{"name":"blocked","size":4}],[{"name":"preferedLanguage","size":6}]]},"uid":"admin::user"}', 'object', NULL, NULL),
	(25, 'plugin_content_manager_configuration_content_types::admin::transfer-token', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"accessKey":{"edit":{"label":"accessKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"accessKey","searchable":true,"sortable":true}},"lastUsedAt":{"edit":{"label":"lastUsedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastUsedAt","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"lifespan":{"edit":{"label":"lifespan","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lifespan","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","accessKey"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"accessKey","size":6},{"name":"lastUsedAt","size":6}],[{"name":"permissions","size":6},{"name":"expiresAt","size":6}],[{"name":"lifespan","size":4}]]},"uid":"admin::transfer-token"}', 'object', NULL, NULL),
	(28, 'plugin_content_manager_configuration_content_types::admin::session', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"userId","defaultSortBy":"userId","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"userId":{"edit":{"label":"userId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"userId","searchable":true,"sortable":true}},"sessionId":{"edit":{"label":"sessionId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"sessionId","searchable":true,"sortable":true}},"childId":{"edit":{"label":"childId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"childId","searchable":true,"sortable":true}},"deviceId":{"edit":{"label":"deviceId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"deviceId","searchable":true,"sortable":true}},"origin":{"edit":{"label":"origin","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"origin","searchable":true,"sortable":true}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"absoluteExpiresAt":{"edit":{"label":"absoluteExpiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"absoluteExpiresAt","searchable":true,"sortable":true}},"status":{"edit":{"label":"status","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"status","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"metadata":{"edit":{"label":"metadata","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"metadata","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","userId","sessionId","childId"],"edit":[[{"name":"userId","size":6},{"name":"sessionId","size":6}],[{"name":"childId","size":6},{"name":"deviceId","size":6}],[{"name":"origin","size":6},{"name":"expiresAt","size":6}],[{"name":"absoluteExpiresAt","size":6},{"name":"status","size":6}],[{"name":"type","size":6}],[{"name":"metadata","size":12}]]},"uid":"admin::session"}', 'object', NULL, NULL),
	(29, 'plugin_upload_settings', '{"sizeOptimization":true,"responsiveDimensions":true,"autoOrientation":false,"aiMetadata":true}', 'object', NULL, NULL),
	(26, 'plugin_content_manager_configuration_content_types::admin::transfer-token-permission', '{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"token":{"edit":{"label":"token","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"token","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","token","createdAt"],"edit":[[{"name":"action","size":6},{"name":"token","size":6}]]},"uid":"admin::transfer-token-permission"}', 'object', NULL, NULL),
	(30, 'plugin_upload_view_configuration', '{"pageSize":10,"sort":"createdAt:DESC"}', 'object', NULL, NULL),
	(31, 'plugin_upload_metrics', '{"weeklySchedule":"42 0 15 * * 2"}', 'object', NULL, NULL),
	(32, 'plugin_i18n_default_locale', '"en"', 'string', NULL, NULL),
	(33, 'plugin_users-permissions_grant', '{"email":{"icon":"envelope","enabled":true},"discord":{"icon":"discord","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/discord/callback","scope":["identify","email"]},"facebook":{"icon":"facebook-square","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/facebook/callback","scope":["email"]},"google":{"icon":"google","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/google/callback","scope":["email"]},"github":{"icon":"github","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/github/callback","scope":["user","user:email"]},"microsoft":{"icon":"windows","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/microsoft/callback","scope":["user.read"]},"twitter":{"icon":"twitter","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/twitter/callback"},"instagram":{"icon":"instagram","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/instagram/callback","scope":["user_profile"]},"vk":{"icon":"vk","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/vk/callback","scope":["email"]},"twitch":{"icon":"twitch","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/twitch/callback","scope":["user:read:email"]},"linkedin":{"icon":"linkedin","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/linkedin/callback","scope":["r_liteprofile","r_emailaddress"]},"cognito":{"icon":"aws","enabled":false,"key":"","secret":"","subdomain":"my.subdomain.com","callback":"api/auth/cognito/callback","scope":["email","openid","profile"]},"reddit":{"icon":"reddit","enabled":false,"key":"","secret":"","callback":"api/auth/reddit/callback","scope":["identity"]},"auth0":{"icon":"","enabled":false,"key":"","secret":"","subdomain":"my-tenant.eu","callback":"api/auth/auth0/callback","scope":["openid","email","profile"]},"cas":{"icon":"book","enabled":false,"key":"","secret":"","callback":"api/auth/cas/callback","scope":["openid email"],"subdomain":"my.subdomain.com/cas"},"patreon":{"icon":"","enabled":false,"key":"","secret":"","callback":"api/auth/patreon/callback","scope":["identity","identity[email]"]},"keycloak":{"icon":"","enabled":false,"key":"","secret":"","subdomain":"myKeycloakProvider.com/realms/myrealm","callback":"api/auth/keycloak/callback","scope":["openid","email","profile"]}}', 'object', NULL, NULL),
	(34, 'plugin_users-permissions_email', '{"reset_password":{"display":"Email.template.reset_password","icon":"sync","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Reset password","message":"<p>We heard that you lost your password. Sorry about that!</p>\n\n<p>But don’t worry! You can use the following link to reset your password:</p>\n<p><%= URL %>?code=<%= TOKEN %></p>\n\n<p>Thanks.</p>"}},"email_confirmation":{"display":"Email.template.email_confirmation","icon":"check-square","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Account confirmation","message":"<p>Thank you for registering!</p>\n\n<p>You have to confirm your email address. Please click on the link below.</p>\n\n<p><%= URL %>?confirmation=<%= CODE %></p>\n\n<p>Thanks.</p>"}}}', 'object', NULL, NULL),
	(35, 'plugin_users-permissions_advanced', '{"unique_email":true,"allow_register":true,"email_confirmation":false,"email_reset_password":null,"email_confirmation_redirection":null,"default_role":"authenticated"}', 'object', NULL, NULL);


--
-- Data for Name: strapi_database_schema; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.strapi_database_schema VALUES
	(1, '{"tables":[{"name":"files","indexes":[{"name":"upload_files_folder_path_index","columns":["folder_path"],"type":null},{"name":"upload_files_created_at_index","columns":["created_at"],"type":null},{"name":"upload_files_updated_at_index","columns":["updated_at"],"type":null},{"name":"upload_files_name_index","columns":["name"],"type":null},{"name":"upload_files_size_index","columns":["size"],"type":null},{"name":"upload_files_ext_index","columns":["ext"],"type":null},{"name":"files_documents_idx","columns":["document_id","locale","published_at"]},{"name":"files_created_by_id_fk","columns":["created_by_id"]},{"name":"files_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"files_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"files_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"alternative_text","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"caption","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"focal_point","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"width","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"height","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"formats","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"hash","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"ext","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"mime","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"size","type":"decimal","args":[10,2],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"preview_url","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider_metadata","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"folder_path","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"upload_folders","indexes":[{"name":"upload_folders_path_id_index","columns":["path_id"],"type":"unique"},{"name":"upload_folders_path_index","columns":["path"],"type":"unique"},{"name":"upload_folders_documents_idx","columns":["document_id","locale","published_at"]},{"name":"upload_folders_created_by_id_fk","columns":["created_by_id"]},{"name":"upload_folders_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"upload_folders_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"upload_folders_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"path_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"path","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"i18n_locale","indexes":[{"name":"i18n_locale_documents_idx","columns":["document_id","locale","published_at"]},{"name":"i18n_locale_created_by_id_fk","columns":["created_by_id"]},{"name":"i18n_locale_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"i18n_locale_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"i18n_locale_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_releases","indexes":[{"name":"strapi_releases_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_releases_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_releases_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_releases_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_releases_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"released_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"scheduled_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"timezone","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_release_actions","indexes":[{"name":"strapi_release_actions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_release_actions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_release_actions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_release_actions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_release_actions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"content_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"entry_document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_entry_valid","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows","indexes":[{"name":"strapi_workflows_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_workflows_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_workflows_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_workflows_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_workflows_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"content_types","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_workflows_stages","indexes":[{"name":"strapi_workflows_stages_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_workflows_stages_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_workflows_stages_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_workflows_stages_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_workflows_stages_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"color","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"up_permissions","indexes":[{"name":"up_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"up_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"up_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"up_roles","indexes":[{"name":"up_roles_documents_idx","columns":["document_id","locale","published_at"]},{"name":"up_roles_created_by_id_fk","columns":["created_by_id"]},{"name":"up_roles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_roles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_roles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"up_users","indexes":[{"name":"up_users_documents_idx","columns":["document_id","locale","published_at"]},{"name":"up_users_created_by_id_fk","columns":["created_by_id"]},{"name":"up_users_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_users_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_users_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"username","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"password","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_password_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"confirmation_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"confirmed","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"blocked","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"display_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"bio","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"interests","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"community_role","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"avatar_color","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"subscriber","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expert_title","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"points","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"month_points","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"month_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"streak","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"badges","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"stats","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"blog_comments","indexes":[{"name":"blog_comments_documents_idx","columns":["document_id","locale","published_at"]},{"name":"blog_comments_created_by_id_fk","columns":["created_by_id"]},{"name":"blog_comments_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"blog_comments_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"blog_comments_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"content","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"useful_base","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"blog_posts","indexes":[{"name":"blog_posts_documents_idx","columns":["document_id","locale","published_at"]},{"name":"blog_posts_created_by_id_fk","columns":["created_by_id"]},{"name":"blog_posts_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"blog_posts_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"blog_posts_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"title","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"content","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"views","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"useful_base","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"categories","indexes":[{"name":"categories_documents_idx","columns":["document_id","locale","published_at"]},{"name":"categories_created_by_id_fk","columns":["created_by_id"]},{"name":"categories_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"categories_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"categories_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"slug","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"icon","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"color","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"site_section","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"discussions","indexes":[{"name":"discussions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"discussions_created_by_id_fk","columns":["created_by_id"]},{"name":"discussions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"discussions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"discussions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"title","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"slug","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"content","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"article","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"pinned","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"featured","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"views","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"poll_options","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"poll_votes","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"useful_base","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"events","indexes":[{"name":"events_documents_idx","columns":["document_id","locale","published_at"]},{"name":"events_created_by_id_fk","columns":["created_by_id"]},{"name":"events_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"events_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"events_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"title","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"host","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"starts_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"going_base","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"notifications","indexes":[{"name":"notifications_documents_idx","columns":["document_id","locale","published_at"]},{"name":"notifications_created_by_id_fk","columns":["created_by_id"]},{"name":"notifications_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"notifications_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"notifications_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"kind","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"badge","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"text","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"read","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"replies","indexes":[{"name":"replies_documents_idx","columns":["document_id","locale","published_at"]},{"name":"replies_created_by_id_fk","columns":["created_by_id"]},{"name":"replies_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"replies_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"replies_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"content","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_best_answer","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"verified","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"useful_base","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"rewards","indexes":[{"name":"rewards_documents_idx","columns":["document_id","locale","published_at"]},{"name":"rewards_created_by_id_fk","columns":["created_by_id"]},{"name":"rewards_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"rewards_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"rewards_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"points","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reason","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_permissions","indexes":[{"name":"admin_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"admin_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action_parameters","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"subject","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"properties","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"conditions","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_users","indexes":[{"name":"admin_users_documents_idx","columns":["document_id","locale","published_at"]},{"name":"admin_users_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_users_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_users_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_users_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"firstname","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lastname","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"username","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"password","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_password_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_password_token_expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"registration_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"blocked","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"prefered_language","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_roles","indexes":[{"name":"admin_roles_documents_idx","columns":["document_id","locale","published_at"]},{"name":"admin_roles_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_roles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_roles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_roles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_api_tokens","indexes":[{"name":"strapi_api_tokens_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_api_tokens_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_api_tokens_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_api_tokens_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_api_tokens_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"kind","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"encrypted_key","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"last_used_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lifespan","type":"bigInteger","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_api_token_permissions","indexes":[{"name":"strapi_api_token_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_api_token_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_api_token_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_api_token_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_api_token_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_transfer_tokens","indexes":[{"name":"strapi_transfer_tokens_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_transfer_tokens_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_transfer_tokens_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_transfer_tokens_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_transfer_tokens_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"last_used_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lifespan","type":"bigInteger","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_transfer_token_permissions","indexes":[{"name":"strapi_transfer_token_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_transfer_token_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_transfer_token_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_transfer_token_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_transfer_token_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_sessions","indexes":[{"name":"strapi_sessions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_sessions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_sessions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_sessions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_sessions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"user_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"session_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"child_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"device_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"origin","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"absolute_expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"metadata","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_core_store_settings","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"value","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"environment","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"tag","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_webhooks","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"headers","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"events","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"enabled","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_history_versions","indexes":[{"name":"strapi_history_versions_created_by_id_fk","columns":["created_by_id"]}],"foreignKeys":[{"name":"strapi_history_versions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"content_type","type":"string","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"related_document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"data","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"schema","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_ai_metadata_jobs","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"completed_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_ai_localization_jobs","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"content_type","type":"string","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"related_document_id","type":"string","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"source_locale","type":"string","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"target_locales","type":"jsonb","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"files_related_mph","indexes":[{"name":"files_related_mph_fk","columns":["file_id"]},{"name":"files_related_mph_oidx","columns":["order"]},{"name":"files_related_mph_idix","columns":["related_id"]}],"foreignKeys":[{"name":"files_related_mph_fk","columns":["file_id"],"referencedColumns":["id"],"referencedTable":"files","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"file_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"related_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"related_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"field","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"files_folder_lnk","indexes":[{"name":"files_folder_lnk_fk","columns":["file_id"]},{"name":"files_folder_lnk_ifk","columns":["folder_id"]},{"name":"files_folder_lnk_uq","columns":["file_id","folder_id"],"type":"unique"},{"name":"files_folder_lnk_oifk","columns":["file_ord"]}],"foreignKeys":[{"name":"files_folder_lnk_fk","columns":["file_id"],"referencedColumns":["id"],"referencedTable":"files","onDelete":"CASCADE"},{"name":"files_folder_lnk_ifk","columns":["folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"file_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"file_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"upload_folders_parent_lnk","indexes":[{"name":"upload_folders_parent_lnk_fk","columns":["folder_id"]},{"name":"upload_folders_parent_lnk_ifk","columns":["inv_folder_id"]},{"name":"upload_folders_parent_lnk_uq","columns":["folder_id","inv_folder_id"],"type":"unique"},{"name":"upload_folders_parent_lnk_oifk","columns":["folder_ord"]}],"foreignKeys":[{"name":"upload_folders_parent_lnk_fk","columns":["folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"},{"name":"upload_folders_parent_lnk_ifk","columns":["inv_folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"folder_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_release_actions_release_lnk","indexes":[{"name":"strapi_release_actions_release_lnk_fk","columns":["release_action_id"]},{"name":"strapi_release_actions_release_lnk_ifk","columns":["release_id"]},{"name":"strapi_release_actions_release_lnk_uq","columns":["release_action_id","release_id"],"type":"unique"},{"name":"strapi_release_actions_release_lnk_oifk","columns":["release_action_ord"]}],"foreignKeys":[{"name":"strapi_release_actions_release_lnk_fk","columns":["release_action_id"],"referencedColumns":["id"],"referencedTable":"strapi_release_actions","onDelete":"CASCADE"},{"name":"strapi_release_actions_release_lnk_ifk","columns":["release_id"],"referencedColumns":["id"],"referencedTable":"strapi_releases","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"release_action_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"release_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"release_action_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows_stage_required_to_publish_lnk","indexes":[{"name":"strapi_workflows_stage_required_to_publish_lnk_fk","columns":["workflow_id"]},{"name":"strapi_workflows_stage_required_to_publish_lnk_ifk","columns":["workflow_stage_id"]},{"name":"strapi_workflows_stage_required_to_publish_lnk_uq","columns":["workflow_id","workflow_stage_id"],"type":"unique"}],"foreignKeys":[{"name":"strapi_workflows_stage_required_to_publish_lnk_fk","columns":["workflow_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows","onDelete":"CASCADE"},{"name":"strapi_workflows_stage_required_to_publish_lnk_ifk","columns":["workflow_stage_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows_stages","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"workflow_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"workflow_stage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows_stages_workflow_lnk","indexes":[{"name":"strapi_workflows_stages_workflow_lnk_fk","columns":["workflow_stage_id"]},{"name":"strapi_workflows_stages_workflow_lnk_ifk","columns":["workflow_id"]},{"name":"strapi_workflows_stages_workflow_lnk_uq","columns":["workflow_stage_id","workflow_id"],"type":"unique"},{"name":"strapi_workflows_stages_workflow_lnk_oifk","columns":["workflow_stage_ord"]}],"foreignKeys":[{"name":"strapi_workflows_stages_workflow_lnk_fk","columns":["workflow_stage_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows_stages","onDelete":"CASCADE"},{"name":"strapi_workflows_stages_workflow_lnk_ifk","columns":["workflow_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"workflow_stage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"workflow_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"workflow_stage_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows_stages_permissions_lnk","indexes":[{"name":"strapi_workflows_stages_permissions_lnk_fk","columns":["workflow_stage_id"]},{"name":"strapi_workflows_stages_permissions_lnk_ifk","columns":["permission_id"]},{"name":"strapi_workflows_stages_permissions_lnk_uq","columns":["workflow_stage_id","permission_id"],"type":"unique"},{"name":"strapi_workflows_stages_permissions_lnk_ofk","columns":["permission_ord"]}],"foreignKeys":[{"name":"strapi_workflows_stages_permissions_lnk_fk","columns":["workflow_stage_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows_stages","onDelete":"CASCADE"},{"name":"strapi_workflows_stages_permissions_lnk_ifk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"admin_permissions","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"workflow_stage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_permissions_role_lnk","indexes":[{"name":"up_permissions_role_lnk_fk","columns":["permission_id"]},{"name":"up_permissions_role_lnk_ifk","columns":["role_id"]},{"name":"up_permissions_role_lnk_uq","columns":["permission_id","role_id"],"type":"unique"},{"name":"up_permissions_role_lnk_oifk","columns":["permission_ord"]}],"foreignKeys":[{"name":"up_permissions_role_lnk_fk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"up_permissions","onDelete":"CASCADE"},{"name":"up_permissions_role_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"up_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_users_role_lnk","indexes":[{"name":"up_users_role_lnk_fk","columns":["user_id"]},{"name":"up_users_role_lnk_ifk","columns":["role_id"]},{"name":"up_users_role_lnk_uq","columns":["user_id","role_id"],"type":"unique"},{"name":"up_users_role_lnk_oifk","columns":["user_ord"]}],"foreignKeys":[{"name":"up_users_role_lnk_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"},{"name":"up_users_role_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"up_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"blog_comments_author_lnk","indexes":[{"name":"blog_comments_author_lnk_fk","columns":["blog_comment_id"]},{"name":"blog_comments_author_lnk_ifk","columns":["user_id"]},{"name":"blog_comments_author_lnk_uq","columns":["blog_comment_id","user_id"],"type":"unique"},{"name":"blog_comments_author_lnk_oifk","columns":["blog_comment_ord"]}],"foreignKeys":[{"name":"blog_comments_author_lnk_fk","columns":["blog_comment_id"],"referencedColumns":["id"],"referencedTable":"blog_comments","onDelete":"CASCADE"},{"name":"blog_comments_author_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"blog_comment_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"blog_comment_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"blog_comments_post_lnk","indexes":[{"name":"blog_comments_post_lnk_fk","columns":["blog_comment_id"]},{"name":"blog_comments_post_lnk_ifk","columns":["blog_post_id"]},{"name":"blog_comments_post_lnk_uq","columns":["blog_comment_id","blog_post_id"],"type":"unique"},{"name":"blog_comments_post_lnk_oifk","columns":["blog_comment_ord"]}],"foreignKeys":[{"name":"blog_comments_post_lnk_fk","columns":["blog_comment_id"],"referencedColumns":["id"],"referencedTable":"blog_comments","onDelete":"CASCADE"},{"name":"blog_comments_post_lnk_ifk","columns":["blog_post_id"],"referencedColumns":["id"],"referencedTable":"blog_posts","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"blog_comment_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"blog_post_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"blog_comment_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"blog_comments_useful_by_lnk","indexes":[{"name":"blog_comments_useful_by_lnk_fk","columns":["blog_comment_id"]},{"name":"blog_comments_useful_by_lnk_ifk","columns":["user_id"]},{"name":"blog_comments_useful_by_lnk_uq","columns":["blog_comment_id","user_id"],"type":"unique"},{"name":"blog_comments_useful_by_lnk_ofk","columns":["user_ord"]},{"name":"blog_comments_useful_by_lnk_oifk","columns":["blog_comment_ord"]}],"foreignKeys":[{"name":"blog_comments_useful_by_lnk_fk","columns":["blog_comment_id"],"referencedColumns":["id"],"referencedTable":"blog_comments","onDelete":"CASCADE"},{"name":"blog_comments_useful_by_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"blog_comment_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"blog_comment_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"blog_posts_author_lnk","indexes":[{"name":"blog_posts_author_lnk_fk","columns":["blog_post_id"]},{"name":"blog_posts_author_lnk_ifk","columns":["user_id"]},{"name":"blog_posts_author_lnk_uq","columns":["blog_post_id","user_id"],"type":"unique"},{"name":"blog_posts_author_lnk_oifk","columns":["blog_post_ord"]}],"foreignKeys":[{"name":"blog_posts_author_lnk_fk","columns":["blog_post_id"],"referencedColumns":["id"],"referencedTable":"blog_posts","onDelete":"CASCADE"},{"name":"blog_posts_author_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"blog_post_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"blog_post_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"blog_posts_category_lnk","indexes":[{"name":"blog_posts_category_lnk_fk","columns":["blog_post_id"]},{"name":"blog_posts_category_lnk_ifk","columns":["category_id"]},{"name":"blog_posts_category_lnk_uq","columns":["blog_post_id","category_id"],"type":"unique"}],"foreignKeys":[{"name":"blog_posts_category_lnk_fk","columns":["blog_post_id"],"referencedColumns":["id"],"referencedTable":"blog_posts","onDelete":"CASCADE"},{"name":"blog_posts_category_lnk_ifk","columns":["category_id"],"referencedColumns":["id"],"referencedTable":"categories","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"blog_post_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"category_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"blog_posts_useful_by_lnk","indexes":[{"name":"blog_posts_useful_by_lnk_fk","columns":["blog_post_id"]},{"name":"blog_posts_useful_by_lnk_ifk","columns":["user_id"]},{"name":"blog_posts_useful_by_lnk_uq","columns":["blog_post_id","user_id"],"type":"unique"},{"name":"blog_posts_useful_by_lnk_ofk","columns":["user_ord"]},{"name":"blog_posts_useful_by_lnk_oifk","columns":["blog_post_ord"]}],"foreignKeys":[{"name":"blog_posts_useful_by_lnk_fk","columns":["blog_post_id"],"referencedColumns":["id"],"referencedTable":"blog_posts","onDelete":"CASCADE"},{"name":"blog_posts_useful_by_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"blog_post_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"blog_post_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"discussions_author_lnk","indexes":[{"name":"discussions_author_lnk_fk","columns":["discussion_id"]},{"name":"discussions_author_lnk_ifk","columns":["user_id"]},{"name":"discussions_author_lnk_uq","columns":["discussion_id","user_id"],"type":"unique"},{"name":"discussions_author_lnk_oifk","columns":["discussion_ord"]}],"foreignKeys":[{"name":"discussions_author_lnk_fk","columns":["discussion_id"],"referencedColumns":["id"],"referencedTable":"discussions","onDelete":"CASCADE"},{"name":"discussions_author_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"discussion_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"discussion_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"discussions_category_lnk","indexes":[{"name":"discussions_category_lnk_fk","columns":["discussion_id"]},{"name":"discussions_category_lnk_ifk","columns":["category_id"]},{"name":"discussions_category_lnk_uq","columns":["discussion_id","category_id"],"type":"unique"},{"name":"discussions_category_lnk_oifk","columns":["discussion_ord"]}],"foreignKeys":[{"name":"discussions_category_lnk_fk","columns":["discussion_id"],"referencedColumns":["id"],"referencedTable":"discussions","onDelete":"CASCADE"},{"name":"discussions_category_lnk_ifk","columns":["category_id"],"referencedColumns":["id"],"referencedTable":"categories","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"discussion_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"category_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"discussion_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"discussions_useful_by_lnk","indexes":[{"name":"discussions_useful_by_lnk_fk","columns":["discussion_id"]},{"name":"discussions_useful_by_lnk_ifk","columns":["user_id"]},{"name":"discussions_useful_by_lnk_uq","columns":["discussion_id","user_id"],"type":"unique"},{"name":"discussions_useful_by_lnk_ofk","columns":["user_ord"]},{"name":"discussions_useful_by_lnk_oifk","columns":["discussion_ord"]}],"foreignKeys":[{"name":"discussions_useful_by_lnk_fk","columns":["discussion_id"],"referencedColumns":["id"],"referencedTable":"discussions","onDelete":"CASCADE"},{"name":"discussions_useful_by_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"discussion_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"discussion_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"discussions_followed_by_lnk","indexes":[{"name":"discussions_followed_by_lnk_fk","columns":["discussion_id"]},{"name":"discussions_followed_by_lnk_ifk","columns":["user_id"]},{"name":"discussions_followed_by_lnk_uq","columns":["discussion_id","user_id"],"type":"unique"},{"name":"discussions_followed_by_lnk_ofk","columns":["user_ord"]},{"name":"discussions_followed_by_lnk_oifk","columns":["discussion_ord"]}],"foreignKeys":[{"name":"discussions_followed_by_lnk_fk","columns":["discussion_id"],"referencedColumns":["id"],"referencedTable":"discussions","onDelete":"CASCADE"},{"name":"discussions_followed_by_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"discussion_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"discussion_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"events_category_lnk","indexes":[{"name":"events_category_lnk_fk","columns":["event_id"]},{"name":"events_category_lnk_ifk","columns":["category_id"]},{"name":"events_category_lnk_uq","columns":["event_id","category_id"],"type":"unique"}],"foreignKeys":[{"name":"events_category_lnk_fk","columns":["event_id"],"referencedColumns":["id"],"referencedTable":"events","onDelete":"CASCADE"},{"name":"events_category_lnk_ifk","columns":["category_id"],"referencedColumns":["id"],"referencedTable":"categories","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"event_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"category_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"events_attendees_lnk","indexes":[{"name":"events_attendees_lnk_fk","columns":["event_id"]},{"name":"events_attendees_lnk_ifk","columns":["user_id"]},{"name":"events_attendees_lnk_uq","columns":["event_id","user_id"],"type":"unique"},{"name":"events_attendees_lnk_ofk","columns":["user_ord"]},{"name":"events_attendees_lnk_oifk","columns":["event_ord"]}],"foreignKeys":[{"name":"events_attendees_lnk_fk","columns":["event_id"],"referencedColumns":["id"],"referencedTable":"events","onDelete":"CASCADE"},{"name":"events_attendees_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"event_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"event_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"notifications_recipient_lnk","indexes":[{"name":"notifications_recipient_lnk_fk","columns":["notification_id"]},{"name":"notifications_recipient_lnk_ifk","columns":["user_id"]},{"name":"notifications_recipient_lnk_uq","columns":["notification_id","user_id"],"type":"unique"}],"foreignKeys":[{"name":"notifications_recipient_lnk_fk","columns":["notification_id"],"referencedColumns":["id"],"referencedTable":"notifications","onDelete":"CASCADE"},{"name":"notifications_recipient_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"notification_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"notifications_actor_lnk","indexes":[{"name":"notifications_actor_lnk_fk","columns":["notification_id"]},{"name":"notifications_actor_lnk_ifk","columns":["user_id"]},{"name":"notifications_actor_lnk_uq","columns":["notification_id","user_id"],"type":"unique"}],"foreignKeys":[{"name":"notifications_actor_lnk_fk","columns":["notification_id"],"referencedColumns":["id"],"referencedTable":"notifications","onDelete":"CASCADE"},{"name":"notifications_actor_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"notification_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"notifications_discussion_lnk","indexes":[{"name":"notifications_discussion_lnk_fk","columns":["notification_id"]},{"name":"notifications_discussion_lnk_ifk","columns":["discussion_id"]},{"name":"notifications_discussion_lnk_uq","columns":["notification_id","discussion_id"],"type":"unique"}],"foreignKeys":[{"name":"notifications_discussion_lnk_fk","columns":["notification_id"],"referencedColumns":["id"],"referencedTable":"notifications","onDelete":"CASCADE"},{"name":"notifications_discussion_lnk_ifk","columns":["discussion_id"],"referencedColumns":["id"],"referencedTable":"discussions","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"notification_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"discussion_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"notifications_blog_post_lnk","indexes":[{"name":"notifications_blog_post_lnk_fk","columns":["notification_id"]},{"name":"notifications_blog_post_lnk_ifk","columns":["blog_post_id"]},{"name":"notifications_blog_post_lnk_uq","columns":["notification_id","blog_post_id"],"type":"unique"}],"foreignKeys":[{"name":"notifications_blog_post_lnk_fk","columns":["notification_id"],"referencedColumns":["id"],"referencedTable":"notifications","onDelete":"CASCADE"},{"name":"notifications_blog_post_lnk_ifk","columns":["blog_post_id"],"referencedColumns":["id"],"referencedTable":"blog_posts","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"notification_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"blog_post_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"replies_author_lnk","indexes":[{"name":"replies_author_lnk_fk","columns":["reply_id"]},{"name":"replies_author_lnk_ifk","columns":["user_id"]},{"name":"replies_author_lnk_uq","columns":["reply_id","user_id"],"type":"unique"},{"name":"replies_author_lnk_oifk","columns":["reply_ord"]}],"foreignKeys":[{"name":"replies_author_lnk_fk","columns":["reply_id"],"referencedColumns":["id"],"referencedTable":"replies","onDelete":"CASCADE"},{"name":"replies_author_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"reply_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"reply_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"replies_discussion_lnk","indexes":[{"name":"replies_discussion_lnk_fk","columns":["reply_id"]},{"name":"replies_discussion_lnk_ifk","columns":["discussion_id"]},{"name":"replies_discussion_lnk_uq","columns":["reply_id","discussion_id"],"type":"unique"},{"name":"replies_discussion_lnk_oifk","columns":["reply_ord"]}],"foreignKeys":[{"name":"replies_discussion_lnk_fk","columns":["reply_id"],"referencedColumns":["id"],"referencedTable":"replies","onDelete":"CASCADE"},{"name":"replies_discussion_lnk_ifk","columns":["discussion_id"],"referencedColumns":["id"],"referencedTable":"discussions","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"reply_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"discussion_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"reply_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"replies_useful_by_lnk","indexes":[{"name":"replies_useful_by_lnk_fk","columns":["reply_id"]},{"name":"replies_useful_by_lnk_ifk","columns":["user_id"]},{"name":"replies_useful_by_lnk_uq","columns":["reply_id","user_id"],"type":"unique"},{"name":"replies_useful_by_lnk_ofk","columns":["user_ord"]},{"name":"replies_useful_by_lnk_oifk","columns":["reply_ord"]}],"foreignKeys":[{"name":"replies_useful_by_lnk_fk","columns":["reply_id"],"referencedColumns":["id"],"referencedTable":"replies","onDelete":"CASCADE"},{"name":"replies_useful_by_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"reply_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"reply_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"rewards_recipient_lnk","indexes":[{"name":"rewards_recipient_lnk_fk","columns":["reward_id"]},{"name":"rewards_recipient_lnk_ifk","columns":["user_id"]},{"name":"rewards_recipient_lnk_uq","columns":["reward_id","user_id"],"type":"unique"}],"foreignKeys":[{"name":"rewards_recipient_lnk_fk","columns":["reward_id"],"referencedColumns":["id"],"referencedTable":"rewards","onDelete":"CASCADE"},{"name":"rewards_recipient_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"reward_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_permissions_role_lnk","indexes":[{"name":"admin_permissions_role_lnk_fk","columns":["permission_id"]},{"name":"admin_permissions_role_lnk_ifk","columns":["role_id"]},{"name":"admin_permissions_role_lnk_uq","columns":["permission_id","role_id"],"type":"unique"},{"name":"admin_permissions_role_lnk_oifk","columns":["permission_ord"]}],"foreignKeys":[{"name":"admin_permissions_role_lnk_fk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"admin_permissions","onDelete":"CASCADE"},{"name":"admin_permissions_role_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"admin_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_permissions_api_token_lnk","indexes":[{"name":"admin_permissions_api_token_lnk_fk","columns":["permission_id"]},{"name":"admin_permissions_api_token_lnk_ifk","columns":["api_token_id"]},{"name":"admin_permissions_api_token_lnk_uq","columns":["permission_id","api_token_id"],"type":"unique"},{"name":"admin_permissions_api_token_lnk_oifk","columns":["permission_ord"]}],"foreignKeys":[{"name":"admin_permissions_api_token_lnk_fk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"admin_permissions","onDelete":"CASCADE"},{"name":"admin_permissions_api_token_lnk_ifk","columns":["api_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_tokens","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_users_roles_lnk","indexes":[{"name":"admin_users_roles_lnk_fk","columns":["user_id"]},{"name":"admin_users_roles_lnk_ifk","columns":["role_id"]},{"name":"admin_users_roles_lnk_uq","columns":["user_id","role_id"],"type":"unique"},{"name":"admin_users_roles_lnk_ofk","columns":["role_ord"]},{"name":"admin_users_roles_lnk_oifk","columns":["user_ord"]}],"foreignKeys":[{"name":"admin_users_roles_lnk_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"admin_users","onDelete":"CASCADE"},{"name":"admin_users_roles_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"admin_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_api_tokens_admin_user_owner_lnk","indexes":[{"name":"strapi_api_tokens_admin_user_owner_lnk_fk","columns":["api_token_id"]},{"name":"strapi_api_tokens_admin_user_owner_lnk_ifk","columns":["user_id"]},{"name":"strapi_api_tokens_admin_user_owner_lnk_uq","columns":["api_token_id","user_id"],"type":"unique"},{"name":"strapi_api_tokens_admin_user_owner_lnk_oifk","columns":["api_token_ord"]}],"foreignKeys":[{"name":"strapi_api_tokens_admin_user_owner_lnk_fk","columns":["api_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_tokens","onDelete":"CASCADE"},{"name":"strapi_api_tokens_admin_user_owner_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"admin_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"api_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_api_token_permissions_token_lnk","indexes":[{"name":"strapi_api_token_permissions_token_lnk_fk","columns":["api_token_permission_id"]},{"name":"strapi_api_token_permissions_token_lnk_ifk","columns":["api_token_id"]},{"name":"strapi_api_token_permissions_token_lnk_uq","columns":["api_token_permission_id","api_token_id"],"type":"unique"},{"name":"strapi_api_token_permissions_token_lnk_oifk","columns":["api_token_permission_ord"]}],"foreignKeys":[{"name":"strapi_api_token_permissions_token_lnk_fk","columns":["api_token_permission_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_token_permissions","onDelete":"CASCADE"},{"name":"strapi_api_token_permissions_token_lnk_ifk","columns":["api_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_tokens","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"api_token_permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_transfer_token_permissions_token_lnk","indexes":[{"name":"strapi_transfer_token_permissions_token_lnk_fk","columns":["transfer_token_permission_id"]},{"name":"strapi_transfer_token_permissions_token_lnk_ifk","columns":["transfer_token_id"]},{"name":"strapi_transfer_token_permissions_token_lnk_uq","columns":["transfer_token_permission_id","transfer_token_id"],"type":"unique"},{"name":"strapi_transfer_token_permissions_token_lnk_oifk","columns":["transfer_token_permission_ord"]}],"foreignKeys":[{"name":"strapi_transfer_token_permissions_token_lnk_fk","columns":["transfer_token_permission_id"],"referencedColumns":["id"],"referencedTable":"strapi_transfer_token_permissions","onDelete":"CASCADE"},{"name":"strapi_transfer_token_permissions_token_lnk_ifk","columns":["transfer_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_transfer_tokens","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"transfer_token_permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"transfer_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"transfer_token_permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]}]}', '2026-10-27 15:00:26.929', '41a12bc1f32353314cd18edf0be679da1371b7d494557a5dafbaf4ce50468be3');


--
-- Data for Name: strapi_history_versions; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: strapi_migrations; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: strapi_migrations_internal; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.strapi_migrations_internal VALUES
	(1, '5.0.0-rename-identifiers-longer-than-max-length', '2026-10-27 15:00:20.622'),
	(2, '5.0.0-02-created-document-id', '2026-10-27 15:00:20.799'),
	(3, '5.0.0-03-created-locale', '2026-10-27 15:00:20.941'),
	(4, '5.0.0-04-created-published-at', '2026-10-27 15:00:21.08'),
	(5, '5.0.0-05-drop-slug-fields-index', '2026-10-27 15:00:21.224'),
	(6, '5.0.0-06-add-document-id-indexes', '2026-10-27 15:00:21.231'),
	(7, 'core::5.0.0-discard-drafts', '2026-10-27 15:00:21.367'),
	(8, 'admin::migrate-prefered-language-dk-to-da', '2026-10-27 15:00:21.376'),
	(9, 'upload::unsign-richtext-and-blocks-urls', '2026-10-27 15:00:21.383');


--
-- Data for Name: strapi_release_actions; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: strapi_release_actions_release_lnk; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: strapi_releases; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: strapi_webhooks; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: strapi_workflows; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: strapi_workflows_stage_required_to_publish_lnk; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: strapi_workflows_stages; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: strapi_workflows_stages_permissions_lnk; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: strapi_workflows_stages_workflow_lnk; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: up_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.up_permissions VALUES
	(1, 'z3kvtkq954qzpmdv40tslhgg', 'plugin::users-permissions.auth.logout', '2026-10-27 15:00:28.025', '2026-10-27 15:00:28.025', '2026-10-27 15:00:28.026', NULL, NULL, NULL),
	(5, 'bt8hechthd1t6dhruef37vp6', 'plugin::users-permissions.auth.changePassword', '2026-10-27 15:00:28.025', '2026-10-27 15:00:28.025', '2026-10-27 15:00:28.027', NULL, NULL, NULL),
	(3, 'xenf1likopoyaych1yu56yut', 'plugin::users-permissions.auth.revokeSession', '2026-10-27 15:00:28.025', '2026-10-27 15:00:28.025', '2026-10-27 15:00:28.026', NULL, NULL, NULL),
	(2, 'r3z8wtx5mo31o64hq04bd3wl', 'plugin::users-permissions.auth.getSessions', '2026-10-27 15:00:28.025', '2026-10-27 15:00:28.025', '2026-10-27 15:00:28.026', NULL, NULL, NULL),
	(4, 'dgmraxyfe5au2g2v3fta5nca', 'plugin::users-permissions.user.me', '2026-10-27 15:00:28.025', '2026-10-27 15:00:28.025', '2026-10-27 15:00:28.027', NULL, NULL, NULL),
	(6, 'ev0rf2a268rmozrg854i6kda', 'plugin::users-permissions.auth.callback', '2026-10-27 15:00:28.154', '2026-10-27 15:00:28.154', '2026-10-27 15:00:28.155', NULL, NULL, NULL),
	(7, 'iga92t3s9qydgw08vvsgjmlm', 'plugin::users-permissions.auth.connect', '2026-10-27 15:00:28.154', '2026-10-27 15:00:28.154', '2026-10-27 15:00:28.155', NULL, NULL, NULL),
	(8, 'aa2wqxc7io3fwyjhgrnsflhx', 'plugin::users-permissions.auth.forgotPassword', '2026-10-27 15:00:28.154', '2026-10-27 15:00:28.154', '2026-10-27 15:00:28.156', NULL, NULL, NULL),
	(9, 'bf5qea3gtpa5obziad71qi38', 'plugin::users-permissions.auth.resetPassword', '2026-10-27 15:00:28.154', '2026-10-27 15:00:28.154', '2026-10-27 15:00:28.156', NULL, NULL, NULL),
	(10, 'lkcnbd2txojzvj54xovr6rwn', 'plugin::users-permissions.auth.register', '2026-10-27 15:00:28.154', '2026-10-27 15:00:28.154', '2026-10-27 15:00:28.157', NULL, NULL, NULL),
	(11, 'sa4y8aew7f80962b2r0edewf', 'plugin::users-permissions.auth.emailConfirmation', '2026-10-27 15:00:28.154', '2026-10-27 15:00:28.154', '2026-10-27 15:00:28.158', NULL, NULL, NULL),
	(12, 'upymzsx05ka75p2vf5ccmju5', 'plugin::users-permissions.auth.sendEmailConfirmation', '2026-10-27 15:00:28.154', '2026-10-27 15:00:28.154', '2026-10-27 15:00:28.158', NULL, NULL, NULL),
	(13, 'z0eippx4kw9ej5p7k2w95q5u', 'plugin::users-permissions.auth.refresh', '2026-10-27 15:00:28.154', '2026-10-27 15:00:28.154', '2026-10-27 15:00:28.159', NULL, NULL, NULL),
	(14, 'r3018zcrprcpvo1lswgmv537', 'api::category.category.find', '2026-10-27 15:00:31.659', '2026-10-27 15:00:31.659', '2026-10-27 15:00:31.659', NULL, NULL, NULL),
	(15, 'dpohdjzfgaytwnrnvkfsktdh', 'api::category.category.findOne', '2026-10-27 15:00:31.677', '2026-10-27 15:00:31.677', '2026-10-27 15:00:31.677', NULL, NULL, NULL),
	(16, 'ia4ga4akesk6qce15ypvk81r', 'api::discussion.discussion.find', '2026-10-27 15:00:31.695', '2026-10-27 15:00:31.695', '2026-10-27 15:00:31.695', NULL, NULL, NULL),
	(17, 'esivdt4ffoduyksrjina2bca', 'api::discussion.discussion.findOne', '2026-10-27 15:00:31.71', '2026-10-27 15:00:31.71', '2026-10-27 15:00:31.71', NULL, NULL, NULL),
	(18, 'lnn03k54sdr3vews8ewk13we', 'api::discussion.discussion.create', '2026-10-27 15:00:31.725', '2026-10-27 15:00:31.725', '2026-10-27 15:00:31.725', NULL, NULL, NULL),
	(19, 'yznj074sr3hibwzuzs5jyj2t', 'api::discussion.discussion.update', '2026-10-27 15:00:31.742', '2026-10-27 15:00:31.742', '2026-10-27 15:00:31.742', NULL, NULL, NULL),
	(20, 'ctpuwfwdd2uftvh04n6objrf', 'api::discussion.discussion.delete', '2026-10-27 15:00:31.757', '2026-10-27 15:00:31.757', '2026-10-27 15:00:31.757', NULL, NULL, NULL),
	(21, 'yzpxowu4wocv5h1etzl5sv5v', 'api::discussion.discussion.useful', '2026-10-27 15:00:31.771', '2026-10-27 15:00:31.771', '2026-10-27 15:00:31.771', NULL, NULL, NULL),
	(22, 'lmdkow9katugts6dve8i5v5s', 'api::discussion.discussion.follow', '2026-10-27 15:00:31.785', '2026-10-27 15:00:31.785', '2026-10-27 15:00:31.785', NULL, NULL, NULL),
	(23, 'pkil6pj5y3zk5ntb07y50nfg', 'api::discussion.discussion.vote', '2026-10-27 15:00:31.798', '2026-10-27 15:00:31.798', '2026-10-27 15:00:31.798', NULL, NULL, NULL),
	(24, 's2ouhq5k0201lp6bp445g5km', 'api::reply.reply.find', '2026-10-27 15:00:31.812', '2026-10-27 15:00:31.812', '2026-10-27 15:00:31.812', NULL, NULL, NULL),
	(25, 'trlr2gv9922ti413t9ddlcqy', 'api::reply.reply.findOne', '2026-10-27 15:00:31.828', '2026-10-27 15:00:31.828', '2026-10-27 15:00:31.828', NULL, NULL, NULL),
	(26, 'gxvscsod3aoi16rr5sfqmtph', 'api::reply.reply.create', '2026-10-27 15:00:31.841', '2026-10-27 15:00:31.841', '2026-10-27 15:00:31.841', NULL, NULL, NULL),
	(27, 'loj1weid2qlpy6skxi3v8lur', 'api::reply.reply.update', '2026-10-27 15:00:31.856', '2026-10-27 15:00:31.856', '2026-10-27 15:00:31.856', NULL, NULL, NULL),
	(28, 'vunht8dssm7h3ux1k3tf8ovw', 'api::reply.reply.delete', '2026-10-27 15:00:31.869', '2026-10-27 15:00:31.869', '2026-10-27 15:00:31.869', NULL, NULL, NULL),
	(29, 'zu1liviids45o5nh5wx0jy0w', 'api::reply.reply.useful', '2026-10-27 15:00:31.883', '2026-10-27 15:00:31.883', '2026-10-27 15:00:31.883', NULL, NULL, NULL),
	(30, 'nazdodxllnjs0kszz2pyuy3t', 'api::blog-post.blog-post.find', '2026-10-27 15:00:31.897', '2026-10-27 15:00:31.897', '2026-10-27 15:00:31.897', NULL, NULL, NULL),
	(31, 'i0s5gtyuqc3wu8kgpmvuaxe8', 'api::blog-post.blog-post.findOne', '2026-10-27 15:00:31.911', '2026-10-27 15:00:31.911', '2026-10-27 15:00:31.911', NULL, NULL, NULL),
	(32, 'bcfpr8yy5mbyria2ki0bkskb', 'api::blog-post.blog-post.create', '2026-10-27 15:00:31.923', '2026-10-27 15:00:31.923', '2026-10-27 15:00:31.923', NULL, NULL, NULL),
	(33, 'wh4ls4ynkm7m6qqz0hvez8tt', 'api::blog-post.blog-post.update', '2026-10-27 15:00:31.936', '2026-10-27 15:00:31.936', '2026-10-27 15:00:31.936', NULL, NULL, NULL),
	(34, 'x39y1h0dlzx8fx22cw18nq72', 'api::blog-post.blog-post.delete', '2026-10-27 15:00:31.948', '2026-10-27 15:00:31.948', '2026-10-27 15:00:31.948', NULL, NULL, NULL),
	(35, 'dvrdqh1g4puo7ze6gvsz0lh9', 'api::blog-post.blog-post.useful', '2026-10-27 15:00:31.96', '2026-10-27 15:00:31.96', '2026-10-27 15:00:31.96', NULL, NULL, NULL),
	(36, 'r4or3kvlhpcuuu97toh2l6m7', 'api::blog-comment.blog-comment.find', '2026-10-27 15:00:31.976', '2026-10-27 15:00:31.976', '2026-10-27 15:00:31.976', NULL, NULL, NULL),
	(37, 'lg3ktttn5lv3tcdyvbm78kp6', 'api::blog-comment.blog-comment.findOne', '2026-10-27 15:00:31.989', '2026-10-27 15:00:31.989', '2026-10-27 15:00:31.989', NULL, NULL, NULL),
	(38, 't3xigk1xe1ekb2m4rjio2hk6', 'api::blog-comment.blog-comment.create', '2026-10-27 15:00:32.002', '2026-10-27 15:00:32.002', '2026-10-27 15:00:32.002', NULL, NULL, NULL),
	(39, 'b1ds50ichjvemzcx6qv4ze0t', 'api::blog-comment.blog-comment.delete', '2026-10-27 15:00:32.015', '2026-10-27 15:00:32.015', '2026-10-27 15:00:32.016', NULL, NULL, NULL),
	(40, 'sn4kmqg57n08srthaluhhj3j', 'api::blog-comment.blog-comment.useful', '2026-10-27 15:00:32.029', '2026-10-27 15:00:32.029', '2026-10-27 15:00:32.029', NULL, NULL, NULL),
	(41, 'as6f5hwj89ci3lz51k624p98', 'api::event.event.find', '2026-10-27 15:00:32.041', '2026-10-27 15:00:32.041', '2026-10-27 15:00:32.042', NULL, NULL, NULL),
	(42, 'bgzn266ya1jylw897z0hcyz7', 'api::event.event.findOne', '2026-10-27 15:00:32.055', '2026-10-27 15:00:32.055', '2026-10-27 15:00:32.056', NULL, NULL, NULL),
	(43, 'bi5ofsrh050vkj3rc249atlu', 'api::event.event.rsvp', '2026-10-27 15:00:32.07', '2026-10-27 15:00:32.07', '2026-10-27 15:00:32.07', NULL, NULL, NULL),
	(44, 'ktuxbr42zqzcik5mvw81l8sn', 'api::notification.notification.find', '2026-10-27 15:00:32.084', '2026-10-27 15:00:32.084', '2026-10-27 15:00:32.084', NULL, NULL, NULL),
	(45, 'hx9rkryp9tqzvainj753b21r', 'api::notification.notification.read', '2026-10-27 15:00:32.098', '2026-10-27 15:00:32.098', '2026-10-27 15:00:32.098', NULL, NULL, NULL),
	(46, 'hrhmm3czj680xdz9advcrzfk', 'api::notification.notification.readAll', '2026-10-27 15:00:32.112', '2026-10-27 15:00:32.112', '2026-10-27 15:00:32.112', NULL, NULL, NULL),
	(47, 'dtbg5l1pzd6rzdsruc5g4evb', 'plugin::users-permissions.user.find', '2026-10-27 15:00:32.127', '2026-10-27 15:00:32.127', '2026-10-27 15:00:32.127', NULL, NULL, NULL),
	(48, 'g0lsv41tqx6ak6w34lpq1yek', 'plugin::users-permissions.user.findOne', '2026-10-27 15:00:32.142', '2026-10-27 15:00:32.142', '2026-10-27 15:00:32.142', NULL, NULL, NULL),
	(49, 'clw8h0z99lzvi5itdz77jd3g', 'plugin::users-permissions.user.updateMe', '2026-10-27 15:00:32.155', '2026-10-27 15:00:32.155', '2026-10-27 15:00:32.156', NULL, NULL, NULL),
	(50, 'lvjbielmtks0uhx02ult9zvy', 'plugin::users-permissions.user.updateAvatar', '2026-10-27 15:00:32.169', '2026-10-27 15:00:32.169', '2026-10-27 15:00:32.169', NULL, NULL, NULL),
	(51, 'mdxwbvnrv43m1la2gww51stu', 'plugin::users-permissions.user.removeAvatar', '2026-10-27 15:00:32.182', '2026-10-27 15:00:32.182', '2026-10-27 15:00:32.182', NULL, NULL, NULL);


--
-- Data for Name: up_permissions_role_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.up_permissions_role_lnk VALUES
	(2, 1, 1, 1),
	(8, 10, 2, 1),
	(1, 2, 1, 1),
	(3, 5, 1, 2),
	(4, 3, 1, 2),
	(5, 4, 1, 2),
	(6, 6, 2, 1),
	(7, 7, 2, 1),
	(9, 9, 2, 1),
	(10, 8, 2, 1),
	(11, 11, 2, 1),
	(12, 12, 2, 2),
	(13, 13, 2, 2),
	(14, 14, 1, 3),
	(15, 15, 1, 4),
	(16, 16, 1, 5),
	(17, 17, 1, 6),
	(18, 18, 1, 7),
	(19, 19, 1, 8),
	(20, 20, 1, 9),
	(21, 21, 1, 10),
	(22, 22, 1, 11),
	(23, 23, 1, 12),
	(24, 24, 1, 13),
	(25, 25, 1, 14),
	(26, 26, 1, 15),
	(27, 27, 1, 16),
	(28, 28, 1, 17),
	(29, 29, 1, 18),
	(30, 30, 1, 19),
	(31, 31, 1, 20),
	(32, 32, 1, 21),
	(33, 33, 1, 22),
	(34, 34, 1, 23),
	(35, 35, 1, 24),
	(36, 36, 1, 25),
	(37, 37, 1, 26),
	(38, 38, 1, 27),
	(39, 39, 1, 28),
	(40, 40, 1, 29),
	(41, 41, 1, 30),
	(42, 42, 1, 31),
	(43, 43, 1, 32),
	(44, 44, 1, 33),
	(45, 45, 1, 34),
	(46, 46, 1, 35),
	(47, 47, 1, 36),
	(48, 48, 1, 37),
	(49, 49, 1, 38),
	(50, 50, 1, 39),
	(51, 51, 1, 40);


--
-- Data for Name: up_roles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.up_roles VALUES
	(1, 'dcdc0x1cfazhors8u6njqczi', 'Authenticated', 'Default role given to authenticated user.', 'authenticated', '2026-10-27 15:00:27.993', '2026-10-27 15:00:27.993', '2026-10-27 15:00:27.994', NULL, NULL, NULL),
	(2, 'k76oxav5cytbo5wfgvnd13ll', 'Public', 'Default role given to unauthenticated user.', 'public', '2026-10-27 15:00:28.008', '2026-10-27 15:00:28.008', '2026-10-27 15:00:28.009', NULL, NULL, NULL);


--
-- Data for Name: up_users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.up_users VALUES
	(1, 'terac4d06nef1om81yb0004l', 'LaRedaction', 'laredaction@demo.lerevenu.test', 'local', '$2a$10$UYQQ76ug8sSfBj/ogrAomuXtf6TLGMnS/Tb2jocf7iyjoy8L8G6XW', NULL, NULL, true, false, 'La rédaction du Revenu', 'Les journalistes du Revenu, présents chaque semaine pour répondre à vos questions.', '[]', 'redaction', 'var(--brand)', false, NULL, 0, 0, '2026-10', 0, '["bienvenue", "premier_sujet"]', '{"likes": 0, "votes": 0, "topics": 3, "replies": 0, "solutions": 0}', '2026-10-27 15:00:32.582', '2026-10-27 15:00:32.582', '2026-10-27 15:00:32.456', NULL, NULL, NULL),
	(2, 'trtgr1me90cxkwl8dvdyqpk6', 'Moderation', 'moderation@demo.lerevenu.test', 'local', '$2a$10$HfKE2W0O6JZMcrrfnPyxh.ahrSKH8euB0aIAeEKgtcjUauxMqGyXG', NULL, NULL, true, false, 'Équipe modération', '', '[]', 'moderator', 'var(--av-3)', false, NULL, 0, 0, '2026-10', 0, '["bienvenue", "premier_sujet"]', '{"likes": 0, "votes": 0, "topics": 0, "replies": 0, "solutions": 0}', '2026-10-27 15:00:32.821', '2026-10-27 15:00:32.821', '2026-10-27 15:00:32.684', NULL, NULL, NULL),
	(3, 'wjgwf41pcebo01zmafnkca18', 'Vincent_ETF', 'vincent_etf@demo.lerevenu.test', 'local', '$2a$10$gBOX7NWRifuZcbOp8mGL3ujuxc.rUX2M16ZpoJc3zc3ijfh1rP/4K', NULL, NULL, true, false, 'Vincent', 'Ingénieur, investisseur passif depuis 2015. Fan des ETF monde.', '[]', 'member', 'var(--av-1)', true, NULL, 612, 148, '2026-10', 0, '["bienvenue", "premier_sujet", "premiere_reponse", "apprecie", "populaire", "solution", "sondeur", "citoyen", "assidu"]', '{"likes": 153, "votes": 0, "topics": 1, "replies": 87, "solutions": 5}', '2026-10-27 15:00:33.074', '2026-10-27 15:00:33.074', '2026-10-27 15:00:32.906', NULL, NULL, NULL),
	(4, 'e2iqiqq8ejcg66du1i2vj73d', 'PapyBoursier', 'papyboursier@demo.lerevenu.test', 'local', '$2a$10$MXEMK2hn.GrLF8BWXkEfX.3XPR/p00eb62HVR0aVTosfa6s7rAWcm', NULL, NULL, true, false, 'Papy Boursier', '40 ans de Bourse, des erreurs et quelques réussites.', '[]', 'member', 'var(--av-4)', true, NULL, 804, 121, '2026-10', 0, '["bienvenue", "premier_sujet", "premiere_reponse", "apprecie", "populaire", "solution", "sondeur", "citoyen", "assidu"]', '{"likes": 201, "votes": 0, "topics": 1, "replies": 115, "solutions": 7}', '2026-10-27 15:00:33.317', '2026-10-27 15:00:33.317', '2026-10-27 15:00:33.118', NULL, NULL, NULL),
	(5, 'm4g3d9tma04ssd5jb9kz6k1z', 'Odile.Retraite', 'odile_retraite@demo.lerevenu.test', 'local', '$2a$10$2eapdFF7nia9ZpgX2wB3BuuXtlEKN3uxhZESHj8lVrCdTKE2YlPK.', NULL, NULL, true, false, 'Odile', 'Jeune retraitée, je gère mon patrimoine en famille.', '[]', 'member', 'var(--av-2)', false, NULL, 286, 97, '2026-10', 0, '["bienvenue", "premier_sujet", "premiere_reponse", "apprecie", "populaire", "solution"]', '{"likes": 72, "votes": 0, "topics": 2, "replies": 41, "solutions": 2}', '2026-10-27 15:00:33.56', '2026-10-27 15:00:33.56', '2026-10-27 15:00:33.376', NULL, NULL, NULL),
	(6, 'zabfuz7rkz44hfcy5szry3rl', 'Nadia.Patrimoine', 'nadia_patrimoine@demo.lerevenu.test', 'local', '$2a$10$UUTytfEcdV/vgr6JfUDt6eiEb1UWCoOpl1c1OycGVHTstmFJKaQDO', NULL, NULL, true, false, 'Nadia', 'Mère de trois enfants, je prépare la transmission sereinement.', '[]', 'member', 'var(--av-5)', true, NULL, 197, 84, '2026-10', 0, '["bienvenue", "premier_sujet", "premiere_reponse", "apprecie"]', '{"likes": 49, "votes": 0, "topics": 1, "replies": 28, "solutions": 2}', '2026-10-27 15:00:33.721', '2026-10-27 15:00:33.721', '2026-10-27 15:00:33.588', NULL, NULL, NULL),
	(7, 't8z3h09mvv9d55xktv34w219', 'Claire_Nantes', 'claire_nantes@demo.lerevenu.test', 'local', '$2a$10$5.dfaQkcTPysspBiGYkl5uQ7AvKmO1q.qS81SSc7FBhLJvKQmBe5a', NULL, NULL, true, false, 'Claire', 'Je compare tout avant de signer.', '[]', 'member', 'var(--av-3)', false, NULL, 166, 61, '2026-10', 0, '["bienvenue", "premier_sujet", "premiere_reponse", "apprecie"]', '{"likes": 42, "votes": 0, "topics": 1, "replies": 24, "solutions": 1}', '2026-10-27 15:00:33.863', '2026-10-27 15:00:33.863', '2026-10-27 15:00:33.75', NULL, NULL, NULL),
	(8, 'vsmnypdln79tqehk2s6shf01', 'Sophie.Invest', 'sophie_invest@demo.lerevenu.test', 'local', '$2a$10$F/OCuIvKdsm7kW/oW5/4NeGuc3De9SMbKaXRTxO/vSH427vf1vj8G', NULL, NULL, true, false, 'Sophie', 'Abonnée au Revenu, curieuse de tout ce qui touche à l''argent.', '[]', 'member', 'var(--av-1)', true, NULL, 151, 58, '2026-10', 0, '["bienvenue", "premier_sujet", "premiere_reponse", "apprecie"]', '{"likes": 38, "votes": 0, "topics": 1, "replies": 22, "solutions": 1}', '2026-10-27 15:00:34.001', '2026-10-27 15:00:34.001', '2026-10-27 15:00:33.895', NULL, NULL, NULL),
	(9, 'gep6f9xq013qr8wnfhjgm5lb', 'Karim_Immo', 'karim_immo@demo.lerevenu.test', 'local', '$2a$10$gxmDgUC97.ANcwnJjTgAd.cd9.vOfbxjgOO0//Ql0jtasLbKKJGOG', NULL, NULL, true, false, 'Karim', 'Investisseur immobilier, 3 biens locatifs et quelques SCPI.', '[]', 'member', 'var(--av-4)', false, NULL, 131, 49, '2026-10', 0, '["bienvenue", "premier_sujet", "premiere_reponse", "apprecie"]', '{"likes": 33, "votes": 0, "topics": 2, "replies": 19, "solutions": 1}', '2026-10-27 15:00:34.137', '2026-10-27 15:00:34.137', '2026-10-27 15:00:34.026', NULL, NULL, NULL),
	(10, 's5alzg9b7h3jhvkvwa7nqv3w', 'Bertrand59', 'bertrand59@demo.lerevenu.test', 'local', '$2a$10$i14HcDZCozljHh9AjKV/beLkogdM6oqlZvblY18wpuqKKxsWilNza', NULL, NULL, true, false, 'Bertrand', 'Cadre dans le Nord, je prépare ma retraite.', '[]', 'member', 'var(--av-3)', false, NULL, 118, 42, '2026-10', 0, '["bienvenue", "premier_sujet", "premiere_reponse"]', '{"likes": 30, "votes": 0, "topics": 2, "replies": 17, "solutions": 1}', '2026-10-27 15:00:34.261', '2026-10-27 15:00:34.261', '2026-10-27 15:00:34.158', NULL, NULL, NULL),
	(11, 'ngewjonhnnw1abg78ckezzpx', 'Marc_Lyon', 'marc_lyon@demo.lerevenu.test', 'local', '$2a$10$9DnLzYc.G46t8BDWQHg1c.t39ykzFQuDO0gkv3ECNOS.vRdujNr6u', NULL, NULL, true, false, 'Marc', 'Passionné d''or et d''histoire monétaire.', '[]', 'member', 'var(--av-2)', false, NULL, 92, 23, '2026-10', 0, '["bienvenue", "premier_sujet", "premiere_reponse"]', '{"likes": 23, "votes": 0, "topics": 1, "replies": 13, "solutions": 1}', '2026-10-27 15:00:34.385', '2026-10-27 15:00:34.385', '2026-10-27 15:00:34.28', NULL, NULL, NULL),
	(12, 'pofyixv7i33czdyu1xevycc4', 'LeRentier', 'lerentier@demo.lerevenu.test', 'local', '$2a$10$/urXA8Xd9EOQHfz96RktyOA7HmuH1wh7USWBDbb/rW1fzPrHCl/BK', NULL, NULL, true, false, 'Le Rentier', 'Stratégie dividendes, patience et réinvestissement.', '[]', 'member', 'var(--av-1)', false, NULL, 73, 31, '2026-10', 0, '["bienvenue", "premier_sujet", "premiere_reponse"]', '{"likes": 18, "votes": 0, "topics": 1, "replies": 10, "solutions": 1}', '2026-10-27 15:00:34.508', '2026-10-27 15:00:34.508', '2026-10-27 15:00:34.411', NULL, NULL, NULL),
	(13, 'ee5ztd9lwah9jvi1l1cd134q', 'Thomas_PEA', 'thomas_pea@demo.lerevenu.test', 'local', '$2a$10$TpXJVp2dP7upShn9OLV1fe6oU6Nk0NnCFoIvpi6kJ1oMzELvcPZ/K', NULL, NULL, true, false, 'Thomas', '32 ans, je débute en Bourse.', '[]', 'member', 'var(--av-4)', false, NULL, 58, 36, '2026-10', 0, '["bienvenue", "premier_sujet", "premiere_reponse"]', '{"likes": 15, "votes": 0, "topics": 1, "replies": 8, "solutions": 0}', '2026-10-27 15:00:34.629', '2026-10-27 15:00:34.629', '2026-10-27 15:00:34.527', NULL, NULL, NULL),
	(14, 'ex34hhqwvayx8q4539yoxbub', 'Julie_Toulouse', 'julie_toulouse@demo.lerevenu.test', 'local', '$2a$10$aceO7tPwQENBSID7vAgg0eFgbnZJf7ZwJ7rLlbKQ3vxRWaq0FVO7i', NULL, NULL, true, false, 'Julie', 'Salariée, j''optimise ma fiscalité sans prise de tête.', '[]', 'member', 'var(--av-1)', false, NULL, 44, 19, '2026-10', 0, '["bienvenue", "premier_sujet", "premiere_reponse"]', '{"likes": 11, "votes": 0, "topics": 1, "replies": 6, "solutions": 0}', '2026-10-27 15:00:34.751', '2026-10-27 15:00:34.751', '2026-10-27 15:00:34.647', NULL, NULL, NULL),
	(15, 'jbsph6g92oqffskuzu8optbr', 'JeuneEpargnant', 'jeuneepargnant@demo.lerevenu.test', 'local', '$2a$10$cnFnvd0WDthocgd4Ik4l7.0jd2QgnElAfZuYN/QRbz1viHI81euZO', NULL, NULL, true, false, 'Hugo', '25 ans, premier CDI, je veux bien démarrer.', '[]', 'member', 'var(--av-2)', false, NULL, 37, 33, '2026-10', 0, '["bienvenue", "premier_sujet"]', '{"likes": 9, "votes": 0, "topics": 1, "replies": 5, "solutions": 0}', '2026-10-27 15:00:34.879', '2026-10-27 15:00:34.879', '2026-10-27 15:00:34.775', NULL, NULL, NULL),
	(16, 'ia1s2cn3cgbyp9dhmb7mc7hs', 'Helene_R', 'helene_r@demo.lerevenu.test', 'local', '$2a$10$h3UomSGh1cQlDGcQkZrzvejS878gC9mN.UF/hPjiih8yWk9WPzHsK', NULL, NULL, true, false, 'Hélène', 'Je loue un studio meublé et découvre la fiscalité qui va avec.', '[]', 'member', 'var(--av-3)', false, NULL, 22, 22, '2026-10', 0, '["bienvenue", "premier_sujet"]', '{"likes": 6, "votes": 0, "topics": 1, "replies": 3, "solutions": 0}', '2026-10-27 15:00:35.047', '2026-10-27 15:00:35.047', '2026-10-27 15:00:34.917', NULL, NULL, NULL),
	(17, 'mett4fhylzwfywh7ewn0wwpu', 'Camille_B', 'camille_b@demo.lerevenu.test', 'local', '$2a$10$iZDEujm3xvDEcoHGhPTFhefzqdiAzVRTqvwemqdJAg.ZTbNOrf1Ke', NULL, NULL, true, false, 'Camille', 'Cadre, 41 ans. Je prépare ma retraite et celle de mes parents.', '["bourse", "assurance-vie", "retraite"]', 'member', 'var(--av-5)', true, NULL, 142, 64, '2026-10', 6, '["bienvenue", "premiere_reponse", "apprecie", "citoyen", "premier_sujet"]', '{"likes": 23, "votes": 4, "topics": 1, "replies": 9, "solutions": 0}', '2026-10-27 15:00:35.192', '2026-10-27 15:00:35.192', '2026-10-27 15:00:35.072', NULL, NULL, NULL),
	(18, 'dq95iyjg6sl2iut05brj1nas', 'Sandrine_CGP', 'sandrine_cgp@demo.lerevenu.test', 'local', '$2a$10$chCp9P/lYMp2q1WTL5i/0.5zMszmPrkoAWh/CLXahhOjBzgEevf3e', NULL, NULL, true, false, 'Sandrine Morel', 'CGP indépendante depuis quinze ans. Je partage ici à titre informatif, sans démarchage.', '[]', 'member', 'var(--av-2)', false, 'Conseillère en gestion de patrimoine', 238, 41, '2026-10', 0, '["bienvenue", "premier_sujet", "premiere_reponse", "apprecie", "populaire"]', '{"likes": 60, "votes": 0, "topics": 0, "replies": 34, "solutions": 2}', '2026-10-27 15:00:35.319', '2026-10-27 15:00:35.319', '2026-10-27 15:00:35.216', NULL, NULL, NULL),
	(19, 'dsnw7tmge7lc8lktehoubk5i', 'Me_Garnier', 'me_garnier@demo.lerevenu.test', 'local', '$2a$10$8cnnpwjd0bJOT4TdgX53C.o.ZBBv9M25OxvgJyVzd43Dra5X.gcym', NULL, NULL, true, false, 'Maître Garnier', 'Notaire en région lyonnaise. Successions, donations, régimes matrimoniaux.', '[]', 'member', 'var(--av-1)', false, 'Notaire', 175, 26, '2026-10', 0, '["bienvenue", "premier_sujet", "premiere_reponse", "apprecie"]', '{"likes": 44, "votes": 0, "topics": 0, "replies": 25, "solutions": 1}', '2026-10-27 15:00:35.469', '2026-10-27 15:00:35.469', '2026-10-27 15:00:35.362', NULL, NULL, NULL);


--
-- Data for Name: up_users_role_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.up_users_role_lnk VALUES
	(1, 1, 1, 1),
	(2, 2, 1, 2),
	(3, 3, 1, 3),
	(4, 4, 1, 4),
	(5, 5, 1, 5),
	(6, 6, 1, 6),
	(7, 7, 1, 7),
	(8, 8, 1, 8),
	(9, 9, 1, 9),
	(10, 10, 1, 10),
	(11, 11, 1, 11),
	(12, 12, 1, 12),
	(13, 13, 1, 13),
	(14, 14, 1, 14),
	(15, 15, 1, 15),
	(16, 16, 1, 16),
	(17, 17, 1, 17),
	(18, 18, 1, 18),
	(19, 19, 1, 19);


--
-- Data for Name: upload_folders; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: upload_folders_parent_lnk; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: admin_permissions_api_token_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_permissions_api_token_lnk_id_seq', 1, false);


--
-- Name: admin_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_permissions_id_seq', 206, true);


--
-- Name: admin_permissions_role_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_permissions_role_lnk_id_seq', 206, true);


--
-- Name: admin_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_roles_id_seq', 3, true);


--
-- Name: admin_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_users_id_seq', 1, false);


--
-- Name: admin_users_roles_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_users_roles_lnk_id_seq', 1, false);


--
-- Name: blog_comments_author_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.blog_comments_author_lnk_id_seq', 8, true);


--
-- Name: blog_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.blog_comments_id_seq', 8, true);


--
-- Name: blog_comments_post_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.blog_comments_post_lnk_id_seq', 8, true);


--
-- Name: blog_comments_useful_by_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.blog_comments_useful_by_lnk_id_seq', 1, false);


--
-- Name: blog_posts_author_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.blog_posts_author_lnk_id_seq', 5, true);


--
-- Name: blog_posts_category_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.blog_posts_category_lnk_id_seq', 5, true);


--
-- Name: blog_posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.blog_posts_id_seq', 5, true);


--
-- Name: blog_posts_useful_by_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.blog_posts_useful_by_lnk_id_seq', 1, false);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categories_id_seq', 11, true);


--
-- Name: discussions_author_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.discussions_author_lnk_id_seq', 20, true);


--
-- Name: discussions_category_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.discussions_category_lnk_id_seq', 20, true);


--
-- Name: discussions_followed_by_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.discussions_followed_by_lnk_id_seq', 1, false);


--
-- Name: discussions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.discussions_id_seq', 20, true);


--
-- Name: discussions_useful_by_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.discussions_useful_by_lnk_id_seq', 1, false);


--
-- Name: events_attendees_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.events_attendees_lnk_id_seq', 1, false);


--
-- Name: events_category_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.events_category_lnk_id_seq', 3, true);


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.events_id_seq', 3, true);


--
-- Name: files_folder_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.files_folder_lnk_id_seq', 1, false);


--
-- Name: files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.files_id_seq', 1, false);


--
-- Name: files_related_mph_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.files_related_mph_id_seq', 1, false);


--
-- Name: i18n_locale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.i18n_locale_id_seq', 1, true);


--
-- Name: notifications_actor_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notifications_actor_lnk_id_seq', 3, true);


--
-- Name: notifications_blog_post_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notifications_blog_post_lnk_id_seq', 1, false);


--
-- Name: notifications_discussion_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notifications_discussion_lnk_id_seq', 3, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notifications_id_seq', 5, true);


--
-- Name: notifications_recipient_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notifications_recipient_lnk_id_seq', 5, true);


--
-- Name: replies_author_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.replies_author_lnk_id_seq', 48, true);


--
-- Name: replies_discussion_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.replies_discussion_lnk_id_seq', 48, true);


--
-- Name: replies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.replies_id_seq', 48, true);


--
-- Name: replies_useful_by_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.replies_useful_by_lnk_id_seq', 1, false);


--
-- Name: rewards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rewards_id_seq', 1, false);


--
-- Name: rewards_recipient_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rewards_recipient_lnk_id_seq', 1, false);


--
-- Name: strapi_ai_localization_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_ai_localization_jobs_id_seq', 1, false);


--
-- Name: strapi_ai_metadata_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_ai_metadata_jobs_id_seq', 1, false);


--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_core_store_settings_id_seq', 36, true);


--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_database_schema_id_seq', 1, true);


--
-- Name: strapi_history_versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_history_versions_id_seq', 1, false);


--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_migrations_id_seq', 1, false);


--
-- Name: strapi_migrations_internal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_migrations_internal_id_seq', 9, true);


--
-- Name: strapi_release_actions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_release_actions_id_seq', 1, false);


--
-- Name: strapi_release_actions_release_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_release_actions_release_lnk_id_seq', 1, false);


--
-- Name: strapi_releases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_releases_id_seq', 1, false);


--
-- Name: strapi_sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_sessions_id_seq', 1, false);


--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_webhooks_id_seq', 1, false);


--
-- Name: strapi_workflows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_workflows_id_seq', 1, false);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_workflows_stage_required_to_publish_lnk_id_seq', 1, false);


--
-- Name: strapi_workflows_stages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_workflows_stages_id_seq', 1, false);


--
-- Name: strapi_workflows_stages_permissions_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_workflows_stages_permissions_lnk_id_seq', 1, false);


--
-- Name: strapi_workflows_stages_workflow_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_workflows_stages_workflow_lnk_id_seq', 1, false);


--
-- Name: up_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.up_permissions_id_seq', 51, true);


--
-- Name: up_permissions_role_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.up_permissions_role_lnk_id_seq', 51, true);


--
-- Name: up_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.up_roles_id_seq', 2, true);


--
-- Name: up_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.up_users_id_seq', 19, true);


--
-- Name: up_users_role_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.up_users_role_lnk_id_seq', 19, true);


--
-- Name: upload_folders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.upload_folders_id_seq', 1, false);


--
-- Name: upload_folders_parent_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.upload_folders_parent_lnk_id_seq', 1, false);


--
-- Name: admin_permissions_api_token_lnk admin_permissions_api_token_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions_api_token_lnk
    ADD CONSTRAINT admin_permissions_api_token_lnk_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_api_token_lnk admin_permissions_api_token_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions_api_token_lnk
    ADD CONSTRAINT admin_permissions_api_token_lnk_uq UNIQUE (permission_id, api_token_id);


--
-- Name: admin_permissions admin_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_role_lnk admin_permissions_role_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions_role_lnk
    ADD CONSTRAINT admin_permissions_role_lnk_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_role_lnk admin_permissions_role_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions_role_lnk
    ADD CONSTRAINT admin_permissions_role_lnk_uq UNIQUE (permission_id, role_id);


--
-- Name: admin_roles admin_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_pkey PRIMARY KEY (id);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: admin_users_roles_lnk admin_users_roles_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users_roles_lnk
    ADD CONSTRAINT admin_users_roles_lnk_pkey PRIMARY KEY (id);


--
-- Name: admin_users_roles_lnk admin_users_roles_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users_roles_lnk
    ADD CONSTRAINT admin_users_roles_lnk_uq UNIQUE (user_id, role_id);


--
-- Name: blog_comments_author_lnk blog_comments_author_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_comments_author_lnk
    ADD CONSTRAINT blog_comments_author_lnk_pkey PRIMARY KEY (id);


--
-- Name: blog_comments_author_lnk blog_comments_author_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_comments_author_lnk
    ADD CONSTRAINT blog_comments_author_lnk_uq UNIQUE (blog_comment_id, user_id);


--
-- Name: blog_comments blog_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_comments
    ADD CONSTRAINT blog_comments_pkey PRIMARY KEY (id);


--
-- Name: blog_comments_post_lnk blog_comments_post_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_comments_post_lnk
    ADD CONSTRAINT blog_comments_post_lnk_pkey PRIMARY KEY (id);


--
-- Name: blog_comments_post_lnk blog_comments_post_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_comments_post_lnk
    ADD CONSTRAINT blog_comments_post_lnk_uq UNIQUE (blog_comment_id, blog_post_id);


--
-- Name: blog_comments_useful_by_lnk blog_comments_useful_by_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_comments_useful_by_lnk
    ADD CONSTRAINT blog_comments_useful_by_lnk_pkey PRIMARY KEY (id);


--
-- Name: blog_comments_useful_by_lnk blog_comments_useful_by_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_comments_useful_by_lnk
    ADD CONSTRAINT blog_comments_useful_by_lnk_uq UNIQUE (blog_comment_id, user_id);


--
-- Name: blog_posts_author_lnk blog_posts_author_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts_author_lnk
    ADD CONSTRAINT blog_posts_author_lnk_pkey PRIMARY KEY (id);


--
-- Name: blog_posts_author_lnk blog_posts_author_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts_author_lnk
    ADD CONSTRAINT blog_posts_author_lnk_uq UNIQUE (blog_post_id, user_id);


--
-- Name: blog_posts_category_lnk blog_posts_category_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts_category_lnk
    ADD CONSTRAINT blog_posts_category_lnk_pkey PRIMARY KEY (id);


--
-- Name: blog_posts_category_lnk blog_posts_category_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts_category_lnk
    ADD CONSTRAINT blog_posts_category_lnk_uq UNIQUE (blog_post_id, category_id);


--
-- Name: blog_posts blog_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts
    ADD CONSTRAINT blog_posts_pkey PRIMARY KEY (id);


--
-- Name: blog_posts_useful_by_lnk blog_posts_useful_by_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts_useful_by_lnk
    ADD CONSTRAINT blog_posts_useful_by_lnk_pkey PRIMARY KEY (id);


--
-- Name: blog_posts_useful_by_lnk blog_posts_useful_by_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts_useful_by_lnk
    ADD CONSTRAINT blog_posts_useful_by_lnk_uq UNIQUE (blog_post_id, user_id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: discussions_author_lnk discussions_author_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions_author_lnk
    ADD CONSTRAINT discussions_author_lnk_pkey PRIMARY KEY (id);


--
-- Name: discussions_author_lnk discussions_author_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions_author_lnk
    ADD CONSTRAINT discussions_author_lnk_uq UNIQUE (discussion_id, user_id);


--
-- Name: discussions_category_lnk discussions_category_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions_category_lnk
    ADD CONSTRAINT discussions_category_lnk_pkey PRIMARY KEY (id);


--
-- Name: discussions_category_lnk discussions_category_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions_category_lnk
    ADD CONSTRAINT discussions_category_lnk_uq UNIQUE (discussion_id, category_id);


--
-- Name: discussions_followed_by_lnk discussions_followed_by_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions_followed_by_lnk
    ADD CONSTRAINT discussions_followed_by_lnk_pkey PRIMARY KEY (id);


--
-- Name: discussions_followed_by_lnk discussions_followed_by_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions_followed_by_lnk
    ADD CONSTRAINT discussions_followed_by_lnk_uq UNIQUE (discussion_id, user_id);


--
-- Name: discussions discussions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions
    ADD CONSTRAINT discussions_pkey PRIMARY KEY (id);


--
-- Name: discussions_useful_by_lnk discussions_useful_by_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions_useful_by_lnk
    ADD CONSTRAINT discussions_useful_by_lnk_pkey PRIMARY KEY (id);


--
-- Name: discussions_useful_by_lnk discussions_useful_by_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions_useful_by_lnk
    ADD CONSTRAINT discussions_useful_by_lnk_uq UNIQUE (discussion_id, user_id);


--
-- Name: events_attendees_lnk events_attendees_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_attendees_lnk
    ADD CONSTRAINT events_attendees_lnk_pkey PRIMARY KEY (id);


--
-- Name: events_attendees_lnk events_attendees_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_attendees_lnk
    ADD CONSTRAINT events_attendees_lnk_uq UNIQUE (event_id, user_id);


--
-- Name: events_category_lnk events_category_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_category_lnk
    ADD CONSTRAINT events_category_lnk_pkey PRIMARY KEY (id);


--
-- Name: events_category_lnk events_category_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_category_lnk
    ADD CONSTRAINT events_category_lnk_uq UNIQUE (event_id, category_id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: files_folder_lnk files_folder_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files_folder_lnk
    ADD CONSTRAINT files_folder_lnk_pkey PRIMARY KEY (id);


--
-- Name: files_folder_lnk files_folder_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files_folder_lnk
    ADD CONSTRAINT files_folder_lnk_uq UNIQUE (file_id, folder_id);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: files_related_mph files_related_mph_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files_related_mph
    ADD CONSTRAINT files_related_mph_pkey PRIMARY KEY (id);


--
-- Name: i18n_locale i18n_locale_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_pkey PRIMARY KEY (id);


--
-- Name: notifications_actor_lnk notifications_actor_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications_actor_lnk
    ADD CONSTRAINT notifications_actor_lnk_pkey PRIMARY KEY (id);


--
-- Name: notifications_actor_lnk notifications_actor_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications_actor_lnk
    ADD CONSTRAINT notifications_actor_lnk_uq UNIQUE (notification_id, user_id);


--
-- Name: notifications_blog_post_lnk notifications_blog_post_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications_blog_post_lnk
    ADD CONSTRAINT notifications_blog_post_lnk_pkey PRIMARY KEY (id);


--
-- Name: notifications_blog_post_lnk notifications_blog_post_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications_blog_post_lnk
    ADD CONSTRAINT notifications_blog_post_lnk_uq UNIQUE (notification_id, blog_post_id);


--
-- Name: notifications_discussion_lnk notifications_discussion_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications_discussion_lnk
    ADD CONSTRAINT notifications_discussion_lnk_pkey PRIMARY KEY (id);


--
-- Name: notifications_discussion_lnk notifications_discussion_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications_discussion_lnk
    ADD CONSTRAINT notifications_discussion_lnk_uq UNIQUE (notification_id, discussion_id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: notifications_recipient_lnk notifications_recipient_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications_recipient_lnk
    ADD CONSTRAINT notifications_recipient_lnk_pkey PRIMARY KEY (id);


--
-- Name: notifications_recipient_lnk notifications_recipient_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications_recipient_lnk
    ADD CONSTRAINT notifications_recipient_lnk_uq UNIQUE (notification_id, user_id);


--
-- Name: replies_author_lnk replies_author_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies_author_lnk
    ADD CONSTRAINT replies_author_lnk_pkey PRIMARY KEY (id);


--
-- Name: replies_author_lnk replies_author_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies_author_lnk
    ADD CONSTRAINT replies_author_lnk_uq UNIQUE (reply_id, user_id);


--
-- Name: replies_discussion_lnk replies_discussion_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies_discussion_lnk
    ADD CONSTRAINT replies_discussion_lnk_pkey PRIMARY KEY (id);


--
-- Name: replies_discussion_lnk replies_discussion_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies_discussion_lnk
    ADD CONSTRAINT replies_discussion_lnk_uq UNIQUE (reply_id, discussion_id);


--
-- Name: replies replies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies
    ADD CONSTRAINT replies_pkey PRIMARY KEY (id);


--
-- Name: replies_useful_by_lnk replies_useful_by_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies_useful_by_lnk
    ADD CONSTRAINT replies_useful_by_lnk_pkey PRIMARY KEY (id);


--
-- Name: replies_useful_by_lnk replies_useful_by_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies_useful_by_lnk
    ADD CONSTRAINT replies_useful_by_lnk_uq UNIQUE (reply_id, user_id);


--
-- Name: rewards rewards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rewards
    ADD CONSTRAINT rewards_pkey PRIMARY KEY (id);


--
-- Name: rewards_recipient_lnk rewards_recipient_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rewards_recipient_lnk
    ADD CONSTRAINT rewards_recipient_lnk_pkey PRIMARY KEY (id);


--
-- Name: rewards_recipient_lnk rewards_recipient_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rewards_recipient_lnk
    ADD CONSTRAINT rewards_recipient_lnk_uq UNIQUE (reward_id, user_id);


--
-- Name: strapi_ai_localization_jobs strapi_ai_localization_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_ai_localization_jobs
    ADD CONSTRAINT strapi_ai_localization_jobs_pkey PRIMARY KEY (id);


--
-- Name: strapi_ai_metadata_jobs strapi_ai_metadata_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_ai_metadata_jobs
    ADD CONSTRAINT strapi_ai_metadata_jobs_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions_token_lnk strapi_api_token_permissions_token_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk
    ADD CONSTRAINT strapi_api_token_permissions_token_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions_token_lnk strapi_api_token_permissions_token_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk
    ADD CONSTRAINT strapi_api_token_permissions_token_lnk_uq UNIQUE (api_token_permission_id, api_token_id);


--
-- Name: strapi_api_tokens_admin_user_owner_lnk strapi_api_tokens_admin_user_owner_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_tokens_admin_user_owner_lnk
    ADD CONSTRAINT strapi_api_tokens_admin_user_owner_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_tokens_admin_user_owner_lnk strapi_api_tokens_admin_user_owner_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_tokens_admin_user_owner_lnk
    ADD CONSTRAINT strapi_api_tokens_admin_user_owner_lnk_uq UNIQUE (api_token_id, user_id);


--
-- Name: strapi_api_tokens strapi_api_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_pkey PRIMARY KEY (id);


--
-- Name: strapi_core_store_settings strapi_core_store_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_core_store_settings
    ADD CONSTRAINT strapi_core_store_settings_pkey PRIMARY KEY (id);


--
-- Name: strapi_database_schema strapi_database_schema_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_database_schema
    ADD CONSTRAINT strapi_database_schema_pkey PRIMARY KEY (id);


--
-- Name: strapi_history_versions strapi_history_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_history_versions
    ADD CONSTRAINT strapi_history_versions_pkey PRIMARY KEY (id);


--
-- Name: strapi_migrations_internal strapi_migrations_internal_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_migrations_internal
    ADD CONSTRAINT strapi_migrations_internal_pkey PRIMARY KEY (id);


--
-- Name: strapi_migrations strapi_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_migrations
    ADD CONSTRAINT strapi_migrations_pkey PRIMARY KEY (id);


--
-- Name: strapi_release_actions strapi_release_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_release_actions
    ADD CONSTRAINT strapi_release_actions_pkey PRIMARY KEY (id);


--
-- Name: strapi_release_actions_release_lnk strapi_release_actions_release_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk
    ADD CONSTRAINT strapi_release_actions_release_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_release_actions_release_lnk strapi_release_actions_release_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk
    ADD CONSTRAINT strapi_release_actions_release_lnk_uq UNIQUE (release_action_id, release_id);


--
-- Name: strapi_releases strapi_releases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_releases
    ADD CONSTRAINT strapi_releases_pkey PRIMARY KEY (id);


--
-- Name: strapi_sessions strapi_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_sessions
    ADD CONSTRAINT strapi_sessions_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions_token_lnk strapi_transfer_token_permissions_token_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk
    ADD CONSTRAINT strapi_transfer_token_permissions_token_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions_token_lnk strapi_transfer_token_permissions_token_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk
    ADD CONSTRAINT strapi_transfer_token_permissions_token_lnk_uq UNIQUE (transfer_token_permission_id, transfer_token_id);


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_pkey PRIMARY KEY (id);


--
-- Name: strapi_webhooks strapi_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_webhooks
    ADD CONSTRAINT strapi_webhooks_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows strapi_workflows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows
    ADD CONSTRAINT strapi_workflows_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk strapi_workflows_stage_required_to_publish_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk
    ADD CONSTRAINT strapi_workflows_stage_required_to_publish_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk strapi_workflows_stage_required_to_publish_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk
    ADD CONSTRAINT strapi_workflows_stage_required_to_publish_lnk_uq UNIQUE (workflow_id, workflow_stage_id);


--
-- Name: strapi_workflows_stages_permissions_lnk strapi_workflows_stages_permissions_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk
    ADD CONSTRAINT strapi_workflows_stages_permissions_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stages_permissions_lnk strapi_workflows_stages_permissions_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk
    ADD CONSTRAINT strapi_workflows_stages_permissions_lnk_uq UNIQUE (workflow_stage_id, permission_id);


--
-- Name: strapi_workflows_stages strapi_workflows_stages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages
    ADD CONSTRAINT strapi_workflows_stages_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stages_workflow_lnk strapi_workflows_stages_workflow_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk
    ADD CONSTRAINT strapi_workflows_stages_workflow_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stages_workflow_lnk strapi_workflows_stages_workflow_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk
    ADD CONSTRAINT strapi_workflows_stages_workflow_lnk_uq UNIQUE (workflow_stage_id, workflow_id);


--
-- Name: up_permissions up_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_pkey PRIMARY KEY (id);


--
-- Name: up_permissions_role_lnk up_permissions_role_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_permissions_role_lnk
    ADD CONSTRAINT up_permissions_role_lnk_pkey PRIMARY KEY (id);


--
-- Name: up_permissions_role_lnk up_permissions_role_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_permissions_role_lnk
    ADD CONSTRAINT up_permissions_role_lnk_uq UNIQUE (permission_id, role_id);


--
-- Name: up_roles up_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_pkey PRIMARY KEY (id);


--
-- Name: up_users up_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_pkey PRIMARY KEY (id);


--
-- Name: up_users_role_lnk up_users_role_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_users_role_lnk
    ADD CONSTRAINT up_users_role_lnk_pkey PRIMARY KEY (id);


--
-- Name: up_users_role_lnk up_users_role_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_users_role_lnk
    ADD CONSTRAINT up_users_role_lnk_uq UNIQUE (user_id, role_id);


--
-- Name: upload_folders_parent_lnk upload_folders_parent_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders_parent_lnk
    ADD CONSTRAINT upload_folders_parent_lnk_pkey PRIMARY KEY (id);


--
-- Name: upload_folders_parent_lnk upload_folders_parent_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders_parent_lnk
    ADD CONSTRAINT upload_folders_parent_lnk_uq UNIQUE (folder_id, inv_folder_id);


--
-- Name: upload_folders upload_folders_path_id_index; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_id_index UNIQUE (path_id);


--
-- Name: upload_folders upload_folders_path_index; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_index UNIQUE (path);


--
-- Name: upload_folders upload_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_api_token_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_permissions_api_token_lnk_fk ON public.admin_permissions_api_token_lnk USING btree (permission_id);


--
-- Name: admin_permissions_api_token_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_permissions_api_token_lnk_ifk ON public.admin_permissions_api_token_lnk USING btree (api_token_id);


--
-- Name: admin_permissions_api_token_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_permissions_api_token_lnk_oifk ON public.admin_permissions_api_token_lnk USING btree (permission_ord);


--
-- Name: admin_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_permissions_created_by_id_fk ON public.admin_permissions USING btree (created_by_id);


--
-- Name: admin_permissions_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_permissions_documents_idx ON public.admin_permissions USING btree (document_id, locale, published_at);


--
-- Name: admin_permissions_role_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_permissions_role_lnk_fk ON public.admin_permissions_role_lnk USING btree (permission_id);


--
-- Name: admin_permissions_role_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_permissions_role_lnk_ifk ON public.admin_permissions_role_lnk USING btree (role_id);


--
-- Name: admin_permissions_role_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_permissions_role_lnk_oifk ON public.admin_permissions_role_lnk USING btree (permission_ord);


--
-- Name: admin_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_permissions_updated_by_id_fk ON public.admin_permissions USING btree (updated_by_id);


--
-- Name: admin_roles_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_roles_created_by_id_fk ON public.admin_roles USING btree (created_by_id);


--
-- Name: admin_roles_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_roles_documents_idx ON public.admin_roles USING btree (document_id, locale, published_at);


--
-- Name: admin_roles_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_roles_updated_by_id_fk ON public.admin_roles USING btree (updated_by_id);


--
-- Name: admin_users_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_users_created_by_id_fk ON public.admin_users USING btree (created_by_id);


--
-- Name: admin_users_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_users_documents_idx ON public.admin_users USING btree (document_id, locale, published_at);


--
-- Name: admin_users_roles_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_users_roles_lnk_fk ON public.admin_users_roles_lnk USING btree (user_id);


--
-- Name: admin_users_roles_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_users_roles_lnk_ifk ON public.admin_users_roles_lnk USING btree (role_id);


--
-- Name: admin_users_roles_lnk_ofk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_users_roles_lnk_ofk ON public.admin_users_roles_lnk USING btree (role_ord);


--
-- Name: admin_users_roles_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_users_roles_lnk_oifk ON public.admin_users_roles_lnk USING btree (user_ord);


--
-- Name: admin_users_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_users_updated_by_id_fk ON public.admin_users USING btree (updated_by_id);


--
-- Name: blog_comments_author_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_comments_author_lnk_fk ON public.blog_comments_author_lnk USING btree (blog_comment_id);


--
-- Name: blog_comments_author_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_comments_author_lnk_ifk ON public.blog_comments_author_lnk USING btree (user_id);


--
-- Name: blog_comments_author_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_comments_author_lnk_oifk ON public.blog_comments_author_lnk USING btree (blog_comment_ord);


--
-- Name: blog_comments_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_comments_created_by_id_fk ON public.blog_comments USING btree (created_by_id);


--
-- Name: blog_comments_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_comments_documents_idx ON public.blog_comments USING btree (document_id, locale, published_at);


--
-- Name: blog_comments_post_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_comments_post_lnk_fk ON public.blog_comments_post_lnk USING btree (blog_comment_id);


--
-- Name: blog_comments_post_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_comments_post_lnk_ifk ON public.blog_comments_post_lnk USING btree (blog_post_id);


--
-- Name: blog_comments_post_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_comments_post_lnk_oifk ON public.blog_comments_post_lnk USING btree (blog_comment_ord);


--
-- Name: blog_comments_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_comments_updated_by_id_fk ON public.blog_comments USING btree (updated_by_id);


--
-- Name: blog_comments_useful_by_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_comments_useful_by_lnk_fk ON public.blog_comments_useful_by_lnk USING btree (blog_comment_id);


--
-- Name: blog_comments_useful_by_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_comments_useful_by_lnk_ifk ON public.blog_comments_useful_by_lnk USING btree (user_id);


--
-- Name: blog_comments_useful_by_lnk_ofk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_comments_useful_by_lnk_ofk ON public.blog_comments_useful_by_lnk USING btree (user_ord);


--
-- Name: blog_comments_useful_by_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_comments_useful_by_lnk_oifk ON public.blog_comments_useful_by_lnk USING btree (blog_comment_ord);


--
-- Name: blog_posts_author_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_posts_author_lnk_fk ON public.blog_posts_author_lnk USING btree (blog_post_id);


--
-- Name: blog_posts_author_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_posts_author_lnk_ifk ON public.blog_posts_author_lnk USING btree (user_id);


--
-- Name: blog_posts_author_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_posts_author_lnk_oifk ON public.blog_posts_author_lnk USING btree (blog_post_ord);


--
-- Name: blog_posts_category_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_posts_category_lnk_fk ON public.blog_posts_category_lnk USING btree (blog_post_id);


--
-- Name: blog_posts_category_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_posts_category_lnk_ifk ON public.blog_posts_category_lnk USING btree (category_id);


--
-- Name: blog_posts_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_posts_created_by_id_fk ON public.blog_posts USING btree (created_by_id);


--
-- Name: blog_posts_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_posts_documents_idx ON public.blog_posts USING btree (document_id, locale, published_at);


--
-- Name: blog_posts_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_posts_updated_by_id_fk ON public.blog_posts USING btree (updated_by_id);


--
-- Name: blog_posts_useful_by_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_posts_useful_by_lnk_fk ON public.blog_posts_useful_by_lnk USING btree (blog_post_id);


--
-- Name: blog_posts_useful_by_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_posts_useful_by_lnk_ifk ON public.blog_posts_useful_by_lnk USING btree (user_id);


--
-- Name: blog_posts_useful_by_lnk_ofk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_posts_useful_by_lnk_ofk ON public.blog_posts_useful_by_lnk USING btree (user_ord);


--
-- Name: blog_posts_useful_by_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blog_posts_useful_by_lnk_oifk ON public.blog_posts_useful_by_lnk USING btree (blog_post_ord);


--
-- Name: categories_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX categories_created_by_id_fk ON public.categories USING btree (created_by_id);


--
-- Name: categories_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX categories_documents_idx ON public.categories USING btree (document_id, locale, published_at);


--
-- Name: categories_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX categories_updated_by_id_fk ON public.categories USING btree (updated_by_id);


--
-- Name: discussions_author_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX discussions_author_lnk_fk ON public.discussions_author_lnk USING btree (discussion_id);


--
-- Name: discussions_author_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX discussions_author_lnk_ifk ON public.discussions_author_lnk USING btree (user_id);


--
-- Name: discussions_author_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX discussions_author_lnk_oifk ON public.discussions_author_lnk USING btree (discussion_ord);


--
-- Name: discussions_category_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX discussions_category_lnk_fk ON public.discussions_category_lnk USING btree (discussion_id);


--
-- Name: discussions_category_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX discussions_category_lnk_ifk ON public.discussions_category_lnk USING btree (category_id);


--
-- Name: discussions_category_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX discussions_category_lnk_oifk ON public.discussions_category_lnk USING btree (discussion_ord);


--
-- Name: discussions_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX discussions_created_by_id_fk ON public.discussions USING btree (created_by_id);


--
-- Name: discussions_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX discussions_documents_idx ON public.discussions USING btree (document_id, locale, published_at);


--
-- Name: discussions_followed_by_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX discussions_followed_by_lnk_fk ON public.discussions_followed_by_lnk USING btree (discussion_id);


--
-- Name: discussions_followed_by_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX discussions_followed_by_lnk_ifk ON public.discussions_followed_by_lnk USING btree (user_id);


--
-- Name: discussions_followed_by_lnk_ofk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX discussions_followed_by_lnk_ofk ON public.discussions_followed_by_lnk USING btree (user_ord);


--
-- Name: discussions_followed_by_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX discussions_followed_by_lnk_oifk ON public.discussions_followed_by_lnk USING btree (discussion_ord);


--
-- Name: discussions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX discussions_updated_by_id_fk ON public.discussions USING btree (updated_by_id);


--
-- Name: discussions_useful_by_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX discussions_useful_by_lnk_fk ON public.discussions_useful_by_lnk USING btree (discussion_id);


--
-- Name: discussions_useful_by_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX discussions_useful_by_lnk_ifk ON public.discussions_useful_by_lnk USING btree (user_id);


--
-- Name: discussions_useful_by_lnk_ofk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX discussions_useful_by_lnk_ofk ON public.discussions_useful_by_lnk USING btree (user_ord);


--
-- Name: discussions_useful_by_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX discussions_useful_by_lnk_oifk ON public.discussions_useful_by_lnk USING btree (discussion_ord);


--
-- Name: events_attendees_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX events_attendees_lnk_fk ON public.events_attendees_lnk USING btree (event_id);


--
-- Name: events_attendees_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX events_attendees_lnk_ifk ON public.events_attendees_lnk USING btree (user_id);


--
-- Name: events_attendees_lnk_ofk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX events_attendees_lnk_ofk ON public.events_attendees_lnk USING btree (user_ord);


--
-- Name: events_attendees_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX events_attendees_lnk_oifk ON public.events_attendees_lnk USING btree (event_ord);


--
-- Name: events_category_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX events_category_lnk_fk ON public.events_category_lnk USING btree (event_id);


--
-- Name: events_category_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX events_category_lnk_ifk ON public.events_category_lnk USING btree (category_id);


--
-- Name: events_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX events_created_by_id_fk ON public.events USING btree (created_by_id);


--
-- Name: events_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX events_documents_idx ON public.events USING btree (document_id, locale, published_at);


--
-- Name: events_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX events_updated_by_id_fk ON public.events USING btree (updated_by_id);


--
-- Name: files_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX files_created_by_id_fk ON public.files USING btree (created_by_id);


--
-- Name: files_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX files_documents_idx ON public.files USING btree (document_id, locale, published_at);


--
-- Name: files_folder_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX files_folder_lnk_fk ON public.files_folder_lnk USING btree (file_id);


--
-- Name: files_folder_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX files_folder_lnk_ifk ON public.files_folder_lnk USING btree (folder_id);


--
-- Name: files_folder_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX files_folder_lnk_oifk ON public.files_folder_lnk USING btree (file_ord);


--
-- Name: files_related_mph_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX files_related_mph_fk ON public.files_related_mph USING btree (file_id);


--
-- Name: files_related_mph_idix; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX files_related_mph_idix ON public.files_related_mph USING btree (related_id);


--
-- Name: files_related_mph_oidx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX files_related_mph_oidx ON public.files_related_mph USING btree ("order");


--
-- Name: files_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX files_updated_by_id_fk ON public.files USING btree (updated_by_id);


--
-- Name: i18n_locale_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX i18n_locale_created_by_id_fk ON public.i18n_locale USING btree (created_by_id);


--
-- Name: i18n_locale_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX i18n_locale_documents_idx ON public.i18n_locale USING btree (document_id, locale, published_at);


--
-- Name: i18n_locale_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX i18n_locale_updated_by_id_fk ON public.i18n_locale USING btree (updated_by_id);


--
-- Name: notifications_actor_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX notifications_actor_lnk_fk ON public.notifications_actor_lnk USING btree (notification_id);


--
-- Name: notifications_actor_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX notifications_actor_lnk_ifk ON public.notifications_actor_lnk USING btree (user_id);


--
-- Name: notifications_blog_post_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX notifications_blog_post_lnk_fk ON public.notifications_blog_post_lnk USING btree (notification_id);


--
-- Name: notifications_blog_post_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX notifications_blog_post_lnk_ifk ON public.notifications_blog_post_lnk USING btree (blog_post_id);


--
-- Name: notifications_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX notifications_created_by_id_fk ON public.notifications USING btree (created_by_id);


--
-- Name: notifications_discussion_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX notifications_discussion_lnk_fk ON public.notifications_discussion_lnk USING btree (notification_id);


--
-- Name: notifications_discussion_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX notifications_discussion_lnk_ifk ON public.notifications_discussion_lnk USING btree (discussion_id);


--
-- Name: notifications_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX notifications_documents_idx ON public.notifications USING btree (document_id, locale, published_at);


--
-- Name: notifications_recipient_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX notifications_recipient_lnk_fk ON public.notifications_recipient_lnk USING btree (notification_id);


--
-- Name: notifications_recipient_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX notifications_recipient_lnk_ifk ON public.notifications_recipient_lnk USING btree (user_id);


--
-- Name: notifications_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX notifications_updated_by_id_fk ON public.notifications USING btree (updated_by_id);


--
-- Name: replies_author_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX replies_author_lnk_fk ON public.replies_author_lnk USING btree (reply_id);


--
-- Name: replies_author_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX replies_author_lnk_ifk ON public.replies_author_lnk USING btree (user_id);


--
-- Name: replies_author_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX replies_author_lnk_oifk ON public.replies_author_lnk USING btree (reply_ord);


--
-- Name: replies_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX replies_created_by_id_fk ON public.replies USING btree (created_by_id);


--
-- Name: replies_discussion_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX replies_discussion_lnk_fk ON public.replies_discussion_lnk USING btree (reply_id);


--
-- Name: replies_discussion_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX replies_discussion_lnk_ifk ON public.replies_discussion_lnk USING btree (discussion_id);


--
-- Name: replies_discussion_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX replies_discussion_lnk_oifk ON public.replies_discussion_lnk USING btree (reply_ord);


--
-- Name: replies_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX replies_documents_idx ON public.replies USING btree (document_id, locale, published_at);


--
-- Name: replies_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX replies_updated_by_id_fk ON public.replies USING btree (updated_by_id);


--
-- Name: replies_useful_by_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX replies_useful_by_lnk_fk ON public.replies_useful_by_lnk USING btree (reply_id);


--
-- Name: replies_useful_by_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX replies_useful_by_lnk_ifk ON public.replies_useful_by_lnk USING btree (user_id);


--
-- Name: replies_useful_by_lnk_ofk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX replies_useful_by_lnk_ofk ON public.replies_useful_by_lnk USING btree (user_ord);


--
-- Name: replies_useful_by_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX replies_useful_by_lnk_oifk ON public.replies_useful_by_lnk USING btree (reply_ord);


--
-- Name: rewards_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rewards_created_by_id_fk ON public.rewards USING btree (created_by_id);


--
-- Name: rewards_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rewards_documents_idx ON public.rewards USING btree (document_id, locale, published_at);


--
-- Name: rewards_recipient_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rewards_recipient_lnk_fk ON public.rewards_recipient_lnk USING btree (reward_id);


--
-- Name: rewards_recipient_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rewards_recipient_lnk_ifk ON public.rewards_recipient_lnk USING btree (user_id);


--
-- Name: rewards_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rewards_updated_by_id_fk ON public.rewards USING btree (updated_by_id);


--
-- Name: strapi_api_token_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_api_token_permissions_created_by_id_fk ON public.strapi_api_token_permissions USING btree (created_by_id);


--
-- Name: strapi_api_token_permissions_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_api_token_permissions_documents_idx ON public.strapi_api_token_permissions USING btree (document_id, locale, published_at);


--
-- Name: strapi_api_token_permissions_token_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_api_token_permissions_token_lnk_fk ON public.strapi_api_token_permissions_token_lnk USING btree (api_token_permission_id);


--
-- Name: strapi_api_token_permissions_token_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_api_token_permissions_token_lnk_ifk ON public.strapi_api_token_permissions_token_lnk USING btree (api_token_id);


--
-- Name: strapi_api_token_permissions_token_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_api_token_permissions_token_lnk_oifk ON public.strapi_api_token_permissions_token_lnk USING btree (api_token_permission_ord);


--
-- Name: strapi_api_token_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_api_token_permissions_updated_by_id_fk ON public.strapi_api_token_permissions USING btree (updated_by_id);


--
-- Name: strapi_api_tokens_admin_user_owner_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_api_tokens_admin_user_owner_lnk_fk ON public.strapi_api_tokens_admin_user_owner_lnk USING btree (api_token_id);


--
-- Name: strapi_api_tokens_admin_user_owner_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_api_tokens_admin_user_owner_lnk_ifk ON public.strapi_api_tokens_admin_user_owner_lnk USING btree (user_id);


--
-- Name: strapi_api_tokens_admin_user_owner_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_api_tokens_admin_user_owner_lnk_oifk ON public.strapi_api_tokens_admin_user_owner_lnk USING btree (api_token_ord);


--
-- Name: strapi_api_tokens_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_api_tokens_created_by_id_fk ON public.strapi_api_tokens USING btree (created_by_id);


--
-- Name: strapi_api_tokens_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_api_tokens_documents_idx ON public.strapi_api_tokens USING btree (document_id, locale, published_at);


--
-- Name: strapi_api_tokens_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_api_tokens_updated_by_id_fk ON public.strapi_api_tokens USING btree (updated_by_id);


--
-- Name: strapi_history_versions_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_history_versions_created_by_id_fk ON public.strapi_history_versions USING btree (created_by_id);


--
-- Name: strapi_release_actions_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_release_actions_created_by_id_fk ON public.strapi_release_actions USING btree (created_by_id);


--
-- Name: strapi_release_actions_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_release_actions_documents_idx ON public.strapi_release_actions USING btree (document_id, locale, published_at);


--
-- Name: strapi_release_actions_release_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_release_actions_release_lnk_fk ON public.strapi_release_actions_release_lnk USING btree (release_action_id);


--
-- Name: strapi_release_actions_release_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_release_actions_release_lnk_ifk ON public.strapi_release_actions_release_lnk USING btree (release_id);


--
-- Name: strapi_release_actions_release_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_release_actions_release_lnk_oifk ON public.strapi_release_actions_release_lnk USING btree (release_action_ord);


--
-- Name: strapi_release_actions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_release_actions_updated_by_id_fk ON public.strapi_release_actions USING btree (updated_by_id);


--
-- Name: strapi_releases_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_releases_created_by_id_fk ON public.strapi_releases USING btree (created_by_id);


--
-- Name: strapi_releases_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_releases_documents_idx ON public.strapi_releases USING btree (document_id, locale, published_at);


--
-- Name: strapi_releases_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_releases_updated_by_id_fk ON public.strapi_releases USING btree (updated_by_id);


--
-- Name: strapi_sessions_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_sessions_created_by_id_fk ON public.strapi_sessions USING btree (created_by_id);


--
-- Name: strapi_sessions_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_sessions_documents_idx ON public.strapi_sessions USING btree (document_id, locale, published_at);


--
-- Name: strapi_sessions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_sessions_updated_by_id_fk ON public.strapi_sessions USING btree (updated_by_id);


--
-- Name: strapi_transfer_token_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_transfer_token_permissions_created_by_id_fk ON public.strapi_transfer_token_permissions USING btree (created_by_id);


--
-- Name: strapi_transfer_token_permissions_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_transfer_token_permissions_documents_idx ON public.strapi_transfer_token_permissions USING btree (document_id, locale, published_at);


--
-- Name: strapi_transfer_token_permissions_token_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_transfer_token_permissions_token_lnk_fk ON public.strapi_transfer_token_permissions_token_lnk USING btree (transfer_token_permission_id);


--
-- Name: strapi_transfer_token_permissions_token_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_transfer_token_permissions_token_lnk_ifk ON public.strapi_transfer_token_permissions_token_lnk USING btree (transfer_token_id);


--
-- Name: strapi_transfer_token_permissions_token_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_transfer_token_permissions_token_lnk_oifk ON public.strapi_transfer_token_permissions_token_lnk USING btree (transfer_token_permission_ord);


--
-- Name: strapi_transfer_token_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_transfer_token_permissions_updated_by_id_fk ON public.strapi_transfer_token_permissions USING btree (updated_by_id);


--
-- Name: strapi_transfer_tokens_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_transfer_tokens_created_by_id_fk ON public.strapi_transfer_tokens USING btree (created_by_id);


--
-- Name: strapi_transfer_tokens_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_transfer_tokens_documents_idx ON public.strapi_transfer_tokens USING btree (document_id, locale, published_at);


--
-- Name: strapi_transfer_tokens_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_transfer_tokens_updated_by_id_fk ON public.strapi_transfer_tokens USING btree (updated_by_id);


--
-- Name: strapi_workflows_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_created_by_id_fk ON public.strapi_workflows USING btree (created_by_id);


--
-- Name: strapi_workflows_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_documents_idx ON public.strapi_workflows USING btree (document_id, locale, published_at);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stage_required_to_publish_lnk_fk ON public.strapi_workflows_stage_required_to_publish_lnk USING btree (workflow_id);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stage_required_to_publish_lnk_ifk ON public.strapi_workflows_stage_required_to_publish_lnk USING btree (workflow_stage_id);


--
-- Name: strapi_workflows_stages_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stages_created_by_id_fk ON public.strapi_workflows_stages USING btree (created_by_id);


--
-- Name: strapi_workflows_stages_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stages_documents_idx ON public.strapi_workflows_stages USING btree (document_id, locale, published_at);


--
-- Name: strapi_workflows_stages_permissions_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stages_permissions_lnk_fk ON public.strapi_workflows_stages_permissions_lnk USING btree (workflow_stage_id);


--
-- Name: strapi_workflows_stages_permissions_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stages_permissions_lnk_ifk ON public.strapi_workflows_stages_permissions_lnk USING btree (permission_id);


--
-- Name: strapi_workflows_stages_permissions_lnk_ofk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stages_permissions_lnk_ofk ON public.strapi_workflows_stages_permissions_lnk USING btree (permission_ord);


--
-- Name: strapi_workflows_stages_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stages_updated_by_id_fk ON public.strapi_workflows_stages USING btree (updated_by_id);


--
-- Name: strapi_workflows_stages_workflow_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stages_workflow_lnk_fk ON public.strapi_workflows_stages_workflow_lnk USING btree (workflow_stage_id);


--
-- Name: strapi_workflows_stages_workflow_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stages_workflow_lnk_ifk ON public.strapi_workflows_stages_workflow_lnk USING btree (workflow_id);


--
-- Name: strapi_workflows_stages_workflow_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stages_workflow_lnk_oifk ON public.strapi_workflows_stages_workflow_lnk USING btree (workflow_stage_ord);


--
-- Name: strapi_workflows_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_updated_by_id_fk ON public.strapi_workflows USING btree (updated_by_id);


--
-- Name: up_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_permissions_created_by_id_fk ON public.up_permissions USING btree (created_by_id);


--
-- Name: up_permissions_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_permissions_documents_idx ON public.up_permissions USING btree (document_id, locale, published_at);


--
-- Name: up_permissions_role_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_permissions_role_lnk_fk ON public.up_permissions_role_lnk USING btree (permission_id);


--
-- Name: up_permissions_role_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_permissions_role_lnk_ifk ON public.up_permissions_role_lnk USING btree (role_id);


--
-- Name: up_permissions_role_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_permissions_role_lnk_oifk ON public.up_permissions_role_lnk USING btree (permission_ord);


--
-- Name: up_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_permissions_updated_by_id_fk ON public.up_permissions USING btree (updated_by_id);


--
-- Name: up_roles_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_roles_created_by_id_fk ON public.up_roles USING btree (created_by_id);


--
-- Name: up_roles_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_roles_documents_idx ON public.up_roles USING btree (document_id, locale, published_at);


--
-- Name: up_roles_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_roles_updated_by_id_fk ON public.up_roles USING btree (updated_by_id);


--
-- Name: up_users_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_users_created_by_id_fk ON public.up_users USING btree (created_by_id);


--
-- Name: up_users_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_users_documents_idx ON public.up_users USING btree (document_id, locale, published_at);


--
-- Name: up_users_role_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_users_role_lnk_fk ON public.up_users_role_lnk USING btree (user_id);


--
-- Name: up_users_role_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_users_role_lnk_ifk ON public.up_users_role_lnk USING btree (role_id);


--
-- Name: up_users_role_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_users_role_lnk_oifk ON public.up_users_role_lnk USING btree (user_ord);


--
-- Name: up_users_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_users_updated_by_id_fk ON public.up_users USING btree (updated_by_id);


--
-- Name: upload_files_created_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_files_created_at_index ON public.files USING btree (created_at);


--
-- Name: upload_files_ext_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_files_ext_index ON public.files USING btree (ext);


--
-- Name: upload_files_folder_path_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_files_folder_path_index ON public.files USING btree (folder_path);


--
-- Name: upload_files_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_files_name_index ON public.files USING btree (name);


--
-- Name: upload_files_size_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_files_size_index ON public.files USING btree (size);


--
-- Name: upload_files_updated_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_files_updated_at_index ON public.files USING btree (updated_at);


--
-- Name: upload_folders_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_folders_created_by_id_fk ON public.upload_folders USING btree (created_by_id);


--
-- Name: upload_folders_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_folders_documents_idx ON public.upload_folders USING btree (document_id, locale, published_at);


--
-- Name: upload_folders_parent_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_folders_parent_lnk_fk ON public.upload_folders_parent_lnk USING btree (folder_id);


--
-- Name: upload_folders_parent_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_folders_parent_lnk_ifk ON public.upload_folders_parent_lnk USING btree (inv_folder_id);


--
-- Name: upload_folders_parent_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_folders_parent_lnk_oifk ON public.upload_folders_parent_lnk USING btree (folder_ord);


--
-- Name: upload_folders_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_folders_updated_by_id_fk ON public.upload_folders USING btree (updated_by_id);


--
-- Name: admin_permissions_api_token_lnk admin_permissions_api_token_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions_api_token_lnk
    ADD CONSTRAINT admin_permissions_api_token_lnk_fk FOREIGN KEY (permission_id) REFERENCES public.admin_permissions(id) ON DELETE CASCADE;


--
-- Name: admin_permissions_api_token_lnk admin_permissions_api_token_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions_api_token_lnk
    ADD CONSTRAINT admin_permissions_api_token_lnk_ifk FOREIGN KEY (api_token_id) REFERENCES public.strapi_api_tokens(id) ON DELETE CASCADE;


--
-- Name: admin_permissions admin_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_permissions_role_lnk admin_permissions_role_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions_role_lnk
    ADD CONSTRAINT admin_permissions_role_lnk_fk FOREIGN KEY (permission_id) REFERENCES public.admin_permissions(id) ON DELETE CASCADE;


--
-- Name: admin_permissions_role_lnk admin_permissions_role_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions_role_lnk
    ADD CONSTRAINT admin_permissions_role_lnk_ifk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;


--
-- Name: admin_permissions admin_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_roles admin_roles_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_roles admin_roles_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_users admin_users_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_users_roles_lnk admin_users_roles_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users_roles_lnk
    ADD CONSTRAINT admin_users_roles_lnk_fk FOREIGN KEY (user_id) REFERENCES public.admin_users(id) ON DELETE CASCADE;


--
-- Name: admin_users_roles_lnk admin_users_roles_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users_roles_lnk
    ADD CONSTRAINT admin_users_roles_lnk_ifk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;


--
-- Name: admin_users admin_users_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: blog_comments_author_lnk blog_comments_author_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_comments_author_lnk
    ADD CONSTRAINT blog_comments_author_lnk_fk FOREIGN KEY (blog_comment_id) REFERENCES public.blog_comments(id) ON DELETE CASCADE;


--
-- Name: blog_comments_author_lnk blog_comments_author_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_comments_author_lnk
    ADD CONSTRAINT blog_comments_author_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: blog_comments blog_comments_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_comments
    ADD CONSTRAINT blog_comments_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: blog_comments_post_lnk blog_comments_post_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_comments_post_lnk
    ADD CONSTRAINT blog_comments_post_lnk_fk FOREIGN KEY (blog_comment_id) REFERENCES public.blog_comments(id) ON DELETE CASCADE;


--
-- Name: blog_comments_post_lnk blog_comments_post_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_comments_post_lnk
    ADD CONSTRAINT blog_comments_post_lnk_ifk FOREIGN KEY (blog_post_id) REFERENCES public.blog_posts(id) ON DELETE CASCADE;


--
-- Name: blog_comments blog_comments_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_comments
    ADD CONSTRAINT blog_comments_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: blog_comments_useful_by_lnk blog_comments_useful_by_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_comments_useful_by_lnk
    ADD CONSTRAINT blog_comments_useful_by_lnk_fk FOREIGN KEY (blog_comment_id) REFERENCES public.blog_comments(id) ON DELETE CASCADE;


--
-- Name: blog_comments_useful_by_lnk blog_comments_useful_by_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_comments_useful_by_lnk
    ADD CONSTRAINT blog_comments_useful_by_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: blog_posts_author_lnk blog_posts_author_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts_author_lnk
    ADD CONSTRAINT blog_posts_author_lnk_fk FOREIGN KEY (blog_post_id) REFERENCES public.blog_posts(id) ON DELETE CASCADE;


--
-- Name: blog_posts_author_lnk blog_posts_author_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts_author_lnk
    ADD CONSTRAINT blog_posts_author_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: blog_posts_category_lnk blog_posts_category_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts_category_lnk
    ADD CONSTRAINT blog_posts_category_lnk_fk FOREIGN KEY (blog_post_id) REFERENCES public.blog_posts(id) ON DELETE CASCADE;


--
-- Name: blog_posts_category_lnk blog_posts_category_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts_category_lnk
    ADD CONSTRAINT blog_posts_category_lnk_ifk FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: blog_posts blog_posts_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts
    ADD CONSTRAINT blog_posts_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: blog_posts blog_posts_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts
    ADD CONSTRAINT blog_posts_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: blog_posts_useful_by_lnk blog_posts_useful_by_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts_useful_by_lnk
    ADD CONSTRAINT blog_posts_useful_by_lnk_fk FOREIGN KEY (blog_post_id) REFERENCES public.blog_posts(id) ON DELETE CASCADE;


--
-- Name: blog_posts_useful_by_lnk blog_posts_useful_by_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts_useful_by_lnk
    ADD CONSTRAINT blog_posts_useful_by_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: categories categories_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: categories categories_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: discussions_author_lnk discussions_author_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions_author_lnk
    ADD CONSTRAINT discussions_author_lnk_fk FOREIGN KEY (discussion_id) REFERENCES public.discussions(id) ON DELETE CASCADE;


--
-- Name: discussions_author_lnk discussions_author_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions_author_lnk
    ADD CONSTRAINT discussions_author_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: discussions_category_lnk discussions_category_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions_category_lnk
    ADD CONSTRAINT discussions_category_lnk_fk FOREIGN KEY (discussion_id) REFERENCES public.discussions(id) ON DELETE CASCADE;


--
-- Name: discussions_category_lnk discussions_category_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions_category_lnk
    ADD CONSTRAINT discussions_category_lnk_ifk FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: discussions discussions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions
    ADD CONSTRAINT discussions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: discussions_followed_by_lnk discussions_followed_by_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions_followed_by_lnk
    ADD CONSTRAINT discussions_followed_by_lnk_fk FOREIGN KEY (discussion_id) REFERENCES public.discussions(id) ON DELETE CASCADE;


--
-- Name: discussions_followed_by_lnk discussions_followed_by_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions_followed_by_lnk
    ADD CONSTRAINT discussions_followed_by_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: discussions discussions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions
    ADD CONSTRAINT discussions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: discussions_useful_by_lnk discussions_useful_by_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions_useful_by_lnk
    ADD CONSTRAINT discussions_useful_by_lnk_fk FOREIGN KEY (discussion_id) REFERENCES public.discussions(id) ON DELETE CASCADE;


--
-- Name: discussions_useful_by_lnk discussions_useful_by_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussions_useful_by_lnk
    ADD CONSTRAINT discussions_useful_by_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: events_attendees_lnk events_attendees_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_attendees_lnk
    ADD CONSTRAINT events_attendees_lnk_fk FOREIGN KEY (event_id) REFERENCES public.events(id) ON DELETE CASCADE;


--
-- Name: events_attendees_lnk events_attendees_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_attendees_lnk
    ADD CONSTRAINT events_attendees_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: events_category_lnk events_category_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_category_lnk
    ADD CONSTRAINT events_category_lnk_fk FOREIGN KEY (event_id) REFERENCES public.events(id) ON DELETE CASCADE;


--
-- Name: events_category_lnk events_category_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_category_lnk
    ADD CONSTRAINT events_category_lnk_ifk FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: events events_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: events events_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: files files_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: files_folder_lnk files_folder_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files_folder_lnk
    ADD CONSTRAINT files_folder_lnk_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;


--
-- Name: files_folder_lnk files_folder_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files_folder_lnk
    ADD CONSTRAINT files_folder_lnk_ifk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: files_related_mph files_related_mph_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files_related_mph
    ADD CONSTRAINT files_related_mph_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;


--
-- Name: files files_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: i18n_locale i18n_locale_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: i18n_locale i18n_locale_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: notifications_actor_lnk notifications_actor_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications_actor_lnk
    ADD CONSTRAINT notifications_actor_lnk_fk FOREIGN KEY (notification_id) REFERENCES public.notifications(id) ON DELETE CASCADE;


--
-- Name: notifications_actor_lnk notifications_actor_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications_actor_lnk
    ADD CONSTRAINT notifications_actor_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: notifications_blog_post_lnk notifications_blog_post_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications_blog_post_lnk
    ADD CONSTRAINT notifications_blog_post_lnk_fk FOREIGN KEY (notification_id) REFERENCES public.notifications(id) ON DELETE CASCADE;


--
-- Name: notifications_blog_post_lnk notifications_blog_post_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications_blog_post_lnk
    ADD CONSTRAINT notifications_blog_post_lnk_ifk FOREIGN KEY (blog_post_id) REFERENCES public.blog_posts(id) ON DELETE CASCADE;


--
-- Name: notifications notifications_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: notifications_discussion_lnk notifications_discussion_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications_discussion_lnk
    ADD CONSTRAINT notifications_discussion_lnk_fk FOREIGN KEY (notification_id) REFERENCES public.notifications(id) ON DELETE CASCADE;


--
-- Name: notifications_discussion_lnk notifications_discussion_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications_discussion_lnk
    ADD CONSTRAINT notifications_discussion_lnk_ifk FOREIGN KEY (discussion_id) REFERENCES public.discussions(id) ON DELETE CASCADE;


--
-- Name: notifications_recipient_lnk notifications_recipient_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications_recipient_lnk
    ADD CONSTRAINT notifications_recipient_lnk_fk FOREIGN KEY (notification_id) REFERENCES public.notifications(id) ON DELETE CASCADE;


--
-- Name: notifications_recipient_lnk notifications_recipient_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications_recipient_lnk
    ADD CONSTRAINT notifications_recipient_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: notifications notifications_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: replies_author_lnk replies_author_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies_author_lnk
    ADD CONSTRAINT replies_author_lnk_fk FOREIGN KEY (reply_id) REFERENCES public.replies(id) ON DELETE CASCADE;


--
-- Name: replies_author_lnk replies_author_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies_author_lnk
    ADD CONSTRAINT replies_author_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: replies replies_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies
    ADD CONSTRAINT replies_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: replies_discussion_lnk replies_discussion_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies_discussion_lnk
    ADD CONSTRAINT replies_discussion_lnk_fk FOREIGN KEY (reply_id) REFERENCES public.replies(id) ON DELETE CASCADE;


--
-- Name: replies_discussion_lnk replies_discussion_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies_discussion_lnk
    ADD CONSTRAINT replies_discussion_lnk_ifk FOREIGN KEY (discussion_id) REFERENCES public.discussions(id) ON DELETE CASCADE;


--
-- Name: replies replies_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies
    ADD CONSTRAINT replies_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: replies_useful_by_lnk replies_useful_by_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies_useful_by_lnk
    ADD CONSTRAINT replies_useful_by_lnk_fk FOREIGN KEY (reply_id) REFERENCES public.replies(id) ON DELETE CASCADE;


--
-- Name: replies_useful_by_lnk replies_useful_by_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies_useful_by_lnk
    ADD CONSTRAINT replies_useful_by_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: rewards rewards_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rewards
    ADD CONSTRAINT rewards_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: rewards_recipient_lnk rewards_recipient_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rewards_recipient_lnk
    ADD CONSTRAINT rewards_recipient_lnk_fk FOREIGN KEY (reward_id) REFERENCES public.rewards(id) ON DELETE CASCADE;


--
-- Name: rewards_recipient_lnk rewards_recipient_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rewards_recipient_lnk
    ADD CONSTRAINT rewards_recipient_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: rewards rewards_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rewards
    ADD CONSTRAINT rewards_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_token_permissions_token_lnk strapi_api_token_permissions_token_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk
    ADD CONSTRAINT strapi_api_token_permissions_token_lnk_fk FOREIGN KEY (api_token_permission_id) REFERENCES public.strapi_api_token_permissions(id) ON DELETE CASCADE;


--
-- Name: strapi_api_token_permissions_token_lnk strapi_api_token_permissions_token_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk
    ADD CONSTRAINT strapi_api_token_permissions_token_lnk_ifk FOREIGN KEY (api_token_id) REFERENCES public.strapi_api_tokens(id) ON DELETE CASCADE;


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_tokens_admin_user_owner_lnk strapi_api_tokens_admin_user_owner_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_tokens_admin_user_owner_lnk
    ADD CONSTRAINT strapi_api_tokens_admin_user_owner_lnk_fk FOREIGN KEY (api_token_id) REFERENCES public.strapi_api_tokens(id) ON DELETE CASCADE;


--
-- Name: strapi_api_tokens_admin_user_owner_lnk strapi_api_tokens_admin_user_owner_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_tokens_admin_user_owner_lnk
    ADD CONSTRAINT strapi_api_tokens_admin_user_owner_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.admin_users(id) ON DELETE CASCADE;


--
-- Name: strapi_api_tokens strapi_api_tokens_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_tokens strapi_api_tokens_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_history_versions strapi_history_versions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_history_versions
    ADD CONSTRAINT strapi_history_versions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_release_actions strapi_release_actions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_release_actions
    ADD CONSTRAINT strapi_release_actions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_release_actions_release_lnk strapi_release_actions_release_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk
    ADD CONSTRAINT strapi_release_actions_release_lnk_fk FOREIGN KEY (release_action_id) REFERENCES public.strapi_release_actions(id) ON DELETE CASCADE;


--
-- Name: strapi_release_actions_release_lnk strapi_release_actions_release_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk
    ADD CONSTRAINT strapi_release_actions_release_lnk_ifk FOREIGN KEY (release_id) REFERENCES public.strapi_releases(id) ON DELETE CASCADE;


--
-- Name: strapi_release_actions strapi_release_actions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_release_actions
    ADD CONSTRAINT strapi_release_actions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_releases strapi_releases_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_releases
    ADD CONSTRAINT strapi_releases_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_releases strapi_releases_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_releases
    ADD CONSTRAINT strapi_releases_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_sessions strapi_sessions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_sessions
    ADD CONSTRAINT strapi_sessions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_sessions strapi_sessions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_sessions
    ADD CONSTRAINT strapi_sessions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_token_permissions_token_lnk strapi_transfer_token_permissions_token_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk
    ADD CONSTRAINT strapi_transfer_token_permissions_token_lnk_fk FOREIGN KEY (transfer_token_permission_id) REFERENCES public.strapi_transfer_token_permissions(id) ON DELETE CASCADE;


--
-- Name: strapi_transfer_token_permissions_token_lnk strapi_transfer_token_permissions_token_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk
    ADD CONSTRAINT strapi_transfer_token_permissions_token_lnk_ifk FOREIGN KEY (transfer_token_id) REFERENCES public.strapi_transfer_tokens(id) ON DELETE CASCADE;


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_workflows strapi_workflows_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows
    ADD CONSTRAINT strapi_workflows_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_workflows_stage_required_to_publish_lnk strapi_workflows_stage_required_to_publish_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk
    ADD CONSTRAINT strapi_workflows_stage_required_to_publish_lnk_fk FOREIGN KEY (workflow_id) REFERENCES public.strapi_workflows(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stage_required_to_publish_lnk strapi_workflows_stage_required_to_publish_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk
    ADD CONSTRAINT strapi_workflows_stage_required_to_publish_lnk_ifk FOREIGN KEY (workflow_stage_id) REFERENCES public.strapi_workflows_stages(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stages strapi_workflows_stages_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages
    ADD CONSTRAINT strapi_workflows_stages_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_workflows_stages_permissions_lnk strapi_workflows_stages_permissions_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk
    ADD CONSTRAINT strapi_workflows_stages_permissions_lnk_fk FOREIGN KEY (workflow_stage_id) REFERENCES public.strapi_workflows_stages(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stages_permissions_lnk strapi_workflows_stages_permissions_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk
    ADD CONSTRAINT strapi_workflows_stages_permissions_lnk_ifk FOREIGN KEY (permission_id) REFERENCES public.admin_permissions(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stages strapi_workflows_stages_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages
    ADD CONSTRAINT strapi_workflows_stages_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_workflows_stages_workflow_lnk strapi_workflows_stages_workflow_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk
    ADD CONSTRAINT strapi_workflows_stages_workflow_lnk_fk FOREIGN KEY (workflow_stage_id) REFERENCES public.strapi_workflows_stages(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stages_workflow_lnk strapi_workflows_stages_workflow_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk
    ADD CONSTRAINT strapi_workflows_stages_workflow_lnk_ifk FOREIGN KEY (workflow_id) REFERENCES public.strapi_workflows(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows strapi_workflows_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows
    ADD CONSTRAINT strapi_workflows_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_permissions up_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_permissions_role_lnk up_permissions_role_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_permissions_role_lnk
    ADD CONSTRAINT up_permissions_role_lnk_fk FOREIGN KEY (permission_id) REFERENCES public.up_permissions(id) ON DELETE CASCADE;


--
-- Name: up_permissions_role_lnk up_permissions_role_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_permissions_role_lnk
    ADD CONSTRAINT up_permissions_role_lnk_ifk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;


--
-- Name: up_permissions up_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_roles up_roles_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_roles up_roles_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_users up_users_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_users_role_lnk up_users_role_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_users_role_lnk
    ADD CONSTRAINT up_users_role_lnk_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: up_users_role_lnk up_users_role_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_users_role_lnk
    ADD CONSTRAINT up_users_role_lnk_ifk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;


--
-- Name: up_users up_users_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: upload_folders upload_folders_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: upload_folders_parent_lnk upload_folders_parent_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders_parent_lnk
    ADD CONSTRAINT upload_folders_parent_lnk_fk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: upload_folders_parent_lnk upload_folders_parent_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders_parent_lnk
    ADD CONSTRAINT upload_folders_parent_lnk_ifk FOREIGN KEY (inv_folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: upload_folders upload_folders_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--


