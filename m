Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25952C21F0
	for <damon@lists.linux.dev>; Thu, 13 Aug 2026 04:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593702; cv=none; b=T5B+48RprsKXLBom5KKOzkfezKhRiv2n/olIaxbJRP/7xsy1kaJ5ELq5nRhXJ26ywjv74g8QO+5OhR6t9rbtYLamHGh1+YhV4Bc5n2D8g86SMRzINNPimdfefWvv5pBrjEWzf4yIgNrWmsxgQngAbja7xXYJhuTSt3l1rxmjXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593702; c=relaxed/simple;
	bh=Sy5JTTduICdJUODaddV1j9CWH9r0kGO9Eq9MJgKeJII=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lvL0Xh3VRKVme83upKmE3ZdJIiMQw7lMnpPfQK1x+tQlM1s/wgy+hA4kS9zLa9bKTOtqvHOm3Ech6SMDnODyy/UVCCBRuCle0tfUgD8YvHeFBuwjHZm/GnKH+vk1Vr9KhCHX/YLxlKf4izuc3tWSwNPiMcVtAz8/6uc3UtUG/Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuzapOMr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuzapOMr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A72A1F000E9;
	Thu, 13 Aug 2026 04:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786593701;
	bh=ABEaF/CeF/eU8iRrhhDO06clHOjLXjxZ8kBCqPjNGbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OuzapOMrPA7TDBwj+DDXHx5Eo9DiHaNNlO7O9HqzFxjw3wiTKV+J6aZ5BpNA6Q2QE
	 FPiq/TcPi01Wvv513VNmUaua2bzhk2nvpOh2giGdhQlDSossdKMLQ6WT4q/jh6pcv8
	 n2c9VihM4JG3CobYmBITGXu5kFJdqtm3r1hF2O6VmNZDFFWGEYDZEuk1kbXiAWvWho
	 94KTvgF1gzzNqrIu9xku6Dhhkb5fXiPvJlwH1KkejNWH0aRvNkHAg4pemwkPgKlBii
	 QqHnweurFZXzKmPRNeYmKjGa/u8mzicA8A+VZDRF7UZlUPC89UEusuMSZ/8hDIAfO1
	 t7Fk+4+LmQUnQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/4] mm/damon/reclaim: remove unnecessary
 damon_call() param validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260813035001.97364-4-sj@kernel.org>
References: <20260813035001.97364-1-sj@kernel.org>
 <20260813035001.97364-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 04:01:40 +0000
Message-Id: <20260813040141.2A72A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent invocation of `damon_call()` during kthread startup lea=
ds to an infinite kernel loop.
--

--- Patch [3]: [RFC PATCH 3/4] mm/damon/reclaim: remove unnecessary damon_c=
all() param validation ---
commit 07f6c5438f6069b0b8225e26e3726d6aa4e3da09
Author: SJ Park <sj@kernel.org>

mm/damon/reclaim: remove unnecessary damon_call() param validation

DAMON_RECLAIM avoids passing NULL or unstarted damon_ctx to damon_call()
with its own validation. The validation is no longer needed, because
the DAMON core layer now handles the corner cases itself. Remove the
unnecessary check.

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 45d5557cc575a..42a2c9cb13431 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
[ ... ]
> @@ -293,10 +291,6 @@ static int damon_reclaim_commit_inputs_store(const c=
har *val,
>  	if (!commit_inputs_request)
>  		return 0;
> =20
> -	/* Skip damon_call() if ctx has not successfully started. */
> -	if (!damon_reclaim_damon_has_started)
> -		return -EINVAL;
> -

[Severity: High]
This is a pre-existing issue, but does removing this validation expose an
infinite loop in the DAMON core?

If userspace writes to this sysfs file concurrently with damon_start(),
damon_call() in mm/damon/core.c can hit a race condition. The core
initializes ctx->call_controls_obsolete to true. If damon_call() runs
before the kthread fully starts, it can read call_controls_obsolete =3D=3D =
true
and jump to the canceled label:

mm/damon/core.c:damon_call() {
    ...
    if (ctx->call_controls_obsolete) {
        mutex_unlock(&ctx->call_controls_lock);
        goto canceled;
    }
    ...
canceled:
    while (damon_is_running(ctx))
        schedule_timeout_idle(msecs_to_jiffies(100));
    return -ECANCELED;
}

If damon_start() concurrently sets ctx->kdamond to non-NULL,
damon_is_running(ctx) becomes true. Because the kthread has just started,
it runs indefinitely, and damon_call() gets trapped in the while loop
forever.

>  	err =3D damon_call(ctx, &control);
> =20
>  	return err ? err : control.return_code;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813035001.9736=
4-1-sj@kernel.org?part=3D3
