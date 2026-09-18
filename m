Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C9F3264FB
	for <damon@lists.linux.dev>; Fri, 18 Sep 2026 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742900; cv=none; b=HPhd8DoT5YVDIZnkZ4bGjOtnMkX8WNRG6a7uYcCnVscMZLJ0DnPoEucKBALSb09GxbJZxPfxmW5MjYubu6nheTR+6cztdUcZA2Amx6mf/VuQ3se2zO48CWJhfsHlCDLgaXO2dN4I5ZBKH6efOGU654n3awBRGM0haNJgtpakrw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742900; c=relaxed/simple;
	bh=oerxcHk4zhJXsvTM3nHAUkZlz8rS+YjGusQbwqLjKxY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gRLtuGccToJ45nxbNNlhaqa6IVJ6qQPE47V35VsbU1Nx5unAtp1MvRdhDwUmy53NbOaFeGqJDiOOTtw4u8d71/Igw/RVyc/0xTnUQw9eBTJ/B5MlHVCcF9VoIaYiBkfFHzpQW8g85UjRrENiKOZpd7dm8X61m6rO6xm8mZGCTcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHQiq6rK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHQiq6rK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C831F000FF;
	Fri, 18 Sep 2026 14:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789742898;
	bh=yJHye5lRtUdrEjVtH5EoQon+jlhO2bf7QdLsTQeMGoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PHQiq6rKSG4EovsbfHRBFl0aOLCMy6X41PfF0vrX227IR0Ocr3/55LPqLzGgMVqUo
	 AP/N53ingO9IHLYVNa2UiHcuWuY9uYJNQ+57wxcqz4aWhLj0i22fniHdxZK4wyRQZH
	 4fakIlTMf24CrBza8HlBJZxsBi/vGiupimMCEZTMHVA0deEfE7gS/000o/BIxqn7JX
	 0MKIB+NtBlal1oeTus6V+oImteBbLSNkZ0v0DmBTLHQDMx0U8EaJsT9k/rvW2cQg6V
	 niS/RhfWZvCeTMQ0e8oehN/C5Rtx6//i+HNVtVrxLuPSqPAxletkj3gIA8TY+8NRZY
	 nKtCub1uWH2Gg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/7] mm/damon/core: introduce
 damos_quota_goal->complement
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260918142827.85303-2-sj@kernel.org>
References: <20260918142827.85303-1-sj@kernel.org>
 <20260918142827.85303-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:48:17 +0000
Message-Id: <20260918144818.18C831F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: integer underflow in damos_set_quota_goal_current_value() for =
complemented metrics
--

commit 94b0fa41235165f1d082ca5735dcefbf9f65199b
Author: SJ Park <sj@kernel.org>

mm/damon/core: introduce damos_quota_goal->complement

This commit introduces the complement field to struct damos_quota_goal
to allow specifying whether to use a complemented value of the goal target
metric. It adds the field and implements the core support, handling the flag
during quota goal commit and current quota goal metric value retrieval.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 2258b72da7a78..25a8221dd2a40 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3238,6 +3239,19 @@ static void damos_set_quota_goal_current_value(str=
uct damon_ctx *c,
>  	default:
>  		break;
>  	}
> +	if (!goal->complement)
> +		return;
> +
> +	/* updte current_value to complemented value */
> +
> +	/* for user_input, users set complemented value on their own */
> +	if (goal->metric =3D=3D DAMOS_QUOTA_USER_INPUT)
> +		return;
> +	if (goal->metric =3D=3D DAMOS_QUOTA_SOME_MEM_PSI_US)
> +		goal->current_value =3D s->quota.reset_interval * 1000 -
> +			goal->current_value;
> +	else
> +		goal->current_value =3D 10000 - goal->current_value;

[Severity: High]
Can this unsigned subtraction result in an integer underflow?

In damos_set_quota_goal_current_value(), if the measured memory stall
(current_value) exceeds the reset interval due to kdamond thread
scheduling delays, heavy system load, or if the user configures
reset_interval_ms to 0 via sysfs, s->quota.reset_interval * 1000 -
goal->current_value will underflow.

Similarly, for BP metrics relying on loosely-coupled lockless kernel counte=
rs
(e.g., global_node_page_state), per-CPU drift can occasionally cause the
returned value to exceed 10000, causing 10000 - goal->current_value to
underflow.

If an underflow occurs, it produces a value near ULONG_MAX.

Would passing this immense value to the auto-tuner mistakenly drop the sche=
me's
reclaim quota to its minimum precisely when memory pressure is highest?

>  }
> =20
>  /* Return the highest score since it makes schemes least aggressive */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918142827.8530=
3-1-sj@kernel.org?part=3D1
