Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFDE35CB95
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089460; cv=none; b=H9/MPXq+jXMnzlEoem2iTFn4Rr1QHJMPyB6HkmB8qbTJs98f3Zn4cEG3ZfRshmYF3e3Kbv/uJ/V39z+QHWyVRkQfTDmz4kC/t8tKCIcRvzsXccKWFKR8ecMwFMzYMNTjeMHHhk9uKp1TuIbmDIl0whFN9Xtx6U6gpcmYOiM/DzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089460; c=relaxed/simple;
	bh=fIUVtYXVOAMLcJt7iE13Nf5b96Z8iuSTaF5sFIzYshc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PoZx4fVfHRV592+r0Ev9pJaur3WeLyAuqQseaMGFgYgxcKd/XdY9jPWYqgvNXryRg23Bu4kH5AXbsWMgL1LiLvaCnzdsr9Veq6RToiBLigdNHsqY+zA0iq/HHM4tluICPVpMTLkjfmTRTXgUYuppaArs9cRU806AB70q5/O2yD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZCmVEhx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZCmVEhx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87D11F000C4;
	Thu, 15 Oct 2026 18:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792089458;
	bh=ySimGnBrSFeR0zsmyiYaiL4tO1s6sYI/Q/9WbHncIDs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZZCmVEhxIuLGxEKlUPXC/KG4ollpfZaWxavjG9guIur13cBs9uzsl0VO6QQQS6k5a
	 OdasI0d72WgD8b+sjEYqCzTkStDv7mW4nvmUEUlFazqJfPtW0zoH4lLl3xKPGVcOZQ
	 1Mw55T2G3Umvw6cqp1FcGkn030CwUj2Lb5Q0GPXaY+tRYYEAtfnKrQgRTnP4ZJ/bok
	 GVsKHqF6yFZZRoPXHIyKR102f17ACms/YHhDYZIfRr4SP6JBx5oeQcTg6Tmly89wVi
	 rDIk8wK5ysUC0haObXAL/Kt1qObt+n6FaH6NbWXLAHipVLpv5TRLRKdSYx+3W95sYE
	 k0nJgRv265C3w==
Message-ID: <sashiko-outbox-173311@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/17] mm/mglru: make generation page counters atomic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20261016-mglru-fg-v4-2-2106750c0bfa@tencent.com>
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-2-2106750c0bfa@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:37:37 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: mglru: lost LRU page counter updates in __lru_gen_reparent_mem=
cg()
--

commit 82d0af39bfdf4a479c7e716d6991b3cf9cc6e2b4
Author: Kairui Song <kasong@tencent.com>

mm/mglru: make generation page counters atomic

This commit converts the multi-gen LRU generation page counters to atomic
longs. This allows the counters to be updated without holding the LRU lock,
relying on eventual consistency.

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index daa7e37c2236a..cab3ba14d20c2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c

[ ... ]

> @@ -4764,7 +4761,7 @@ static void __lru_gen_reparent_memcg(struct lruvec =
*child_lruvec, struct lruvec
> =20
>  	for (i =3D 0; i < get_nr_gens(child_lruvec, type); i++) {
>  		int gen =3D lru_gen_from_seq(child_lrugen->max_seq - i);
> -		long nr_pages =3D child_lrugen->nr_pages[gen][type][zone];
> +		long nr_pages =3D atomic_long_read(&child_lrugen->nr_pages[gen][type][=
zone]);
>  		int child_lru_active =3D lru_gen_is_active(child_lruvec, gen) ? LRU_AC=
TIVE : 0;
>  		int parent_lru_active =3D lru_gen_is_active(parent_lruvec, gen) ? LRU_=
ACTIVE : 0;
> =20
> @@ -4772,9 +4769,8 @@ static void __lru_gen_reparent_memcg(struct lruvec =
*child_lruvec, struct lruvec
>  		list_splice_tail_init(&child_lrugen->folios[gen][type][zone],
>  				      &parent_lrugen->folios[gen][type][zone]);
> =20
> -		WRITE_ONCE(child_lrugen->nr_pages[gen][type][zone], 0);
> -		WRITE_ONCE(parent_lrugen->nr_pages[gen][type][zone],
> -			   parent_lrugen->nr_pages[gen][type][zone] + nr_pages);
> +		atomic_long_set(&child_lrugen->nr_pages[gen][type][zone], 0);
> +		atomic_long_add(nr_pages, &parent_lrugen->nr_pages[gen][type][zone]);
[Severity: High]
Does the non-atomic extraction and clearing of the child's counter create
a read-modify-write window that wipes out lockless updates from
folio_inc_lru_refs()?

Because __lru_gen_reparent_memcg() reads the child's counter, executes a
list_splice, and then unconditionally overwrites the counter via
atomic_long_set(0), any concurrent lockless counter additions or
subtractions that land during this window appear to be completely wiped
out and never propagated to the parent memcg.

Could we replace the read and zeroing with atomic_long_xchg(&..., 0) after
the list splice? This would atomically extract and clear the counter,
ensuring updates during the window are passed to the parent.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-mglru-fg-v=
4-0-2106750c0bfa@tencent.com?part=3D2
