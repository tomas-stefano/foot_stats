require 'singleton'
require 'digest/md5'

require 'json'
require 'rest-client'

require 'foot_stats/version'

module FootStats
  autoload :Championship,               'foot_stats/championship'
  autoload :ChampionshipClassification, 'foot_stats/championship_classification'
  autoload :ErrorResponse,              'foot_stats/error_response'
  autoload :Live,                       'foot_stats/live'
  autoload :Match,                      'foot_stats/match'
  autoload :Narration,                  'foot_stats/narration'
  autoload :Player,                     'foot_stats/player'
  autoload :Request,                    'foot_stats/request'
  autoload :Resource,                   'foot_stats/resource'
  autoload :Response,                   'foot_stats/response'
  autoload :Setup,                      'foot_stats/setup'
  autoload :Stream,                     'foot_stats/stream'
  autoload :Team,                       'foot_stats/team'
end
