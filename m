Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EB1285CBC
	for <damon@lists.linux.dev>; Sun, 26 Jul 2026 21:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785100250; cv=none; b=uzSuJKGFKRNBUfaONOaZZkgbuYJY4SIDYaLZHZgMbM99bZIoQNiz10/UbLQBgg3GlHF0VBSt5oTu3DqO5Aq1I5wVxrY/ZwTCDgkNi/ye8yoS3SEXanEP2ZpxHYPuo/SekwmB49WVCIt7qePxt/HNTwsR02hwtCM/R8fc4nchnR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785100250; c=relaxed/simple;
	bh=GhPGvCBCY92QGKIWW5HiRJWEkoZhK4q6rHIqGtIPEM4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WdR/D9y60uRM9EQCoZ8F2KG/9DTm/U8q18g0ZX0i6S+AJBdvmLhH9GFi2XLj1Qk4m/bwrIYqkcNWy2NLXF7ou0YMKDcpubi5Q8ryJB75VEziwaQksFKTw1cI7xY20wA0/fNX3+yTkFaTtDvsXKhnWq1pKQvv9EznnRxEWf4bPlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8ARJ4b1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8ARJ4b1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8EA1F000E9;
	Sun, 26 Jul 2026 21:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785100248;
	bh=vjeBsyaXxo3lIuJGKS6tRFaUVgDwAx/1G/s54YJY0Pw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W8ARJ4b1oxfSMi2EHht2JWZG4HqR0J2SwwxJ9F5iI+YX/oxVYjfjO8gbraaxFcORP
	 eamR0F5LF/jJCEhi9iXPo1PQ32FP8ag+5V+aR/PZB6EIN2PjSLURPcjT8Sb8pgP8g6
	 Z8dXhxoYfd31QoGruHuVDzr35G0r4my3QDa9/Lc9MJL7hEysmq4G/tPIiiR92cFoLJ
	 4jzAz+gFLun8fxvvFkjFS2msMZd+ggu2bXdijKoHb1A7/VxLflVoRdWJSiP0Fm2QuK
	 tXhjr4P7kxr35RaHtpnDykk8AYXo2HQQUV7W449aqQjVZhWf+fYROM5vsxtlLorfZJ
	 sTEF9b6qpnpNw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm/damon: adjust isolated pages stat for
 DAMOS_MIGRATE_{HOT,COLD}
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260726205548.2287-1-sj@kernel.org>
References: <20260726205548.2287-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 21:10:48 +0000
Message-Id: <20260726211048.8B8EA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Early return in damon_migrate_pages() leaves isolated folios on th=
e caller's list, causing memory leaks, stat inflation, and stack UAF.
--

--- Patch [1]: [RFC PATCH] mm/damon: adjust isolated pages stat for DAMOS_M=
IGRATE_{HOT,COLD} ---
commit 1efec5dea2b48b50043eba6bdae1821a99318049
Author: SJ Park <sj@kernel.org>

mm/damon: adjust isolated pages stat for DAMOS_MIGRATE_{HOT,COLD}

Callers of migrate_pages() should adjust NR_MIGRATED_{ANON,FILE} for
isolations and putback of the folios. This patch fixes DAMOS_MIGRATE_{HOT,C=
OLD}
which mistakenly missed the stat adjustment, potentially confusing compacti=
on
and reclaim.

Link: https://github.com/damonitor/damo
Link: https://lore.kernel.org/20260726164356.87940-1-sj@kernel.org

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index e59f77eca83b2..9809fa12b09a8 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c

[ ... ]

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 5a6a78054784a..5c6c3a597fd0b 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -346,6 +346,8 @@ static unsigned long damon_pa_migrate(struct damon_re=
gion *r,
> =20
>  		if (!folio_isolate_lru(folio))
>  			goto put_folio;
> +		node_stat_add_folio(folio, NR_ISOLATED_ANON +
> +				folio_is_file_lru(folio));
>  		list_add(&folio->lru, &folio_list);

[Severity: High]
This isn't a bug introduced by this patch, but if s->target_nid is invalid
(e.g., if it defaults to NUMA_NO_NODE), damon_migrate_pages() returns early
without draining the folio list:

mm/damon/ops-common.c:damon_migrate_pages() {
	if (target_nid < 0 || target_nid >=3D MAX_NUMNODES ||
			!node_state(target_nid, N_MEMORY))
		return nr_migrated;
    ...
}

Since folio_list is a stack variable here in damon_pa_migrate() and is pass=
ed
to damon_migrate_pages() later in this function, wouldn't this early return
permanently leak the isolated folios and cause a use-after-free when the st=
ack
variable goes out of scope?=20

Furthermore, with this patch applied, doesn't this error path also permanen=
tly
inflate the newly added NR_ISOLATED stats because the cleanup loop in
damon_migrate_folio_list() is never reached?

A similar issue appears to exist in mm/damon/vaddr.c:damos_va_migrate(),
where priv.migration_lists is freed without checking if any folios were left
behind by an early return.

>  put_folio:
>  		addr +=3D folio_size(folio);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726205548.2287=
-1-sj@kernel.org?part=3D1
