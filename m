Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BEA356746
	for <damon@lists.linux.dev>; Thu,  4 Jun 2026 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587699; cv=none; b=rnZvBiJKcO19Md5WH1LWw2qYZGEWGm5MpoMKNV3O2AhsxiIpQjmOkj4Q/ojiR8iW8l2lzej2ZseD0YOXfNOY+oFYj60F4TajnN/KN/+fedNEoQWtrQcm2u28ZfcBtF7vA1gKR3v+GOdTVImcoto+OCtcSPm8GAZDoAIXYLp0JB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587699; c=relaxed/simple;
	bh=RTnkB7ssv2velEHQ8tB83N5XPRWG3Vq16XfCgIocp7I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sMG8gXv5eNnvnMHvDPPrHWFge6xECvT7GUX/4czDvhyS/eh+Ow6LcxaY+JBmS/ZOxtyzkDxFvJxP6EKAJeIb+3cy6a7FIlodDdPbnsIrcIUtPD8jtrOG9L56ThtzSQ8cKK7p4K/nV14OkaDoDAN4xsA7SyeFgxtF2bRDCNMRWP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yfg7AvZD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yfg7AvZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4EE1F00893;
	Thu,  4 Jun 2026 15:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780587697;
	bh=K+/8fk4pxDabb2oMa4bNmPyf71DSrsHEDjigpem1mr0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yfg7AvZDTka7l2c6UjV1xcKbIx4kAruyhYaIi7dpgcwqJm+jRVy3gotfG+rgIfCga
	 c0A03fBmbJEQjAmbIhIgYb46uxqWzL23q6aOcvqj91T8tirHk/kni4+JzLTGAR81Nt
	 CO8VSeoV0hb+NPIfsCWaxJr7hjcL5NOCdUvaKgIeqjoHYkV5XTntqcbHpA13qlVoL1
	 iJ3wwDKkYtY+IGKLWX1GMZ0dUA0W1q+F+go8K/ubTIENsYo7owYOzSMEWl3JAnGURn
	 apevCmnHlVyORExblHZIH4Zl0qmuS+pyfrduLd0mfCkl+fJbfxLJ1PxPEmyYjRMgVA
	 rOzwuoA2kaiHg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 3/4] mm/damon: introduce DAMON_HUGEPAGE for hot
 region hugepage collapsing
Reply-To: sashiko-reviews@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260604150338.501128-4-gutierrez.asier@huawei-partners.com>
References: <20260604150338.501128-4-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 15:41:36 +0000
Message-Id: <20260604154137.2E4EE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] A Time-of-Check to Time-of-Use (TOCTOU) race condition in damon_hu=
gepage_apply_parameters() can lead to a division by zero kernel panic.
- [High] Writing to the enabled sysfs node or passing it as a load paramete=
r before module_init finishes causes an immediate NULL pointer dereference.
- [High] The sysfs parameter addr_unit can be set to ULONG_MAX, leading to =
an integer overflow in the ALIGN macro and a division by zero kernel panic.
- [Medium] Misuse of ALIGN() produces a non-power-of-two min_region_sz, sil=
ently breaking the monitoring daemon.
- [Low] The addr_unit module parameter is exposed and documented for addres=
s translation, but is entirely ignored by VADDR operations.
--

commit 3617a4956285835faa63e992e7cc7a6aa7cb4d8d
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing

This patch introduces a new DAMON module (SAMPLE_DAMON_HUGEPAGE)
which collapses hot regions into huge pages.

SAMPLE_DAMON_HUGEPAGE operates in the virtual memory space, for a
specific task. The user is expected to supply the PID of the task
that is going to be monitored through the monitored_pid module
variable.

SAMPLE_DAMON_HUGEPAGE uses the hugepage auto-tune mechanism to
increase or decrease the aggressiveness of page collapsing. User
autotuning is also available for additional tuning aggressiveness
control.

The module also includes changes to the DAMON compilation, so that
the module can be enabled or disabled.

> diff --git a/samples/damon/hugepage.c b/samples/damon/hugepage.c
> new file mode 100644
> --- /dev/null
> +++ b/samples/damon/hugepage.c
> @@ -0,0 +1,350 @@
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
Since damon_hugepage_mon_attrs.aggr_interval is a module parameter that can=
 be
modified concurrently without locks, could it be set to zero exactly between
the zero-check in damon_hugepage_apply_parameters() and this division?

If a privileged user writes 0 to the sysfs node in that time window, it wou=
ld
trigger a division by zero kernel panic.

> +		.max_age_region =3D UINT_MAX,
> +	};
> +
> +	return damon_new_scheme(
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
> +    // align power of two
> +	param_ctx->min_region_sz =3D max(DAMON_MIN_REGION_SZ / ALIGN(addr_unit,=
 2), 1);

[Severity: High]
Does this ALIGN() macro expose us to an integer overflow if a user sets
addr_unit to ULONG_MAX?

The macro adds (2 - 1) before masking, which would overflow ULONG_MAX to 0,
making the evaluation 0. This leads to a division by zero panic on
DAMON_MIN_REGION_SZ / 0.

[Severity: Medium]
Will this ALIGN(addr_unit, 2) calculation produce a non-power-of-two result
if addr_unit is set to a value like 6?

ALIGN(6, 2) evaluates to 6, and damon_commit_ctx() strictly requires
min_region_sz to be a power of two. If it isn't, damon_commit_ctx()
returns -EINVAL and flags the context as maybe_corrupted, which silently
terminates the kdamond background thread.

Should this use roundup_pow_of_two() instead?

> +
> +	spid =3D find_get_pid(monitored_pid);
[ ... ]
> +static const struct kernel_param_ops addr_unit_param_ops =3D {
> +	.set =3D damon_hugepage_addr_unit_store,
> +	.get =3D param_get_ulong,
> +};
> +
> +module_param_cb(addr_unit, &addr_unit_param_ops, &addr_unit, 0600);
> +MODULE_PARM_DESC(addr_unit,
> +	"Scale factor for DAMON_HUGEPAGE to ops address conversion (default: 1)=
");

[Severity: Low]
Is this parameter accurately described for VADDR operations?

The DAMON core explicitly ignores addr_unit for VADDR operations. Exposing
this parameter does not scale addresses as documented, but it does improper=
ly
shrink the byte-granularity of min_region_sz, creating a misleading user AP=
I.

> +
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
> +	/* Monitored process may have exited. In that case, ctx->kdamon is set =
*/
> +	/* to NULL. If enabled is set to 'off' through sysfs, we just set the  =
*/
> +	/* params and exit */
> +	if (!damon_is_running(ctx) && !enable)

[Severity: High]
Can this crash on boot or module load?

If the parameter damon_hugepage.enabled=3DY is passed at boot or module loa=
d,
this store callback executes before the module's init function runs. Because
the init function hasn't run, the global ctx pointer is NULL here.

The left-hand side of the condition calls damon_is_running(ctx), which
unconditionally dereferences the NULL pointer at mutex_lock(&ctx->kdamond_l=
ock),
causing a kernel panic.

> +		goto set_param_out;
> +
> +	/* Called before init function.  The function will handle this. */
> +	if (!damon_initialized())
> +		goto set_param_out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604150338.5011=
28-1-gutierrez.asier@huawei-partners.com?part=3D3
