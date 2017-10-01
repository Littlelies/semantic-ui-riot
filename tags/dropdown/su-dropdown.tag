<su-dropdown class="ui selection {opts.class} { search: opts.search } { multiple: opts.multiple} dropdown { active: visibleFlg } { visible: visibleFlg }"
  onclick="{ toggle }" onfocus="{ open }" onblur="{ blur.bind(this, false) }" tabindex="{ opts.search ? -1 : getTabindex() }">
  <i class="dropdown icon"></i>
  <input class="search" autocomplete="off" tabindex="{ getTabindex() }" ref="condition" if="{ opts.search }" onkeydown="{keydown}"
    onkeyup="{ keyup }" onfocus="{ open }" onblur="{ blur.bind(this, true) }" />
  <a each="{item in opts.items}" class="ui label transition visible" style="display: inline-block !important;" if="{ item.selected }">
  { item.label }
  <i class="delete icon" onclick="{ unselect }"></i>
</a>
  <div class="{ default: default} text { filtered: filtered }" if="{ !opts.multiple || !selectedFlg }">
    { label }
  </div>
  <div class="menu transition { transitionStatus }" tabindex="-1">
    <virtual each="{item in opts.items}">
      <div class="item { default: item.default }" if="{ isVisible(item) }" value="{ item.value }" default="{ item.default }" onclick="{ itemClick }"
        onmousedown="{ mousedown }" onmouseup="{ mouseup }">
        <i class="{ item.icon } icon" if="{ item.icon }"></i>
        <img class="ui avatar image" src="{ item.image }" if="{ item.image }" />
        <span class="description" if="{ item.description }">{ item.description }</span>
        <span class="text">{ item.label }</span>
      </div>
      <div class="header" if="{ item.header && !filtered}">
        <i class="{ item.icon } icon" if="{ item.icon }"></i>
        { item.label }
      </div>
      <div class="divider" if="{ item.divider && !filtered}"></div>
    </virtual>
    <div class="message" if="{ filtered && filteredItems.length == 0 }">No results found.</div>
  </div>

  <style>
     :scope.ui.dropdown .menu>.item.default {
      color: rgba(0, 0, 0, 0.4)
    }
  </style>

  <script>
    this.visibleFlg = false
    this.selectedFlg = false
    this.filtered = false
    this.value = ''
    this.label = ''

    this.on('mount', () => {
      if (opts.items && opts.items.length > 0) {
        this.label = opts.items[0].label
        this.value = opts.items[0].value
        this.default = opts.items[0].default
      }
      this.update()
      this.parentUpdate()
    })

    this.on('update', () => {
      if (opts.multiple) {
        opts.items.forEach(item => item.selected = false)
        opts.items.filter(item => this.value && this.value.indexOf(item.value) >= 0).forEach(item => item.selected = true)
        this.selectMultiTarget(true)
      } else {
        const selected = opts.items.filter(item => item.value === this.value)
        if (selected && selected.length > 0) {
          const target = selected[0]
          if (this.label !== target.label) {
            this.selectTarget(target, true)
          }
        } else if (opts.items && opts.items.length > 0) {
          if (this.value != opts.items[0].value) {
            this.value = opts.items[0].value
          }
          if (this.label != opts.items[0].label) {
            this.label = opts.items[0].label
            this.default = opts.items[0].default
          }
        }
      }
    })

    // ===================================================================================
    //                                                                               Event
    //                                                                               =====
    this.toggle = () => {
      if (!this.focused()) {
        this.visibleFlg = !this.visibleFlg
        if (this.visibleFlg) {
          this.open()
        } else {
          this.close()
        }
      }
    }

    this.mousedown = () => {
      this.itemActivated = true
    }

    this.mouseup = () => {
      this.itemActivated = false
    }

    this.blur = isSearchField => {
      if (!isSearchField && opts.search) {
        return
      }
      if (!this.itemActivated) {
        this.close()
      }
    }

    this.itemClick = event => {
      event.stopPropagation()
      if (opts.multiple) {
        if (!event.item.item.default) {
          event.item.item.selected = true
        }
        this.selectMultiTarget()
        return
      }
      this.selectTarget(event.item.item)
      this.close()
    }

    // -----------------------------------------------------
    //                                         search option
    //                                         -------------
    this.keydown = () => {
      this.filtered = true
      this.update()
    }

    this.keyup = event => {
      const value = event.target.value.toLowerCase()
      this.filtered = value.length > 0
      this.search(value)
    }

    // -----------------------------------------------------
    //                                       multiple option
    //                                       ---------------
    this.unselect = event => {
      event.stopPropagation()
      event.item.item.selected = false
      this.value = opts.items.filter(item => item.selected).map(item => item.value)
      this.selectedFlg = opts.items.some(item => item.selected)
      this.parentUpdate()
    }

    // ===================================================================================
    //                                                                               Logic
    //                                                                               =====
    this.open = () => {
      this.visibleFlg = true
      this.search('')
      this.transitionStatus = 'visible animating in slide down'
      setTimeout(() => {
        this.transitionStatus = 'visible'
        this.update()
      }, 300)

      if (opts.search) {
        this.refs.condition.focus()
      }
      this.update()
      this.trigger('open')
    }

    this.close = () => {
      this.visibleFlg = false
      this.transitionStatus = 'visible animating out slide down'
      setTimeout(() => {
        this.transitionStatus = 'hidden'
        this.update()
      }, 300)

      if (opts.search) {
        this.refs.condition.blur()
        if (this.filtered && this.filteredItems.length > 0) {
          this.selectTarget(this.filteredItems[0])
        } else {
          this.refs.condition.value = ''
          this.filtered = false
        }
      }
      this.update()
      this.trigger('close')
    }

    this.selectTarget = (target, updating) => {
      this.value = target.value
      this.label = target.label
      this.default = target.default
      if (opts.search) {
        this.refs.condition.value = ''
        this.filtered = false
      }
      if (!updating) {
        this.update()
      }
      this.parentUpdate()
      if (opts.action) {
        opts.action()
      }
      this.trigger('select', target)
    }

    this.selectMultiTarget = (updating) => {
      this.value = opts.items.filter(item => item.selected).map(item => item.value)
      this.selectedFlg = opts.items.some(item => item.selected)
      if (!updating) {
        this.update()
        this.parentUpdate()
      }
      this.trigger('select', opts.items.filter(item => item.selected))
    }

    this.search = target => {
      opts.items.forEach(item => {
        item.searched = item.label && item.label.toLowerCase().indexOf(target) >= 0
      })
      this.filteredItems = opts.items.filter(item => {
        return item.searched
      })
      this.update()
      this.trigger('search')
    }

    this.parentUpdate = () => {
      if (this.parent) {
        this.parent.update()
      }
    }

    this.focused = () => {
      return document.activeElement === this.root
    }

    // ===================================================================================
    //                                                                              Helper
    //                                                                              ======
    this.isVisible = item => {
      if (opts.multiple && (item.default || item.selected)) {
        return false
      }
      return item.searched && !item.header && !item.divider
    }

    this.getTabindex = () => {
      if (opts.tabindex) {
        return opts.tabindex
      }
      return 0
    }
  </script>
</su-dropdown>