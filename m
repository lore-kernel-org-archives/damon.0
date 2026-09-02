Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014322F260C
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 00:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309273; cv=none; b=ZHbOPn6PsKupj8em3t/eCYa+SkOlQYUkocNXhdqDoIYZC2ISQpBkyH00De7XYHmMPfWy5nYGTZKam9Iq+//7cIzhODp8nI9OvKVwTvc8FqpXl1UBqZjJ8BZMXX2PxJy9jmL+2eGcXVOiE0THxopCdaWBQm02eKSIUd/RO0dmV6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309273; c=relaxed/simple;
	bh=CuvGME675PahrMNaidlbqN0+RD7Bo90hIF2WrhRMx9w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H/QQZ7ynlDP29og2WnWTCrnwudfkTQjtvYQ4IIMjZ4rQ8Hl3V5i3ejMyUwNqos8XHqziVYpUwMXmS8InzVaYBOwIycR5GVuxYntPGs5H1NNNekCilujPKpcA+cueNlulIrTgNRvHFI2/DutC359B810y8FS7m8txlwwilY7X87k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6A6oamj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6A6oamj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C0F1F000E9;
	Wed,  2 Sep 2026 00:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788309270;
	bh=lgSAzp5MI3tN8fg7qmIml2PvqYVowzCF0T98PEQ47s0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n6A6oamje9bGP2c2zuB74R2oddsMyF/j3KftegUb7ZnovzmGudxj1VLgpIoPjhgfd
	 3+PmmQKPsRWJscRSDeRaO4M8KFM/SWIGfGPlBYO3Ny1qFHYY5R2MHGdQBsWxreSsv/
	 lwEbYs8nllVcxTsZicYV5Hkxob+i+J7XsTRudD09AgYz+Pn3b5Fq4GIEl/uJ4R7ACJ
	 7kSuNOuSfaADzhs9AZ1jKkwu/UMYHFWVOPTWsh+bRnnuvSP52RX7buuub69dI7R/8G
	 I1d/r+2qoqSEMBhpNc0fjRSBnJZQID1vqGrEOU8k2ignHH40xOSkljYEfsCxwX8dbp
	 9DWEMYoeocYuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] mm/damon/tests/core-kunit: test committing psi goal
 to psi goal
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902002725.108635-2-sj@kernel.org>
References: <20260902002725.108635-1-sj@kernel.org>
 <20260902002725.108635-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 00:34:29 +0000
Message-Id: <20260902003429.D1C0F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_test_commit_quota_goal_for() is set to test committing a new psi
> goal on an existing psi goal.  However, damon_test_commit_quota_goal()
> is mistakenly not covering the test case.  Add the test case.
>=20
> Fixes: 99f89debafc5 ("mm/damon/tests/core-kunit: add damos_commit_quota_g=
oal() test")
> Cc: <stable@vger.kernel.org> # 6.19.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902002725.1086=
35-1-sj@kernel.org?part=3D1

