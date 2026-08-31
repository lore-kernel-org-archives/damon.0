Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C9D39D6E9
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199816; cv=none; b=JAIegSrRwyLxe+Ooqjt2+L20OjvnV+FbQ5bkDqOg5mmJNndFV24A7dv5BHZrqLnRfjV779VKQrsCBlhUtNwXlCVDyzB8d5I/ANnxIxJTQ4otVghhBxTrw0fxyganu4/ioHTmLGIAAid5Ynwv7/cViS/aRxnSzDdN0biixvMSLaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199816; c=relaxed/simple;
	bh=7i6ls8sPEXOlvtAXLawqEDrojwvEC+kwCcvsDL/Sa5M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kRntiWKCygeo5TB83XXVTe3rBRcpwC2JOlHcg9Uq7XCCJn2+giSz3OgPgUFhYnvmqHNB6PWMGcvw7dhoWbPH+UBbZ9pSOki9UgiV8XOf0ZdOJeeafzl/r3N3BMnoyZVoEV1yrX3lqbyk5Z6uG2Y6seaqsMWYdQZsIeYvXiE2YX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZYmQH2P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZYmQH2P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF031F000E9;
	Mon, 31 Aug 2026 18:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199814;
	bh=7i6ls8sPEXOlvtAXLawqEDrojwvEC+kwCcvsDL/Sa5M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KZYmQH2PASh/Pmqpd4kCULZidFFFcazL+xuoIyQi3J+VJpTArJ8M7ZtXYCbZ5WLG3
	 Zf3asXRiqSsDSm5MKMSNUQzxjVa11XPEFz2Z9dEDd1BimM50GAr010/wYHB4iWhZ1h
	 wrlrEA3nqy27XOnHfXOGUeXzZ68tFZe7/eeqobP83h2kDAEjK1xthreJMPMMtsku9r
	 1gp2vSSHt72V/4b6CZhDkmNQoii2y/FZca0/rQ6m1Cb5qvfgs6fWDhtrI0oYubyU3e
	 xUslnW+cLD9jlyYjvGMLPNSo0L4YiT0i+OgeJp58ObVD4mflYR8o510yWciHT/QBur
	 bROukTV5ywW/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon/core-kunit: test probe_hits handling at
 region split and merge
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831150650.84829-2-sj@kernel.org>
References: <20260831150650.84829-1-sj@kernel.org>
 <20260831150650.84829-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:10:14 +0000
Message-Id: <20260831181014.8BF031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Jason Angelov <jasonangelov@ucla.edu>
>=20
> damon_split_region_at() copies probe_hits[] and last_probe_hits[] to
> the new split region.
> damon_merge_two_regions() sets probe_hits[] to the size-weighted
> average of the merged regions.
>=20
> Extend damon_test_split_at() and damon_test_merge_two() tests to
> cover those fields.
>=20
> Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150650.8482=
9-1-sj@kernel.org?part=3D1

