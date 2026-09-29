Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822DC3AB5DA
	for <damon@lists.linux.dev>; Tue, 29 Sep 2026 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668993; cv=none; b=DUXw6vOWBVYRNZQZXjKDArOERV/LaDCF4nn3/hxvk0uGWKwdcMAWRaCDBml2JESq+6dqP1CjqQTMVQR3861KQ46M9y/5DBrypWD5Bnur6JVLFEA3LU/+2EZGUmkBjO/f0L9ahibhLBeu//ohHH4b/IE5cyV0vqg0QAwFZ8OrHUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668993; c=relaxed/simple;
	bh=cpBTfHSAnJTcoqVZgGRTUJdoxEHGIb4t1Ca3Qzb3Rqc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cm33/zDIwuUj/2H2ip9YxlSghvF4+o1UT2Zcj5jahuQz0NmzAn9J4w1T2FfOmzwsr6D3LORximgWcsU+pwG6J0sgNEyrveLcou+Qg4AUE1ajI4tgVBoA8rzfRC1GBBbyf4UsBxq1VCsm/kxWfm0YVs+BQZoniwn7MD17NS2hcVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIRPMl4s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIRPMl4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21151F000FF;
	Tue, 29 Sep 2026 08:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790668992;
	bh=H107HjRB6Yzchxq1dCnyc8eTSlcN8vvJjEUq3SWe4Os=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cIRPMl4sIntd87T7vU6izFzGeNNW9CAbPrMKUY7QCkMR9ThN3iv5qXjhdnl9bUmru
	 MeFzYjs8YjKqOioKOiKCjXDVgUK4OsGxEUvTGLbPDUVp040AovU/YVsVjB0VYDOETs
	 nRdiohA6B4rlMPhxtJ0gq5z8/oOu9dmwf+WSEcgF6oRO0ij2QEyF43rGIgb5gK+N2d
	 foRIGoT2NVaYbBbiZe8q61RNoMxUiXpTm4AfFp1Mz59KuVtQ0ZVdhCdONYJ6xngEd0
	 PgWG+naHvNRNowgslQNMzJEBcTGlQSuddeEG75kJit7h2lxso9KUbfHVrA7B6D6ezd
	 1hQxygga3okDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] mm/damon/tests/core-kunit: test
 quota_goal->complement commit
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260929080113.41708-5-sj@kernel.org>
References: <20260929080113.41708-1-sj@kernel.org>
 <20260929080113.41708-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 08:03:11 +0000
Message-Id: <20260929080311.F21151F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Extend existing DAMOS quota goal commit unit test to test the complement
> flag.  Set the source complement flag and confirm the destination is
> updated to the given input.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929080113.4170=
8-1-sj@kernel.org?part=3D4

