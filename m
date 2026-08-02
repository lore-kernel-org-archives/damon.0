Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1AB324B33
	for <damon@lists.linux.dev>; Sun,  2 Aug 2026 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785697472; cv=none; b=AgSarjKANdizN8K5l8wAqqcRHaV18146ND6614TtGa+1lqSw0UD4PxrQ1JwsniG8IdPXD7V0zc94v2YwAgQGh3NDTdgKOaFR4+tKgfRjT18FVsYAGU7SOTFfHQn2hqKpvsCt+wE00GJ47nRaW0WvZPny6Togg5gVhcp7aX+neUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785697472; c=relaxed/simple;
	bh=t0s56fIwAVfw11BvbrsMXpJ+QMxOjhXDXSvE/gFPobk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kqjbxYabndBlRutOCYD7AAk2kISph420GROWqqQBNiRS62F53m9P1rulX06aqafu8Tjn7jt972mepUQfOV1k31Las5+OpsUqJWTz9fO5ZJm0IB7vSTDiB+s73Js4Y0vyMhC0jpBg7w0ZAx4oQkkUMtRIHW32ZJNxu3gnZdwKqBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEtHloaP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEtHloaP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080611F000E9;
	Sun,  2 Aug 2026 19:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785697471;
	bh=1VBbj4+sd0yb84vuZ/y/0Webgoio/781+TZoRGQ/VZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AEtHloaPkPlRGhpRBmlg1BytZ41I5LGORrGQ73LWsU1PqEAmoP8mOnH4Rr1+xiJOR
	 XIneckP80PM+ypoUmszV0+feIwNEbYOOt9Ki508DDDu1m/GdEM5m6mtjlI1Zvr/gLy
	 7Poiu4NI0ZlfwbtM9CF52l50bkNshrd8dWuofSHS0fMUKLcqDqey5EEomQGQh72GyJ
	 WOzmNGeFV0ze6FL5wj/po2DzQXgFmPLKlWhRQ56/Una9SAU95GbAozOz2uiUND2R5/
	 d6HgD3ggQbBLpx6NJIYAKAKpVdy6ArezuQnLoNP4DLKCfu40+/+DYYNeYXZ/zjKSzv
	 A4zadapPC4toQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] mm/damon/reclaim: skip damon_call() if ctx has
 not started
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260802185430.9940-2-sj@kernel.org>
References: <20260802185430.9940-1-sj@kernel.org>
 <20260802185430.9940-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 19:04:30 +0000
Message-Id: <20260802190431.080611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch fixes =
an indefinite hang in `mm/damon/reclaim.c` when writing to `commit_inputs` =
before the DAMON context starts, while failing to apply the identical fix t=
o `mm/damon/lru_sort.c`. This leaves `damon_lru_sort` vulnerable to the exa=
ct same bug.
--

--- Patch [1]: [RFC PATCH 1/2] mm/damon/reclaim: skip damon_call() if ctx h=
as not started ---
commit 86e90c966d8636445486cfde6487a797b433cb75
Author: SJ Park <sj@kernel.org>

mm/damon/reclaim: skip damon_call() if ctx has not started

This commit addresses an indefinite hang in DAMON reclaim when writing to
commit_inputs before the context has fully started. It introduces a tracking
flag to determine whether the DAMON context has successfully started in ord=
er
to safely skip damon_call().

Cc: <stable@vger.kernel.org> # 7.2.x

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 09e941d75f67d..45d5557cc575a 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
[ ... ]
> @@ -291,11 +293,8 @@ static int damon_reclaim_commit_inputs_store(const c=
har *val,
>  	if (!commit_inputs_request)
>  		return 0;
> =20
> -	/*
> -	 * Skip damon_call() if ctx is not initialized to avoid
> -	 * NULL pointer dereference.
> -	 */
> -	if (!ctx)
> +	/* Skip damon_call() if ctx has not successfully started. */
> +	if (!damon_reclaim_damon_has_started)
>  		return -EINVAL;
> =20
>  	err =3D damon_call(ctx, &control);

[Severity: High]
This isn't a bug introduced by this patch, but does the same vulnerability
exist in mm/damon/lru_sort.c?

It looks like damon_lru_sort_commit_inputs_store() uses the exact same
logic that was fixed here in reclaim.c:

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

If a user writes to commit_inputs for damon_lru_sort before the thread has
started, could damon_call() blindly invoke wait_for_completion() and hang
indefinitely without a running thread to signal it?

Should a similar fix be applied to mm/damon/lru_sort.c to prevent a task
from hanging in an uninterruptible sleep state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802185430.9940=
-1-sj@kernel.org?part=3D1
