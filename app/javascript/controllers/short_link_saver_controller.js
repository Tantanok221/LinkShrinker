import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    save_local_storage(event) {
        if (event.detail.success) {
            setTimeout(() => {
            const container = document.querySelector('#shrink-link-result');
            console.log(container)
            if (container) {
                const shortUrl = container.dataset.shortUrl;
                const targetUrl = container.dataset.targetUrl;

                const links = JSON.parse(localStorage.getItem('shortenedLinks') || '[]');

                links.push({
                    shortUrl: shortUrl,
                    targetUrl: targetUrl,
                    createdAt: new Date().toISOString()
                });
                localStorage.setItem('shortenedLinks', JSON.stringify(links));
            }},1000)
        }
    }
}