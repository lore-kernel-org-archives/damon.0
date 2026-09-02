Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3B442AA9
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 00:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309594; cv=none; b=LfsgZRM6apSdPvKVm3Yx7yuCm+/G3LTqitnvCoNV7wGyqhCJH8+4cTHur3g8v5bjnlLRZDGlz063OkeNKYJUK3Eujoov8lSHTG0406OYZqSNw6qEg34R+fqqzvnhQxjunZDxayWL7ylZOrsdbQVg0I4uT3FA0/mei+aVPXDL9mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309594; c=relaxed/simple;
	bh=CPI4muoPjvp3/+DcqOTvN9PUVOnrYMHbZ7oPexq+OJM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dn2ZeQSHF9jhNDDbz0KrkEJ9OuDdGRfw5ua8XXxMmj1oildO5Kb5uNFiUhbME44ACE0nv/uxtWZZ7Flx+rhEFhwdPW98Dfrb3sudZZkxNblJiKxxPv1Iv1nc/XW6hWNHPZkspoyPbY5n6KPjMUyfqETnap0PIhbLocDEbY3UFwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gV4xpd/D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gV4xpd/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EED1F000E9;
	Wed,  2 Sep 2026 00:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788309592;
	bh=DQFQwi7ptxsgUNJfJg7IYLx86E0sBXPk63ggReMdpKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gV4xpd/D3YWnmzCIPiN3is8/peQjdXThSb8sDNtdbm3WZ6WS22jTK8pw2UBXn8gkQ
	 bTmtHiQ8NR1a7Kbl0b0eLqTeT2wU/vIf2u1XtOAJrYOSTWk6UHt8HPOsFXgMx9wEhX
	 fpYus8XGBoD3ZJdic66gWgSWDLgngy0w/2uwYRk7zJd8/ulqt/v0j0XBzSKzHrQe0l
	 9cp9enUCMjY/lwRfdDG7lSq/D05woKeDYhTvehYWgCekDHqcceAtn7fQfOft/zsGKY
	 LcEC+KphqgPpbwDjzG8R3AfuT/NNZYoZL66ROD1ETlLYGPTAJu5I1Q+gBTeNd8OZ4J
	 qhC0zPNMlL3wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] mm/damon/core: copy nid for eligible_mem_bp damos
 quota goal commit
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902002725.108635-4-sj@kernel.org>
References: <20260902002725.108635-1-sj@kernel.org>
 <20260902002725.108635-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 00:39:50 +0000
Message-Id: <20260902003951.11EED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Inconsistent state handling in damon_commit_ctx() on memory alloca=
tion failure.
--

commit c0fdc35d2fb6726e726ba0e857811cbaefc34918
Author: SJ Park <sj@kernel.org>

mm/damon/core: copy nid for eligible_mem_bp damos quota goal commit

damos_commit_quota_goal_union() is not updating the ->nid union field
when the goal metric is DAMOS_QUITA_NODE_ELIGIBLE_MEM_BP.  Hence, if a
DAMOS quota goal of the type is online committed in a way that it will
reuse other quota goal's memory space, the new goal will work with a
garbage nid value.  As a result, the DAMOS scheme can show unexpected
aggressiveness.

> damos_commit_quota_goal_union() is not updating the ->nid union field
> when the goal metric is DAMOS_QUITA_NODE_ELIGIBLE_MEM_BP.

This isn't a bug, but there's a typo (DAMOS_QUITA_NODE_ELIGIBLE_MEM_BP) in
the commit message.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 647ac77f573bb..a499d7866c507 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1143,6 +1143,9 @@ static void damos_commit_quota_goal_union(
>  		dst->nid =3D src->nid;
>  		dst->memcg_id =3D src->memcg_id;
>  		break;
> +	case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
> +		dst->nid =3D src->nid;
> +		break;
>  	default:
>  		break;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but is a pre-existing logic
flaw in the core DAMON commit mechanism on memory allocation failure.

In mm/damon/core.c:damon_commit_ctx():

	err =3D __damon_commit_ctx(test_ctx, src);
	if (err)
		goto out;
	err =3D __damon_commit_ctx(dst, src);

If the second call to __damon_commit_ctx() fails with -ENOMEM, won't it
leave the active dst context corrupted?

For example, an OOM condition can occur here in
mm/damon/core.c:damon_commit_schemes():

		new_scheme =3D damon_new_scheme(&src_scheme->pattern,
				src_scheme->action,
				src_scheme->apply_interval_us,
				&src_scheme->quota, &src_scheme->wmarks,
				NUMA_NO_NODE);
		if (!new_scheme)
			return -ENOMEM;

A failure here exits the commit process without rolling back prior scheme
updates, leaving the active dst context partially updated.

The kernel handles this by setting dst->maybe_corrupted =3D true, which
forces the kdamond monitoring thread to terminate gracefully but permanentl=
y.

Could this be triggered by a user-initiated online parameter update
encountering an OOM condition during the second __damon_commit_ctx()
invocation?

Does this violate the atomic nature of damon_commit_ctx() (which uses
test_ctx precisely to avoid partial updates on the active context) and
cause an unintended loss of the running context?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902002725.1086=
35-1-sj@kernel.org?part=3D3
