Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CA52C3257
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 04:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237641; cv=none; b=IFDmgRfwheCMu96Ek0MbMT5w59NACAwxggpH5y7k0olPArXz1o6Dmsde6mk9IEgWuOsnqaMg4CalupaLIcqCKHr5WGJotYd5owa7omPIZLop5RPcreVBaEyImPaSwF1eaFyA9fNEATu9Y98tiFlxdxUo/QziZJYrLWlmncniR0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237641; c=relaxed/simple;
	bh=2LwYRSCrqC9kUlff6hUBmqrDkpGPWSQkCgXZTak+4J0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dln+2WI3Dh3AeX15ZBc2CkycvSRTa/ifmgGJE/QjofECoHycm17NEWSR106YO/4XgxGxJmctWguLTAGyagkquC2BZWqhQLObA3MctIWZ4gFnic0kpJq4OKhGKFW/qfySuJ+QSkDVfjeJFn7k7aErcK6WFcIwT6FfUk3FR7dPOrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QugD+w8p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QugD+w8p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB911F000E9;
	Tue,  1 Sep 2026 04:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237639;
	bh=+MU+NAvj9orXS16qhqO0Y6/qoiifBIeSU+Ss5wM6UDo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QugD+w8puz+DNATaRXvjra414uShjREaJOygo2KDqAqex29N63NvACTGzCA7uHLur
	 MWwTBfKQXQvjsinZe+bxFGeFJkrHGtjMMaLpSAyipVvv/Rk/tcKrVaReX0ofadoYaw
	 owp/xjdY81V4adzCtLaXxIrPGC/+YY76/nRfT2M0DyrgwmIplGwWxg1dTfFAknp9w6
	 WD9LGPU4Zfp1pSYMYNZ9GZgCGfeN/CG5Nv0JrIjYE0pBM7ybdrazsmcsbmsx7XJMn+
	 kRBlvg8j+wdC0V0rayshg0NdCEVcdQhAOd5opxyuxkwl+7GZgClLv3/29Xyvl4Qew2
	 P7PMnrSoYGChA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/17] mm/damon/sysfs: implement preps directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901043417.2165-10-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
 <20260901043417.2165-10-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 04:40:38 +0000
Message-Id: <20260901044039.3AB911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Implement a sysfs directory named 'preps' under the probe directory.  It
> will be evolved to be used for specifying probe preps.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901043417.2165=
-1-sj@kernel.org?part=3D9

