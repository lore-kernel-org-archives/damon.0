Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAFD1448E0
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 07:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036822; cv=none; b=b1srLvlFUhaPigLpzzpJmFi2gsVOsrdM/6fYqTnc+MAQ6B3jpZzR79Fd09wbekD/pVxSMur9NIcO/MP1YJ8G+pjrAmR8ned5cq8q2oFrmPx8rIefFo4i5nsshZ6JWDPQlfCh7mirLgFoAdv/8YB63SiKZI6E9EqW5YUpPZXdywY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036822; c=relaxed/simple;
	bh=DG2y/Q+rXebvCXjhy78jWtxCZ0ylO5gktzyw3f1HVWg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DGX3Qxtwhw4WxF1W81qOaU6vPx2204FJAYrR+b5yUVNCfO069CoFGPqKIqCtgghD0qqnCjgPxpulIX0IWtiNPk/caWNHAN+QI6ygGEMospQ5FzchcpWfH3rV20PpjgoxUFvR66jeSHmwC2I3ANmUD021D8/5942okdBY5yxyT0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHk2iog+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHk2iog+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE40D1F00A3A;
	Tue, 18 Aug 2026 07:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787036821;
	bh=DG2y/Q+rXebvCXjhy78jWtxCZ0ylO5gktzyw3f1HVWg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jHk2iog+lry0jQ2xgnDd3lR1ssXJqmnzY62Cu6HwLY+64edqQ4xsITRwTkHTTYKKB
	 GLohUk3woI90AfzEY8K4IKJeDk5KQmhZM6ZuklvG8klUE6Nd93bGAZUKjV7cUQ82wv
	 PfCRhc+4GLYbEr1Sttsn0wZtbVIUuLf44BfbLIRmt45FZatdadiw++XveGqwTw3ZFr
	 MRx3E8CmHis3ki8DTZ3MkZkg+wE8kxOA111xYcbbU+E84RuPQje/SyYi6X4A+wI/55
	 mIJ/Q0slopp3wlOnDD1zirkpFMHAdcsI+lGiFdLPIgMsbvYNYcSdEGGO3zuNy5rnF3
	 vVHY/mZXdrUNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/7] docs/zh_CN: update DAMON reclaim translation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Doehyun Baek" <doehyunbaek@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260818070358.455768-7-doehyunbaek@gmail.com>
References: <20260818070358.455768-1-doehyunbaek@gmail.com>
 <20260818070358.455768-7-doehyunbaek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 07:06:58 +0000
Message-Id: <20260818070700.BE40D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update the Chinese translation of .../admin-guide/mm/damon/reclaim.rst.
>=20
> Update the translation through commit c9380cdd949d
> ("Docs/{admin-guide,mm}/damon: fix DAMON documentation details").
>=20
> Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818070358.4557=
68-1-doehyunbaek@gmail.com?part=3D6

