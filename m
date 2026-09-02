Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B913B4CCDCA
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 05:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328225; cv=none; b=obTyhEDTiHtytFaZkg3c1Y/2OiQXP17YM305H09Z1gxY/Vux7YeDMrUT1AyP7XLbYKU3Nn3umOq1MHwV9mET/3xoiUCoI87HsuYgiSO+AJYgbUIT9ukeVvViI6PNXZpUnrnzS4I5nH6O72+tAJVBHX6Ewk5ehZ/ySeEgD+PK2Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328225; c=relaxed/simple;
	bh=0TZeWoS+MXjOSrYdtySUNezUilVME2TSlQAdt+IiUgk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TV/OzKvK1xFTYViuvIg14+F0PNsdxVCCK3fDohmbqsjNvosNEU9ibK1VLN7yyzYzm8ZQgrpcGqx/PjgpmGp1DdhQBGP8xFle5vtYl+ssadgxD7p5HNw86cGcgG7tQLg/Cz8MuMyl+11VBAlN3K9sRisR8ByUDpSM5WiFcq1bUs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKE+oYjH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKE+oYjH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9891F000E9;
	Wed,  2 Sep 2026 05:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328224;
	bh=2FoaKjmIfFCrWhLM/jH27XbbBtE9hfgVT+zfA7UBKAM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YKE+oYjHN+xAr27tykYKaNOC6XDJ+ZqBp0O3GIkmaIaud8D8d/XKqBouir4QJcr+J
	 EzZ7lStrU3oEeVvQZ/2nOjaeLzFL2VPnINNNE5c+xJlS4MLdRaO9hQZtmHAg5armiv
	 EJt4SFvtqnhF2T9fYCFWkJhqOSjWfcPF/6MJ048VG0GluoE158Jwf7zU4WKZMlWi1D
	 YBWPlPtkQ4xe5GwjeYloGkC2mJsB5WOOf6LqLH1cYS7fSwVXGtLHQj29n09W+2KLNh
	 48Xp7cHMdnR/u0VPRYIUkatgyhT553N+N78MvVpNwi5Z2hKO7szPT+Z8VvsOxGdmB1
	 Q4A0SLF0nEsEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/12] mm/damon/vaddr: remove a debug message
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902054747.99370-4-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
 <20260902054747.99370-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 05:50:23 +0000
Message-Id: <20260902055024.2C9891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> There is a debug message in the DAMON virtual address space operation
> set.  It has not really been used in a meaningful way for the last few
> years, though.  Remove it.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902054747.9937=
0-1-sj@kernel.org?part=3D3

