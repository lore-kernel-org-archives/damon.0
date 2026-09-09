Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EEC37E5C0
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 05:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788933218; cv=none; b=EYNI6etACqY40yZH1UPwpy1cNaeYr/Cavh2Voquq2bsfcct3eQiRtt+rK5DUNUiNWBlxk1EFxPyTyt1k4wK5oc793bBYCjnemgNCgZEwov4yIaDJUvQsRDAme6nrVlGOFbzvJcPcSGeP/PCxI/1gg/qS6HPxJXaod0aIhwTIDtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788933218; c=relaxed/simple;
	bh=7MRVNcNk+hkLDqv+YCHI8AWEcQhgXzV4nU9m7uSVvoQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rBBmrmMtcEhWobfzkEFpH20QjLDIhQ0/73SElHF/XeHqg56AhRFCtHli4TaSWo6Sk33Y/d4pmP3zmAJcHpqO/BqXDpPkoAdTlCtsMwPASUDUCqhYJ3vojN+z/tmqSWuHc+Nr5GqVJFrcJSnzkIitoyU3PV5vsCqmfnefTi4wrU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvYIAv6J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvYIAv6J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2F31F00A3A;
	Wed,  9 Sep 2026 05:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788933216;
	bh=NBG12cjPEF22pKbZjnnzF8i2ucMeb+lb4pYArEjaWeI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IvYIAv6J7DMVUwSxIetTCfyHqmyp0NRzODQsBsiU0B0mHI6ymOPZLspo5chNIY3gA
	 sE5/E4Gqm129cTRyh4NnWvQl8cgS321AaynGz0/lJfu4tHobAjpljjgHpPdEIao+dK
	 T3UaOZmjh58NRKYlQAKVA8pwMa4SrNEmtwl/uqaHI/CGAUItnLebApad/CJ/0yfv5f
	 1hoz2NnfGbHXUZqIqL64UxSYrMFg/cc5fHmIzNDQSUnKg0IEuqh5RKhw3eZyAugLO2
	 c7L70l2vXBVrkGb5ljDZQTfvDK7ok6ETIrefJyFhxPHtJuENHHQH8j6GswizblEOLU
	 u0OqqsyrhbLUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y] mm/damon/vaddr: drop last same folio access
 check optimization
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909055038.259529-1-sj@kernel.org>
References: <2026090857-overhear-pull-af4d@gregkh>
 <20260909055038.259529-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 05:53:36 +0000
Message-Id: <20260909055336.AC2F31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> The optimization can race when multiple kdamonds are running.  Meanwhile,
> the impact of the optimization is quite doubtful.  Just remove it.
>=20
> The user impact of the issue should be quite trivial.  After all, the race
> can happen only when the user intentionally setup DAMON in the way.  Even
> if it happens, it would be rare and only degrade the best-effort
> monitoring results.  No critical consequences like kernel panic or memory
> corruption happen.
>=20
> The race possibility was discovered [1] by Sashiko.
>=20
> Link: https://lore.kernel.org/20260715031002.108504-4-sj@kernel.org
> Link: https://lore.kernel.org/20260621204050.10993-1-sj@kernel.org [1]
> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memo=
ry address spaces")
> Signed-off-by: SJ Park <sj@kernel.org>
> Cc: <stable@vger.kernel.org> # 5.15.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 831846078caa14b7d00b2ccca8b8fe522afe3204)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909055038.2595=
29-1-sj@kernel.org?part=3D1

