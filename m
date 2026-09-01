Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD59512E1DC
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 04:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237360; cv=none; b=HVWMFZBdjcmfIJd+QGOJoUg/fP6mMWd13DCxKt9f40X65dbca6+yC7k98Gm0bEr49eITDHb+/IWWMYwlZ/wzuw4j86imWCVdBhXEGH2TKALDvgKAmiMKeRnSSMi6IT/EJVWu4H1r0aa+59mlg6vJdzGQ1QKgrILpDAmHPRgo+0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237360; c=relaxed/simple;
	bh=BvceWLtOxbtQn/Bk4gmoNCmwk06yXH6ezO9sWnxcabU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s5o+tPFB23lHXFUX5bcHfiJvm+8tgcOMwPPT31Ni6ZYj8/PP/3604Vc+x/mz077dzPQ5Q3lM8JFx2AptIdMxRP2ZkDZlIZ+8ZUFrLT4VVO9B/oFCno6o3vOfmbf+pNlVwKrLML/n2G4um5QaYwntm+BOEvBltysoLIJoboiDZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi5LWmQs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi5LWmQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328471F000E9;
	Tue,  1 Sep 2026 04:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237359;
	bh=BvceWLtOxbtQn/Bk4gmoNCmwk06yXH6ezO9sWnxcabU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gi5LWmQsHy3WiYCcgwXoxaGOKjAyzkoNjHRtthW0lld67aLWJafgwcUYFXjObZv/s
	 tX/zQ36QhSt01y8mnCWzOiNW+4UpfBC33d6OKkQ4PWvCfqATRzUqmKentOChxS3Xra
	 dRgTY/NpmJXIGWcMt6oXXJw79eH1NEdCbEsRMxXCzE6GZh6ivSXXJWjoqw1rbjp0OM
	 Mzi782pV/6EycTloztoOu0lOaqmMQ1l9Z8CTbobKD3SswKO9Em54hXX3uNts6fRQqV
	 qzcleovJW9iEXVsRcrPNaZkaLMmHkGNgh+JqgAzH5KS88e003klQVTYZBD0WKGx+IL
	 4FWsqIp7XV4iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/17] Docs/mm/damon/design: document probe preps
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901043417.2165-16-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
 <20260901043417.2165-16-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 04:35:58 +0000
Message-Id: <20260901043559.328471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON design document for the newly added DAMON probe preps
> feature.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901043417.2165=
-1-sj@kernel.org?part=3D15

