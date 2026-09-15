Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F03C9438
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483495; cv=none; b=EHZHRYT0YPYEtKAK9mLxgXU5TL8gAxHq2BmJEgiZG+Un2hkdR/h6X6UqT9DPB9jiR3+ol/mE9eIVbW/ajP3osm2dG4R1Nj/eebJo9xA6GCUHe1/YIzT8+DAGQ7/CqZcM3/+C0RmE2xgPFMqrVHq0omjQZtOSrovUSouwcrPb0Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483495; c=relaxed/simple;
	bh=5HWAeHHmBmjkCtxbJrTWsXB4dre74g0+39N5O7U//wg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tqzIAwbgElU9Np2poR69YFJaP1GUwYBXuQ5xAS7wdmnOiFljo5UlVkz2NrvrcPip38aI9nJWU8HEKMYvVhA+OJ8/JsMB78Fihaan9fL+90pJPvn9bA6l4VE6kVzZeWrDyCsHDXRCPa79pm42ibp1+7TK+o+tzhk0wPxQzAvlj78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZ/pPW36; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZ/pPW36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027A91F000FF;
	Tue, 15 Sep 2026 14:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789483494;
	bh=Z1A7+xwuHx5JGUiLjTZd4K3Gh6b3Gr6GxJMkhOtiCws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AZ/pPW364g4Fl63HR2KmeMQDIc7+28w/V+O6F43Ja3SddXQKipAtQwAi1mnLVLP8l
	 kKxAG/XxqlVSCbSDeY4/w3jh9za9Y//dNuCwLqC2n3nRoEolZOdL0e1f06wt2Ujg8R
	 hwvN0tf2b5l+8vHuwOVvJK7dOwB6WpFuN//zt6kw7tAdlYZoUOU0KMOiFsHuPSeIYC
	 fRp6PfORk0TYA67VTpHNnX4C+BmyqkhLZWlwLhhO0vs7ywRhTFHQWYyzveKTOM+jay
	 zSvbJkA6pKxCz5fbWiXt5zr68YMHUP3sdId2do9pL9Lw+YYFVE2fDZ/9KCmQIznyJn
	 ERQ9LO8oPFavg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] mm/damon/core: commit hugepage_size type damon
 filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260915143359.91472-3-sj@kernel.org>
References: <20260915143359.91472-1-sj@kernel.org>
 <20260915143359.91472-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 14:44:53 +0000
Message-Id: <20260915144454.027A91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Extend data attribute probe filters commit logic for the new
> hugepage_size filter type.  Since it needs to carry the size range of
> the hugepage, update the logic to update the size range fields of the
> commit destination filter struct.  While doing that, validate the given
> range and propagate an error if it is invalid.  Add the error handling
> in the callers, too.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915143359.9147=
2-1-sj@kernel.org?part=3D2

