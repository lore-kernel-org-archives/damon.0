Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C44255F2C
	for <damon@lists.linux.dev>; Fri, 22 May 2026 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469932; cv=none; b=Gh1Cseo0pT1XXiAjL1/LjFRbeAHAYBl5UM5gpCzezWyFjZ+rlOw5tOJEp5eQMyctlhdeGxOB/fFfntFxjsP8cT7/LZhFP5Dv+AB/ZujTA9Y3MTHkgB7rPQ5nZcPkfqt+M/mBAKc2/iV42Pxy3L/GhTuoz8jD20E37+6lUose8lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469932; c=relaxed/simple;
	bh=6fUTFkQpyDBJ6XSBD5LR4LIRf7yKNt/57K6BKlF+qQg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uSTE2xaCT5+/PKLXooOFAMunxnryq/RQrbZH/YHVRzQ7pxU7Hmt7+6VaAWzRckfJkaUeORiO/97dtMKXft769wETv5eIGooK2evkhYwP1nawvvFukIEyChU5YzcvwQYoAgojsQR1Ab4vwURG/uQXWMA3IWvK9dM4MWVD9ooLjKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YokPGXCY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YokPGXCY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900B11F00A3D;
	Fri, 22 May 2026 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779469930;
	bh=wK8TwtwoAtMUxBO2Bws81qZIGAPPS0hl6tCTIOCBRWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YokPGXCYisGYp6097lr42l5H2twBoHX6xGuc+cHJrcv9Cf7J5qBBCgXeIVgpy8GM8
	 BNLxFbNN8GnuLRc84jpGb8e5nhphW9hJZYc1mbf6AhCC+MrMLZC4LXNCxnUF+uWTQ0
	 +W5l7qXexUXtT/2AmXBoTW8KWTixLtDAU4925l4vuaagyjhWGZ/1YD2saq6OxQqG5B
	 /8L4y0Tw705rxIFQPnLnMUCn/rwccywwd/VEclshQXUeI5G7iMVCPMKAgEAsJu6oWt
	 /YZmfnOHEU/xG1yWzwbFJtocMv0MLbGhpaS8wLiPJ4y6taAl8RKtEEXY7AQwv4XjcC
	 tuivyIJGJ2TxQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/4] mm/damon: introduce DAMON_HUGEPAGE for hot
 region hugepage collapsing
Reply-To: sashiko-reviews@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260522145518.158910-4-gutierrez.asier@huawei-partners.com>
References: <20260522145518.158910-4-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 17:12:10 +0000
Message-Id: <20260522171210.900B11F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] Writing to the `enabled` sysfs parameter after `damon_hugepage_ini=
t()` fails causes an unconditional NULL pointer dereference.
- [High] A concurrent sysfs write can set `aggr_interval` to 0 after it was=
 checked, causing a divide-by-zero kernel panic.
- [High] The `enabled` sysfs parameter becomes permanently stale if the mon=
itored process terminates, locking out users.
- [High] Missing `is_power_of_2()` check for `min_region_sz` causes silent =
daemon termination and sysfs lockout.
- [Medium] The `monitored_pid` parameter is interpreted in different PID na=
mespaces depending on the triggering mechanism.
- [Low] The `monitored_pid` variable is defined as a `long` but exported as=
 an `unsigned long` via `module_param`.
- [Low] The default value of `min_age` does not match the module's document=
ation comment.
- [Low] Memory allocated for the global DAMON context and target structures=
 is leaked if module initialization fails.
--

commit 9a01dc3d39519d9465c7f43f62e4bda67ccf751a
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing

This patch introduces a new DAMON module (DAMON_HUGEPAGE) which
collapses hot regions into huge pages.

> diff --git a/mm/damon/hugepage.c b/mm/damon/hugepage.c
> new file mode 100644
> index 0000000000000..f7ca3a409f59c
> --- /dev/null
> +++ b/mm/damon/hugepage.c

[ ... ]

> +static long monitored_pid;
> +module_param(monitored_pid, ulong, 0600);

[Severity: Low]
Is this intentional to declare monitored_pid as a long but export it via
module_param as an unsigned long? Both the declaration and the sysfs
parameter type should be consistent.

> +
> +/*
> + * Time threshold for hot memory regions identification in microseconds.
> + *
> + * If a memory region has been accessed for this or longer time,
> + * DAMON_HUGEPAGE identifies the region as hot, and collapse it into a h=
uge
> + * page.  100 microseconds by default.
> + */
> +static unsigned long min_age __read_mostly =3D 100000;

[Severity: Low]
Does the comment match the default value here? The comment explicitly
states 100 microseconds by default, but the variable is initialized to
100000, which translates to 100 milliseconds since DAMON time parameters
are handled in microseconds.

[ ... ]

> +static struct damos *damon_hugepage_new_scheme(void)
> +{
> +	struct damos_access_pattern pattern =3D {
> +		/* Find regions having PMD_SIZE or larger size */
> +		.min_sz_region =3D PMD_SIZE,
> +		.max_sz_region =3D ULONG_MAX,
> +		.min_nr_accesses =3D 0,
> +		.max_nr_accesses =3D UINT_MAX,
> +		.min_age_region =3D min_age /
> +			damon_hugepage_mon_attrs.aggr_interval,

[Severity: High]
Could a concurrent sysfs write set aggr_interval to 0 here?

While aggr_interval is checked for zero in damon_hugepage_apply_parameters(=
),
it is exposed via module_param_named and can be modified concurrently by ro=
ot.

If a write occurs between the check and this division, could it result in
an unhandled division by zero kernel panic?

> +		.max_age_region =3D UINT_MAX,
> +	};

[ ... ]

> +static int damon_hugepage_apply_parameters(void)
> +{
> +	struct damon_ctx *param_ctx;
> +	struct damon_target *param_target;
> +	struct damos *scheme;
> +	struct damos_quota_goal *goal;
> +	struct pid *spid;
> +	int err;
> +
> +	err =3D damon_modules_new_vaddr_ctx_target(&param_ctx, &param_target);
> +	if (err)
> +		return err;
> +
> +	param_ctx->addr_unit =3D addr_unit;
> +	param_ctx->min_region_sz =3D max(DAMON_MIN_REGION_SZ / addr_unit, 1);

[Severity: High]
Should we check if min_region_sz is a power of two here?

If addr_unit is set via sysfs such that this calculation yields a
non-power-of-two value (e.g., 3), damon_commit_ctx() will return -EINVAL.

Before returning, damon_commit_ctx() sets dst->maybe_corrupted =3D true,
which flags the running ctx as corrupted and causes the kdamond thread
to silently terminate. This leads to the enabled sysfs parameter getting
stuck permanently.

> +
> +	spid =3D find_get_pid(monitored_pid);

[Severity: Medium]
Will this resolve the PID in different namespaces depending on how the
update is triggered?

When a user writes to the 'enabled' parameter, find_get_pid() executes in
the user's process context using the user's PID namespace.

When a user writes to 'commit_inputs', the application is handled
asynchronously by damon_hugepage_damon_call_fn() inside the kdamond kernel
thread, which operates in the root (init) PID namespace.

This means the same monitored_pid value could be interpreted as different
processes depending on which sysfs parameter triggered the update.

> +	if (!spid) {
> +		err =3D -EINVAL;
> +		goto out;
> +	}

[ ... ]

> +static int damon_hugepage_enabled_store(const char *val,
> +				const struct kernel_param *kp)
> +{
> +	bool is_enabled =3D enabled;
> +	bool enable;
> +	int err;
> +
> +	err =3D kstrtobool(val, &enable);
> +	if (err)
> +		return err;
> +
> +	if (is_enabled =3D=3D enable)
> +		return 0;
> +
> +	/* Called before init function.  The function will handle this. */
> +	if (!damon_initialized())
> +		goto set_param_out;
> +
> +	err =3D damon_hugepage_turn(enable);

[Severity: High]
Can this unconditionally dereference a NULL pointer if module initialization
fails?

If damon_hugepage_init() fails (e.g., memory allocation fails in
damon_modules_new_vaddr_ctx_target()), the global ctx pointer remains NULL.
Because DAMON_HUGEPAGE is a built-in module, its sysfs parameters are
still accessible.

A subsequent write of 'Y' to 'enabled' invokes damon_hugepage_turn(true),
which calls damon_hugepage_apply_parameters(), leading to:

damon_commit_ctx(ctx, param_ctx)
    dst->maybe_corrupted =3D true;

Since dst is the global ctx pointer which is NULL, this will cause an
immediate kernel panic.

[Severity: High]
Could the 'enabled' sysfs parameter become permanently stale here?

If the monitored target process exits, the kdamond thread detects the inval=
id
target, stops, and clears ctx->kdamond, but the global 'enabled' parameter
remains true.

If a user attempts to restart monitoring by writing 'N' to 'enabled',
damon_hugepage_turn(false) calls damon_stop(), which eventually calls
__damon_stop(). Since ctx->kdamond is NULL, __damon_stop() returns -EPERM.

The store function receives this error and aborts without setting
enabled =3D false. Subsequent writes of 'Y' return immediately because
is_enabled =3D=3D enable is true. This permanently locks the sysfs interfac=
e.

> +	if (err)
> +		return err;
> +
> +set_param_out:
> +	enabled =3D enable;
> +	return err;
> +}

[ ... ]

> +static int __init damon_hugepage_init(void)
> +{
> +	int err;
> +
> +	if (!damon_initialized()) {
> +		err =3D -ENOMEM;
> +		goto out;
> +	}
> +	err =3D damon_modules_new_vaddr_ctx_target(&ctx, &target);
> +	if (err)
> +		goto out;
> +
> +	call_control.data =3D ctx;
> +
> +	/* 'enabled' has set before this function, probably via command line */
> +	if (enabled)
> +		err =3D damon_hugepage_turn(true);
> +
> +out:
> +	if (err && enabled)
> +		enabled =3D false;
> +	return err;

[Severity: Low]
Does this leak the allocated ctx and target structures if initialization fa=
ils?

If the module is enabled by default via boot parameters, and
damon_hugepage_turn(true) fails, the function returns an error without
freeing the memory dynamically allocated by
damon_modules_new_vaddr_ctx_target() for ctx and target.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522145518.1589=
10-1-gutierrez.asier@huawei-partners.com?part=3D3
