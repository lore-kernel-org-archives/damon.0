Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90A4A2055
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358512; cv=none; b=W3P847ku806tBNqUeU8JxcM7bLwE3a8pOJk8yt7z/gucJXuVFkmaW/cQzF31d6HgykQfypwj1QkYXue6Ry1eiSl0BXPnhLGvdijCyLWfrzugwaQ9O2iNOH6l+T6W1NwA6648+z/pgyEwMUBltoyQ5BMnGiz6JdKfcKXgD9ySakg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358512; c=relaxed/simple;
	bh=WdQNUHkaLmLTMrMNaTksIOy9OFBpjsqU2D1N7LeGaKo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HEl0P/yo+j/OoJvN8a6SMuA1okzyBBaoeNTCbqpq0KS2CvFZq3kHt9Xzy2Gc/ohVce2HTtCwQUI5S6T4ZRP6DRlIblZm2nBovKCrHVSTDOtSqnf0GhgPI8nIoTAlosns9GJhYiB4+C3uFqNTeCYbrw27V95bwju+L21SlG6M6L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dk2TgueH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dk2TgueH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA05D1F000E9;
	Wed,  2 Sep 2026 14:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788358511;
	bh=WdQNUHkaLmLTMrMNaTksIOy9OFBpjsqU2D1N7LeGaKo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dk2TgueHmNw3FH5JgfhbfgOZ/XqpHFAHshQL3O0wWnLJNieSA+qZRxP2c1Q4bgn7n
	 S4emWcWrbUJa6IX933jKxLDEhQOVO5x9O4pq01SMlbBRKlXgfoUlvOa+Ge1oPIZmSM
	 pUZTaW3CUpI1LDwpCrOU8POJMJE3lKJaUa7GB8xLU6f8Ez6EfCqb1uCUgslHOfD+VO
	 GqF8X3OAMopmXlkiVoEmzJa/cMJb/b1yGU4zlsYcIv+/uyUoiH9DKwZElfaTvMM/DH
	 rcejsLD3u0VqcsneBeNMV9VUGaVcmlnrvddHbWNIG1AEpQ68VE9DT3wt0DOg2sdNSm
	 6RSdWK2lEq02A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] selftests/damon/sysfs.py: test damon probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902140313.85983-7-sj@kernel.org>
References: <20260902140313.85983-1-sj@kernel.org>
 <20260902140313.85983-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:15:10 +0000
Message-Id: <20260902141510.CA05D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Extend sysfs.py to commit DAMON probes via sysfs, and see if it changed
> in-kernel DAMON status as expected using drgn.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902140313.8598=
3-1-sj@kernel.org?part=3D6

