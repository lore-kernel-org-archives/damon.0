Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6EE3B6356
	for <damon@lists.linux.dev>; Wed,  1 Jul 2026 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918075; cv=none; b=DGKEOmsndxh07yNQjVN4TEk5nGqqSDMjhqJE/EmViEJSQVp4KKrlvmx9E1Yv+ow/ujNKZDSk+4gEMEIUlYDJ7RzwoupJcQ9E4UBU5iLtT01hKiaB7YpRklouAcjkD60g5UtkDlgtIJEydC1IjoKUdrAhE1NiABVkBM0R6Hw3tJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918075; c=relaxed/simple;
	bh=/3rdu9tjmJoYgAZnJZFGMNpwUCYVUliBez7L+jv0ZW0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ieGp9vUelOYhD+ARwzlvz6H0IPdD6IbaEPTytK4uzUGmEMVPVeBZkQzp2oGzOt76QuQDTY7SJakwCrvIriYms7/c/vlVjJP+/gcXu8LJJ9cI66xmAVlKWLd+m+fPYhwvH6yFwMi2Wh3+qpXBqalv8P8QRC6HFC3hTAs9IvzqPUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxBg4SWr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxBg4SWr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FB21F000E9;
	Wed,  1 Jul 2026 15:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782918070;
	bh=NGSVghnm/DocGdJ7iNbdOwoCX3zqJbkqe1L7v3YEeZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jxBg4SWr24KOoVH9K2yGacoOrzk7j5Jw8GLCgS0uyRgIw44Kwc98PXrnSEFPbOrW4
	 P64FfvI6TJqsSYETmsONeHP+3PxtOMRpieH2mLgO/VDkpdPrM65sNgzNeCrCNu0Wt+
	 fm7WHxPDoIc7zizjpIwNPaEisN68TMmDc9K0ZaJVC3iCBqxqlQOisPrrR5B7X9aJsV
	 i/9XgUaP8CdTsSjuvGUFF03XWieohsdnFNg0yT26WpLcOJY6JkZri7U6L0LiuyceR2
	 saDuRCNq6psvEUqOAVxFtHFT82ygykhbMIqY8heCqOn+WmzR/IWVeUImZhFcFSqe17
	 e/lTdHbzHylwg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/8] mm/damon/core: safely validate src on
 damon_commit_ctx()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260701144815.113325-2-sj@kernel.org>
References: <20260701144815.113325-1-sj@kernel.org>
 <20260701144815.113325-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 15:01:10 +0000
Message-Id: <20260701150110.A4FB21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Validation step incorrectly tests the existing context (`dst`) ins=
tead of the new parameters (`src`), completely neutralizing the patch's saf=
ety guarantees.
--

commit 4ac81fdba8a8c8576fad127fdd4347015f4dac51
Author: SJ Park <sj@kernel.org>

mm/damon/core: safely validate src on damon_commit_ctx()

This commit updates damon_commit_ctx() to validate parameters safely by
applying them to a test context before applying them to the running context.
If the test context validation succeeds, the real update proceeds.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 5febe58a07028..5ca176eb27e1d 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -1635,6 +1622,52 @@ int damon_commit_ctx(struct damon_ctx *dst, struct=
 damon_ctx *src)

[ ... ]

> +int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
> +{
> +	struct damon_ctx *test_ctx;
> +	int err;
> +
> +	test_ctx =3D damon_new_test_ctx(dst);
> +	if (!test_ctx)
> +		return -ENOMEM;
> +	err =3D __damon_commit_ctx(test_ctx, dst);

[Severity: High]
Does this code incorrectly validate the existing context instead of the new
parameters?

test_ctx is initialized as a clone of dst via damon_new_test_ctx(dst). If
__damon_commit_ctx() applies dst to test_ctx again, it avoids testing the
new parameters in src entirely.

If src contains invalid parameters (like a non-power-of-two min_region_sz),
it will bypass this check. When the unvalidated src is subsequently applied
to the running context:

    err =3D __damon_commit_ctx(dst, src);
   =20
it can fail partway through. This leaves dst->maybe_corrupted =3D true and
causes the running kdamond monitoring thread to terminate unexpectedly.

Should the validation step be checking src instead?

    err =3D __damon_commit_ctx(test_ctx, src);

> +	if (err)
> +		goto out;
> +	err =3D __damon_commit_ctx(dst, src);
> +out:
> +	damon_destroy_ctx(test_ctx);
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701144815.1133=
25-1-sj@kernel.org?part=3D1
