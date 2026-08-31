Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7413E3D93
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788177017; cv=none; b=KzQf7DepXBsU6mwo5FaI5OM4W8II+C/3drZ9T/l4iJoIiLVlUJv5+gOYY0wc7u6Z6Ut8y2PZ/Um5lWvfyeUZzkXRNBQtRgOJ3MTKFGtIs2qfzHQE1Ez6iRG31sAjz5nFain/m9PPZ8dR37V7PqsfsxCnAq7QFvpu5SnM1Tt9+20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788177017; c=relaxed/simple;
	bh=HlZSpqNtZKBqGIxAofp2kyYHxqkkjMHf3H29rP0K6/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c/JQKQXE+t7EvoFiNgyhhMqFfcE7TlB9NaYA6dLKtENAgrKRVanZfey09MS5qcdpJEz88vaEC4Vfjgw7v8Tlpy/VenzgcZQ3X5cnWg6MywQQjG8StWqISbdRHhCN3qU8xIMn87iJqTF+WI5DNkmsIEiKJ6YbuIT+1LPpVJifqhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6XlBXSZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6XlBXSZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A53C1F000E9;
	Mon, 31 Aug 2026 11:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788177015;
	bh=mHQWjHgBKzOsXdxqH24UgmFVrJ6x6p2wi1hF2bfiRdg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a6XlBXSZ+ZdLJ3lMAFmmh9Y2xb6yLz0DF8rqqmjw62hwpqQZmeRI6gKUzP+Birg1U
	 XILT6Ib7SsoTVpS1cTCCBDrymHEoqwAVmlvQ03Ak3oCgm6qLuxzJfD8HxKgQ0OR2jA
	 mC/kXhok9jV3CWQ1ttAxeYUar86aZMwNO0RkeXET5xeZ+pe+RfmLKYJdLIWMzXUJYm
	 F3eh7F8Y4/yqiUDvlM1uOMLyfppJGV2G+ZhZDLf1nuy4s/8gHFr3MfVElgz7fcdyPs
	 jwrR7IBegNHJStEVaZVxpcMwiC8ltlVyTTDEbEjYXMFyz/8ct3h+oBHFd+PDBzcHLQ
	 Sn9ZvV2t4mdeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/tests/core-kunit: add test for unconditionally
 skipping the last region
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831113735.3349-1-aethernet65535@gmail.com>
References: <20260831113735.3349-1-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 11:50:14 +0000
Message-Id: <20260831115015.3A53C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces a KUnit test for a bug in `damos_skip_charg=
ed_region()` but completely omits the code fix, causing the test to fail un=
conditionally and break CI.
--

commit 7f67629ee782b9649498afa3088f50459bfb8f3b
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/tests/core-kunit: add test for unconditionally skipping the last r=
egion

This commit introduces a KUnit test to verify that the last region is not
skipped before being processed.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 4a536d41cdb2d..90b0fda34fba2 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
[ ... ]
> @@ -1632,6 +1632,48 @@ static void damon_test_rand(struct kunit *test)
>  	}
>  }
> =20
> +static void damon_test_last_region_quota_reset(struct kunit *test)
> +{
> +	struct damos s =3D {0};
> +	struct damon_target *t;
> +	struct damon_region *r1, *r2;
> +	unsigned long min_region_sz =3D 10;
> +	bool skipped;
[ ... ]
> +	s.quota.charge_target_from =3D t;
> +	s.quota.charge_addr_from =3D r1->ar.end;
> +
> +	skipped =3D damos_skip_charged_region(t, r2, &s, min_region_sz);
> +
> +	/* 'r2' is not processed, it should not skip */
> +	KUNIT_EXPECT_EQ(test, skipped, false);

[Severity: Medium]
Does this patch omit the fix for the core logic?

Without an accompanying fix for damos_skip_charged_region() in
mm/damon/core.c, won't this new test unconditionally fail and break CI?

Because the underlying bug is not fixed in this patch, the old logic still
triggers and returns true when it processes the last region:

mm/damon/core.c:damos_skip_charged_region() {
	...
	if (quota->charge_target_from) {
		if (t !=3D quota->charge_target_from)
			return true;
		if (r =3D=3D damon_last_region(t)) {
			quota->charge_target_from =3D NULL;
			quota->charge_addr_from =3D 0;
			return true;
		}
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831113735.3349=
-1-aethernet65535@gmail.com?part=3D1
