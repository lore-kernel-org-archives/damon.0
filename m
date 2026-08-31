Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDC835C692
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199135; cv=none; b=ubS0840BEOo2ftke87u2q05rx2J1nvjrLC07rMzqK8d9iSmhoii9ehEATfmCIYume51E60t3giQbeMOHPi3E7vy0q8MY0AFqs0QZb5/F19mA75nCXat+qXabPwT4pR8sul+kDqHM+L0ltKzr4agc/FTpOoz8LBx6+l9hTYP7lb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199135; c=relaxed/simple;
	bh=ITZNRIFrIw3XnPcMMsp9kE9VN0v59VJ/xfAILWFbIIw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O5OAOqTz9GtsXAZxhAXoAK+pDnTeS34lYsXxbPSdaUXHiditGEC5HVaxiG9nttFtQnFskOOpRZMdQhKa9vImlRztWx+A0OE2yQhihi+QKvdrJjAfuyqSFwyKPkHW1r8M8smH7JkzUXDniJrOLcAUXHzzw+eiDhT/v/Rusu8baZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnjYIRe7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnjYIRe7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C371F000E9;
	Mon, 31 Aug 2026 17:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199133;
	bh=eFJbg71qqB69gpqC7Qj2MjaI+acSh2nxRLM/cW3p990=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hnjYIRe7jNHWclDLbYrgx6OdtCpCAuvXvU27MbIOb8AwS2tzYfMIAyG0gF51Gwl7s
	 m0S+xNzouD4NM8KtW4jnzyOmM6Vgna/sH6G5sjB/t5C+Mwo0XGhb3fDsg08wtWSC3d
	 CKa3TH6LwXezkWd9YEeIdj43nqUyJGUg7PIX2FchrfM8dylZjc3vuyhnOCB2js1oAH
	 myATBFL7+CDjR/TPuPXMlaYNnZR2ESs7cMyTbPsrMghS0wDh7V6VEEmipBu/ALOOY5
	 /QEFmTLVskMH+nfHG/NjReE5WN/hX7WJNsyt3gsBtapWo7+TpoChOMtjAw17XSthQ3
	 S1I3Rj4tvYflw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] mm/damon/core: introduce damon_set_target_pid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831142611.77572-3-sj@kernel.org>
References: <20260831142611.77572-1-sj@kernel.org>
 <20260831142611.77572-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 17:58:52 +0000
Message-Id: <20260831175853.15C371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> The logic that finds the struct pid for a given pid number and assigns
> it to a damon_target is duplicated in multiple places.  Including
> damon_sysfs_add_target() of mm/damon/sysfs.c and the start functions
> of the two sample modules, samples/damon/wsse.c and
> samples/damon/prcl.c.  Add a function that does the work, and replace
> the duplicated code in the places with calls to the function.
>=20
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831142611.7757=
2-1-sj@kernel.org?part=3D2

