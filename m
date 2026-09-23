Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906172236EB
	for <damon@lists.linux.dev>; Wed, 23 Sep 2026 00:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790123489; cv=none; b=HpPSdg5cG0K0A7isP52kFwgRI2sb/K+01URtXJSjVUCdmJxtlx6zhrRXc5hHTUtFE8SJtrzDWas2c+10tU9otw79iZd4oa1j+L99ASvV8ZN/b7QoDgzF9ytaphsfg2uozBDn7W57Q4s1RJbn6mhL0rSX2i36kk5PWHCoxG18edo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790123489; c=relaxed/simple;
	bh=RPA4a6IIfzujV0iZ9bIDm+qrO5ajtBv2DqCnUu469Ks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FfoLf+HrPUu63Z+JgnGGGu7U1OVSUFt6pE525d6MI+CzgarN3KY8bQLlVhFybOsSA60NV4GIESzlVk0p9ggaXdgs7BxVluA3Fu/mhylWbeFQOsXqoXaebbHniTpLLzWCTxu8t7kJ39IJR8ufPIRDwfcXYihN8ogW1lMse9QBfYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E49W2i/M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E49W2i/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F731F000FF;
	Wed, 23 Sep 2026 00:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790123488;
	bh=n1PPiwAHVWagD2OdcXniGbttQ3F1lK5AxlHGsQmPM8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E49W2i/M3cvXKNdZP1wMxmubWAuu8YCcJq4SauiOl2+MddHH12nXOy+lacJJg1SSw
	 eCmRII9ylX/8MYfmp7/XNHlUnQbL+/HFP9C0iQTAbikcuvsxmgGqV0jnt319hVlzfQ
	 rderuEEVKFIPmBdpipL/OBaDxhEJAE8zhCYAIGYkN46YM87XSsizVsHhY7ynPgKUpt
	 VHouf+EDb8fydTY5DPHFEAKXmUw6w+Yhm87QMi89+f6QR0NgFCe3TFTE6cma624Zw4
	 Luk8XYtGNewC1YXDC5sSVkh8lBEnQVUmvgnZXgawR3XA4kjGyfQ6meWay1aciGK7bD
	 DOGXfYG9a9aMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] mm/damon/tests/core-kunit: test the temporal
 tuner's size quota conversion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260923002600.1825448-3-donggeunyoo.kernel@gmail.com>
References: <20260923002600.1825448-1-donggeunyoo.kernel@gmail.com>
 <20260923002600.1825448-3-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 00:31:27 +0000
Message-Id: <20260923003128.19F731F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_goal_tune_esz_bp_temporal() encodes the size quota in basis
> points, so the conversion is exact only up to ULONG_MAX / 10000.  Pin
> the three sizes around that boundary: the largest one that fits, the
> first one that does not, and ULONG_MAX.
>=20
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923002600.1825=
448-1-donggeunyoo.kernel@gmail.com?part=3D2

