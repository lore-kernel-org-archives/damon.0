Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037B42C3257
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237635; cv=none; b=jlon83ouEILep3CXDpBs1Lx6TH+P9QGKI0znbsA2lT0K83qi1O4eldLUCxsGSYhqVEMjtOSX5gyg4GUHd+2d9s8SzGs4onQxSSleLE6wLaC8Ay4AAQpDPZ/CJ2vNs3QM4ogyTeACkKvDwSlMH2VP/63is+jR/4fjnSt3ZoyU7d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237635; c=relaxed/simple;
	bh=A5SVScjbhok1/G1m+c6eWiIZjmYegw09VlCxWuvKDXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OJbRx2O886uBDAxj071OPzNnhwJwMpunVFBk5Xx/kGldcP7sD45cWqr+aa+FV6ugVv4HLoSQjwZvMnJ6uadOjQ7fucT1UD1y7y0kDd3o39EmOq2sVEPOnyTVqUffAZ3NSKVAoAf7HL0bjmSuzGzpEido0T8x5/BXavgD1wmVr58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyDKTCYl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyDKTCYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED091F000E9;
	Tue,  1 Sep 2026 04:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237633;
	bh=fhbwuKDcTmHCdwnDTd6ylLThQnSImIfayPrv8VMpHCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UyDKTCYlyEsPg1hwXCIFnI+MlVA6zvrhKMDeaLUKhh1ypAy3A1Fu7POI6e7D0PVU4
	 wTNJXLIJeb7Aa8m0yvt2pf8F6mK0sftu8c1wOnPvBdp4hvVN/42xP8boc3q43TLSvO
	 ln9wzfpvSJaXp5n09WJGI7wGS+TncB7RhqomMSHCWpydd2HdYy5edY/IGhArx+a5a9
	 gONo3/Wy5PQMUFnuCSm8GgRTTGb0KmEbYIg8BCDB+JBU+i5Cj9+08T7eSeRWTnzMHc
	 QkMYLPQls7NxHlV4NEqGh/oRCR0bnB62IFtLWcGQuvuSmjtPG2wUwoUv+d0cuZV9rV
	 s+5rM7qmVDlvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/17] mm/damon/sysfs: create directories for nr_preps
 writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901043417.2165-12-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
 <20260901043417.2165-12-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 04:40:33 +0000
Message-Id: <20260901044033.7ED091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Implement nr_preps write action to actually create subdirectories of the
> number.  Each of the directory will be evolved to represent each probe
> preparation action.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901043417.2165=
-1-sj@kernel.org?part=3D11

