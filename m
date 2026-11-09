Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187706;
	b=GKtZcOXbeXlNAuvQoH4Op1o7j4YEIRGEzXmaXhvXyuU3LGsXkbJO4LJuUGORFm7jR+6w
	 V4nuKG4t7U7oiF+mqQB88nQSKZFPgu42wrMdB4Cqs4eyPj1jhMLVRK/Bnkld3BI0x/MDK
	 gh6QsHeixEhnBJkMYKFFDMz7u+CQsBdcplkTCx2FTEArC02wNNHXZLEpwvVCCSlLu6UIv
	 60p7bY+CVk7lKyxVymjFKRRPNSE5xft4FTLK53ASqWUeEIs3rNDu+xlg7dKOvFnzeR9bb
	 28wiYKAYd72R7mXPyL5KszDW206xzDsrSA5KtoxBMTUAcQmwGK7/eRLXVJZf7Fq8I/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187706;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Nyw5jYEPKA/70cvicg5V41eQLNfCnLZDywD0sGaa0is=;
	b=POCnP5XCvgph1iynbq/tws5wPbDUzMuAYzXpgLLrCwNLSPP3c2FkXT06H2QFFWpRx1sb
	 XOmOT9mjJ9X3es6SMW5KvoIgINK67E96j8vdJ0UgTGYJMrepQZk+AzFLyfi4VxP7GqGpS
	 OXl4dfC7panrycaEwbfWPpT/fUdXwYXbsHl1ZnRE5Vp2MpFRGMFo/rBVtAQdZhp1jvMl1
	 I1HLKlFaeblsgFoVS3Xs7N5y9qOppWkcoCxZk59TW7hY76jubV3QeIQ7lTu0ECCjvlM4k
	 aUrNQM8r2bJpBZ5qTODsDpY8v7OvZOKvSRTdh8Lh1xGaWO2VRkWCbydAH4wsQAeb0Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6MT47PK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E867F606CCD0
	for <damon@lists.linux.dev>; Mon,  9 Nov 2026 01:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6MT47PK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9211F0089F;
	Mon,  9 Nov 2026 01:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794187705;
	bh=Nyw5jYEPKA/70cvicg5V41eQLNfCnLZDywD0sGaa0is=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d6MT47PK/nb0gL3PL+V22I42qqTQfK18II2EorZdzWHtojpJVZNlWtmQ+37mUkYjh
	 Y0yWccuPEEhF5tSrmPvN/LCf4LMchXvSIDvncOT18JQdVtT7fnb4xb8K1xVxyuNIQx
	 z7jkjqA/+P5njS7ATivkITJ2zPU4ghBT+ch/3cCLYZNgJhxUHha8Vno0np65eZ4KmO
	 Whyeu7/lP57xuQVshQ/QgbJoqL5glCaG8C3y2Q8l9DAAZESglJk+cWlWNYXq62UswQ
	 DBvq2G/j7qkKWaFaKr8uP8K/6YtGEpQhbdCAROj4NQYfqj9nxs5+AluGU43PpaUZGZ
	 i/37VzwSYk6BA==
Message-ID: <sashiko-outbox-204294@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y v2] mm/damon/core: handle uninitialized
 damos_quota_goal->last_psi_total
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Brendan Higgins" <brendan.higgins@linux.dev>, "David
 Gow" <davidgow@davidgow.net>, "Quanmin Yan" <yanquanmin1@huawei.com>, damon@lists.linux.dev, linux-mm@kvack.org, "Lian
 Wang" <lianux.mm@gmail.com>, "Kunwu Chan" <kunwu.chan@gmail.com>
In-Reply-To: <20261109011347.92467-1-sj@kernel.org>
References: <20261109011347.92467-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 01:28:24 +0000
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

commit 5e9b1f636c184ecf41e05d717ad5e0116b0fca20
Author: SJ Park <sj@kernel.org>

mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total

This commit initializes damos_quota_goal->last_psi_total to U64_MAX when
creating or committing a DAMOS_QUOTA_SOME_MEM_PSI_US goal, and sets
goal->current_value to goal->target_value on the first tuning round so the
effective quota remains unchanged until a baseline PSI reading is recorded.

Link: https://lore.kernel.org/20260902002725.108635-3-sj@kernel.org
Link: https://lore.kernel.org/20260718005316.89585-1-sj@kernel.org [1]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 3142776e2e0ee..420ef0adaa7e3 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -1616,7 +1619,12 @@ static void damos_set_quota_goal_current_value(str=
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
Can setting goal->current_value =3D goal->target_value here overflow in
damos_quota_score() when goal->target_value exceeds ULONG_MAX / 10000?

Unlike mainline where damos_quota_score() uses mult_frac(), this branch
computes the score with direct unsigned long multiplication:

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
increase quota->esz_bp on the first round instead of keeping the current
quota unchanged.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109011347.9246=
7-1-sj@kernel.org?part=3D1
