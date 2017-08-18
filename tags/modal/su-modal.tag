<su-modal>
  <div class="ui dimmer modals page transition { transitionStatus }" onclick="{ dimmerClose }">
    <div class="ui modal transition visible active {opts.class}">
      <i class="close icon" if="{ opts.class == 'fullscreen' }" onclick="{ close }"></i>
      <div class="ui header { icon: opts.modal.heading.icon }">
        <i class="icon { opts.modal.heading.icon }" if="{ opts.modal.heading.icon }"></i>
        { (opts.modal.heading.text) ? opts.modal.heading.text : opts.modal.heading }
      </div>
      <div class="content {opts.modal.content_class}">
        <yield />
      </div>
      <div class="actions">
        <div each="{ opts.modal.buttons }" class="ui button { type } { labeled: icon && text } { icon: icon } { inverted: opts.class == 'basic' }"
          onclick="{ parent.click.bind(this, action) }">
          { text }
          <i class="icon { icon }" if="{ icon }"></i>
        </div>
      </div>
    </div>
  </div>
  <style>
    .ui.dimmer.visible.transition {
      display: flex !important;
      align-items: center;
      justify-content: center;
    }

    .ui.modal {
      top: auto;
      left: auto;
      position: relative;
      margin: 0;
    }
  </style>
  <script>
    this.on('mount', () => {
      if (!opts.modal) {
        opts.modal = {}
      }
      if (typeof opts.modal.closable === 'undefined') {
        opts.modal.closable = true
      }
    })

    this.on('update', () => {
      if (opts.modal.visible) {
        this.transitionStatus = 'animating fade in visible'
        setTimeout(() => {
          this.transitionStatus = 'visible'
          this.update()
        }, 500)
      }
    })

    this.click = action => {
      this.close(action)
    }

    this.dimmerClose = action => {
      if (opts.modal.closable) {
        this.close(action)
      }
    }

    this.close = action => {
      if (action && toString.call(action).slice(8, -1).toLowerCase() === 'function') {
        action()
      }
      opts.modal.visible = false
      this.transitionStatus = 'animating fade out visible active'
      this.update()

      setTimeout(() => {
        this.transitionStatus = 'hidden'
        this.update()
      }, 300)
    }
  </script>
</su-modal>