Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7D93BAD9B
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 04:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618189; cv=none; b=lAz6Ubebauhxj5Kld6Dj5hVytrFInAysCbDPESxnhUf5FBf3k2USB0tofoyPmUOo8lvo1uSbeGdwwbwHqT42PB9mdBuom/B8jmrUh64n6d2nBWP9KQQe1o1k33+ZRTbCEv1ktB468BR91HqMLeuFJ9FJ/Jc5YifJ6Hpd9TBJcMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618189; c=relaxed/simple;
	bh=lqT36dN+HbwOzSeBT7XD+4/alXBJgylTod0bf6H3WLU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B4EYTVEh0OaV4Wo7wNTqcRPAH5My/9A7ZiqV1stXByc6kPurO5dC/ouBLbo3p0mXzJeDyM/sX/X1yVIBFyB1m2qBivIT5eyIPegoJYPMW/BcJtZZTcgAA4jhN2Jehl8K4+Z2kwbagUxre4rk5DY4MWXTtcLfpT13nZjdmaQHJDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkRnxifW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkRnxifW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD031F000FF;
	Thu, 17 Sep 2026 04:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618184;
	bh=oHnf02UvBy+9YjKjSpumO0iGibjS3RuDD3q/idDmCzk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SkRnxifWDTlckKX65qNWrI3vktGbsAK2wKuxD5krCmhai+gUj5kOYcMjiUNKGLmXh
	 duzqVJeGgg19NARytDs4US/I4j4DJLOG02tZ9dwpfEWkCjUs9CWhOHKVIKKKKZP8Fo
	 R8SqQqgWTuLpLZPNBi2rjebdtvu2o3ObCl1sjWYZm64fq50TGg5T+4QIHvKnWIFAUU
	 VA1DXeagL217YLeQw6sT81HOrM54GtYndrNbPxbq8T/ILQnTDd+How9HgH+2cBqIQX
	 g5ffHPuq9/EItdrUu/ZwMXeg9Leve2iG4PxLhnZn9hJcRMC218bT/01E6JWzkF0bIt
	 O774EK7A2WSig==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 01/10] mm/damon/api: remove NR_DAMOS_FILTER_TYPES
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917040537.107341-2-sj@kernel.org>
References: <20260917040537.107341-1-sj@kernel.org>
 <20260917040537.107341-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 04:09:43 +0000
Message-Id: <20260917040943.CBD031F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Nobody uses NR_DAMOS_FILTER_TYPES.  Remove it.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917040537.1073=
41-1-sj@kernel.org?part=3D1

