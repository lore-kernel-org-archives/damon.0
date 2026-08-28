Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F172E764D
	for <damon@lists.linux.dev>; Fri, 28 Aug 2026 01:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787882125; cv=none; b=ZJqGf2c1dVonaxMFByY1OADK0a6ElJJRWotGjSvUeQ7SNot759hdYKCKQ+BZLrlzPnbjQhHKma9A6X2wScFCAFeQEw+ZHOWs6sKd4D3hDg/RFQD2R+IIVFI9JT2dUilUAxEUc1hJMsJ/zn2W8HN8oyqeUNHWZy+tokWG8OolUJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787882125; c=relaxed/simple;
	bh=F6wCzbykZskHbZipJYem+WDXYVqGRasPqE+9wGlor9M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BbnyGxG+EqAcoaXEgA66aKDinOURDFRydBm0FQ01vnHDaH/eLCrLA+nYyJj4Bni0XP46C5G2s/YT33MlxxPckcnNk2lP/jrZWVoz0egdAedszSftoefJGlNd+eu36U6OFQ77p1T3uNDbI8p+dQN3xYAJxC7lcwB7xIR4th/Ea7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGUi1m0B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGUi1m0B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0AA1F000E9;
	Fri, 28 Aug 2026 01:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787882124;
	bh=s4tbPZ82B4i6Sm7n7ZPxlKAUIWJaxqdm33qG2UierjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UGUi1m0BwmfiJ1lHrek6zOtc+1ZFvJ6WH9/XVextIHjDmogqewJaqvX6TqzsgtivZ
	 lzk9s56cRqjfiejLy+8cqCvwmJsd7Ox+5sF4q5XvJ5qRQjbEAbW2fOvx4rvHSefqnA
	 9wDPy7N65H8OK0y2BzIL1zkmTgYsr1uJRNfo7kkR9EPcdTd6m5O48Reja6+S8Hxrjd
	 GxqAG/7XDiBspw6bmR9x+sHXF+eX6nl+tAg4rQLDe6NVeMZGRSDIN0kmrATxDmIcJv
	 7dUkrb2G+z1ySMHJdlsP6g3I+wThB2qMJ9jwaW9ZuYVdTeFQTSPVehp/FXDMwM2wZM
	 9TUN3vv58vqpA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 2/4] mm/damon/core: handle uninitialized
 damos_quota_goal->last_psi_total
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260828014659.121058-3-sj@kernel.org>
References: <20260828014659.121058-1-sj@kernel.org>
 <20260828014659.121058-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 01:55:23 +0000
Message-Id: <20260828015524.5F0AA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Integer underflow when initializing last_psi_total causes severe q=
uota throttling instead of maintaining the quota.
--

commit 216061cc4d3a0304d1961ab1798b65cbf748aa6c
Author: SJ Park <sj@kernel.org>

mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total

This commit handles an uninitialized last_psi_total for PSI metric DAMOS
quota goals by initializing it to U64_MAX. During the first tuning round,
it detects this state and attempts to set last_psi_total such that the
first iteration has no unexpected effect on the quota.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 644daf5a16560..b0c8e22ab5404 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3018,6 +3022,10 @@ static void damos_set_quota_goal_current_value(str=
uct damon_ctx *c,
>  		break;
>  	case DAMOS_QUOTA_SOME_MEM_PSI_US:
>  		now_psi_total =3D damos_get_some_mem_psi_total();
> +		/* uninitialized last_psi_total; make no effect this round */
> +		if (goal->last_psi_total =3D=3D U64_MAX)
> +			goal->last_psi_total =3D now_psi_total +
> +				goal->target_value;
>  		goal->current_value =3D now_psi_total - goal->last_psi_total;

[Severity: High]
Does this arithmetic result in an integer underflow on the first tuning
round?

If goal->last_psi_total is set to (now_psi_total + goal->target_value), the
calculation on the very next line becomes:

goal->current_value =3D now_psi_total - (now_psi_total + goal->target_value)

This evaluates to -goal->target_value. Since current_value is an unsigned
long, this underflows to an astronomically large value. Will the feedback
loop interpret this as a massive over-achievement and drastically throttle
the quota to its minimum, causing the exact opposite of the intended
"no effect this round" behavior?

>  		goal->last_psi_total =3D now_psi_total;
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828014659.1210=
58-1-sj@kernel.org?part=3D2
