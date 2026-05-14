Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5571EEA3C
	for <damon@lists.linux.dev>; Thu, 14 May 2026 02:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778725046; cv=none; b=klUdb4+FJJsOo+8zakpYPm34Jw+SCayvTUzInsRWEt/r5/I8Gs/qQtMwEBWa623koY3n/hKaqqu4L18Q+HWlVPwgzJnHU1C8PTfwE7OZYeM65DlypgWOCz0YGc8FHNInyE2CPmd/wxtQJdqkg+BRI1fMFvyxiPGLI3tzmHldYP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778725046; c=relaxed/simple;
	bh=Gbbb9rwZriCTSJqISObuUqTDZR27meln9U90fO7tcwk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y4sqDrbcLxCo6E4B2vcpp+bwo0nZylluC8B/89r5FBkevmeJjuKt/bS3ODFH4UMi+AQUYCeEzK9wZfpHruVhmxhXsrHE+DiT2HS8Gb8YJmlRu8ko96ikQwSDw+qSYhUEel8oqqOIjZ+BsxD74YY8N5nYI8uht+VrZ2JNCTogD5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwoNo5gH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwoNo5gH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2801FC19425;
	Thu, 14 May 2026 02:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778725045;
	bh=Gbbb9rwZriCTSJqISObuUqTDZR27meln9U90fO7tcwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WwoNo5gHBTktokaeumLlDDenz9dW5bvYXdzeJ2yfuESqPXK3W11YuvNM13IgwcAcA
	 a9VNdZ0yudKcDV2jtGyBXh/hUSyOkuoZoZP2aQHZnjQfEDLVvd/9aGMhyucseujjuS
	 9HevWLz08JRnAn5zXCKPO1+vo18paaZsm+Oz2x7zJSZykYv0qA101cFp8sQBWh1w3I
	 nGyDVw1Hs3EjsGBQr4ipWFHCIKJTwo+k6N782xklVaGTM8g6U7TOTFlhR/6dRX2Xof
	 HMFBwBq0b7SioMsG2G+iJRuxx+VtMh67FECqV5w6gsNeBVQFAtnOTGKOgP3t8AWXye
	 fAKgpUYC8/0Tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y] mm/damon/reclaim: detect and use fresh enabled
 and kdamond_pid values
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260513050501.216835-1-sj@kernel.org>
References: <20260513050501.216835-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 02:17:24 +0000
Message-Id: <20260514021725.2801FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch fails to fix the state machine deadlock that prevents kd=
amond from restarting, leaving the bug described in the commit message unre=
solved.
- [Low] The patch introduces calls to undefined functions `damon_is_running=
()` and `damon_kdamond_pid()`, causing a build failure.
--

commit de09cefa1bba6b569eff518a49dbc5fb07b59452
Author: SeongJae Park <sj@kernel.org>

mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values

This patch updates DAMON_RECLAIM to dynamically detect the status of the
enabled and kdamond_pid parameters. It aims to prevent users from seeing
stale status values and being unable to restart the kdamond thread when
it stops unintentionally.

Link: https://lore.kernel.org/20260419161003.79176-1-sj@kernel.org
Link: https://lore.kernel.org/20260419161003.79176-2-sj@kernel.org

>     For example, the issue can be reproduced via below steps.
[ ... ]
>     # # even after fixing the wrong parameter,
>     # # kdamond cannot be restarted.
>     # echo 1 > addr_unit
>     # echo Y > enabled
>     # ps -ef | grep kdamond
>     root         815     803  0 17:54 pts/4    00:00:00 grep kdamond

Does this patch actually resolve the restart issue described here?=20

Looking at damon_reclaim_timer_fn(), the state machine still appears to
deadlock if kdamond stops unintentionally:

	now_enabled =3D enabled;
	if (last_enabled !=3D now_enabled) {
		if (!damon_reclaim_turn(now_enabled))
			last_enabled =3D now_enabled;
		else
			enabled =3D last_enabled;
	}

When kdamond dies, the global enabled and static last_enabled variables
remain true.

If a user writes 'Y' to enabled, the timer sees last_enabled =3D=3D now_ena=
bled
(true =3D=3D true) and exits without restarting kdamond.

If a user writes 'N' to enabled, the timer calls damon_reclaim_turn(false),
which invokes damon_stop(). Since the thread is already dead, damon_stop()
returns -EPERM. The timer misinterprets this as a failure to stop and
executes enabled =3D last_enabled, reverting enabled back to true.=20

Could this leave the state machine permanently deadlocked?

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 7952a0b7f409d..dc435aefd44f5 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
[ ... ]
> @@ -220,6 +203,13 @@ static DECLARE_DELAYED_WORK(damon_reclaim_timer, dam=
on_reclaim_timer_fn);
> =20
>  static bool damon_reclaim_initialized;
> =20
> +static bool damon_reclaim_enabled(void)
> +{
> +	if (!ctx)
> +		return false;
> +	return damon_is_running(ctx);

Are damon_is_running() and damon_kdamond_pid() defined anywhere in the tree?

They don't appear to be declared in include/linux/damon.h or defined in
mm/damon/core.c.

Could this patch depend on prerequisite patches that might be missing?
Without them, this causes implicit function declaration errors and
unresolved symbol linker errors.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513050501.2168=
35-1-sj@kernel.org?part=3D1
