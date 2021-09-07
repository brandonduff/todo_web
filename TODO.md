Todo File
---

- [ ] Allow undoing particular todos
- [ ] Continuations instead of http routing
    - [ ] Can simply trigger an action on a component
    - [ ] Component is passed form data in some way from callback (or it gets set via fields by the time the callback is invoked, like Seaside!)
    - [ ] Form actions are auto-generated
- [ ] Multi tenancy
    - [ ] Marshal for persistence. PStore should help with this
    - [ ] Associate notes with session state
    - [ ] Store notes associated with separate notepads for different users, based on session
    - [ ] Allow creation of users. Passwords w/ BCrypt could be fun to figure out (or just start with something insecure)


test list
- 'form_submission' duplication
- make this an application, not a gem
  - basically, remove TodoWeb module and gemspec, replace with Gemfile
- clearing finished todos
  

