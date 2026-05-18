Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FB3391826
	for <damon@lists.linux.dev>; Mon, 18 May 2026 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779134268; cv=none; b=P5guXoaHvHAHwTwrIXRiUb4QfNiK/X0+oXLLHPL1uK1Cta4dSypZqa8e9+zDiDGMdJUWbaIqB1yoHBeUKfVZC8N+laBpM/R7/9hW72vsHQhtcv2bfIEI7NK50vq6dFj+dLRvRo2/SEpneLaSXT7EQ85NVYnWbdIaWSa+WROjQhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779134268; c=relaxed/simple;
	bh=9zeQKeFG1tFzps9ExMQXAIK/Nrg6Hx1PpYGH5u8FLzc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MGZF2mrTazLINsp45iDpLB6NVFl0ViIiDr4ePY+/+7502Ci+nRO8/axnQWZtm96WWWStfItSdGNEHuhwkWBjVjO794FA5/BjjO9S7JgXy7iU4gelyw2JidXLtZP972gx8yoQC76C4leMuHSRC5KUKLYTMK6A2RZTbf/f8s0Q+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFEwzQBT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFEwzQBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF14C2BCB7;
	Mon, 18 May 2026 19:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779134267;
	bh=9zeQKeFG1tFzps9ExMQXAIK/Nrg6Hx1PpYGH5u8FLzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cFEwzQBTyTB8hsBrowKA4D2J4N11tPq3p+C77FHw3IPzNZU80W5HDgmIkcld8cHGy
	 /gU+hkou8Bw98O2HgKzLA4KbAUlSwA+vKZD/h7ac31ERTKCHjg/LT1e0WiD3lu3gms
	 AdsSIVWuezisvqPnFEn7u90XqvGKn1vcqTwMXmpvLF+isrl1x35ly9nc58vHWpuu/E
	 mbfqTstT6hVAOD6fjwybDmMtQrzxET7JseunwR2+P8xhRi87votw44J1mzySFgdWzH
	 cwC3ZUvXz1SqTgXWl6vFeTq432vNIIPu9KZFuquh2hJ/XepAETUMfKfD6YJwt80Iwb
	 FH5BLiD3NDVsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] mm/damon/sysfs: implement
 update_schemes_quota_goals command
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maksym Shcherba" <mshcherba2000@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260518190932.42270-2-maksym.shcherba@lnu.edu.ua>
References: <20260518190932.42270-2-maksym.shcherba@lnu.edu.ua>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 19:57:47 +0000
Message-Id: <20260518195747.8CF14C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Concurrent lockless modification of the sysfs current_value field =
causes a data race and silently destroys uncommitted user input.
--

commit 82969e621e89de8b04fc04548d5cd270bf1bb3b7
Author: Maksym Shcherba <mshcherba2000@gmail.com>

mm/damon/sysfs: implement update_schemes_quota_goals command

This commit introduces the DAMON_SYSFS_CMD_UPDATE_SCHEMES_QUOTA_GOALS
command. It adds the logic to copy the current_value from the internal
damos_quota_goal structure to the damos_sysfs_quota_goal sysfs structure
and integrates it with the sysfs interface.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 622c3799db87b..198a510003143 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c

[ ... ]

> +void damos_sysfs_update_quota_goals(
> +		struct damon_sysfs_schemes *sysfs_schemes,
> +		struct damon_ctx *ctx)
> +{

[ ... ]

> +		damos_for_each_quota_goal(goal, &scheme->quota) {
> +			if (goals_idx >=3D sysfs_goals->nr)
> +				break;
> +
> +			sysfs_goals->goals_arr[goals_idx++]->current_value =3D
> +				goal->current_value;

Looking at current_value_store() in mm/damon/sysfs-schemes.c, user input is
written directly to the sysfs goal->current_value without holding
damon_sysfs_lock or using atomic operations.

Since the sysfs writer does not hold the lock, will this concurrent
modification create a data race that triggers KCSAN warnings?

> +		}
> +	}
> +}

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index d5863cc33d230..ecc880b52b329 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c

[ ... ]

> @@ -1656,6 +1672,7 @@ static int damon_sysfs_repeat_call_fn(void *data)
>  	damon_sysfs_upd_tuned_intervals(sysfs_kdamond);
>  	damon_sysfs_upd_schemes_stats(sysfs_kdamond);
>  	damon_sysfs_upd_schemes_effective_quotas(sysfs_kdamond);
> +	damon_sysfs_upd_schemes_quota_goals(sysfs_kdamond);
>  out:
>  	mutex_unlock(&damon_sysfs_lock);
>  	return 0;

Since damos_sysfs_update_quota_goals() is executed periodically here
(when refresh_ms > 0), the DAMON worker thread can overwrite a user's
uncommitted quota update with the old core state.

For goals using DAMOS_QUOTA_USER_INPUT, could this cause user input to be
lost before they have a chance to execute commit_schemes_quota_goals?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518190932.4227=
0-1-maksym.shcherba@lnu.edu.ua?part=3D2
