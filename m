Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170063749EB
	for <damon@lists.linux.dev>; Thu, 13 Aug 2026 04:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593877; cv=none; b=BbMAJlPRKjguahqY2NRQdl+NYi0NiCr3euBrfcOrr25g7pbpPf476IKBUXxWUHhaIcrin7ASfkUJe8fax/ZbBPz4wcknxnhEJ+ZL+EoAmLqWOMQhJyukaGzKgKmFM02YiVKl3l+oE0WkKlelzMjWNI9zej9ELFCcJrzgGY3qX98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593877; c=relaxed/simple;
	bh=4UUXpT+MjAeeCw37Hvltue7LfuMT46Yqrgb/UTD6aQw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=duZmRyTITe129yPToQEtHvw0lqSQwUKgSGJw2LRwrfFA4a8qk6bnPNBCm5FjD9suYRrfDcMYYhmtAl5cKVBeL+JZqnCCHxdE9ax9mlH8dYQaYih7+plto9MC3zFeMQXUmnTVaLKzcBW4v1DHSdbqTmxd27ImEBArc/9iNy41gL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMBOdeRp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMBOdeRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13F21F000E9;
	Thu, 13 Aug 2026 04:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786593876;
	bh=yP6UTok0iAvzz9YGfT73iriNT1763hRL79tsxmh/jOM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HMBOdeRpzNDUiMFQM6qnWM4kUH2KGTwemTWVZOfiMXbT2EJtaunXL03GdCLH/YXl6
	 PYODR3YrWPefKdUA9+sdUOrfZg3hThRdgxaQmtdBq+ZKQz4XUdzB+Ni04b0307jV12
	 btTvxy5rt1wy6Y+1zyR2iXv+0pph25FMLXVnS7a+K/rcroNCRuL0rLsP/ZsJ6VbLHb
	 rRGHjXCHRYZLFEda34terq1svkmLJSOlefqqv2gjMFD98nY63JIIO3dDNU2iYiXzJQ
	 KoNhGvhRcEU3qQRRDN42aR2mvowO23vRC2lT9sYGE/bytZA8mjEQfRQ0FxFjFoTxXk
	 kNzFX7mh689Iw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/4] mm/damon/lru_sort: remove unnecessary
 damon_call() param validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260813035001.97364-5-sj@kernel.org>
References: <20260813035001.97364-1-sj@kernel.org>
 <20260813035001.97364-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 04:04:35 +0000
Message-Id: <20260813040435.C13F21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the `damon_lru_sort_damon_has_started` check exposes a ra=
ce condition causing an infinite loop in `damon_call()` when invoked concur=
rently during kdamond startup.
--

--- Patch [4]: [RFC PATCH 4/4] mm/damon/lru_sort: remove unnecessary damon_=
call() param validation ---
commit 288d310b5c3c2bd758d5db8eef7c717db03cbd01
Author: SJ Park <sj@kernel.org>

mm/damon/lru_sort: remove unnecessary damon_call() param validation

This commit removes custom validation in damon_lru_sort_commit_inputs_store
that checked if the damon context had successfully started before calling
damon_call. The commit message states this is safe because the damon core
layer now handles these corner cases.

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index bd847829a9907..f25ee7326e87c 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
[ ... ]
> @@ -368,10 +366,6 @@ static int damon_lru_sort_commit_inputs_store(const =
char *val,
>  	if (!commit_inputs_request)
>  		return 0;
> =20
> -	/* Skip damon_call() if ctx has not successfully started. */
> -	if (!damon_lru_sort_damon_has_started)
> -		return -EINVAL;
> -
>  	err =3D damon_call(ctx, &control);

[Severity: High]
Does removing this safeguard expose a race condition causing an infinite
loop in damon_call when invoked concurrently during kdamond startup?

If a user writes to the enabled sysfs file to start the daemon, and
concurrently writes to commit_inputs, damon_call can execute while
damon_start is waiting for kdamond to fully initialize.

In this scenario, damon_call could read ctx->call_controls_obsolete =3D=3D =
true
(since the kdamond thread hasn't cleared it yet) and jump to the canceled
path:

mm/damon/core.c:damon_call() {
    ...
canceled:
	while (damon_is_running(ctx))
		schedule_timeout_idle(msecs_to_jiffies(100));
	return -ECANCELED;
}

Because the daemon thread has already been spawned and assigned, making
damon_is_running persistently true, won't this loop indefinitely, hanging
the sysfs writer process?

> =20
>  	return err ? err : control.return_code;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813035001.9736=
4-1-sj@kernel.org?part=3D4
