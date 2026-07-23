Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8196530FC03
	for <damon@lists.linux.dev>; Thu, 23 Jul 2026 06:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784787869; cv=none; b=K/2TwqsCDE+qQ90Yg369k2owYbRM3TmNRihjuYWJ7Ar+1MPJH8A8JQlB2T7O7HrKhCmdvvWQm/GgH+m0Hx/0iHBx+hlqnEsOL3ZnKHRE0nkNjpMsWqd0azyHoLgh44ABsQHZE+2mnVo3InbGAE7LuPqVsaXj8ilzIBQWLt3HCCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784787869; c=relaxed/simple;
	bh=JjbYz/w54sHidcVnr1YQmlJdJNhExjsGmq4lequgodg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eqVJADjSnbiQSKqu3UqGAdSSV/QTerEv3Ce6iXfDFjzn6l3aFVrK4g4CifyTo6DXSvYOsCQRRGA1foFPVFeXSANHQULbcZB0zBgSH/OWfOWJ3k4PxeRTOiDHVqN0IHzVmbCSQ5HtOYS6er2RRs7eskf6Q+amt2e0mdlTaVMLAfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abZNzHjG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abZNzHjG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D719C1F000E9;
	Thu, 23 Jul 2026 06:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784787868;
	bh=sTc2BXPZfJP5oD0nm3TcKVyvJEt0T7+Zu2NrROGAhtI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=abZNzHjG0l9n1zsAgZj6w4aE2aKp6qZpXFGgyDCjJM57EybIVtHRQ5Gy1Li//N1e8
	 my2NBAwzdndl+e3019wK4OcMhIBUIfkN+OPJS+BIR7QO64SLLhHyYDYMaxNi8wo3NO
	 Ct75H4rnPrS6D3MK74Ktss9pJvLTE+n2EJBtQSj46xIgcBIFWY8U3UAOsj/LFNbt4Y
	 f/2HtmjXOBg52He7DsAZ2PS2Y+YAmVnWAKdLSaH5UJg3D78iD2Qr5i3zw2jjZF+VBZ
	 ctmKx/ZDoe8to2IUgQEEXzHky3za/RDVkB+6LQdTU2qwKpbXuDsFfLpTnIZsMG0qjv
	 CFn+k8c7PaiOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/ops-common: putback folios on invalid migrate
 nid
Reply-To: sashiko-reviews@lists.linux.dev
To: dayou5941@163.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260723061246.1878435-1-dayou5941@163.com>
References: <20260723061246.1878435-1-dayou5941@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 06:24:27 +0000
Message-Id: <20260723062427.D719C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect Loop Advancement / Bounds Oversight (PFN advancement bug)
- [High] Missing yield in unbounded list putback loop
--

--- Patch [1]: [PATCH] mm/damon/ops-common: putback folios on invalid migra=
te nid ---
commit b4aa488aeb8640931363ab9a919f2ae6536d57ba
Author: liyouhong <liyouhong@kylinos.cn>
mm/damon/ops-common: putback folios on invalid migrate nid

This commit extracts the LRU putback logic into a helper function and
uses it to return folios to the LRU when damon_migrate_pages() is called
with an invalid target_nid. This prevents folios from remaining isolated
from the LRU permanently.

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index e59f77eca83b2..1286fe54b0d9d 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -330,12 +330,22 @@ static unsigned int __damon_migrate_folio_list(
>  	return nr_succeeded;
>  }
> =20
> +static void damon_putback_folio_list(struct list_head *folio_list)
> +{
> +	struct folio *folio;
> +
> +	while (!list_empty(folio_list)) {
> +		folio =3D lru_to_folio(folio_list);
> +		list_del(&folio->lru);
> +		folio_putback_lru(folio);
> +	}
> +}

[Severity: High]
This is a pre-existing issue, but can this tight loop cause CPU soft lockup=
s?

If a DAMON scheme isolates a massive region that fails to migrate, or is
given an invalid migration NID, the isolated folio list could scale to
millions of folios. Because this loop takes the LRU lock for each folio
without a yield point, could it monopolize the CPU and cause severe latency
spikes? Should there be a cond_resched() in this loop?

[ ... ]

[Severity: High]
This is a pre-existing issue, but do these unconditionally sized advancemen=
ts
elsewhere in the DAMON codebase risk skipping uninspected memory regions?

In mm/damon/paddr.c:damon_pa_pageout():

    addr +=3D folio_size(folio);

And similarly in mm/damon/vaddr.c:damos_va_migrate_pmd_entry() and
damos_va_stat_pmd_entry():

    nr =3D folio_nr_pages(folio);

When a DAMON region starts in the middle of a large folio (a tail page), or
a PTE walk encounters a partially mapped large folio, advancing the pointer
by the total folio size or total number of pages overshoots the bounds. Does
this silently skip adjacent, unrelated PTEs and physical addresses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723061246.1878=
435-1-dayou5941@163.com?part=3D1
