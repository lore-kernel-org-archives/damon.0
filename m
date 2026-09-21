Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF5F1FC0
	for <damon@lists.linux.dev>; Mon, 21 Sep 2026 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789950983; cv=none; b=RiVjCLKTbOYMKtzyh7tzwm7IeVncJ5RgO6qcZKm5a5+y9RdFC2QGY8AyAyIiH/ufsQ3mgXiTR0IqFDYMs71y7QJN9z/8wso5e8fJU6sjPx5NZUts0QVd+D3fQGGrddridf7vZf0Y/r80JP3etWYFm33qAicuWdGlBx/PDKyplnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789950983; c=relaxed/simple;
	bh=d+U9gRGLQHOr0Swv1gL3FFCI2sEPrTJ6lXfOW8WNFbU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dx2qLGGRRUm81kghBraJ+60Y9j5L6YMu3yyGkoGXa5S8yZxysOCmcThvR62kU/V8uG/wFkSofvaNDCcMcWrmv/UT4TFMG8u4NCt8rSbxXKBkN79peZeybUEyxPxGZJKPKTbXO4IVpChB2Dp3t137K0+9/gFyzf1MjkeYT8zbdWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkV9OODD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkV9OODD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BA71F000FF;
	Mon, 21 Sep 2026 00:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789950982;
	bh=d+U9gRGLQHOr0Swv1gL3FFCI2sEPrTJ6lXfOW8WNFbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HkV9OODDftljFCFt36ZZ0hZyuM6Qh1IkgkH5g2w6moTdvYedjcWex9qIbhxgWQZw9
	 fItOQBovZCxt5MnH70Z9I3kCHmo9Yy5QQU9QMZ7NdQxKibHPYBwBhlIX2AB12LrX2c
	 q9qfNunyMdJWJRGwkDybKhfEpWw1cY/3QYfcyF24ZgsaQ8ztxWeuFA+xib8RjM0bEo
	 pKS9j3xj40iw5vA8un0XyrnLtWgMnpNSdPdKoSdnpq1f7Zd6jvK5nqNnnhhUPtjf/U
	 5hJcIsiEeniQDzfa9Zuhj7N3VVOy6u7RhX7ox+BYilqfD5RAJL8WWYuIgLpmW8DvBc
	 eY9/DUiihSL3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] mm/damon/tests/core-kunit: test preservation of
 caller quota state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260921003047.12041-3-kmehltretter@gmail.com>
References: <20260921003047.12041-1-kmehltretter@gmail.com>
 <20260921003047.12041-3-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 00:36:21 +0000
Message-Id: <20260921003621.E8BA71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Check that damon_new_scheme() initializes the new scheme's quota without
> changing the caller's quota. Cover all eight fields initialized by
> damos_quota_init().
>=20
> Also check that damon_commit_ctx() preserves those fields in the
> destination scheme for both accepted and rejected parameter updates.
> Use an invalid min_region_sz for the rejected update and confirm that
> returning -EINVAL leaves the running quota state unchanged.
>=20
> Without the preceding fix, all eight fields are cleared in the
> constructor test and in both context update cases.
>=20
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921003047.1204=
1-1-kmehltretter@gmail.com?part=3D2

