Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2862355057
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320152; cv=none; b=D3z1kAFfSQt9+ocAyQuh5FwEr1IAUSrxC1LK/IUeSKAaJDSjtyrH9M7wglS9mfGfuVz5yjMBzQB5gyAdL40cvW4ZpmCAReGs8smS9xNnU269IaUQZlb9aS2+YXWOEl4lkGwUvRxNdWLQq47lem06ZooNdTfMjMPPr/FwfQPGWhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320152; c=relaxed/simple;
	bh=ISA0nOd/gEWEk0H0YgfsjjGbjKaLeSI0Xh0j0o4TZMs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=miIHnulfGepYgfGombJ+CGLWUKdeDg8PBr5vVDymL6nfkjV45fV+K8/GcGBJPhF5QYBAt77ghVhmlPb93Qb8klkszqhDfe1hPkb5RwLBHlW9zoG2JQ+ebwjWpt+Fujbwgek+RiFEW35nLt+T1EsLjzR4YiayLwEgPZMW36t/cpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EL+HvM6H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EL+HvM6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0F01F000FF;
	Sun, 13 Sep 2026 17:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789320151;
	bh=PHlIbWqNS/mOoZ1vuxEQ/ZCbFobRFO+iGlYmbzrWrjo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EL+HvM6HROe6mM6qzqbLm6xsYGVyufAnY83kHWI67+n3FtdkJEUwFWr9R1kwLTHIt
	 TdFziKgSEuoGuyUf14xyJZigKVDB/h+cfB37XHlxWY8Mkbfn2qOzC4mYi2lYTHhFN2
	 LtOWi23GS1xE/xKzW1/LVpAft0FkGtm1GcFRYhctwireV5RNAI8ZnGV2i8upycfxg/
	 3LFoLOgmRFzkNFM+9MNtOza2FDrGLbcGk5EWRvmSc1DFdBUH12dNCJU/TkWRDfKOEa
	 HuZmKK/s9IBtea391KtwNb5ZIqMt6Ux7B9j16sxbfF6P46H62mVuSakibmGyQTWhRP
	 dy+6FbSYUFBmg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 6/8] mm/damon/sysfs-schemes: use switch-case in
 add_scheme_filters()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260913171706.103052-7-sj@kernel.org>
References: <20260913171706.103052-1-sj@kernel.org>
 <20260913171706.103052-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 17:22:31 +0000
Message-Id: <20260913172231.6C0F01F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913171706.1030=
52-1-sj@kernel.org?part=3D6

