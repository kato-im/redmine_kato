Redmine::Plugin.register :redmine_kato do
  name 'Kato'
  author 'LeChat, Inc.'
  description 'Sends notifications to Kato.'
  version '0.0.1'
  url 'https://github.com/kato-im/redmine_kato'
  author_url 'https://kato.im/'

  Rails.configuration.to_prepare do
    require_dependency 'kato_hooks'
    require_dependency 'kato_view_hooks'
    require_dependency 'project_patch'
    Project.send(:include, RedmineKato::Patches::ProjectPatch)
  end

  settings :partial => 'settings/redmine_kato',
    :default => {
      :kato_url => ""
    }
end
