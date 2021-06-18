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
- Hold onto stateful components for lifetime of app instead of recreating every request
- Action gets removed from continuation dict when it's called, because we'll be rerendering
  - Is this necessary, or will it just get overridden anyway?
- 
