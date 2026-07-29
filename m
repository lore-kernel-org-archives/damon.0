Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE88453A27
	for <damon@lists.linux.dev>; Wed, 29 Jul 2026 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336779; cv=none; b=JiswK069jxQ6O7hswklZdJNOkLdkp6DuLfvcW7HOwUZwCku6UIEOfSPvbKWy69R2RWINbdo+WmZwvbYZwigIt1qr6wTvZivKLaQAG04gU1Sx0yl25ll5uAjX7L9NlE9ymkroR/a34rVu8BJzbt/XPElyQrvnHvX7S+ZfZ79VOKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336779; c=relaxed/simple;
	bh=F2MDraGFiHpiNLWAk1zMx+16qFqVD5F4m4u/D0V+TkY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VqtgvByr53bfHL1EX64to3ZtZjW9OsvoXZHz2aBonaIUT93/R3zxrc26i5yju2OJUPVbbofVOAx3igff6uNeCi95u2HjRLpavoxebFIhC2RezQfzZFZsQThQdeth0eSGVK1mzhMHdtdT3SsvEXWQsVdTcFvtzuNCPhAy62WXjio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkvLaoit; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkvLaoit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFBE1F000E9;
	Wed, 29 Jul 2026 14:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785336778;
	bh=XcLcf+3uZOgqQ3IYJe7k7BRuPOG9gOmRqSTXY5oFaFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mkvLaoitJSrqsPsb5wtnIehVpHrQeQ2VSgJwS9ku+zUQNw5NxZFYaz0FvvaIMoPgs
	 SfwKijWDji/7mgxqC6pgPMXxgfK2kZVCGFVRNDHzNdj21gY5fm5B6W6RIniqCm/Sst
	 L8g0aVzJcT6T02hm5O5A3mThiHwnOSZt3lM7cfryT31uM71BkDBzqp90+0U9/bSUti
	 7T/9RnGuOJe3UAk+YldxR5fvz2+H9IkhY6bUVlVWTbWKGZLr5PybHRqa2kBBCp3zwd
	 xPAVoW4n9fwNE52iGk9z5fH6sfJq/yse9loekLiZ6idQQ2beiKjPePHU0i+N8e5gY2
	 hgDPf8E7yhFZA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/6] mm/damon/tests/core-kunit: test
 damon_commit_filter()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260729144738.90895-2-sj@kernel.org>
References: <20260729144738.90895-1-sj@kernel.org>
 <20260729144738.90895-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 14:52:57 +0000
Message-Id: <20260729145257.CCFBE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The kunit test uses the wrong enum type `DAMOS_FILTER_TYPE_MEMCG=
` instead of `DAMON_FILTER_TYPE_MEMCG` when checking `src->type`, causing t=
he `memcg_id` assertion to be silently skipped.
--

--- Patch [1]: [RFC PATCH 1/6] mm/damon/tests/core-kunit: test damon_commit=
_filter() ---
commit e16ea26a19f85858bdb608d81842e976d30c3270
Author: SJ Park <sj@kernel.org>

mm/damon/tests/core-kunit: test damon_commit_filter()
   =20
Add kunit test to ensure damon_commit_filter() updates destination
filter as expected for valid inputs.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 4a536d41cdb2d..6cbe22accabfb 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -1306,6 +1306,45 @@ static void damon_test_commit_target_regions(struc=
t kunit *test)

[ ... ]

> +static void damon_test_commit_filter_for(struct kunit *test,
> +		struct damon_filter *dst, struct damon_filter *src)
> +{
> +	damon_commit_filter(dst, src);
> +	KUNIT_EXPECT_EQ(test, dst->type, src->type);
> +	KUNIT_EXPECT_EQ(test, dst->matching, src->matching);
> +	KUNIT_EXPECT_EQ(test, dst->allow, src->allow);
> +	switch (src->type) {
> +	case DAMOS_FILTER_TYPE_MEMCG:
> +		KUNIT_EXPECT_EQ(test, dst->memcg_id, src->memcg_id);
> +		break;

[Severity: Medium]
Will this case label ever be matched?

This code checks against DAMOS_FILTER_TYPE_MEMCG, but damon_test_commit_fil=
ter()
below initializes the source filter with type DAMON_FILTER_TYPE_MEMCG.

Because of this mismatch, the switch statement falls through to the default
case, and the test silently skips the assertion for memcg_id.

> +	default:
> +		break;
> +	}
> +}
> +
> +static void damon_test_commit_filter(struct kunit *test)
> +{

[ ... ]

> +	damon_test_commit_filter_for(test, &dst,
> +			&(struct damon_filter){
> +			.type =3D DAMON_FILTER_TYPE_MEMCG,
> +			.matching =3D false,
> +			.allow =3D false,
> +			.memcg_id =3D 123,
> +			});
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729144738.9089=
5-1-sj@kernel.org?part=3D1
