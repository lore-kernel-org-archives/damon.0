Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E763424D75
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199964; cv=none; b=AgWZOzAdaxP5o06H1MrxKu5OSReucXH2CVBkYm1fYTGq8PbxhyzYp7eIurkAu/iGuQwfjPcRdKQoYLCROKJXpgpKUEx80y/1ZVArkr1zDDarJupoOePF/FLhJSy02TauQRIQDc/2HIHXc8vWCGIdQKc6kcIKkcqnY4JK6HTnIuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199964; c=relaxed/simple;
	bh=eercJWz6/L6eH8mFyL2z+rwK1bJ5tsQVA+YYukVD7U8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qcZ/KGG5N8xiz8vrgdR7BCwZ+yuU2hQ1DAinVU4UXQoA8Pd4iVGVlCbsI96RKei3OLXWyA6vZE22aLqXxmT+hdMlgla0jTb3rlJ4Tbocdf7zjwSof9C6am/bLvNxsS9sAHVpTff22kmf2cktVpzzCqpU/56T+CGvZvKkSimDaKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4t//WEU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4t//WEU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B20C1F000E9;
	Mon, 31 Aug 2026 18:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199962;
	bh=eercJWz6/L6eH8mFyL2z+rwK1bJ5tsQVA+YYukVD7U8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i4t//WEUoJ9TazXydYwAYH+vMOg/2UBgZ8h6xn5e/EaWG3ZNLO8RavjcwaVqtHVbn
	 x2tu2sXuZd3Rq5BhSokbCfVARpkN1gpY1Q/Qc6Wk6Uq7S3hqyhVEusFrl7IHM6QvNk
	 UhZ2etGitsjagoz5dBkdHx6D0RUJvxWrAfwbfi+nuB5JHFbSWDKf94VT63E2Gi+IhP
	 xWAnTZgrtmAjils73JFoG6dvk90kIC0JBIf3pRCZOGMidhJAPB3ESXOHMCPwwz/Fo6
	 1xergIPDaS+S7xWMa/FPfPR62D6++GrCKRT0H5cB17L240bNXOZ5VabBXtHJsh+2Bg
	 whexcBISlt7ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] mm/damon/tests: use scoped_guard() for
 damon_test_ops_registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831142611.77572-6-sj@kernel.org>
References: <20260831142611.77572-1-sj@kernel.org>
 <20260831142611.77572-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:12:41 +0000
Message-Id: <20260831181242.5B20C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>
>=20
> Replace manual mutex_lock() and mutex_unlock() calls with the
> scoped_guard() macro. This simplifies the code, improves readability,
> and ensures that the lock is automatically released when the scope
> ends, preventing potential lock leaks in the future.
>=20
> Signed-off-by: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831142611.7757=
2-1-sj@kernel.org?part=3D5

