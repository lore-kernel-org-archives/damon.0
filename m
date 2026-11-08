Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168209;
	b=eRqyN7RU22W39TjiuZMg3lu47jrAjso4MbVZ7r0aMygJSo7BKvgSgdTD4pIxG+PtyPGf
	 vU7aVhX5S3gpUjKjfsawpF22fVYqUGsFbyOKNLIg1Hoh7IIllsUPtIsZL03ry1kWG9DQA
	 rgvmYltnMzkSq1hwX0zbrEPPbCn0BlcofkLkrwwktzhuj8kRd1rCbyMhbQ4jbGxitNndf
	 n1orjChN3w92YZG93zoc6MBTZFA9phP9tCTvJUJgSSGufxp8JKFzl9UysZUHUXpsFqjKY
	 QlXzEjaQ1Hiupn13YBRycuKpomc8YX5QDxEy+Hu9iW10vtYQ9rQ5CUjfGwLB33jXjIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168209;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DZ6gdZXmi+wGnZ9NA1jOeRLxjxmr/2rmV5TZgPwzxj4=;
	b=eI2pkhtXMu3Dts+U4En+IsQN+AbMXs+r6X6gdwPruD8wyGUHv3VoHdODdyyWVft1PLns
	 I+/rpW6mEgpSv+CaVJNJufXdrDA0cQIbPHj3j9I3kI9g9WwYHTQAPFbd1PPBMVYJrYfNN
	 LuE4OC/vS4a7/yz3A9De5WkWwmnyyyFwGG5wi37k6b1ItIx+VRGGG8v8zn9UEWdOG1eiw
	 WkZv8xsZsJK7plWfeNhMA7xNpTofGJ8nmnIaY/HlSU/XkgrOU6M1Qj/2ORkzm/s/qnmyZ
	 0wFL82b3TzSzYPEgsaJakQlxBVADhA3j+cD4NV3Jpy3wy9rktE+7tPNMh6weGsEd2bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KdXtynUd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ABE606A31C
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 20:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KdXtynUd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EB41F0089F;
	Sun,  8 Nov 2026 20:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794168208;
	bh=DZ6gdZXmi+wGnZ9NA1jOeRLxjxmr/2rmV5TZgPwzxj4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KdXtynUdUUSz2QX4FLHkq1IJ5Bbm5ohUKS//EZI/ce81aoJ2geW29TVr8cD0feOmb
	 k8opN37d91LRaoS8Ypam63Xq4B/p33j9SeXA2RnBbFD39DL8bSKrtE3ow/vHk34A/l
	 P2wFdHAab1hueE0bEhNjSKKyP5jGjFVBezFWQuh4mE0oMIDDkwzvhBYIlBsXjS8Sso
	 HSt/zfQWYu7rXT6w8dq8NzZz9KXSAf8OIzXCKil4kRtVScCrEIi9pb+IzMP6nsIp6U
	 v+2Q5B3smCJtYLoCOMrzyg+QBgeaUCiiiy9mf4LCxCL1jhF7D8LPE8Lmrc1z9Ph3XJ
	 eqB6VeUiWlLIg==
Message-ID: <sashiko-outbox-204001@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y 3/5] mm/damon/core: handle uninitialized
 damos_quota_goal->last_psi_total
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Brendan Higgins" <brendan.higgins@linux.dev>, "David
 Gow" <davidgow@davidgow.net>, "Quanmin Yan" <yanquanmin1@huawei.com>, damon@lists.linux.dev, linux-mm@kvack.org, "Lian
 Wang" <lianux.mm@gmail.com>, "Kunwu Chan" <kunwu.chan@gmail.com>
In-Reply-To: <20261108195145.115792-4-sj@kernel.org>
References: <20261108195145.115792-1-sj@kernel.org>
 <20261108195145.115792-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 20:03:27 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mm/damon: integer overflow in damos_quota_score() on first
  PSI round
--

commit 6456f90a0b14251a6d548d6849beb9dd850f55e6
Author: SJ Park <sj@kernel.org>

mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total

This commit initializes damos_quota_goal->last_psi_total to U64_MAX upon
creation and commit, and sets goal->current_value to goal->target_value on
the first PSI tuning round so the effective quota remains unchanged until
a baseline PSI reading is recorded.

Link: https://lore.kernel.org/20260902002725.108635-3-sj@kernel.org
Link: https://lore.kernel.org/20260718005316.89585-1-sj@kernel.org [1]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 6ef77741b783b..52f01a6508b66 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -1608,7 +1611,12 @@ static void damos_set_quota_goal_current_value(str=
uct damos_quota_goal *goal)
>  		break;
>  	case DAMOS_QUOTA_SOME_MEM_PSI_US:
>  		now_psi_total =3D damos_get_some_mem_psi_total();
> -		goal->current_value =3D now_psi_total - goal->last_psi_total;
> +		/* uninitialized last_psi_total; make no effect this round */
> +		if (goal->last_psi_total =3D=3D U64_MAX)
> +			goal->current_value =3D goal->target_value;
> +		else
> +			goal->current_value =3D now_psi_total -
> +				goal->last_psi_total;
>  		goal->last_psi_total =3D now_psi_total;
>  		break;
>  	default:

[Severity: Medium]
Can setting goal->current_value to goal->target_value overflow in
damos_quota_score() when goal->target_value exceeds ULONG_MAX / 10000?

Unlike mainline where damos_quota_score() uses mult_frac(), this tree
computes the score with unsigned long multiplication:

mm/damon/core.c:damos_quota_score() {
	damos_for_each_quota_goal(goal, quota) {
		damos_set_quota_goal_current_value(goal);
		highest_score =3D max(highest_score,
				goal->current_value * 10000 /
				goal->target_value);
	}
}

When goal->target_value > ULONG_MAX / 10000 (for example, above 429,496 us
on 32-bit architectures), goal->current_value * 10000 wraps around and
produces a score below 10000, causing damon_feed_loop_next_input() to
increase the effective quota on the first round instead of keeping it
unchanged.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108195145.1157=
92-1-sj@kernel.org?part=3D3
