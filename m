Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD432FF669
	for <damon@lists.linux.dev>; Thu, 14 May 2026 01:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723385; cv=none; b=Gr+KRcnI/rl59WE4nrcrwYyCVH91PpXuxyAt8BSr6rQDl2tqRs8vqE4QQOLYMbFDyhOIgOCX6CmjKEyMQVwGwy5md+TIp+4KmQI1SdYyBMbtjypZOhttE02b9RKBXSxa0G5eXlkJyjunJ4J3lqjpehHMnKVblPVv+3PiaqLMiyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723385; c=relaxed/simple;
	bh=MKX6Om4ih9GrZaAAXGuPoHPAUFRKIpWp6ClApIy34Eg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cq1jLDdmq1nZCwpyEkMa5BayYhHkb7kRpME2k0OguFJfZyH2Gm/hF1/qOZZcekgW/l5PRJmk0NvhFXd+JzBTLSHsEV3MAyjI93IylUmqONxpfygkZq/WflqXDBiGE9WuxrE+HNNN+GzQzckLIB2UI1BW7IDh5ost3KSIH2kcjEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evsu9Du3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evsu9Du3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766F4C19425;
	Thu, 14 May 2026 01:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778723385;
	bh=MKX6Om4ih9GrZaAAXGuPoHPAUFRKIpWp6ClApIy34Eg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=evsu9Du3yfbpGjxbAvg7siy8tRY90Sg5dQYpe6R+os/wVXLNfwvzmk7ZoQ1W5CR78
	 5bcqdgaDX93azrkQ1Nv49zZ+WLyx6MBWsQqkHVKYih+aYCw/4lrcU8g+nXhjcS4ORK
	 nSKK2vGRUdljC5l4i4F5HFPOBR4Slke29qvErL745GEjHDPKRnPvXntjpy8T19hMqQ
	 3kXiFo4Wrv1euQxI+PNXpyPE3D8MEQ8gkeTTXfu74ikMmkOORYtN5HBD4hw+L2en/Q
	 yAH4p+h/Wk9PJdKRgLucqZ8zX3t+jojW4Z1ph3oOmWRe1su5Z7wsAokHI9shb4ee+J
	 E/WruwLOZfuow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y 2/2] mm/damon/lru_sort: detect and use fresh
 enabled and kdamond_pid values
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260513040734.144259-2-sj@kernel.org>
References: <20260513040734.144259-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 01:49:45 +0000
Message-Id: <20260514014945.766F4C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit fixes a state synchronization bug in `mm/damon/lru_so=
rt.c` but misses the identical bug in `mm/damon/reclaim.c`.
--

commit 1cc3b4aed4385359f20cea12e2233bf01f20b6b6
Author: SeongJae Park <sj@kernel.org>

mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values

This commit updates DAMON_LRU_SORT to dynamically check the 'enabled' and
'kdamond_pid' statuses instead of relying on cached values. This prevents
a state synchronization bug where stale parameters could prevent restarting
DAMON after an unintentional stop.

Link: https://lore.kernel.org/20260419161003.79176-3-sj@kernel.org

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 5654e31a198a4..4fdc5c76ff109 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
[ ... ]
> @@ -239,60 +230,93 @@ static int damon_lru_sort_turn(bool on)
[ ... ]
>  static int damon_lru_sort_enabled_store(const char *val,
>  		const struct kernel_param *kp)
>  {
> -	bool is_enabled =3D enabled;
> -	bool enable;
>  	int err;
> =20
> -	err =3D kstrtobool(val, &enable);
> +	err =3D kstrtobool(val, &enabled);
>  	if (err)
>  		return err;
> =20
> -	if (is_enabled =3D=3D enable)
> +	if (damon_lru_sort_enabled() =3D=3D enabled)
>  		return 0;

Should this same fix be applied to mm/damon/reclaim.c?

It appears DAMON LRU Sort and DAMON Reclaim share identical module parameter
logic. In mm/damon/reclaim.c, damon_reclaim_enabled_store() still uses the
cached enabled variable:

static int damon_reclaim_enabled_store(const char *val,
		const struct kernel_param *kp)
{
	bool is_enabled =3D enabled;
	bool enable;
	int err;

	err =3D kstrtobool(val, &enable);
	if (err)
		return err;

	if (is_enabled =3D=3D enable)
		return 0;

If the kdamond thread stops automatically there, would leaving this identic=
al
logic cause an issue where the stale enabled and kdamond_pid values prevent
the user from restarting it without a reboot?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026051241-thievish=
-uncurious-73fe@gregkh?part=3D2
