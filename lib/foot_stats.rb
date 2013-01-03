require 'foot_stats/version'

module FootStats
  autoload :Championship,  'foot_stats/championship'
  autoload :ChampionshipClassification, 'foot_stats/championship_classification'
  autoload :ErrorResponse, 'foot_stats/error_response'
  autoload :Match,         'foot_stats/match'
  autoload :Narration,     'foot_stats/narration'
  autoload :Resource,      'foot_stats/resource'
  autoload :Request,       'foot_stats/request'
  autoload :Response,      'foot_stats/response'
  autoload :Team,          'foot_stats/team'
  autoload :Setup,         'foot_stats/setup'
end
