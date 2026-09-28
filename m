Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF5748BD5B
	for <damon@lists.linux.dev>; Mon, 28 Sep 2026 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588581; cv=none; b=AZQXj0F1gaP7M1/mOlEB+c3QlhbyxECq7/tM1zJF0NTjZkT00uvoHf2stXvIJPr+LEcjbLZKLPJqwIoEcGoMPzVAQgGtrnBlc/ERPqTbT1KVC1Prf0TQFK46wqu+c3FKIT5lClz3aL51v5Y1mfemVDAN8sxB0CEzHyhE63OKeaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588581; c=relaxed/simple;
	bh=8cD/d+Iab8CUKlFZzkYkOgLGYTkHKj69XEKZ2+u5YqU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HbM91cGuR7/CUyXBwICDZvtxRUl10Afpc40sS3G07w7E+KSUZpi9u2E7Cig09wE3jgpZiEyiF4CRl7lF1UxSmMxNsuITxX1jVBXUIaXapWnAV8tSPBQoGi9xb4a+7gm2UKAKNsaFAomBAFIXpz2GiNFumbnydJuWQSmh949WMKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgJCB78j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgJCB78j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551B51F000FF;
	Mon, 28 Sep 2026 09:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588579;
	bh=ftV5kf4XW83kwkPT13oHi/DU+TvFMxOxo5thMNTIZU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IgJCB78jb2p+kVGRPjaTrgLKGQhxP9siPQmBbsimBVwF7cQWh4TMTodIEPkKYDu5F
	 zwPE+2lQYlrE8J6U0ryARVHrVrT+hG/Vqk+AcBlOXUFj1sqUCUuzX3m1I1Vm4yQi6+
	 lYLNr6OoCcGDPKtrKzqRaZbHZTSxk0pPblDqPwaUeq+N6NSeuZhyWyacBncdpsmdqd
	 uwJPXw45l6CHzf5+11j+9mJxYWIP9XJWhBGcolcUFLnQ4I3SWoCa/ykv9Wf//UdSD1
	 eFaH+KTJB/y/j0Cjt41twyMH+v6SuE4RgLzqqmSrY3iJ0bwEaqRXbnXk4lRp98km6J
	 HBvQhEz5gRxaA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 2/8] mm/damon/core: add complement argument to
 damos_new_quota_goal()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260928093342.16584-3-sj@kernel.org>
References: <20260928093342.16584-1-sj@kernel.org>
 <20260928093342.16584-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 09:42:58 +0000
Message-Id: <20260928094259.551B51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_quota_goal->complement needs to be manually set by each API
> callers.  It is easy to make mistakes.  Extend the quota goal
> constructor, damos_new_quota_goal() to receive and set the complement
> flag value. Also update all callers to use the new signature.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928093342.1658=
4-1-sj@kernel.org?part=3D2

