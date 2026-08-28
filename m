Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1296E30F7EB
	for <damon@lists.linux.dev>; Fri, 28 Aug 2026 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787882080; cv=none; b=YBGjk2l+uBEh0fYvAEN8s+waTLZKoCBmU/P0gWW0hLIBxf1219HaXgG3baYnDtXyySJD2HctITjUnMp/irwlYWF4AZTQlDgj89PtRsRbamBJJqIZmf4f3WDrQAovXfuXXTiAa2Nu8sR3usS8J+85gNhRScEu0XePHAhD8jxBFAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787882080; c=relaxed/simple;
	bh=+AiJv2N1R9f7Af6zoJRAabiihQjYFz0wSaazDauB40I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DROKMRGqAgOuXsT9+DS8D/tS7RJYCllSdJoQR/aHb7K1CNZ+UDhztRkzmXJCE2lsRvR6gBk59HseW1O+F+2qc7oqEDWGWcNwSirRvGrpa9BQ8/4iqfspj1Kwxfb3k8Z3Qy9fDGZSC0yF3JU1O89NR0lWI9viNaN3PISiTFhPHFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYf1ljYI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYf1ljYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA701F000E9;
	Fri, 28 Aug 2026 01:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787882078;
	bh=KIVUyUZHEmTGTO/BApOwn3jrGiJnSBul/uwJzAjj/YA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PYf1ljYIC2QEOqFuiAkgjDK8WWoLwwsGSjFmBH2KKpoZ6YHC7gwYRvWiKz0bDOZDw
	 9bOdS5pBRrK1KZ73dHQtuJHufkchvDBOGiQHMXBpwTlP18Z0+talbuU9KI0sDG3u8d
	 UZvlonO1knKUgBVRQo0OixinhT+6/Z6Dlqp3daKRaq7wMxGD0/8ZRpNom9sk497u4/
	 VXZ8Fdcy625FAb8jjrE90Dn/V/aLVETJhF60HTWuRFf7KN3o40dtZKXE37OxYjtePo
	 6/5Sd21xGz+OJetmTg4Hk3G4+CqzJVUg7kNWvl1K/blrRbbY255FQtTuvL0R8Rb4jq
	 JlMAHN8mbK7Fg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 1/4] mm/damon/tests/core-kunit: test committing
 psi goal to psi goal
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260828014659.121058-2-sj@kernel.org>
References: <20260828014659.121058-1-sj@kernel.org>
 <20260828014659.121058-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 01:54:38 +0000
Message-Id: <20260828015438.8FA701F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828014659.1210=
58-1-sj@kernel.org?part=3D1

