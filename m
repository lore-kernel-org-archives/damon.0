Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4EE3B777F
	for <damon@lists.linux.dev>; Wed,  1 Jul 2026 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907668; cv=none; b=DIfRzxIljquZL+wkmCJoYIcsupOx3TdhG+ABmMAH21PL+pEd0oLikkYhXSe67Obkr4LsXxT/oaT/au4Fj20TKCsR/GCxnHWjJbQxUiBFdOVZlmep/ALIkQjAQEfvZmZokyczLie9Bpq+shvtswZxOmGVMoSwAfZlh8n5Lp1T7/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907668; c=relaxed/simple;
	bh=uog6RXFhaucHaNO9K0oKWvKLevw+ghzVyRQEv4arQWo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kRJvociQuSlUIPgyfDl6rDS9QnFvSUrJiol3xIMZioNzGQqVzhZN0WuUu6tIMgkoBzHBY7AavbmxtpbBNtGl3LgAV89mtH+QFeVRN0f6V+z3l6fPNKDBabuaxCOFkUZYMEJEEjJ/9KSJRksj8ECaX84X0ypCdJH7KdNGfvtVr7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMwfPGBC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMwfPGBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AD91F00A3A;
	Wed,  1 Jul 2026 12:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782907666;
	bh=cpWF6C5erHwPEFPatvlGVc2Q7dBSh7ZAROFMCvT4vh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GMwfPGBCH9cHDvj5CdqPLT6o0s7VIwV8Hkl68DPbs5X2aL47I5dM+nfCSclutj5wk
	 +INN0q38uN1J4yDd2gzHXIJ+BezRnnfHDDJJktYRpnpPH1BV99z5Ar8tlz9ZX/Lht6
	 Hx9zlvgbNvIhjrnv3AnuRdIoziN65epKt28E7hTz9MGAsJ9vpiXkOZ1TzWiMs9RpCL
	 61GicJZasRfJoLsuJJG05IKjgVJJJEsyVn3bPF0VCp6mQlWXty65VYYLq12gOpPYz6
	 B9nGz4k9+06ITqUOpZugnP03FfOyT3hDuXKD+WfrPPT+Bi+5czjBepLgo6V5FI2Xj4
	 TI7vLva4OPXeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] mm/damon: add target_order field for
 DAMOS_COLLAPSE
Reply-To: sashiko-reviews@lists.linux.dev
To: "wang lian" <lianux.mm@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260701114716.56503-2-lianux.mm@gmail.com>
References: <20260701114716.56503-1-lianux.mm@gmail.com>
 <20260701114716.56503-2-lianux.mm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 12:07:45 +0000
Message-Id: <20260701120746.98AD91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The newly added `target_order` field is not initialized in `damon_=
sysfs_scheme_alloc()` or `damon_new_scheme()`, leading to kernel heap memor=
y leaks to userspace via sysfs.
- [High] The `target_order` field is not copied when committing scheme upda=
tes, causing configuration changes to be ignored.
- [Medium] TOCTOU race in `damon_sysfs_mk_scheme` allows configuring invali=
d `target_order` for DAMOS_COLLAPSE and DAMOS_SPLIT schemes.
- [Low] Unconditional use of `HPAGE_PMD_ORDER` causes a build failure (`BUI=
LD_BUG()`) on architectures or configurations without huge page support.
--

commit 5b7feca9accb6a6f2fee1a76e45a6ee03f08c17e
Author: Wang Lian <lianux.mm@gmail.com>

mm/damon: add target_order field for DAMOS_COLLAPSE

DAMOS_COLLAPSE currently collapses into PMD-size THP only.  Add a
target_order field to express per-order mTHP collapse intent.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index cfbbf8ba28f63..35b90b47e35a0 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -570,6 +570,11 @@ struct damos_migrate_dests {
>  struct damos {
>  	struct damos_access_pattern pattern;
>  	enum damos_action action;
> +	/*
> +	 * @target_order: target order for mTHP actions (DAMOS_COLLAPSE).
> +	 * 0 means system default (PMD order).  Valid: 0, 2..HPAGE_PMD_ORDER.
> +	 */
> +	unsigned int target_order;

[Severity: High]
Does adding this field require updating damos_commit() in mm/damon/core.c to
copy the new value?

When a user updates the target_order via sysfs and commits the changes,
damos_commit() copies parameters from the pending sysfs scheme to the runni=
ng
scheme. Since target_order is not copied there, it looks like dynamic
configuration changes to this field will be silently ignored.

[Severity: High]
Is this field properly initialized when allocating a new scheme?

Looking at damon_new_scheme() in mm/damon/core.c, the core struct damos is
allocated using kmalloc_obj() which does not zero-initialize memory. Since
target_order is not explicitly initialized there, it will contain
uninitialized heap data.

[ ... ]
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 41f93a1823bf1..085b8042d1250 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
[ ... ]
> @@ -2644,6 +2647,34 @@ static ssize_t target_nid_store(struct kobject *ko=
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

[Severity: High]
Can this leak kernel heap memory to userspace?

The struct damon_sysfs_scheme is allocated in damon_sysfs_scheme_alloc()
using kmalloc_obj(), which does not zero the memory. The new target_order
field is not initialized during allocation.

If a user reads the sysfs file via target_order_show() before writing to it,
uninitialized kernel heap memory will be exposed.

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
> +	if (val !=3D 0 && (val < 2 || val > HPAGE_PMD_ORDER))

[Severity: Low]
Will this cause a build failure on configurations without huge page support?

When CONFIG_PGTABLE_HAS_HUGE_LEAVES is not set (e.g. both THP and Hugetlb
are disabled), HPAGE_PMD_SHIFT is defined as a statement expression
triggering a BUILD_BUG().

Since CONFIG_DAMON_SYSFS does not depend on huge page support, evaluating
HPAGE_PMD_ORDER unconditionally here will trigger that build error.

[ ... ]
> @@ -3010,6 +3045,16 @@ static struct damos *damon_sysfs_mk_scheme(
>  	if (!scheme)
>  		return NULL;
> =20
> +	if (sysfs_scheme->action =3D=3D DAMOS_COLLAPSE &&
> +	    sysfs_scheme->target_order !=3D 0 &&
> +	    sysfs_scheme->target_order !=3D HPAGE_PMD_ORDER) {

[Severity: Medium]
Is there a Time-of-Check to Time-of-Use race when reading target_order?

damon_sysfs_mk_scheme() builds the kernel internal struct damos object from
the sysfs state while holding damon_sysfs_lock. However, sysfs property
writers like target_order_store() do not acquire damon_sysfs_lock when
modifying sysfs_scheme->target_order.

Because sysfs_scheme->target_order is read multiple times here:

1. To check if it is valid for DAMOS_COLLAPSE.
2. To log a warning if invalid.
3. For final assignment to scheme->target_order below.

A concurrent write could change the value between the checks and the final
assignment, completely bypassing the validation rules.

> +		pr_warn("DAMON collapse: target_order %u not supported, only PMD order=
 (%u) is available. Use 0 or %u.\n",
> +			sysfs_scheme->target_order,
> +			HPAGE_PMD_ORDER, HPAGE_PMD_ORDER);
> +		sysfs_scheme->target_order =3D 0;
> +	}
> +	scheme->target_order =3D sysfs_scheme->target_order;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701114716.5650=
3-1-lianux.mm@gmail.com?part=3D1
