Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F58849C4CA
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789399885; cv=none; b=RlM5jG0b25Af5wzk1cjqD8yifOtNBRV8pt2izoRgPqXiDjIWQEfBH1weMed0zWocA+LX0MSTtWq+tHbe4LVmWopuGwp0MJ9MRrfrW1KzGJba22efN53LG5LGHtSqOXhKmAAHulwRjJhAj/ZWjcBkgd3pkFsEhhC4YMq7OYorjTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789399885; c=relaxed/simple;
	bh=+hqNuExQIHvbCnGvxp60H2Tk2lo2ggCcU/nFM3WvHNw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=asmkqeZYI3FzXtwfGNHEXJAgr3/i5d5u/bp+B2Q+Yf3bVTKRjSkqsIWhmFzKWALZnWQBqtmhwt0GBd9Nlubrqsft8PLZmITDUGT5rJkP8MihBN9ECtyoad2mknxmmwTIiGOOsP+fbjU0gvqTVKHMy4zOJ13i6/SiCDgPEYefxGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtSwl8Us; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtSwl8Us"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411DD1F000FF;
	Mon, 14 Sep 2026 15:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789399882;
	bh=6lwesLcAZeHus1KgjWs0Mndgc34ivJLd4NVvaH2s28g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CtSwl8Usz1RA1qLS3pfWbUWGkazke6m6OMj5T619E5spKbxBIpaWbsfgk1DB4vZfF
	 jpeaHhJ7+ua1cItx/2Jg/WmxdJAWUOEgkACAGtTta0P7CqCXpwSMfxhCRYLseGujUa
	 dG7AQmnoKVGluPyPl2+sH//G3IgjaI5Enr8crT8D9/B8f2Ed7hc5pGjSgUHNhBnWjP
	 753J9conL6XTdua27Oeuj3qg+c/g6buA59ROW75USeLLdEaHWf+DSNl8UNnRTxtnqx
	 Mg7uUi1iEFDyQDibWOBOeFD/z3LRvs3bgy90v/h5csPdm+XuHQxQHsUkA+FTLOyf6F
	 B+SlQuAAjpvNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] mm/damon/sysfs-schemes: use switch-case in
 add_scheme_filters()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914142327.92510-7-sj@kernel.org>
References: <20260914142327.92510-1-sj@kernel.org>
 <20260914142327.92510-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 15:31:21 +0000
Message-Id: <20260914153122.411DD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_sysfs_add_scheeme_filters() has long if-else chains for DAMOS
> filter types.  Convert the code to use switch-case, which would be
> cleaner and more efficient.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914142327.9251=
0-1-sj@kernel.org?part=3D6

