Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B36361DDC
	for <damon@lists.linux.dev>; Sat, 16 May 2026 23:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778975745; cv=none; b=CgURrFqiCRmoYF0tLN5Tu62WxmQtsWBCU5e2qYap7kUweNd1nLd80r7/kC1kTxUYaJ1DLmAj34qKdbKOIxnUSeNe0xY6mcsU2eQlnS6f7D6dHp8IwbBv/jk5sIqyI6IUPu1JJAL2M5zdxX5lfKhnpOxnILJrkbvcgNv5RwrD2P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778975745; c=relaxed/simple;
	bh=w0EZNXOxshgWMf6EP3KNkHG1SkhDoynRKamAfFwwpaY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qBQveAl10CNs2Q6vH/8YXixgri0VnKcNCCtOkxnUCUGCOo+ddo8WmuQrvz7UGxrg9yqGxcrECMKLa3XDtDoAgk+fYZ/5HhB/x4pecpB9Ez8DSiV4SAZXPamFXEXvx5IKXjGNrL1TN5kYVl4pfFLkYmgvJBPqR9bMtyAdYJk4CWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHuHPOV4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHuHPOV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B71C2BCB7;
	Sat, 16 May 2026 23:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778975745;
	bh=w0EZNXOxshgWMf6EP3KNkHG1SkhDoynRKamAfFwwpaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=OHuHPOV4xmgPyR2GzJT12WBu/muoyDDkq1TZWQmdNX9vEvBV+Aml9J70CQiQRJ2QM
	 rWhpSDfQp+moATvfln/0axDVB+3dB0D5sUqmVbxDzvZWCQxVhUdRALxUYY6y9VPYkE
	 4Ps2PPr0+EyovSvw4vexoysstOJD+N/9SrIIDIQPbeItVbobnWdkxmLi2EirIqBLXf
	 knD7xNez3rTBOsxdZpNfBEyvnZj15AjpH30ttHMlRGvV2vgLuuZ/dQwhdCKcjzOQUv
	 28/r5dhcE6uY/BaE1LSrYT7XXzzK2v5h5c2MtPtasO53Kv1GKJ4yUCU8KdoLlpQ5bc
	 WXvrMZ7pHZbVQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/5] mm/damon/paddr: add time budget to migration
 page walk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260516210357.2247-6-ravis.opensrc@gmail.com>
References: <20260516210357.2247-6-ravis.opensrc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 23:55:44 +0000
Message-Id: <20260516235545.18B71C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The amortized time budget check can be permanently bypassed due to=
 variable PFN strides and loop continues.
- [High] Early termination causes permanent starvation for the tail end of =
large DAMON regions.
- [High] The time budget targets the wrong phase, failing to cap the actual=
 latency spike of the migration.
- [High] PFN advancement after folio conversion permanently misaligns the s=
can.
--

commit 87860cbf6b4be5f161140aa9a1f9b7d0461955ba
Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

mm/damon/paddr: add time budget to migration page walk

This patch adds a 100ms wall-clock time budget to damon_pa_migrate() to
prevent long migration walks from causing high scheduling latencies. The
time check is amortized by checking ktime_get() every 4096 pages.

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index e844c990987b9..a2565287bc10f 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
[ ... ]
> @@ -283,6 +293,11 @@ static unsigned long damon_pa_migrate(struct damon_r=
egion *r,
>  			}
>  		}
> =20
> +		/* Time budget: keep kdamond responsive on long migration walks. */
> +		if (!(pfn & DAMON_PA_MIGRATE_TIME_CHECK_MASK) &&
> +		    ktime_after(ktime_get(), deadline))
> +			break;

Can this time check be permanently bypassed?

If pfn advances by variable strides, such as when addr +=3D folio_size(foli=
o)
adds a multi-page stride that jumps over the 4096-page boundary, the exact
match !(pfn & DAMON_PA_MIGRATE_TIME_CHECK_MASK) is missed, skipping the
check for the entire next 4096-page cycle.

Additionally, if pfn does land exactly on a multiple of 4096, but the
pageblock is skipped via the continue statement just above this block:

        if (!page) {
            addr +=3D pageblock_nr_pages * PAGE_SIZE;
            continue;
        }

the loop advances and leaps over the time check.

If the loop terminates early here, is there a mechanism to save the PFN
where the scan aborted?

Since the DAMON core is unaware of this internal early return, the next time
the scheme applies to this region, it appears it will restart the walk from
the very beginning of the region.

Could this result in a permanent livelock for large regions, where memory
beyond the 100ms scan horizon is never reached or migrated?

>  		folio =3D damon_get_folio(pfn);
>  		if (damon_pa_invalid_damos_folio(folio, s)) {
[ ... ]
>  		if (!folio_isolate_lru(folio))
>  			goto put_folio;
>  		list_add(&folio->lru, &folio_list);
>  put_folio:
>  		addr +=3D folio_size(folio);

This wasn't introduced by this patch, but does the address advancement
correctly handle tail pages?

Since the region start addr might not be folio-aligned, if it falls within
a tail page of a large folio, does adding the total folio_size(folio)
overshoot the end of the current folio and skip the head page of the next
folio?

>  		folio_put(folio);
>  	}
>  	applied =3D damon_migrate_pages(&folio_list, s->target_nid);

Does the time budget cap the actual latency spike of the migration?

The 100ms budget limits the fast folio isolation phase. The loop can isolate
gigabytes of memory within 100ms. Once the deadline is reached, all
collected folios are passed to damon_migrate_pages().

Could migrating this massive batch, which requires memory allocation and
page copying, take seconds to complete in a single blocking call and fail
to keep the migration responsive?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260516210357.2247=
-1-ravis.opensrc@gmail.com?part=3D5
