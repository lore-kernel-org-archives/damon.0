Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3913F58DC
	for <damon@lists.linux.dev>; Wed, 27 May 2026 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884641; cv=none; b=O9alcOGpaTofqj/WxMUDeVdX9olTG5EsvxJ7y1OTIzvDkAivoBRw8vBKzlwhQqQcGHGH4m6o1Imw9fG46+bzmlxHWxzP4ozz1nhLM2S8xZGKQ7KMBfEkgZui4S1kr6jQI7Dr54CmCXWxrFot83kE/dHzEjqOpRwqOBYlOPzCnzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884641; c=relaxed/simple;
	bh=KT8fEi2GCsYJ1JMODHWCJgCWGsx9vGqYCtxCHUxGgWk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uwISQPMYn9DkhCBodRlNVsES17Yx4jP7gBGgVAamRS2hpdMoaeYLDEwIu/EpT/TTwvpxukT1zZYGJyCRMsx7/9wgvUB2rvfNOhjw0yuPJnJ7SPy16IqmZazMahgJbmhvdVu2ANjTSu9Dy6DpPCt78IVFgbKtJDiNr/kAi0FlMz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G59fR61E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G59fR61E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD9C1F00A3C;
	Wed, 27 May 2026 12:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779884640;
	bh=VwIFy7vjhJnuV0WFyImjHes61Uk47QJrXQCOlcbs0ok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G59fR61E2jxxTTZ98uvj3UIIjKkJBnO1qgTL/4ddit2wbXE174vai713b5u6L8q+Q
	 +Efnjkaaf1jVoZnMH7Aogyb/IKnDxnsT6pHDVUjh+rLDkZzHZGBsdOKXTaL9782641
	 ZhqBUZvAR1zd3zdxAd/sjdaVbSMiG29G2iKgPn7mTbtEY2/DUXA+VZoiNj4BE1IV5D
	 C3iUlq4ZAfcEhu8FoHglY3z/CjJZ9VglVH+fLfR3pXQaAGoNB117PWYtsYGUzCJogH
	 Dg6HP4A1Lbj6pj/UmNzXy7J8a9wNknyX8m1RqoNjSlUKtbHrhSuyPJoBc5onLTK79x
	 s5zuCgs6ZAuTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/15] mm: handle ANON_VMA_LAZY during migration
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260527110147.17815-13-tao.wangtao@honor.com>
References: <20260527110147.17815-13-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 12:23:59 +0000
Message-Id: <20260527122359.ECD9C1F00A3C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Dereferencing vma->vm_mm without protection leads to a use-aft=
er-free of the mm_struct.
- [High] Discarding the pointer returned by lock_vma_under_rcu() leads to a=
 leaked per-VMA lock and unmatched unlock on the original VMA.
- [High] Migration unconditionally fails for unmapped anonymous folios beca=
use folio_trylock_get_anon_rmap() returns NULL for them.
- [High] Holding a dynamic number of anon_vma or VMA read locks concurrentl=
y during batch migration violates locking rules and overflows lockdep depth.
--

commit 18d8778974aea49701a86271f93dca924bc4ff06
Author: tao <tao.wangtao@honor.com>

mm: handle ANON_VMA_LAZY during migration

To ensure the atomicity of folio migration, introduce
folio_trylock_get_anon_rmap().

> diff --git a/mm/migrate.c b/mm/migrate.c
> index b397cdeab09a9..4abbfd1faea26 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
[ ... ]
> @@ -1287,26 +1300,17 @@ static int migrate_folio_unmap(new_folio_t get_ne=
w_folio,
[ ... ]
> -	if (folio_test_anon(src) && !folio_test_ksm(src))
> -		anon_rmap =3D folio_get_anon_rmap(src);
[ ... ]
> +	if (folio_test_anon(src) && !folio_test_ksm(src)) {
> +		anon_rmap =3D folio_trylock_get_anon_rmap(src);
> +		if (!anon_rmap_value(anon_rmap))
> +			goto out;
> +	}

[Severity: High]
Does this cause migration to unconditionally fail for unmapped anonymous
folios? For unmapped folios, folio_get_anon_vma() returns NULL because
folio_mapped() is false, which causes folio_trylock_get_anon_rmap() to
return ANON_RMAP_NULL. Before this change, the code ignored a NULL rmap
for unmapped folios and proceeded. With this goto out, any attempt to
migrate an unmapped anonymous folio might repeatedly fail with -EAGAIN.

[Severity: High]
Could this lead to holding a dynamic number of read locks concurrently
during batch migration? Because migrate_pages_batch() processes folios in
batches, it iterates and calls migrate_folio_unmap() to acquire the lock
for every folio before it begins calling migrate_folio_move() to release
them.

Holding these locks concurrently across an entire batch could easily exceed
lockdep's MAX_LOCK_DEPTH (48) and cause severe contention or stall writers
on those VMAs during long-latency operations like TLB flushing.

[ ... ]
> diff --git a/mm/rmap.c b/mm/rmap.c
> index cb104310cdc9b..bd5587735ee06 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1223,6 +1223,46 @@ anon_rmap_t folio_lock_anon_rmap_read(const struct=
 folio *folio,
>  	return anon_vma ? anon_vma_to_anon_rmap(anon_vma) : ANON_RMAP_NULL;
>  }
> =20
> +anon_rmap_t folio_trylock_get_anon_rmap(const struct folio *folio)
> +{
> +	struct anon_vma *anon_vma;
> +	struct vm_area_struct *vma;
> +
> +	if (folio_test_anon_vma_lazy(folio)) {
> +		vma =3D folio_get_anon_vma_lazy(folio);
> +		if (vma && !lock_vma_under_rcu(vma->vm_mm, vma->vm_start)) {

[Severity: Critical]
Is it safe to dereference vma->vm_mm here without protection? While the VMA
object itself might be protected from being freed, a VMA does not pin its
associated mm_struct. If the process has exited, the mm_struct could be
freed via free_mm().

Passing a dangling vma->vm_mm pointer to lock_vma_under_rcu(), which
attempts to walk the maple tree, could result in a use-after-free.

[Severity: High]
Does this discard the pointer returned by lock_vma_under_rcu() and leak the
per-VMA lock?

lock_vma_under_rcu() returns a pointer to the locked VMA if successful.
The condition implicitly casts this pointer to a boolean and discards it.
If the lock succeeds, the code proceeds to return the original vma pointer
instead of the locked one, leaving the successfully locked VMA permanently
locked.

Later, anon_rmap_unlock_put() would call vma_end_read() on the original
vma pointer, which was never explicitly locked.

> +			vma_put(vma);
> +			vma =3D NULL;
> +		}
> +		if (vma)
> +			return vma_to_anon_rmap(vma);
> +	}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527110147.1781=
5-1-tao.wangtao@honor.com?part=3D12
