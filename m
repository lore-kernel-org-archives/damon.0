Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD7B49C4B8
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358506; cv=none; b=YU/Hoo6IhMoTrFiRQ5GEpBDCs886o6Xd+lUIy6Ax62SViMwrjmusZAyVOrgQ0AQMHlHcOWg9kN2VCDT48YqtV/7X/kFQPCAiocJKQwMgkUHGSjsULAhw2IYOychUJlSXFhscrEHjW8MJuRhgLLC6zKyWVaLgaDdX8yKV3uZbXKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358506; c=relaxed/simple;
	bh=ToUrjO/xRjGSPPULlLnDDU2cUAum47gQcjmwLDu8+nQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WRovbCuOQWogRpy2tvsdGl5b+2XGM47wrSoHfqAtyE8sbhcIU1dfTwIetWlhC7XahUeQqRV8DnWkWMNti0a+tB3XdWJimUr69DIEFnLgt29YPdeFb6G0wYts6IQZwSkXq3OKrBGl/AARkXw/pQIJRoJ9khA0ZLly9aPs6N8HLJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHSBVzBF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHSBVzBF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3521F000E9;
	Wed,  2 Sep 2026 14:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788358505;
	bh=ToUrjO/xRjGSPPULlLnDDU2cUAum47gQcjmwLDu8+nQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PHSBVzBFvqRG1XLpmDdT4971sWMPNFTpei7rlJnm3uTODaSv6zNatQFAfd4dU2fo2
	 GwAxikTiKy5rrEYHqTz49FVHEpaMEJrRFsmIb0hxmWSLKA2fkNmtC3CNkI3JTawt20
	 Ne4ma49QApG5q/9m9D93kLnyZ6Qtj2PEyyrWH8LdmCJNPEzU+Qcd0qG9xJMc9jGl/B
	 nuAQeyQ82LOzBk0qiwA6DCFR9i8puXiBbrL0UrgGk4Adc4hlJyqD8eTZb+TDCVkiDr
	 e914qQt9fMzte0LZ9cp9lnd7GIyTL+qOc8To0WilWoOCO2wfsm9gkJMAUxSNPfMm8U
	 VA4D83tXkeBJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] selftests/damon/_damon_sysfs: implement DamonProbes
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902140313.85983-4-sj@kernel.org>
References: <20260902140313.85983-1-sj@kernel.org>
 <20260902140313.85983-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:15:04 +0000
Message-Id: <20260902141505.1E3521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Extend _damon_sysfs.py to support staging and committing DAMON probes.
> It will be used for setting DAMON probes via sysfs changes for testing
> purposes.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902140313.8598=
3-1-sj@kernel.org?part=3D3

