Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341B63BFE42
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 01:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789781197; cv=none; b=McZiUXlILTA/1aEOGeHzSoGYOrxYkm7M6Jrtm0cwDTW1zmyB80/50drfBRFCcc4VaGTq+YwASBcx/WUV+Qo3iiyddwzZe6UJEr+gLN8GsHNN3NJV0dYM0KSm9bRCzr2UNWzddh8o97W+OGMDuXzhCN4pUvMPpid6ms11hVY9diE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789781197; c=relaxed/simple;
	bh=ndRwEqsItXZEICW4ofh9pkiZikm2NACajAtyc9r8T+s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h0+CMpq5I1dKxVrK9O7lUJrcCi8+Q9lo4gGjgiv7vsLup9Ajfbzowh8TriY4qzP7vWR3KchPgzVfMUU9pGhTuXHPvMlxdKOwhB8hEAqCSTxjC5IXj90cx2YrkxIjInxpcoN3VcoYIy8GN85sXVrUNeqLas9TRJNldBLoVeS6Y34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rx5gXdU9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rx5gXdU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49A41F000FF;
	Sat, 19 Sep 2026 01:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789781196;
	bh=cWCzlEOo0h+0JUdhFzN2IWlmXyYfndsoECG/ZW99Lvs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rx5gXdU9PDC7K4PSctU+p9EZuEaGS4uwQ26i95qjyHwkNz8Rq++UFjdWtBgqueCjq
	 Ew/l3iQknDw4zIftdw5wA9L19CUsOogCMrDeurE/G8FwEpIu6ZVft8OfGv4xmUUZbu
	 rG2aHqJrVlCt07/DqdjlBa5+HElayWaoa9UJnLC6ZbVsC7vMyj3JFuNEzntKwvEVBo
	 QZnAAAZCBxvGSwHmnXODzsw5ZvBvv4+4+e9ZGyriJfKrmfyM9Hfnl0RK++e5pfamZq
	 GbHxXbd402/c/FJYb2WrptHmQFCYZWHcmeGL/F134o259oDWBvCPNSfyGyfIsR2izO
	 Xu/kA9mxlI/gA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/7] mm/damon/sysfs-schemes: support quota goal
 complement flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260919011359.88921-4-sj@kernel.org>
References: <20260919011359.88921-1-sj@kernel.org>
 <20260919011359.88921-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 01:26:35 +0000
Message-Id: <20260919012635.E49A41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm/damon: integer underflow in DAMOS_QUOTA_SOME_MEM_PSI_US complem=
ent calculation
--

commit cd02e1bd14a7884bf9a21f0cab584b1a0f9992ce
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs-schemes: support quota goal complement flag

This patch adds a new sysfs file for the quota goal directory to allow
setting and getting the quota goal metric complement flag value.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 06af417bc9a2f..8f083611741fd 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c

[ ... ]

> @@ -2869,7 +2898,8 @@ static int damos_sysfs_add_quota_score(
>  		if (!sysfs_goal->target_value)
>  			continue;
> =20
> -		goal =3D damos_new_quota_goal(sysfs_goal->metric, false,
> +		goal =3D damos_new_quota_goal(sysfs_goal->metric,
> +				sysfs_goal->complement,
>  				sysfs_goal->target_value);
>  		if (!goal)
>  			return -ENOMEM;

[Severity: High]
Now that complement =3D true can be configured via sysfs, does this expose
an integer underflow in damos_set_quota_goal_current_value()?

If a user configures a DAMOS quota goal using DAMOS_QUOTA_SOME_MEM_PSI_US
with complement =3D true, the actual elapsed wall-clock time between
evaluations can exceed the configured s->quota.reset_interval due to
routine thread scheduling delays or high system load.

In mm/damon/core.c:damos_set_quota_goal_current_value(), the accumulated
PSI time (goal->current_value) could then exceed reset_interval * 1000,
underflowing the unsigned subtraction:

	if (goal->metric =3D=3D DAMOS_QUOTA_SOME_MEM_PSI_US) {
		goal->current_value =3D s->quota.reset_interval * 1000 -
			goal->current_value;
		return;
	}

Unlike the basis-point metrics below it, this lacks a safety bounds check.
The unsigned integer underflow results in an erroneously massive quota scor=
e.

This causes damon_feed_loop_next_input() to evaluate score >=3D goal * 2 and
return the minimum possible input (min_input), severely throttling the quota
size (esz) to a minimal value.

This effectively disables DAMOS scheme actions for that window, despite the
system being under severe memory pressure, which is exactly when tuning
is most important.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919011359.8892=
1-1-sj@kernel.org?part=3D3
