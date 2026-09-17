Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A4124E4C6
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 04:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618170; cv=none; b=BX1O1k+vxOb4pw/8cGj6RCPiNyvMdydmO3szAHe4pzMmd0tYi4IPlDoENUfoWM8LHNZT/wLaotByCaYwY8GaNEIfLJH6xGOM/nOZIzo7t2hQ+agaJ1ZKtyovc3zIgXWyTenFHlZvFg712A1EfQPckFTAB3yYnlxjAiMxhznM0t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618170; c=relaxed/simple;
	bh=8gIw791MvgRd23OWxsbQo20BVYOrrsXm0WnNdp4XvNk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FFvZXOvhHi5bsM4hSsDDLvkXKz7/fv6sq2ZT7GUAuUilvSeoHOiw3W15cvhgzFbYl74zycUep4xASKiWkqKRh+FAy3bVAx98DI6tJLOiZW/xBuzqtLj4W5VJFLmsJi50F/4HkcLHGvocn+j384YfOCKZgVZP4gQ+WsoeS2xUIVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uj3sPh5+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uj3sPh5+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E14A1F00893;
	Thu, 17 Sep 2026 04:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618168;
	bh=64jCcNGlE4/xxSyps/eplZVYM2FXIE64rL9Zy7Wl+Fw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uj3sPh5+NiQBFLSo2W8o7mejZk462dfe02ZWduaZ9zj2kA38qmO36BO6bja2Et5TH
	 NyMiZoTCH/+XPwjtJG0r//UsJo3m2v2iRshFQqTSOMQB19DZF+J9uBBbyQBpRynhvM
	 AoL+BZf841k1uW3mbL2NV9WWKS2LmncdmDdtwNum0V9IWrEqcdUTI/A3lzq4EyeI2j
	 H67asBiA48H5dPF2G2kjwewnUaRzLpLqjLoaxyDwbDv7HL2DFc0fQWD0Q5vnyQByiF
	 oJX5Hvrc21ZDnhqFus5W7y6u8HPXxr6gReEU1UCNUkrNMhBmjRDfAJg8iqI2NPWtWL
	 423Idj2Q6Kaww==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 08/10] mm/damon/tests/core-kunit: add
 probe_hits_wsum damos filter commit test
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917040537.107341-9-sj@kernel.org>
References: <20260917040537.107341-1-sj@kernel.org>
 <20260917040537.107341-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 04:09:27 +0000
Message-Id: <20260917040928.1E14A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMOS filter commit kunit test lacks test cases for probe_hits_wsum
> filter type.  Add test cases for probe_hits_wsum type DAMOS filter
> commit.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917040537.1073=
41-1-sj@kernel.org?part=3D8

