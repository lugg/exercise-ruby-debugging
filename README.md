# Ruby Exercise

This is a vanilla Rails API app containing a single stub endpoint to dispatch Luggs:

> POST /moves

Setup like regular Rails apps:

```
$ bundle install
$ rake db:setup
```

It comes with a stub implementation of Onfleet, the service we use to dispatch actual requests.

One day a customer wrote us in via support:

> Hi, I'm having trouble to request a Lugg.  
> My address is 9 Hilgard Way, in Berkeley.  
> I keep getting an "Internal error" from your app.  
> Please advise.

We have written a test to simulate this issue, to run it:

```
$ rake
```

Can you identify what's the culprit?

How would you address the issue?
