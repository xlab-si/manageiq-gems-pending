require 'fs/ext3/superblock'

module Ext3Probe
  def self.probe(dobj)
    unless dobj.kind_of?(MiqDisk)
      $log.debug("Ext3Probe << FALSE because Disk Object class is not MiqDisk, but is '#{dobj.class}'") if $log
      return false
    end

    dobj.seek(0, IO::SEEK_SET)
    Ext3::Superblock.new(dobj)

    # If initializing the superblock does not throw any errors, then this is ext3
    $log.debug("Ext3Probe << TRUE") if $log
    return true
  rescue => err
    $log.debug("Ext3Probe << FALSE because #{err.message}") if $log
    return false
  ensure
    dobj.seek(0, IO::SEEK_SET)
  end
end