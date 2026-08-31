Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C811FF7C7
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198270; cv=none; b=M19AHOrADl4w28bia/I5pwDWf8ozD5lYEu/f7yB3XVtXbsvy0QoQBR4Hv5oklAoG7crm+hgZGh+8tETilkvw5b3YOSLXymp536dK85pMXk0RBxAJt97td9l3mLIMIZNACNbIlph+Gd3jqrjcCTweGQZJGogErfgMW6fzrIGPXhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198270; c=relaxed/simple;
	bh=0XzQJzKYmsGL+Lv2VhguYvfUv39ru1jM04in/y8lIbM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qL5wc/i3vVh9gsrY1/lfeWRS2L4fiE7oJrlxS0N8quuRBK8IhQEksKlxRek0eZYiotmuhKsory4uZhwXRkq7No3p9CrgdIKI5v1183kZKl3V2sF2nTqYE9g1W3h1piTh3H07/1RdfMKr6Xmjs+Z5ontFHhNLandnP4WPgjYRCzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcqVknsc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcqVknsc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0C11F000E9;
	Mon, 31 Aug 2026 17:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788198268;
	bh=5+yTsVI0QducLrI4okdSGpTHqzbK+93mt54k05tgukY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AcqVknscBDZkXxC2xaeKud1m4NWAVdhOagz8jZjDj8B42+ugiGeUuyJlaXWciX+kW
	 expHI08u7a2FXdGcs0jsiKcETaOusOKfEkqeTHvXK2YuAJnxYVB+Kco5RULUvPY32z
	 4cQK2DgYMHeWR90xrM7+r8ZDVJL8biXnKFYp65QtrsDLG/RTiDNhR7jk5RCpttTP9b
	 CWBV0WMefEUxj1pH2ji/Gl6p9EldaAqJ7h0cFnfibMWgUOMUS/UdMW/YMWG3jR5jP7
	 V0v4eAyKz+4rCGjgVkgROfun4gpGczNM6JZHdgJ/w9jiyYHXqvKZ9vj4l/IbrpMjzE
	 QeIrtF0p4+PmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] mm/damon/core: remove declaration of
 __damon_commit_ctx()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831142611.77572-2-sj@kernel.org>
References: <20260831142611.77572-1-sj@kernel.org>
 <20260831142611.77572-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 17:44:28 +0000
Message-Id: <20260831174428.8D0C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
>=20
> It was added by commit b1471afe4d10 ("mm/damon/core: do parameter testing
> commit on damon_start()") but is actually not needed.  Remove it.
>=20
> Changes from v1
> - v1: https://lore.kernel.org/20260806170701.79266-1-zenghui.yu@linux.dev
> - Collect R-b: from SJ.
> - Rebase to latest mm-new.
>=20
> Cc: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
> Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831142611.7757=
2-1-sj@kernel.org?part=3D1

