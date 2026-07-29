Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4C1213E9C
	for <damon@lists.linux.dev>; Wed, 29 Jul 2026 00:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785286565; cv=none; b=Tqm7mUPlWX4VbXoYOUh7t02FnFmHNBbNLR1v2IAB/F6Mlnve+WcFzDLnnY5nZUnfUBLjH6nRSNNrDtHZyZrpq2DTjMks0HqFAhQ8a2mhZQznv87/K9dty88saD/liDJ4RARA4Itrdi5H5C6SZeGSRB/sIBAXJZUOKAVRqM10yCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785286565; c=relaxed/simple;
	bh=eJDlHqAsGpkRuMQCO4Mlm5NCbRz1KMFch0569SbLWno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3W/j+XM8OdvMTy8xx3oMpVNps0TTmMmU84kfLBSNF694wK5yqn55wKQUHUxHKsYgf0DBvnKXkuXl7H52ywLRFqBNvGqPOZxwLKnks5Tb/dsaU/urIL3t0UIxy3jPUy92cyvV6fhu7H4ujpePoVRa6XJ5SJ/XGsm8AhdOm+uUwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MClBYYA8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MClBYYA8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287981F000E9;
	Wed, 29 Jul 2026 00:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785286564;
	bh=8ngwVY06JQe79vqWTP5x+lulJKRYP5dy8+nQUGRJqCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MClBYYA8+0r3/XT1BOBSwEkieTbTw5yHGyz0nsJ6D06OJGZ7RT7IwvYEtPTcQeBWO
	 FFBRJg2Zh9MpoaVnFKV0uTsdiwjH0/mR3AJ4CSHPQGRkSXxDpie8oetS4YcRDmEFi/
	 Oq/WOfwXJqMdEL28G9Y22FlEp3WLgUx9X6e2JOr2Kv5EJxLe2OE1uJtizij2/CqWD5
	 YKmS9M8TCpc/XMLvfsomUNJ8CMTU04+ErB93GhQlN669vs2lQBAlLOyJwbhhe2EplB
	 jHuodfzKWSVr+Wdb80UPLyGx8zhGXk3+xgHo09dx229y5ywEELde+KYIHYTxKseC+v
	 0oe0L5N+2dlXQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Gregory Price" <gourry@gourry.net>,
	damon@lists.linux.dev
Subject: Re: [PATCH 1/4] mm/damon: defensively skip zone device folios in damon_get_folio()
Date: Tue, 28 Jul 2026 17:55:55 -0700
Message-ID: <20260729005557.98222-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728195705.53F851F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 28 Jul 2026 19:57:04 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [Medium] The explicit `folio_is_zone_device()` check added by the patch is dead code and fails to achieve its stated intent.
> 
> Pre-existing issues:
> - [High] Early return in damon_ptep_mkold and damon_pmdp_mkold skips MMU notifier aging for device-exclusive swap PTEs.
> - [High] The scheme's `last_applied` pointer caches a freed folio pointer, leading to a dangling pointer comparison.
> --
> 
> --- Patch [1]: [PATCH 1/4] mm/damon: defensively skip zone device folios in damon_get_folio() ---
> commit 8181b2e77c1b49bcb808528f343f72fdbf9d168c
> Author: Gregory Price <gourry@gourry.net>
> 
> mm/damon: defensively skip zone device folios in damon_get_folio()
> 
> All DAMON physical- and virtual-address operations obtain their folios
> through damon_get_folio(). That helper already excludes ZONE_DEVICE
> memory implicitly via pfn_to_online_page() and folio_test_lru(), but
> this is inconsistent with other callers in mm/ which test explicitly.
> 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index 0981a5e3af172..0db1383de5d01 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -32,7 +32,8 @@ struct folio *damon_get_folio(unsigned long pfn)
> >  	folio = page_folio(page);
> >  	if (!folio_try_get(folio))
> >  		return NULL;
> > -	if (unlikely(page_folio(page) != folio) || !folio_test_lru(folio)) {
> > +	if (unlikely(page_folio(page) != folio) || !folio_test_lru(folio) ||
> > +	    folio_is_zone_device(folio)) {
> 
> [Severity: Medium]
> Since ZONE_DEVICE folios do not have the LRU flag set, won't the
> !folio_test_lru(folio) check always evaluate to true for them?
> 
> Additionally, earlier in damon_get_folio(), pfn_to_online_page(pfn) is
> called, which strictly returns NULL for ZONE_DEVICE memory. Doesn't this
> mean ZONE_DEVICE memory will never reach this new folio_is_zone_device()
> check at all, making it dead code?

This is what Gregory already mentioned about in the commit message.  I added a
question about this, too, though.  Let's keep discussing in the main thread.

> 
> >  		folio_put(folio);
> >  		folio = NULL;
> >  	}
> 
> [Severity: High]
> This is a pre-existing issue, but I have a question about how
> damon_get_folio() returning NULL interacts with device-exclusive memory.
> 
> When DAMON encounters a device-exclusive PFN swap PTE in damon_ptep_mkold()
> or damon_pmdp_mkold(), damon_get_folio() returns NULL because
> pfn_to_online_page() rejects it. Both of these callers then immediately
> early-return on !folio:
> 
> mm/damon/ops-common.c:damon_ptep_mkold() {
>     ...
>     folio = damon_get_folio(pfn);
>     if (!folio)
>         return;
>     ...
> }
> 
> Doesn't this early return silently bypass the mmu_notifier_clear_young()
> call completely, breaking DAMON's ability to monitor device accesses
> (which relies on the MMU notifier for device-exclusive PTEs)?

This is an intended behavior.

> 
> [Severity: High]
> This isn't a bug introduced by this patch, but looking at how DAMOS
> physical address apply functions interact with folios, I noticed
> something about the last_applied pointer:
> 
> In mm/damon/paddr.c:damon_pa_pageout(), a reference is dropped:
> 
> mm/damon/paddr.c:damon_pa_pageout() {
>     ...
>     folio_put(folio);
>     ...
>     s->last_applied = folio;
> }
> 
> Since folio_put() drops the reference, could this store a dangling
> pointer across DAMON region processing boundaries?
> 
> If that physical memory is subsequently reallocated for a new folio,
> it will reside at the exact same address. When this pointer is later
> checked in damon_pa_invalid_damos_folio():
> 
> mm/damon/paddr.c:damon_pa_invalid_damos_folio() {
>     ...
>     if (folio = s->last_applied) {
>         folio_put(folio);
>         return true;
>     }
>     ...
> }
> 
> Could this falsely match the dangling pointer and erroneously skip a
> valid, newly allocated folio from DAMOS actions?

I agree it is not super ideal, but missing one access event from DAMON's
best-effort monitoring is no problem.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260728194714.3713735-1-gourry@gourry.net?part=1
> 


Thanks,
SJ
