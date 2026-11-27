Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795819329;
	b=rSEmlCHpaXESgAqYcpGm9qDogt2uph+aNfvPHQ9kJCH0hbmqGA91VIPLe89z4liEbqYC
	 ihID5A/5V6vzAOVRMsh83pAKQnxBxxMNH4NdEQP17H6Z/GTE9Roy1qyUqdKCPniejG2rj
	 abvC1KtYBSWN4BVxFsYVYF1+iu8yuMlbGDsP/cdDwEtF3niD71IhGYTOYg+LLksLRWtbj
	 hd2bR7/Qsgn5UdYhtYWqiLxRLUein64mPkRl4IY/ZkYYO9xzL+fReVIi3sOduR6awWQHy
	 ArczSRoMNnjBjRKrz8wNsOVtvxrXYQKhNz27gMeto+62cckdijDM6zSpNyFITUBrhtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795819329;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=H2QamErgkgfwsP7LyCOuQ/swCiUPTeBoO2jKl7hZ6Nc=;
	b=LswJ6gtq8yotKGvUVKT9ZLWQjVvVkq3ONDgZB8AuTVBZvOxSCwRgytgfI92b0YOEM9sC
	 Eoe7seGIWMBxWx5loyILiGfdXJX6cXSljrvEnnz6K0LwJidVBhyd9FE5EV7PcBBDiB/nw
	 PHA0xtZjQFeIIdQ6O76lJKlJsSLuH2uALhVM5bG5dX+wzaEmtjDDRVE1oVo2g8+igtcsX
	 VxkMosqSgmAqY9xkIXdjLtqksNu9YuAvRtqWK3HMV3cCEmsLAhctE2lpR79b3PEC3Ypl3
	 cnd/TrQSe+CylqBQJxRRpIP4EMm51owww89DE2+CfDC/JQaC12TcRRw6UUE2fCZcR6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PC2epmmq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF9F606A31C
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 22:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PC2epmmq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDD01F00893;
	Fri, 27 Nov 2026 22:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795819329;
	bh=H2QamErgkgfwsP7LyCOuQ/swCiUPTeBoO2jKl7hZ6Nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PC2epmmqXYvUeMAnz+7Dufe7cROLyPEMfG5YbdXft7Ef3xnyGr6IrJGwtWsaT+mMr
	 uN1XCR79hXc0FZaI5NOBPrm38JtFwNx3/MVAZZTenvV3xVAGXcuIOk7D1rIHmL8M0i
	 EhSV3Vsz1ob7IPJW7qX60LqEqs/WEaHdfEiYmhK9UDjrmMXtLnSJ8zY7SZR+ZcFyxk
	 icWeSIvrF4IJZU7rx16nbo0e47Q33JDIFwxkrgIslI8L66tbBRvpcFSSygcYjsI0jC
	 ppZ0/EaWVaZoBNADYTuZ+5QdT3flkQE8QC6ce8GsAabSkJ7GvUCzJ7rkj/3S19aoMP
	 VzD+TUMsOcpSg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v3 3/7] mm/damon/vaddr: implement sz_filter_passed for migrate_{hot,cold} action
Date: Fri, 27 Nov 2026 14:41:51 -0800
Message-ID: <20261127224152.106358-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-238334@kernel.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 27 Nov 2026 22:35:53 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] mm/damon/vaddr: NULL folio dereference in
>   damos_va_migrate_pmd_entry()
> --
> 
> commit 446fe1a8fb2f01d2025ab8ed2dd156f643ec9800
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/vaddr: implement sz_filter_passed for migrate_{hot,cold} action
> 
> This commit threads sz_filter_passed through damos_va_migrate() and
> damos_va_migrate_pmd_entry() to accumulate the size of folios that pass
> DAMOS ops filters during migrate_{hot,cold} actions.
> 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index c8f93a19c840e..721a23856ee16 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> [ ... ]
> > @@ -895,6 +898,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
> >  		s->last_applied = folio;
> >  		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
> >  			continue;
> > +		*sz_filter_passed += folio_size(folio);
> >  		damos_va_migrate_dests_add(folio, walk->vma, addr, s,
> >  				migration_lists);
> >  	}
> 
> [Severity: High]
> Can the PTE loop in damos_va_migrate_pmd_entry() dereference a NULL folio
> when vm_normal_folio() returns NULL (for example, on the shared zero page
> or a special mapping)?
> 
> Earlier in this series, commit "mm/damon/vaddr: use damos->last_applied
> for migrate action" placed damos_va_invalid_folio() (which checks !folio)
> after folio_page_idx() and folio_nr_pages():
> 
> mm/damon/vaddr.c:damos_va_migrate_pmd_entry() {
> 	...
> 		folio = vm_normal_folio(walk->vma, addr, ptent);
> 		page_idx = folio_page_idx(folio, pte_page(ptent));
> 		nr = folio_nr_pages(folio) - page_idx;
> 		if (damos_va_invalid_folio(folio, s))
> 			continue;
> 	...
> }
> 
> When folio is NULL, folio_nr_pages() dereferences NULL while holding the
> page table lock.  Checking !folio (or calling damos_va_invalid_folio() or
> checking !folio before computing page_idx and nr, as in
> damos_va_stat_pmd_entry()) avoids the NULL pointer dereference.

I will fix it in the next spin.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261127222719.105510-1-sj@kernel.org?part=3
> 


Thanks,
SJ
