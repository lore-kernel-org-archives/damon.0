Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FA6282F2C
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199202; cv=none; b=iBhJOyPNMKy6fUMsX/S3ETPs2ZisEXUq9l9ZZmRCqHlE/hWsECqatJJ/L+KS4+FZfdvtx+bVckp2nddtusfvYUJFf8wlxbhKNP7HTed6SbYetf7izAXK5SVxYkFVpKhCv+d8DyMaPKfRDQDFCd0wQxQUEFCeGoYZYmMAed1Pj4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199202; c=relaxed/simple;
	bh=eGNj9no3W4lKdZ84GSNS1zNYpBorvW86mvb0jN9LlAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I9d8rcxrtjXmKc61eI4Qdc4xvTVd+YJ8T0whuKyuzEMYqeByIG2XMQWeKfxsb3OjurUuLwZMMXcmcILPMKSxk3ii3fk/T8Spea2w7ldgy0HLsDNLGd0aqG92pzCQ+KQJOeABVqsHX6HoKn+fRY17FhBd5vMTt/Y+sqpt3cRNF58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CV1u9qZx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CV1u9qZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEE81F000E9;
	Mon, 31 Aug 2026 18:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199201;
	bh=XKaAtAv2jvgq8J0mm2WUov8clSJKc/dUWnAlC7F5Ayw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CV1u9qZxKy+h86/jzL3UyiiMufWeI8mFfqc0NxWon1L5awOT7dg91OSTDPNVKrTM2
	 Ldii7g1u9DawU/2a/Ya4zPHRAqOEqO5wn8bDa97hRcZ1rCgXhITdU6zr5fVi9W5KaT
	 yqsTnN+sxxFWkoH+zaVM9OnT4Wr26vMFLioAI61dUpRTHzLm0sOweWQrqyRwa3v0NV
	 frVMx5pbObT0JKwVjjA8jEzvU7MdnHq93G+K+awaMt/9C8jIkC0qCzIRMPJCV+lXwh
	 vrkq/Cm+FYJahIXW717CA2BKrCbgLlwZ4tw5zEB+HkxC8MMCM6lRtL7JRmmZH1hKkv
	 4VBr7V9lwTyFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] mm/damon/ops-common: factor out
 damon_putback_folio_list()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831142611.77572-4-sj@kernel.org>
References: <20260831142611.77572-1-sj@kernel.org>
 <20260831142611.77572-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:00:00 +0000
Message-Id: <20260831180000.DCEE81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Li Youhong <liyouhong@kylinos.cn>
>=20
> The putback loop is duplicated in damon_migrate_folio_list() and on the
> invalid-nid path of damon_migrate_pages().  Factor it into a small helper
> for readability.  No functional change.
>=20
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831142611.7757=
2-1-sj@kernel.org?part=3D3

