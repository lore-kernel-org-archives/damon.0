Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29B73B47D2
	for <damon@lists.linux.dev>; Sun,  2 Aug 2026 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688614; cv=none; b=FHTadQKDCqYYjkYJe5dYRDZYEcJ/U1xwp2ucvQ4TwJwWrmn0aztUGfiG0uXIEPI3lPgcMMchFtXSUxpSnbgLNfKQ5DORlZGoQKxVh/4S06vjn+K+xH2O2aQckSVWViTKT8VoICOzdf5lVjipcfYxlTFk3yZW/VruGA9YWZ0V3pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688614; c=relaxed/simple;
	bh=s/JF850rjsg1oB+Xzc84ZnSyUPB3mQTLsf00ltE/RDw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cu81k1ZOPArETdiGheFvynGS8t8A+0/xNTD/tbu2IPsE6xFxM4PnxMkmMOKYDm5eL2SZDgC6mjcpWuw+8C1L5U9rd09d2ZbOxoCmnNlEAkeYOfehZmS/a/QFVg2Qp0X13BG98vrQpSnSMQPSSYOignCMkqWTesYXmRYI/57u7tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/kjsreL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/kjsreL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5DF1F000E9;
	Sun,  2 Aug 2026 16:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785688612;
	bh=HWKbLs56QUYZkFQWLwUwUmv9VS27U0jNGii/I8JWtDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b/kjsreLckYp5yLUJKwTO9lmURPdB4XqHgsHFvgSDFlhRmTgy8/U2emBOnzpio/da
	 hesDS+En+usbQT9YjeVkkRYp4z9C1SJsLBafRYm38/CMvY0oVHbIRPIAyaLSxDuGDM
	 jqfG4cPG6h5F/Yh42m6rYbh0q5XOzZ1d6qe6jjsKyM1AnmHwF7SzzygBP3vv/4wZ1K
	 YEC9i3TCbJmd9HboiQIo2+kAtgwSujEVVzWKDUnBUQ98YMuNbsoiUdkonz1KHTSjMm
	 BYZQrCxRT9zhXPRgcTLw5z8/PIv4AXZVFt/vnS7CbFJrGqsgjZyfiVTHOVosNCTHC0
	 ykUHpkpflVUmw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/2] mm/damon/lru_sort: error out for >10000
 active_mem_bp
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260802162050.89477-3-sj@kernel.org>
References: <20260802162050.89477-1-sj@kernel.org>
 <20260802162050.89477-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 16:36:51 +0000
Message-Id: <20260802163652.4C5DF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The newly added validation check for `active_mem_bp` can be bypass=
ed via a Time-Of-Check to Time-Of-Use (TOCTOU) race condition, resulting in=
 division by zero.

Pre-existing issues:
- [High] The function `damos_get_in_active_mem_bp()` triggers a division by=
 zero if the system tracks no active or inactive LRU pages.
- [High] Writing to the `commit_inputs` module parameter while DAMON is ini=
tialized but not running indefinitely suspends the writing process.
--

--- Patch [2]: [RFC PATCH v2 2/2] mm/damon/lru_sort: error out for >10000 a=
ctive_mem_bp ---
commit e683bbcbac1ca0611d9909a3bb95074271d3aa04
Author: SJ Park <sj@kernel.org>

mm/damon/lru_sort: error out for >10000 active_mem_bp

damos_quota_score() can trigger division by zero if the target value is
zero.  DAMON_LRU_SORT lets users set the target value for the hot memory
scheme via active_mem_bp parameter.  It avoids setting it as the target
value if the parameter value is zero.  However, it also sets the cold
memory scheme with a target value that is calculated as '10000 -
active_mem_bp + 2'.  Hence, if a user sets active_mem_bp 10002, the cold
memory scheme's quota goal target value can be zero.  As a result,
division by zero can be triggered.  Fix by returning an error when the
user tries to start DAMON with >10000 active_mem_bp parameter value.

Link: https://lore.kernel.org/20260801213028.5127-1-sj@kernel.org

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 7e077084cb03a..3920d5042f109 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -233,6 +233,8 @@ static int damon_lru_sort_add_quota_goals(struct damo=
s *hot_scheme,
> =20
>  	if (!active_mem_bp)
>  		return 0;
> +	if (10000 < active_mem_bp)
> +		return -EINVAL;
>  	goal =3D damos_new_quota_goal(DAMOS_QUOTA_ACTIVE_MEM_BP, active_mem_bp);

[Severity: High]
Since active_mem_bp is a global module parameter, can its value change betw=
een
the bounds check and the call to damos_new_quota_goal()?

If a concurrent write updates active_mem_bp to 10002 immediately after the
check completes, the cold memory scheme's quota goal target value could sti=
ll
end up being zero, resulting in the division by zero this patch aims to
prevent.

Would caching the value locally with READ_ONCE() avoid this race?

>  	if (!goal)
>  		return -ENOMEM;

While reviewing this code, I also noticed a couple of pre-existing issues.

This isn't a bug introduced by this patch, but in mm/damon/core.c:

mm/damon/core.c:damos_get_in_active_mem_bp() {
    ...
	active =3D global_node_page_state(NR_LRU_BASE + LRU_ACTIVE_ANON) +
		global_node_page_state(NR_LRU_BASE + LRU_ACTIVE_FILE);
	inactive =3D global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_ANON) +
		global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_FILE);
	total =3D active + inactive;
	if (active_ratio)
		return mult_frac(active, 10000, total);
	return mult_frac(inactive, 10000, total);
}

[Severity: High]
Can mult_frac() trigger a division by zero if total is 0?

If the system tracks no active or inactive LRU pages, or if per-CPU counter
drifts clamp the global state to 0, total will evaluate to 0 and be used as
the denominator.


This is also a pre-existing issue, but in mm/damon/lru_sort.c:

mm/damon/lru_sort.c:damon_lru_sort_commit_inputs_store() {
    ...
	/*
	 * Skip damon_call() if ctx is not initialized to avoid
	 * NULL pointer dereference.
	 */
	if (!ctx)
		return -EINVAL;

	err =3D damon_call(ctx, &control);
    ...
}

[Severity: High]
Does damon_call() require the kdamond thread to be actively running?

If the module is initialized but DAMON has not been enabled, it appears
damon_call() will queue the request and wait indefinitely on a completion
that will never be signaled by the stopped thread, causing the writing
process to hang in an uninterruptible sleep state.

Could we check damon_is_running(ctx) before calling damon_call()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802162050.8947=
7-1-sj@kernel.org?part=3D2
