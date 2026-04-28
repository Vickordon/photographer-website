// Phoenix LiveView JavaScript
import "phoenix_html"
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"

let csrfToken = document.querySelector("meta[name='csrf-token']")?.getAttribute("content")

let Hooks = {}

// Lightbox for gallery
Hooks.Lightbox = {
  mounted() {
    this.el.addEventListener('click', (e) => {
      if (e.target.tagName === 'IMG') {
        this.openLightbox(e.target.src, e.target.alt)
      }
    })
  },
  openLightbox(src, alt) {
    const lightbox = document.createElement('div')
    lightbox.className = 'lightbox'
    lightbox.innerHTML = `<div class="lightbox-content"><span class="close-lightbox">&times;</span><img src="${src}" alt="${alt}"></div>`
    document.body.appendChild(lightbox)
    lightbox.addEventListener('click', (e) => {
      if (e.target === lightbox || e.target.className === 'close-lightbox') {
        lightbox.remove()
      }
    })
  }
}

// Form validation
document.querySelectorAll('form').forEach(form => {
  form.addEventListener('submit', (e) => {
    const required = form.querySelectorAll('[required]')
    let valid = true
    required.forEach(input => {
      if (!input.value.trim()) {
        valid = false
        input.style.borderColor = 'red'
      } else {
        input.style.borderColor = '#ddd'
      }
    })
    if (!valid) {
      e.preventDefault()
      alert('Будь ласка, заповніть всі обов'язкові поля')
    }
  })
})

// Mobile menu
const createMobileMenu = () => {
  const navbar = document.querySelector('.navbar')
  if (!navbar) return
  const toggle = document.createElement('button')
  toggle.className = 'mobile-menu-toggle'
  toggle.innerHTML = '☰'
  toggle.style.display = 'none'
  navbar.appendChild(toggle)
  toggle.addEventListener('click', () => {
    document.querySelector('.nav-menu')?.classList.toggle('active')
  })
  if (window.innerWidth <= 768) toggle.style.display = 'block'
  window.addEventListener('resize', () => {
    toggle.style.display = window.innerWidth <= 768 ? 'block' : 'none'
  })
}

createMobileMenu()

let liveSocket = new LiveSocket("/live", Socket, { hooks: Hooks, params: {_csrf_token: csrfToken} })
liveSocket.connect()
window.liveSocket = liveSocket

console.log('📸 Сайт фотографа завантажено!')
