require('dotenv').config()
const crypto = require('crypto')
const qs = require('qs')


const slack = (req, res, next) => {
  if (req.body) {
    let requestBody = qs.stringify(req.body, { format: 'RFC1738' })
    let timeStamp = req.headers['x-slack-request-timestamp']
    let slackSignature = req.headers['x-slack-signature']

    // protect against replay attack
    if ((Math.floor(new Date() / 1000) - timeStamp) > 60 * 5) {
      // if it's more than 5 min difference, it could be a replay attack.
      console.log('could be a replay attack')
      res.status(401)
    }

    // concatinate the version number with timestamp and the req.body
    let version = 'v0'
    let signatureBaseString = `${version}:${timeStamp}:${requestBody}`
    hash = crypto.createHmac('sha256', process.env.slack_signing_secret).update(signatureBaseString).digest('hex')
    my_string = `${version}=${hash}`

    if (my_string === slackSignature) {
      console.log('valid post from slack')
      next()
    } else {
      res.status(403)
    }

  }
}
const client = (req, res, next) => {
  console.log('validate')
  console.log('INNAN STRINGIFY: ', req.headers['client-signature'])
  let clientHeader = qs.stringify(req.headers['client-signature'])
  console.log(typeof clientHeader)
  hash = crypto.createHmac('sha256', process.env.client_signature).digest('hex')
  if(hash === clientHeader) {
    console.log('DA MATCH:', hash, clientHeader)
    next()
  } else {
    console.log('DA FAIL: ', hash, clientHeader)
    res.status(403).send('No way, José!')
  }

}

module.exports = {
  slack,
  client
}
