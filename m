Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121584FE2EB
	for <damon@lists.linux.dev>; Fri, 18 Sep 2026 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744178; cv=none; b=jony1OvviqjJN6ODmuvEFE7J8hR4g5aeMaz0hrNY2vkHHE3/rAbkcZnp379kWN8QucBVKeWcxryIwUZcAYmbuzfrSNGk8XfT+pJtHlChG0wyab0a1aavjTwzY+7NyHvw45UusiMG1U7E3tWzkdKh5rISrIj93A/SICkqrWYD2lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744178; c=relaxed/simple;
	bh=RkqvJnCCbfVWc7MoRK/jPOdlJD4wbTNquVQZxrFZpqk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uP9uNN3pJtp14HT2k5pivouP3xMshJ4CPXJ7BhTwrUvThHaolUv8qqY8BOK5bNGtmLCgN8oSybsyEEfjwZ3RXlvl/qg6tuC5Ec9bCnom9J8Of1PgmOJmwm/npVm+p0DIbWP5moGnV1GYh1fE+r9uW9UvAiNrzQOEvhFhEzUaejw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ge7FGd5B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ge7FGd5B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC5B1F0089C;
	Fri, 18 Sep 2026 15:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744174;
	bh=mD74R7Zmu/Lup6nfTpTro6o4PvYf0rkTeqQRIAEF2KI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ge7FGd5BXFTiyRzDO78nzufDgn5e5PTAntUQS5+M1Rt2WDIsTUZdqOcDVo8M9lyKG
	 nP5NIMnGuLMpxp8c0j9ebst5bfMPfkDs4KPXIhgB/PITvmR2kcz5+sPUHm+/FJeouY
	 4RvWUJm9N1fFy3fxX0J05u9d0o254WURoiUX2WOtzjz/xlyr+EbsnJjyQi0BOGWQ7f
	 N2GfNuY70WDrOM+42aVrp4z82Q+dqZoW/iBWp8llfOKVu04WuAEMOUBxpo1I2n1dLx
	 H+nQpWowNrbi+u9wiKuH+mUnPCyXSICjylEIWcI3QozqVkcoWJXYUM4/c1oGgaJkTQ
	 0knNFn/OyACpA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/7] Docs/admin-guide/mm/damon/usage: update for
 quota goal complement file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260918142827.85303-7-sj@kernel.org>
References: <20260918142827.85303-1-sj@kernel.org>
 <20260918142827.85303-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:09:33 +0000
Message-Id: <20260918150934.1CC5B1F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] damon: inconsistent file count in usage documentation
--

commit 3ff19ca809eb7c0b839b503a68fe82c349a81160
Author: SJ Park <sj@kernel.org>

Docs/admin-guide/mm/damon/usage: update for quota goal complement file

Update DAMON usage document for the newly added quota goal metric
complement sysfs file.

> diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation=
/admin-guide/mm/damon/usage.rst
> index ba47255448564..b3f2e591fb7e4 100644
> --- a/Documentation/admin-guide/mm/damon/usage.rst
> +++ b/Documentation/admin-guide/mm/damon/usage.rst

[ ... ]

> @@ -493,11 +494,11 @@ to ``N-1``.  Each directory represents each goal an=
d current achievement.
>  Among the multiple feedback, the best one is used.
> =20
>  Each goal directory contains five files, namely ``target_metric``,
> -``target_value``, ``current_value``, ``nid``, and ``path``.  Users can s=
et and
> -get the five parameters for the quota auto-tuning goals that specified o=
n the
> -:ref:`design doc <damon_design_damos_quotas_auto_tuning>` by writing to =
and
> -reading from each of the files.  Because the kernel does not update
> -``current_value``, reading it only makes sense when ``target_metric`` is
> +``complement``, ``target_value``, ``current_value``, ``nid``, and ``path=
``.

[Severity: Low]
Does this introductory sentence need to be updated to say six files instead
of five files?

The patch updates the next sentence to say six parameters, but the word five
in the preceding context line was missed, so it now contradicts the list of
six files that immediately follows it.

> +Users can set and get the six parameters for the quota auto-tuning goals=
 that
> +specified on the :ref:`design doc <damon_design_damos_quotas_auto_tuning=
>` by
> +writing to and reading from each of the files.  Because the kernel does =
not
> +update ``current_value``, reading it only makes sense when ``target_metr=
ic`` is
>  ``user_input``.  Note that users should further write
>  ``commit_schemes_quota_goals`` to the ``state`` file of the :ref:`kdamond
>  directory <sysfs_kdamond>` to pass the feedback to DAMON.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918142827.8530=
3-1-sj@kernel.org?part=3D6
