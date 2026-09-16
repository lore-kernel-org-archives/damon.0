Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE244F55C5
	for <damon@lists.linux.dev>; Wed, 16 Sep 2026 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567483; cv=none; b=Ls8WYb+EsJo1ffFtJFgUwL2ZY45SGjIZA6G/6DYMuehPSeVNFw8xvebrdDDU3CwvWe4b3A/TC6mDtSg8Lw05gx/OL3n+tR5UpDL4oDxq5VWPp4BhgVKL3ugc0SV9jlO9y98C0smlU2VcgD6mFBRMZDR11IjkPlDy1hqMJphU25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567483; c=relaxed/simple;
	bh=pVHMH35y1J5BBo+GJli1QTLE4WqjDj/fjOzf/jClzGA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fIrMdduEdeug5Bk/6HEgZIw7L0b8e73OELDl4l8MOX5ul6d1bY7jRsAzec4q7gxe0NHGHxBXy0VCQEZ0JS2SD8xEg8zKzW8iZQSLEA9BGL0ffvLKsbzfvUOHtAKQSuWydlcVx0OiNjxf5TsmgabZvoxDNLp6zVd3dDjPzMXQRFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y68OewQc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y68OewQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DBE1F00893;
	Wed, 16 Sep 2026 14:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789567481;
	bh=X7/6hD6P+bG1KZp2o3K+gtrBJXqyqOd2n4RUxhJsBHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y68OewQcFMweT1KKaY+H6xSMQJpg2X7om8N98edJo9O7DuX24OJyYNePyMDtLK+kS
	 tZLc5GDdsdDZWSex4GTzy9Ld7DkGeNdMgyvjH5kLqSE6AgflULAEbImj3YXT/8tGrd
	 jxFL75cZfbn+rWvY1aPbcOGyi/swuTd/+ijv+7bOsJTXLlOCKET/W0xvBhvkrm9kS8
	 u7D95qA2SCC47WPnilj5bSFMMWqGBihLO+jEtx5/Eit6Uo0Ph+FKG3FZbBBGEdWpgP
	 LYTCvLqe7sbepsUmEKmcjpr4DIK0YFTFBYwqfYnjiIjYeD7xjOzHMhdH1IBiGv9zAd
	 Hw9K563eaLcvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: don't skip damos_adjust_quota() while
 esz is not zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260916135020.86483-1-sj@kernel.org>
References: <20260916135020.86483-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:04:40 +0000
Message-Id: <20260916140441.35DBE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMOS could unexpectedly stop working when a user disables quota using
> the online parameters commit feature.  Fix it by correcting a wrong
> quota unset check in damos_adjust_quota().
>=20
> DAMON users could disable all quotas by unsetting time and size quotas,
> and removing all quota goals.  The intention of disabling quotas would
> be making DAMOS run at full speed.  When such quota disabled setup is
> detected, damos_adjust_quota() skips all its work.  The skipped works
> include effective size quota (damos_quota->esz) updates and charged
> quota amount (damos_quota->charged_sz) resets.  The intention is to
> avoid doing unnecessary work when quotas are disabled.
>=20
> However, users could do the setup while effective size quota is
> non-zero, by doing the disabling with the online DAMON parameters commit
> feature.  In this case, because the effective size quota exists, DAMOS
> [ ... ]
>=20
> Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
> Cc: <stable@vger.kernel.org> # 5.19.x
> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916135020.8648=
3-1-sj@kernel.org?part=3D1

