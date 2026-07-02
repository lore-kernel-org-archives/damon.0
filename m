Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA017480946
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986539; cv=none; b=dfTYvm29/YeNWqKtu6qn40fdxP8GWTsuDp/bH7gzt9wnQ6Bu5v59t6xTCtPxSJ4R6CZtwpAbuoG+X7rGbThRnkBlxn5HY8WV6mittChf+Cslz3jQCV3GcIyNm+RwScL2kZZwiTwOvlofNpSMiR3pZhWKV+Z2lo3N7jfy2McTTMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986539; c=relaxed/simple;
	bh=055/QjDf3+TbCW3oUEJmS9vCD9HWtjsFMxQiGb2Ic2s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WXpAZWlyvhMTfaN5JxcKW8tinLtVdXdMAa0wp9rwinszpxKKa96JTiwM10QjRYmgHi4j7GbFQFq71nMQfHJhZ4myn7YooGLuUmjIaOSoqD2h5AT7dOXSER3rYa9NnATwdy8g3b+c7MtSkNrSGM9+zLPgk+4RXrVYvfxZ5CJwnP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+Fcn1uP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+Fcn1uP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6D81F000E9;
	Thu,  2 Jul 2026 10:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782986538;
	bh=2WKbZMdWlyyUyTm/V4ju3XqMFnPV5NlEkYQ29y0rkUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K+Fcn1uP4QqKb5CC1iAvnB1JDiLnLoZ2ekLt+JzWhVZ5KDvOO4jStTZw6MFljCdv9
	 9QywHrANQGjaRFbShkfq5L/dYsQqbYkCyBcq5q5Xr+612sULF0l+HYbM/QcwSff7Oy
	 7UfDDrnYPCzKunj9YOVgd4Kt6a9MGM8SmWUadwU4Ib0XHZwSeZYyp1naU8Wip6f4bN
	 UYczz7oxhkiharBUWN9DH9WRVWPuVWB52fmj4Dj6gNNP5F6DzxQIzbQM59q+3qwtH9
	 spO7p99CKkGVAddOp6YEzK9g4feozFMP6g+5RpgyP9ZARqdeCUov+LriKTE8Lf1UOa
	 ak+1UDQ/HlNFg==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND RFC PATCH v2 1/5] mm/damon: add target_order field for
 DAMOS_COLLAPSE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lian Wang" <lianux.mm@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260702095227.75866-2-lianux.mm@gmail.com>
References: <20260702095227.75866-1-lianux.mm@gmail.com>
 <20260702095227.75866-2-lianux.mm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 10:02:17 +0000
Message-Id: <20260702100218.2E6D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Sysfs value for `target_order` can silently diverge from the act=
ive DAMON scheme's internal state.
- [Low] The `#else` block fallback for `target_order` when THP is disabled =
is unreachable.
--

commit 38547105610a7847b39b76172e675c32ee3ca4f5
Author: Lian Wang <lianux.mm@gmail.com>

mm/damon: add target_order field for DAMOS_COLLAPSE
   =20
Adds a target_order field to express per-order mTHP collapse intent for
DAMOS_COLLAPSE. Wires up the sysfs interface target_order to configure this
value and warns when an unsupported non-PMD order is used.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index dbf2b0515d582..9067cb66632ed 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c

[ ... ]

> @@ -2644,6 +2648,39 @@ static ssize_t target_nid_store(struct kobject *ko=
bj,
>  	return err ? err : count;
>  }
> =20
> +static ssize_t target_order_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	struct damon_sysfs_scheme *scheme =3D container_of(kobj,
> +			struct damon_sysfs_scheme, kobj);
> +
> +	return sysfs_emit(buf, "%u\n", scheme->target_order);
> +}
> +
> +static ssize_t target_order_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	struct damon_sysfs_scheme *scheme =3D container_of(kobj,
> +			struct damon_sysfs_scheme, kobj);
> +	unsigned int val;
> +	int err;
> +
> +	err =3D kstrtouint(buf, 0, &val);
> +	if (err)
> +		return err;
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	if (val !=3D 0 && (val < 2 || val > HPAGE_PMD_ORDER))
> +		return -EINVAL;
> +#else
> +	if (val !=3D 0)
> +		return -EINVAL;
> +#endif
> +
> +	scheme->target_order =3D val;
> +	return count;
> +}

[ ... ]

> @@ -3010,6 +3052,25 @@ static struct damos *damon_sysfs_mk_scheme(
>  	if (!scheme)
>  		return NULL;
> =20
> +	target_order =3D sysfs_scheme->target_order;
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	if (sysfs_scheme->action =3D=3D DAMOS_COLLAPSE &&
> +	    target_order !=3D 0 &&
> +	    target_order !=3D HPAGE_PMD_ORDER) {
> +		pr_warn("DAMON collapse: target_order %u not supported, only PMD order=
 (%u) is available. Use 0 or %u.\n",
> +			target_order,
> +			HPAGE_PMD_ORDER, HPAGE_PMD_ORDER);
> +		target_order =3D 0;

[Severity: Medium]
Will this cause the sysfs API to report an incorrect state to userspace?

When an unsupported order is encountered, this overrides target_order to 0 =
for
the internal scheme, but it fails to update sysfs_scheme->target_order or
return an error. Userspace reading from target_order_show() will see the
divergent uncorrected value and believe a specific target order is active
when it has silently been overridden to the default.

> +	}
> +#else
> +	if (sysfs_scheme->action =3D=3D DAMOS_COLLAPSE && target_order !=3D 0) {
> +		pr_warn("DAMON collapse: target_order not supported without THP. Use 0=
.\n");
> +		target_order =3D 0;
> +	}

[Severity: Low]
Is this block reachable?

In target_order_store(), if CONFIG_TRANSPARENT_HUGEPAGE is not set, any
non-zero value unconditionally returns -EINVAL. It seems target_order will
always be 0 when evaluating this block.

> +#endif
> +	scheme->target_order =3D target_order;
> +
>  	err =3D damos_sysfs_add_quota_score(sysfs_quotas->goals, &scheme->quota=
);
>  	if (err) {
>  		damon_destroy_scheme(scheme);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702095227.7586=
6-1-lianux.mm@gmail.com?part=3D1
