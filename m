Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E8E3D9548
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 20:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244039; cv=none; b=Grp9huxYe7C0cX9NioFIWHbMk6IXS/Yd+mFW1aNrm/+n2DJVC7/oazQbPjEtCSkx/4YAU2X3brxqc/M/H5LHiSrCPu7YJVyvRNd4tu2CZ2DQJEmMoo4WNKanYHnycB1IXvdxUn9fH9YLR8QZVf/8WoKs+76LEi3aEFd/bWGpPiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244039; c=relaxed/simple;
	bh=achJuAterL2rMKddNSEDoECyrfBNyCsLg0QCSfOUadY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QEl4+6PWgQ0jUrk7jw/fbn4UlmT2dKBdKtcV/flChEphii80YfFwxKH2QVyGPdKa106Y+/76Ug6SoTEo9VLJK75IzphhurqfMwaOYFL7n4heE1ZdGT4mKhh7iSrm8ysrzxIfpmXqU1lHp50DsWuQDyTIFVJDmCmc9BRP+LpXZ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW+HREAB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW+HREAB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3069E1F00899;
	Sat, 12 Sep 2026 20:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244031;
	bh=achJuAterL2rMKddNSEDoECyrfBNyCsLg0QCSfOUadY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NW+HREABN6LZKNX/EbhNVSFGQkoPo+CCs34iNZAdVoFP9gwZiNbPacau3lEDJpIkg
	 voht4tDKwnhkfP0N2VXrqD8hZvDO6qR6MtR2A31qlmPr6joacwx8Ffl8Kti/g/cPdX
	 qacl2HgvZxF3UihniW7RHmdSIl7GrFgQKNOHuj8ZKw6JhNDVbST4xjrF3FGF9EEAT8
	 TT5CpcQNTbnkTR1pjHTZSxpI3YG2xvGuOJ3/ndPi2bxU41wuj7bLWthrZ6h9oEl7rM
	 fSDTO7TS2BIVjoxBMwIohNF0/OPMUdNiaLZxxs/qKloEUTC7ANWPdUtOWA6AVP3tag
	 nHulvGjZa1zLQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/9] mm/damon/paddr: remove pa parameter from
 damon_pa_filter_pass()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260912200814.145612-7-sj@kernel.org>
References: <20260912200814.145612-1-sj@kernel.org>
 <20260912200814.145612-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 20:13:50 +0000
Message-Id: <20260912201351.3069E1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_pa_filter_pass() receives the 'pa' parameter, but doesn't use it.
> Remove the parameter from the function signature.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912200814.1456=
12-1-sj@kernel.org?part=3D6

