Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269BC440A3E
	for <damon@lists.linux.dev>; Wed, 23 Sep 2026 06:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790143435; cv=none; b=KSgO4QARVjrljZj2Tbz1Yd0D36xILD1q8U1CK+p/JrbkNTYKL5dv/BGq+FCXjJU3J+N57rS+yTUeXUfvc0XMZvzPJ5cY5O3mFOTGPwau5u7cxinCz8EuJVlCeKW0WvsbUPV0Z8rtxFQMjr0E644CCcC5S+tTWzEBA5QvkFaTbBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790143435; c=relaxed/simple;
	bh=32aTO6CCORGVEE7sjqD+ZhAwTSXEFXMw6mKDOPtuLp4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CmaajT8bMQnJOyEkSVJnOTmakLd35x1Kbi8LTVk27y1Kw3QSwaUDCxIoJ1nxL1IBF7tiEehontW1T2yvlRoHNF47YyEan9JAejR59IZXXHnpK5zgUOv4/drzuu/MTV/+NsYYQzFcbH7LKRGIlupx/Wc/+Y7eZsBEPVpQYjhlQWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLXWbssS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLXWbssS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6855C1F00893;
	Wed, 23 Sep 2026 06:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790143429;
	bh=32aTO6CCORGVEE7sjqD+ZhAwTSXEFXMw6mKDOPtuLp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RLXWbssSkB8zuOh90VQDAcMMasRMcy3mOR+/Mllvj8WOpWSC3qoX3Vekrrales1NS
	 l8Nsa3MSct/2ZvFyQ9W6hrvhNZeHwvLvlnn0vS/Xun7l33z2XpU4KgXxi1HE3eqsuZ
	 xIxMUwCPP50ubcNn4LIejxraE4udQ8EXEG/QRCRtZPfjmf6TeOhFCqy30JkiDShCIc
	 d6YHQ3BJl6pan3o7h/xkSGjPuSGISBL92HquAN4nQ4ibD3ZK+TrEgj8njFpiVQlTkd
	 Hw5fblwW0eeCN3juwvmKCIsV88SvkpkiVFiip6vMNN+c8zqutkeAc45BKXeOejvMJx
	 kB91nPgQUHfuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 mm-unstable] mm/damon/core: keep the temporal tuner
 quota over an unmeasured PSI round
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260923055139.2982-1-sj@kernel.org>
References: <20260923055139.2982-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 06:03:48 +0000
Message-Id: <20260923060349.6855C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Karl Mehltretter <kmehltretter@gmail.com>
>=20
> The patch in mm-unstable of subject "mm/damon/core: handle uninitialized
> damos_quota_goal->last_psi_total" scores a PSI quota goal without a
> previous sample as achieved. This leaves the consist tuner's input
> unchanged, but the temporal tuner sets its quota to zero for an achieved
> goal. A running scheme with a nonzero temporal quota therefore loses a
> charge window after a quota-goal commit.
>=20
> Use the effective quota to preserve the temporal tuner's previous
> goal-achievement state during an unmeasured round, as SJ suggested [1].
> Score the goal as achieved when the effective quota is zero and as not
> achieved otherwise. A new scheme's initially zero quota stays zero, and
> the consist tuner's behavior is unchanged.
>=20
> Move the PSI current-value calculation and last_psi_total update into a
> helper that takes the current PSI total. This lets a unit test cover the
> unmeasured and measured rounds without depending on system memory
> pressure.
>=20
> Link: https://lore.kernel.org/damon/20260916001311.101024-1-sj@kernel.org=
/ [1]
> Fixes: 2dbb60f789cb ("mm/damon/core: implement PSI metric DAMOS quota goa=
l")
> Cc: <stable@vger.kernel.org> # 6.9.x
> Cc: Lian Wang <lianux.mm@gmail.com>
> Cc: Kunwu Chan <kunwu.chan@gmail.com>
> Suggested-by: SJ Park <sj@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923055139.2982=
-1-sj@kernel.org?part=3D1

