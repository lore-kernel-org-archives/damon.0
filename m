Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDBB30566D
	for <damon@lists.linux.dev>; Mon,  3 Aug 2026 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766003; cv=none; b=Fssou1t/th3dHolaHkX9YwhzlRWhYzyr0Znmb4wo8Spfhb5Dgpt+jYztAqZqDThQzv8CmKhJ6XfdN6ro/BBm6tS7l1BspB238d2mj+PAbHNPqlF6TUL00QOx+vEhugjfXkVkiGZeaikc0ccyDi8r03VAcueY6Mew8gWTWDyFYAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766003; c=relaxed/simple;
	bh=N9MHvmJMhCT5fo/4KKWb5vUdZ84bsZfZlPGSs4CSPsY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AXulg1WBrAY7xkmibjJxp5oXH5F7W0V8AQTrTGFfWP0OB1y24BSWJbDyGVbAvefk/dyVskzJQeE5Pt916R5wXQAOrkJrZAYGQrJO8pKL3nXr6Z+ZGkyRLK6Js2PEmctph3cr0kiQ14+a4S1VCXCABUIUuryR2ixOk8IDyJ+xzRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRWe3YB6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRWe3YB6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCE51F00A3A;
	Mon,  3 Aug 2026 14:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785766002;
	bh=8RtOmV8+ctk7us3/xaBlUeQBd3QY/u7750xCdIciYRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NRWe3YB6Mnq2gT+6o7s5jmb9WzZ/BaD6nssRfkJWde6t3dq+OFxQd0GHFJUmTJ8Lx
	 DEqJzsoFLIKNzsTDD8sfDeLcHxf4qCEaXCbX+kISngxdbbDfjVCFjv34+sgB5quA7C
	 q2XkFAj+cWXoDOwUdUpZjDlgQdcRD5wfThNcQQ35QuoQ8Erw1TcuNo1Txi7vDZnc+i
	 jED8nGgNu3p+DbQkbTakE4+myAB2yHTxp6fKRO6LlWPEl8AK67NdQjwXO0vdKXl7Wd
	 GNQRqPiNIXf3zFES6MkYV1cBDGYcTvnQmpBbuuuUJZPrnLVJy5QbO+84K00CfPjH6K
	 ELm6ipf6BO4SQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mm/damon/reclaim: skip damon_call() if ctx has not
 started
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260803134646.16640-2-sj@kernel.org>
References: <20260803134646.16640-1-sj@kernel.org>
 <20260803134646.16640-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 14:06:41 +0000
Message-Id: <20260803140642.0DCE51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The patch fixes an indefinite hang in `mm/damon/reclaim.c` when =
`commit_inputs` is written before the context is started, but completely mi=
sses the identical vulnerability in `mm/damon/lru_sort.c`.
--

--- Patch [1]: [PATCH 1/2] mm/damon/reclaim: skip damon_call() if ctx has n=
ot started ---
commit d00b612017f41a8bee83736cc54b16dba8d079ff
Author: SJ Park <sj@kernel.org>

mm/damon/reclaim: skip damon_call() if ctx has not started

DAMON_RECLAIM calls damon_call() for commit_inputs parameter user input
if the DAMON context is initialized. The context could be initialized,
but not yet successfully started. In the case, damon_call() could
indefinitely hang. Fix the problem by memorizing if the DAMON context
has ever successfully started, and skip damon_call() if it has not.

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

[Severity: Medium]
This is a pre-existing issue and was not introduced by the patch under revi=
ew,
but does mm/damon/lru_sort.c also need this same fix?

Looking at damon_lru_sort_commit_inputs_store() in mm/damon/lru_sort.c, it
retains the identical vulnerable logic that was patched here in reclaim.c:

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

If a user writes 'Y' to /sys/module/damon_lru_sort/parameters/commit_inputs
before the damon_lru_sort module has been turned on for the first time,
damon_call() is invoked before the kdamond thread has been created.
Will this cause the caller to hang indefinitely in wait_for_completion()
just like the reclaim.c version did?

Should a similar damon_lru_sort_damon_has_started flag be tracked in
damon_lru_sort_turn() to fix this in lru_sort.c as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803134646.1664=
0-1-sj@kernel.org?part=3D1
