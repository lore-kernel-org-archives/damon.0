Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44044192D8A
	for <damon@lists.linux.dev>; Wed,  1 Jul 2026 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782919252; cv=none; b=Taatp8GAqLcIHa+YWxL8mMBfkxTSfSyW4u5vu8KQVtXpuBJkX+B1H6kZXT8KfmyNMxfaAxaFqPBoCinZYmzFzA6LS83IiRbaTYm0eMCF7HNRE4oBAo+sX7PTjCRpAe9T6QIZJoWNh7wBx5VEqrV4R2jn2yZJZASpwdDcK33Itx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782919252; c=relaxed/simple;
	bh=fs66piiUFDtyVO9iOOHMX5/0nC3CG1atYTq9T56gbZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pNC4L43LCa7Hu/6/HnwrSl59Q2UjIysrKdbQ7KOA0VWnptj2kJbMBb9FjaFgOfdsDgFuR2OJg6Ayn0rID6zDxhBA7i26Fz5+t61ECYwO39s5kaipGmfJ7dijM0c3Vw5/kKJEPfU/mgKkV9ZGdfGxpcU5sOtemETkwaCuCE+8vbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOFiafYP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOFiafYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBEE1F000E9;
	Wed,  1 Jul 2026 15:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782919250;
	bh=UY+yCP6ZLPvhQiKRDheBnZf5O3lF5L4E1wnKnHkKXcs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iOFiafYPaW8sDRWHZRYigdX+g9/F7xxvMx2B9RoO1GxZ4pTzXuKGcRxsVupB/4vlm
	 LioKVpgeerOgt1Za7UwDFUpgu/V+hDnEWpgmpRWGyQldDDi5xu2k1PQhy/xu3hEqB9
	 jV1pMGlSUEhQLac5fDTC2PuI+af0kkfE3BlJxM1qAKabebJkDlylQSIJ9pc2fsYb5j
	 ffmqbGmwlHJGtbQrLM2CW4TZoLs95b+GU0FzzB3zTv3JaSsfhFXcztKGtwEtH7Qj7Y
	 o0ITVKn1ShRi1JY/vVPEw6eTd7EFmRX0ZTBx6aGNHUa1pRf/siHWEIBU9lLPBphZdw
	 4AAqEwjIvpTBQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/8] mm/damon/core: do parameter testing commit on
 damon_start()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260701144815.113325-3-sj@kernel.org>
References: <20260701144815.113325-1-sj@kernel.org>
 <20260701144815.113325-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 15:20:50 +0000
Message-Id: <20260701152050.BDBEE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] `damon_commit_ctx()` incorrectly validates `dst` against `test_ctx=
` instead of `src`, bypassing the safety mechanism.
- [Medium] Reusing a single `test_ctx` across multiple loop iterations in `=
damon_start()` leaks state between contexts, leading to non-deterministic v=
alidation outcomes.
--

commit db4fd1a9680927efd94179ba2c47dd9fdd14f123
Author: SJ Park <sj@kernel.org>

mm/damon/core: do parameter testing commit on damon_start()

damon_start() and damon_commit_ctx() are the two main API functions for
setting DAMON parameters. This commit embeds the parameter check already
present in damon_commit_ctx() into damon_start(), allowing callers to
safely use damon_start() without manually validating parameters first.

The commit message mentions that damon_commit_ctx() does holistic
parameters testing. Looking at damon_commit_ctx() in the same file:

mm/damon/core.c:damon_commit_ctx() {
	...
	test_ctx =3D damon_new_test_ctx(dst);
	if (!test_ctx)
		return -ENOMEM;
	err =3D __damon_commit_ctx(test_ctx, dst);
	if (err)
		goto out;
	err =3D __damon_commit_ctx(dst, src);
	...
}

[Severity: High]
Does this bypass the safety validation mechanism in damon_commit_ctx()?

The validation incorrectly tests the active context dst against test_ctx
instead of testing the incoming parameters src.=20

If invalid parameters are supplied or if a mid-commit allocation fails, the
incoming parameters src are directly applied to the active context dst
without any prior dry-run validation. This leaves the active context dst in=
 a
corrupted state (maybe_corrupted =3D true), potentially leading to monitori=
ng
thread crashes or unpredictable kernel behavior.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 5ca176eb27e1d..ace202f47dd7c 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -1785,13 +1787,22 @@ static int __damon_start(struct damon_ctx *ctx)
>   */
>  int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
>  {
> +	struct damon_ctx *test_ctx;
>  	int i;
>  	int err =3D 0;
> =20
> +	test_ctx =3D damon_new_ctx();
> +	if (!test_ctx)
> +		return -ENOMEM;
> +
>  	for (i =3D 0; i < nr_ctxs; i++) {
> -		if (!is_power_of_2(ctxs[i]->min_region_sz))
> -			return -EINVAL;
> +		err =3D __damon_commit_ctx(test_ctx, ctxs[i]);

[Severity: Medium]
Does reusing a single test_ctx across multiple loop iterations leak state
between contexts?

If a caller invokes damon_start() with multiple contexts (nr_ctxs > 1),
test_ctx is mutated in the first iteration. In the second iteration,
__damon_commit_ctx() runs on the same, un-cleared test_ctx.

For example, if ctxs[1] has an obsolete target:

mm/damon/core.c:damon_commit_targets() {
	...
		/* target to remove has no matching dst */
		if (src_target->obsolete) {
			err =3D -EINVAL;
			goto out;
		}
	...
}

It evaluates against the residual targets of ctxs[0]. If ctxs[0] had enough
targets, the obsolete target incorrectly matches and passes validation. If
ctxs[0] had no targets, it fails with -EINVAL, producing non-deterministic
validation results.

> +		if (err) {
> +			damon_destroy_ctx(test_ctx);
> +			return err;
> +		}
>  	}
> +	damon_destroy_ctx(test_ctx);
> =20
>  	mutex_lock(&damon_lock);
>  	if ((exclusive && nr_running_ctxs) ||

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701144815.1133=
25-1-sj@kernel.org?part=3D2
