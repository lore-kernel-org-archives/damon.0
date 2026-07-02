Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76482391837
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027304; cv=none; b=tR8NC+A90pyk6oUDNiaYLrdRpLu6V2ZiJ6EcCRhywzdWEolEcoHIR6ZAYpb/BDHuGyQlq7RWqkZp+eeSz/mtqkHYhTKp3e9nM5BEJAmPeFKhYFBHfnytpZoE/9KC5slWBBFnv3XvOdkyx7O6SZotXL3LacAKr+g104EdFgJdvv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027304; c=relaxed/simple;
	bh=1iYn35bcZd3qWaolQzOxVQwPF0/SI9kgtguD5F0O9C0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A5Zw/pcYTkRDTbRso/AqJRRTrJ1VcVM0xvZn5GvH7mA9mCba3dr1J2c2r7OYcde8pMjOVpLI4qFXNpfOjFW9NE0CWooBbHWIU5V1ld08VKvdY7GEv4t0eNkBWJrJXMd2mQ02dF8b0KJTRWQtlWP3evt5TlQQ+LSjYBFiYY0RP60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqxSqrdw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqxSqrdw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB6D1F00A3D;
	Thu,  2 Jul 2026 21:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783027303;
	bh=kLmqrdXcJzUJcsrshVq9gBoBPyLS6PxPtRJ6MRJdgCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KqxSqrdwErdTRLz5uNtV8kQ1UV7gNXRCkAiKpkYIuqAch1I03JEnC37JL2JoATE50
	 i7tDCbhXxAkyfV8IJI8cm/XGbeXKJSlimAtcQ9epjmTiAgaafVZiPQQjgIS5W374KT
	 G5NW5wOrg99u5CUoC/sS4i2cxdy0+DB+nGcN/8JF2AR6mxPBX6Xf2Y39tDcuy9k+CJ
	 C19UhoBPOBE4A8xNIpCpfgCruhIILIjdO+i8xkeo15eZewmUyNvhF7FCmJuwa/GJD2
	 f7FO4zNS4fSqtYBWYbsTCagvsceAFCWi1Ko8h0W684SKG7eNZlTOtv5TsuG3vKHDZg
	 lzfds6mD6ArFQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 1/8] mm/damon/core: safely validate src on
 damon_commit_ctx()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260702210551.95167-2-sj@kernel.org>
References: <20260702210551.95167-1-sj@kernel.org>
 <20260702210551.95167-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 21:21:42 +0000
Message-Id: <20260702212143.0CB6D1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] damon_commit_ctx() silently corrupts the quota charging state of r=
unning schemes.
--

commit b274d76c061808ff0cd97c6e9433199f816cc1de
Author: SJ Park <sj@kernel.org>

mm/damon/core: safely validate src on damon_commit_ctx()

damon_commit_ctx() does its holistic parameter set validation while
applying the new parameter in the set one by one.  If it finds a
parameter is invalid, because some invalid parameters may already be
committed (it is called "commit" but not atomic and irreversable), it
stops the running DAMON context.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index c6fc35be633b3..b523a18a7b971 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -1702,6 +1689,52 @@ int damon_commit_ctx(struct damon_ctx *dst, struct=
 damon_ctx *src)
>  	return 0;
>  }
> =20
> +static struct damon_ctx *damon_new_test_ctx(struct damon_ctx *dst)
> +{
> +	struct damon_ctx *test_ctx;
> +	int err;
> +
> +	test_ctx =3D damon_new_ctx();
> +	if (!test_ctx)
> +		return NULL;
> +	err =3D __damon_commit_ctx(test_ctx, dst);

[Severity: High]
This is a pre-existing issue, but does this unintentionally corrupt the run=
ning
quota state?

When __damon_commit_ctx() is called with the running context (dst) as the
source, it copies the schemes via damon_commit_schemes(), which calls
damon_new_scheme() and passes a pointer to the active scheme's quota:

mm/damon/core.c:damon_commit_schemes() {
	...
	new_scheme =3D damon_new_scheme(&src_scheme->pattern,
				src_scheme->action,
				src_scheme->apply_interval_us,
				&src_scheme->quota, &src_scheme->wmarks,
				NUMA_NO_NODE);
	...
}

damon_new_scheme() then calls damos_quota_init() on that provided quota
pointer:

mm/damon/core.c:damon_new_scheme() {
	...
	scheme->quota =3D *(damos_quota_init(quota));
	...
}

damos_quota_init() zeroes out the fields in-place:

mm/damon/core.c:damos_quota_init() {
	...
	quota->esz =3D 0;
	quota->total_charged_sz =3D 0;
	...
}

This mutates the running scheme's quota state, which would make the quota
effectively "full" mid-interval and prevent the scheme from applying its
actions until the next reset interval.

Since this patch moves this test context logic into the core
damon_commit_ctx(), doesn't this expose all API users like damon_reclaim
and damon_lru_sort to this state corruption when parameters are committed?

> +	if (err) {
> +		damon_destroy_ctx(test_ctx);
> +		return NULL;
> +	}
> +	return test_ctx;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702210551.9516=
7-1-sj@kernel.org?part=3D1
