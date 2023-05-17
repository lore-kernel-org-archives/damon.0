Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2683953A0
	for <damon@lists.linux.dev>; Wed, 17 May 2023 06:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Uiam3MV1AIHx2JXhBYlardHpiKPPLXRwMMxlhPQWj/8=; b=lCMxRrDHuojZ0UPd/0UgioRB86
	2fhjUmfD78FcEyAu/uz3qh+YysEvBlNn3xRL8Tsf6EbZ3JjOPy6WMGzZ6RC48vvcs2bufdXIbItkI
	QKDCuWVkywiVvHZ+0vIGTEaNwHLPKEoKjT+qbxKoNaOVlewfVtaLHA028AScpKU449bGeo8DpmSq4
	cQtDOvl7rY08GfxHMJlOMTuitFwEx8Tde4zleVg3eoI6f+RJX2KGDrRE5MndVj+WaA6OXP010uY55
	3MqslUAkzi3wJzPq957lHtT+WX0rw+ZkskTevkhRhbJUEDcY6KS57uu+alDGFxf0qPsuqmi3hmEFe
	v57ygwTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pzAW7-008PAq-1I;
	Wed, 17 May 2023 06:20:07 +0000
Date: Tue, 16 May 2023 23:20:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	SeongJae Park <sj@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, damon@lists.linux.dev,
	Christoph Hellwig <hch@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [RESEND PATCH v1 1/5] mm: vmalloc must set pte via arch code
Message-ID: <ZGRyF1nL20wUK2et@infradead.org>
References: <20230511132113.80196-1-ryan.roberts@arm.com>
 <20230511132113.80196-2-ryan.roberts@arm.com>
 <db1b8b8f-c3ac-4dbb-8b15-125c0929856a@lucifer.local>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db1b8b8f-c3ac-4dbb-8b15-125c0929856a@lucifer.local>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, May 13, 2023 at 02:14:18PM +0100, Lorenzo Stoakes wrote:
> > Fixes: 3e9a9e256b1e ("mm: add a vmap_pfn function")
> 
> Not sure if this is really 'fixing' anything, I mean ostensibly, but not
> sure if the tag is relevant here, that is more so for a bug being
> introduced, and unless an issue has arisen not sure if it's
> appropriate. But this might be a nit, again!

vmap_pfn was factored out of i915-specific code, which probably never
ran on anything but x86 at that time.  Now that intel builds plug in
GPUs is probably could.  But independent of that core mm code should use
the proper APIs.

