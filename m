Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE80B2EEE83
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 00:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605766; cv=none; b=dctNv0MOFMd1WLU1YgUjrJcownqP3A6SjmXMwUVSsNMVH3j+FzRMjiHxyiLllP6s0LpmLumi2iWcwTiluMEKOpLpiRuLaJbNz+bmLxpdEe7/Ek6o0ny26Nch4Nz9ttleSG/HxqxnhC3I4ddJfvKcUHfdtFg/f5tXuDCHxgoepmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605766; c=relaxed/simple;
	bh=DKwQEswWumINr5JisiGcrIZ1BCCpIACA7HKuDd9nyck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WyoMkrcx+EmdLPRvBAH8yOQ1z8VVl3kJsoi8lqCGHJg+C/Ndb5Kh5JvFXWQGseks8kHklGvxBpY83hVrqD9hbMxl4I0oJD/awOgypylfnyBiHimkLUx8TRpSZfqj3+H6WyJ83t+ZD0v7MxgArPcA0CpMsY0gF/txvmgsM3mf2hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7Zf6z1D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7Zf6z1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242E41F000FF;
	Thu, 17 Sep 2026 00:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605765;
	bh=E/ETICNWYpg9SUfxlu4EzoAjsQ7C8oMOOxz033Jq9bc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f7Zf6z1DuL9ByXOUpzzRM6kIfBHpJwEVLyEwrd6PXyY5G920RvsCnGUPnvkoZglU8
	 tTpg0tWZCpeyX8Fz3uWdpLxvkGwE7MEtxQ8kKbXYRjgzgbJzifgSlE+aIRjr63AMHN
	 F+Fg9ATKVNyAHJKwQ4fHM5pPJESi3IjXpVhvoi8I7VkD3/BxuOgXadhQ86fKXgbQpG
	 HIc/cowrAHkAEDh1ibnvuLRdC5bbrg0TCHhoZcHLehcU62GbotcVF8pUZDRi6LNTUp
	 ygD3rHnJqpcpxSQdZH3Bitq5kakngPpidYBj7JCYV0z8cDXhPJ9rUqcnlCPYVogdlI
	 zWply8Ou5wcIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] mm/damon/tests/core-kunit: test the size charged
 for a filter-trimmed region
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917003553.2465523-3-donggeunyoo.kernel@gmail.com>
References: <20260917003553.2465523-1-donggeunyoo.kernel@gmail.com>
 <20260917003553.2465523-3-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 00:42:44 +0000
Message-Id: <20260917004245.242E41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_test_filter_out() checks that an address range filter splits a
> region at the filter boundary, and stops there.  Nothing checks what
> damos_apply_scheme() then charges to the quota and reports as tried.
>=20
> damos_test_apply_scheme_filtered_sz() covers the two ways such a filter
> trims a region: one that starts before the filter's range, and one that
> starts inside it.
>=20
> damos_test_apply_scheme_filter_sz_unchanged() and
> damos_test_apply_scheme_quota_sz() cover the cases whose accounting must
> not change: a region wholly inside a reject range, one wholly inside an
> allow range, two filters trimming in a single call, a filter type that
> never splits, no filter at all, a region the quota trims, and a quota
> remainder too small for one region.
>=20
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917003553.2465=
523-1-donggeunyoo.kernel@gmail.com?part=3D2

