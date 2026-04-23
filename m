Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387143C9EF3;
	Thu, 23 Apr 2026 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776914565; cv=none; b=mwJoUpQj4pYSC1h6rN5LbwXzgLLg83PI+bLirmpr+3ojmZt48maVdN3SOPTN1TCDzuJtLWVV02De3CnubbfZUTJFWuhIuHIJh9dJk+3MxNRg1X78KRB5rRQjr2vLYMmfCatHihKlSXYa0r65DPQgj6scyLJxsx3NxNcT4pZ0w7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776914565; c=relaxed/simple;
	bh=mdJX/SO1arXSe054zEYwAAoCyUcwJEguEE+GmJ1wXR8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pPXXBogYjJW0N0tQHUVyNZFqrEAOOC5UkKaisJPWC6cZ8n2WcN98kdzz+wA93heQUW9YyX2OkLWZdP2GvapSo6Ws/wirpWuorAYBTa8MDJK9S3XQAIMWCwilqTI99B71bkaMNb5x5uVW24nSavY4opkjtzcx/qoT1TOQLN73pQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaZ7VX6X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaZ7VX6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD69FC2BCB2;
	Thu, 23 Apr 2026 03:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776914564;
	bh=mdJX/SO1arXSe054zEYwAAoCyUcwJEguEE+GmJ1wXR8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eaZ7VX6XdkJoesTjD75W5qYMhDWUvU+YzhL0pYJwOjVDUY0MIlvP9v4SjQffD8C/u
	 I+GTkHOxE6KAccPQpWDrdOvQc1lXUevSmaNfUO8ueIby9cK/BAv3caFAVN/lsmxsC0
	 pheZYyQa6v7Zrkv7uqv34o3DG14n1d6S3QWhZqek42fBBtxQ8DogVdpccWOY/6s7pk
	 a0AYFNkgOL2oZub5ReNKZTZnEiFOOu7k6BWJMpfC+ZaGWuK4RQIq3uMoM9avCWvK73
	 Py3mUca7N6cUhGxx+rsy6zXgRY3ZAsSx36W7T46mV1vYOnGeWHvz9Y8Rpf8lWyHMwB
	 v5iwS+oULAEhw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 4/4] mm/damon/paddr: support perf event based
 access check
Reply-To: sashiko@lists.linux.dev
To: "Akinobu Mita" <akinobu.mita@gmail.com>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org
In-Reply-To: <20260423004211.7037-5-akinobu.mita@gmail.com>
References: <20260423004211.7037-5-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 03:22:44 +0000
Message-Id: <20260423032244.BD69FC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 6 potential issue(s):
- [High] Severe Performance Regression and Soft Lockups via O(N) Memory Ite=
ration
- [High] Address Scale Mismatch Breaking Access Reporting (`ctx->addr_unit`=
 ignored)
- [High] Infinite Loop and Kernel Hang via Integer Overflow on 32-bit
- [High] XArray Index Truncation Corrupting PAE Physical Addresses
- [Medium] Silent Failure due to Missing `PERF_SAMPLE_PHYS_ADDR` Validation
- [Low] Unused Local Variable `tidx`
--

commit 0cc4cc53289c7273fbdf7b96674ce9315f78cdfb
Author: Akinobu Mita <akinobu.mita@gmail.com>

mm/damon/paddr: support perf event based access check

This commit adds perf event based access checks for physical address space
monitoring. It implements support similar to the virtual address space
monitoring, relying on PERF_SAMPLE_PHYS_ADDR to obtain the data source
address.

> mm/damon/paddr: support perf event based access check
[ ... ]
> However, for perf events that can be specified with physical address
> spaces monitoring, the data source address corresponding to the sample
> must be obtainable as a physical address.  In other words,
> PERF_SAMPLE_DATA_SRC and PERF_SAMPLE_PHYS_ADDR must be specifiable in
> perf_event_attr.sample_type.

Is there validation in the code to enforce this requirement? If a user or
the framework fails to set the sample_phys_addr attribute, the perf
subsystem might fail to populate the physical address and default to 0.
Could this silently process invalid samples and record all accesses at
physical address 0?

[ ... ]
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 5cdcc5037cbc1..97df21281fb13 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
[ ... ]
> @@ -363,6 +363,47 @@ static int damon_pa_scheme_score(struct damon_ctx *c=
ontext,
>  	return DAMOS_MAX_SCORE;
>  }
> =20
> +#ifdef CONFIG_PERF_EVENTS
> +
> +void damon_pa_perf_check_accesses(struct damon_ctx *ctx, struct damon_pe=
rf_event *event)
> +{
> +	struct damon_perf *perf =3D event->priv;
> +	struct damon_target *t;
> +	unsigned int tidx =3D 0;

Is tidx needed here? It is incremented at the end of the loop but never
read, which might trigger an unused-but-set-variable compiler warning.

> +
> +	if (!perf)
> +		return;
> +
> +	damon_paddr_histogram_init(&perf->paddr_histogram);
> +
> +	damon_perf_populate_paddr_histogram(ctx, event);
> +
> +	damon_for_each_target(t, ctx) {
> +		struct damon_region *r;
> +
> +		damon_for_each_region(r, t) {
> +			unsigned long addr;
> +
> +			if (r->access_reported)
> +				continue;
> +
> +			for (addr =3D r->ar.start; addr < r->ar.end; addr +=3D PAGE_SIZE) {

Does this directly use the core address as a physical byte address?

DAMON scales physical addresses down using ctx->addr_unit, meaning
r->ar.start and r->ar.end hold these scaled core addresses. If
ctx->addr_unit is greater than 1 (e.g., PAGE_SIZE), r->ar.start is actually
a Page Frame Number. Incrementing a PFN by PAGE_SIZE would skip large
blocks of memory per iteration. Should the code convert core addresses to
physical addresses using damon_pa_phys_addr() first?

Could this increment overflow on 32-bit architectures? If a physical memory
region ends near ULONG_MAX, addr +=3D PAGE_SIZE might wrap around to 0. This
would keep the addr < r->ar.end condition true indefinitely, causing an
unkillable infinite loop.

Additionally, does this loop iterate over every single page in the region?
Since DAMON regions can be extremely large, iterating over millions of
pages and performing a synchronous XArray lookup for each one without
yielding via cond_resched() could heavily saturate the CPU and stall RCU
grace periods.

> +				if (damon_paddr_histogram_count(&perf->paddr_histogram,
> +									addr & PAGE_MASK)) {

Does the underlying XArray implementation safely handle 64-bit physical
addresses on 32-bit systems?

The perf subsystem records the access address as a 64-bit u64 paddr, but
the XArray API uses unsigned long for its indices. On systems using PAE to
access more than 4GB of RAM, passing a 64-bit raw byte address to the
XArray could truncate the upper 32 bits, causing physical addresses above
4GB to alias with lower addresses. Would using Page Frame Numbers as XArray
indices instead of raw byte addresses avoid this?

> +					damon_update_region_access_rate(r, true, &ctx->attrs);
> +					r->access_reported =3D true;
> +					break;
> +				}
> +			}
> +		}
> +		tidx++;
> +	}
> +
> +	damon_paddr_histogram_destroy(&perf->paddr_histogram);
> +}
> +
> +#endif /* CONFIG_PERF_EVENTS */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423004211.7037=
-1-akinobu.mita@gmail.com?part=3D4
