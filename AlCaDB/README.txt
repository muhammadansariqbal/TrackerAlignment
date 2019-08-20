Useful Links for AlCaDB Stuff
=============================

# AlCaDB tutorial
https://indico.cern.ch/event/828624/

# Looking up tags using conddb
conddb [-h] [--db DB] [--verbose] [--quiet] [--yes] [--nocolors]  [--editor EDITOR] [--force] [--noLimit]
# For example to see contents of a db file i.e. list of all tags
conddb --db myFile.db listTags
# To see the payloads in a specific tag
conddb --db myFile.db list Alignments

# Copy and tailor tags locally
conddb_import [options]
  --debug                  switch on debug mode
  -h [ --help ]            help message
  -f [ --fromConnect ] arg source connection string (optional, default=connect)
  -c [ --connect ] arg     target connection string (required)
  -P [ --authPath ] arg    path to the authentication key
  -u [ --user ] arg        user name
  -p [ --pass ] arg        password
  -i [ --inputTag ] arg    source tag (optional - default=tag)
  -t [ --tag ] arg         destination tag (required)
  -b [ --begin ] arg       lower bound of interval to import (optional, 
                           default=1)
  -e [ --end ] arg         upper bound of interval to import (optional, 
                           default=infinity)
  -x [ --description ] arg User text ( for new tags, optional )
  -o [ --override ]        Override the existing iovs in the dest tag, for the 
                           selected interval ( optional, default=false)
  -r [ --reserialize ]     De-serialize in reading and serialize in writing 
                           (optional, default=false)
  -K [ --forceInsert ]     force the insert for all synchronization types 
                           (optional, default=false)
  -N [ --editingNote ] arg editing note (required with forceInsert)
# For example
conddb_import -c sqlite_file:targetLocalFile.db -f frontier://FrontierProd/CMS_CONDITIONS -i TrackerAlignment_v25_offline -t Alignments -b 1 -e 313041
conddb_import -c sqlite_file:targetLocalFile.db -f sqlite_file:sourceLocalFile.db -i Alignments -t Alignments -b 1 -e 313041

# To upload conditions
uploadConditions.py localFile.db

