#!/usr/bin/env coffee

DEFAULT_SIZE = 96
DEFAULT_IMAGE = "http://i.imgur.com/wyMAL.jpg"
version = require(__dirname + '/package.json').version

program = require 'commander'
program.version(version).usage('[options] email')
program.option '-d, --destination [filename]', "destination [~/.face]", "#{process.env.HOME}/.face"
program.option '-s, --size [size]', "image size [#{DEFAULT_SIZE}]", parseInt, DEFAULT_SIZE
program.parse(process.argv)

if not program.args.length then program.help()

email = program.args[0]
hash = require('crypto').createHash('md5').update(email).digest('hex')

url = "http://www.gravatar.com/avatar/#{hash}?s=#{program.size or DEFAULT_SIZE}&d=#{DEFAULT_IMAGE}"

request = require 'request'
fs = require 'fs'
request(picUrl).pipe(fs.createWriteStream(program.destination))

console.log "Success!"

