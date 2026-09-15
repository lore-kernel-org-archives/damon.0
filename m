Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851763CFF44
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483308; cv=none; b=EJBsrNH9/jCw1MKiBqjkabljEU/stK9aR61KZDvvTl8titveDUaFxW8Dhwy/SiIbd5a2Mnuev0YQ1aDljeekWe3/FgLPH6P6mkH87SW9bS8rEtw6vtk14DcRkT0hChCpsGyVAh+01Tgf0Ze//dN5DgeA7Z6ead8Tk4KaP/W4Mqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483308; c=relaxed/simple;
	bh=GqMzAUkd1HgizMO3G4nP+OvLYNZSBg7nMj9bq7F3liA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iz2KgjYGOGO88AmypU1k/QqAaFFGf7Fav5wOXiBFqwlOYHveHZgW1oK2Cq6ZzvF9vNTD8aVgQ41dozAz/2xEamDI/q2yXL3iASGEfrrYQocxleV6gngKhp70rVJ51vCeSQMQgOm/NvvGuL3jWhL3R/NwdaVXg5ItxPjha4/8bKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3cO0GMx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3cO0GMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01FD1F000FF;
	Tue, 15 Sep 2026 14:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789483307;
	bh=rG7NJYSmTaia1pCG5fR53y3CjwROu9t5a+cWXrHBJFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m3cO0GMxAOEACCeRNODKnYV8awwzs2sDdFX8J6c9UYDl5V1ZU+vD/a5UcLInNkn/Y
	 HrqNBrP+h6WdV0vNttKthA2mjWLOYWw4OAvnPIEwj7pAI7d7+dkjoe4keJQ26CMQjw
	 +H5FlE4p2s/jNQd0dTVGS0OKgRWKe/dPO7Lk+aXnt/GQp7Gn7UGMpRX2PhohFZKBke
	 z0R63P8quS5vi/eKkOVwScHf8PqUcKZCDqrvuuLrHDR0YP0YSqvd3CePnFB4WDwBzO
	 AbFzt7kq7ypu+kAizlzcVYSJRhWUacw7uaoAVSj/PhDFa3cN5meX69yS0ZaSmzR+n7
	 kLSPw/i+jmj0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] Docs/ABI/damon: update for hugepage_size probe
 filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260915143359.91472-9-sj@kernel.org>
References: <20260915143359.91472-1-sj@kernel.org>
 <20260915143359.91472-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 14:41:46 +0000
Message-Id: <20260915144146.E01FD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> For the newly added hugepage_size data attribute probe filter, two new
> sysfs files are added for the size range.  Update DAMON ABI document for
> the new files.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915143359.9147=
2-1-sj@kernel.org?part=3D8

