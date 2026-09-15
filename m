Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361783F8EB7
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483397; cv=none; b=sDAgY0kLGRFHiKCt6g/ZJ7Qu+ut67XJFLCJEryQIb+zV/CmC4BBYmYcOCm8rPOlyTidFSqWyfDMZIszSfr/EPs9LsimlMrcMXVo76u7RLejyKkp1uPL8VG05ZscQFNVxMZCZlFmwFWaaxkBLpnB+gOny/h/CeYH/7JUcxDTuYDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483397; c=relaxed/simple;
	bh=sfSDrezOp/3FJLVMKrDjxWIEXy4zM5J+CoOjz9XwOr4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qcQ+q9EUbuscqPWlwlaanym8Ym2WCwPFN3yatCDSb52Jxda7Kv4Jy1r//9vPWjENBlxXRaxpH6rOnTc6CKiyNNIgUCzV+IikhoBI74QWWAofdxwDoT0m5M+7CsU/tLhQE+iamizHOaHv2srK6Trp1PegzNA8zPEGN1ls2KqthaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZ95r2Rx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZ95r2Rx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55071F000FF;
	Tue, 15 Sep 2026 14:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789483396;
	bh=m9msU4w0tZbkDUIXMFMM249cYM+Ecbytc5nGgTQ/5EE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gZ95r2Rx4F0ZWO31Y2qAy7o5t/7h6W8i6WEbSoN9f0fOV0YAU1x2B18uWxXbFfMA4
	 X71Go8KpzLUNk17tA5i2iIvpOyO14drW0lJ5tDe7aIiI25G2vfn70RS7KCjcTVCiqZ
	 xmbMkm/PM7T7403ebkBZJvg2GSBiJmPOnvcwGwLIMltkRLrOoV/81RFdz508dV+0il
	 tK1zIOpnxEH+D9jZlKN22z2Bs5NbNdOVH5FlHxlowHyb06kYKZu6nhFaYDnTKXstm8
	 vBKLNx8C6/MBWc3OzkIVmqZDJpaS2rD6yBa0jkxGwJUeuCZ6+iu7qfUGZQ6e+N4cp3
	 g7cmNTsYok3AQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] mm/damon/api: introduce
 DAMON_FILTER_TYPE_HUGEPAGE_SIZE
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260915143359.91472-2-sj@kernel.org>
References: <20260915143359.91472-1-sj@kernel.org>
 <20260915143359.91472-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 14:43:15 +0000
Message-Id: <20260915144315.E55071F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Introduce a new data attribute probe filter type, hugepage_size.  It
> will work for memory that is backed by a hugepage of a given size range.
> Add a new damon_filter_type enum DAMON_FILTER_TYPE_HUGEPAGE_SIZE to
> identify the type.  Add two new fields in the damon_filter struct for
> saving the size range.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915143359.9147=
2-1-sj@kernel.org?part=3D1

