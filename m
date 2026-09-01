Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E19C3D9527
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269259; cv=none; b=LfNUusOo3si0qg1tDka7Culm4EjhETgaqk/8f788umNN9wH70okF2By2E4Vx+ElNawBpeq6jaT8zVhE426YHstRGVzpjFW/HSMN6b5P45XJOdWy8pQo3dSvRJ+zdz26KgSLqaC56KMR84TnSEUP+7/qSxYHPXvZ88ajr/nBjmKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269259; c=relaxed/simple;
	bh=95FXOg93SQLHMqOCmgqfELaV0KRy0QIKO3fMjdxny6U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VxWgGgtGuWHACDegsBbygy4ihHhNnCUipfbdcuVoygVBN9PUS9UEdbvMfQVejpzaPzDzt1YUqaDqPH8yKAv7KdtEKH7Kpz+X20ZEd16RxhRD7QP/ryl4d4euerM01qwQamS8L+1Nn7HOf7q1oT1Ml+TogGNh8HBgklLqimsotN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiSq/GoE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiSq/GoE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556DD1F00A3D;
	Tue,  1 Sep 2026 13:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269258;
	bh=xialZoi3nqKvt4myIuAMsmNocuo5WzEODHYuzAGyKMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fiSq/GoEdxwC1u7930j1C+hzuNYvJSaL/q5XmKN8UxQsbwi01HkS0NfjfqeSCEqed
	 X1cOOG03ZM5/YgluHtoZkE7fPfOI4q+UD8ZnQBTue+EGnWdOnJgMDev7hlZuxFmKq7
	 oOUf32baKev3mVSSfDcx2MUw4djchVMfnHor8eECj7iZ2XB2MX8yvuN+/xjVyRyvw1
	 FrQoCJOYMWtLIZJABXAeigpUbyP8YJKcZFU4IWwwCUzSJ4U+sg1jOfuempi9fvp8pK
	 tWSo6CARS0qGborjAeluQ0iyq0wfTNblrD+DPwR5UJlt481kNTEpyU5wjx9l2+SOrc
	 iqAsBrs3ijcLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] mm/damon/paddr: respect folio end for DAMOS_STAT
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901131850.98037-3-sj@kernel.org>
References: <20260901131850.98037-1-sj@kernel.org>
 <20260901131850.98037-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:27:37 +0000
Message-Id: <20260901132738.556DD1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> The function for applying DAMOS_STAT in DAMON physical address space
> operation set (paddr), namely damon_pa_stat(), applies DAMOS filters to
> folios of the given region.  For that, it gets folios of addresses in
> the region.  It starts from the region start address and advances the
> address by the size of the folio of the address until it goes out of the
> region.  If the start address is in the middle of a large folio, and if
> the next folios are small, some of the next folios could be skipped. Fix
> the issue by advancing the address to exactly the start address of the
> next folio.
>=20
> The user impact is that the DAMOS_STAT-based page level monitoring
> results become inaccurate.  Since the page level monitoring is supposed
> to provide relatively high precision, this is definitely a problem.  It
> is arguably not critical since it is only monitoring quality
> degradation.
>=20
> Fixes: bdbe1d7bc325 ("mm/damon/paddr: increment pa_stat damon address ran=
ge by folio size")
> Cc: <stable@vger.kernel.org> # 6.14.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901131850.9803=
7-1-sj@kernel.org?part=3D2

