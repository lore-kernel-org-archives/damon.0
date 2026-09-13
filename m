Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5381340286
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320765; cv=none; b=sukBPgULBxtFaESqIL6+SbMZ23Vty0S5+z8tz2X7x7qwn6uNphGTgLPtnkDNT0E8zsO2ahzYgEbbk9JeB8ZZkPJB5hh7F7vIFsb7Ox6tJeN0c+ma1pzYLSkQ9osZ34gAkymOKXJ8oZxKWTW3p6oTxlMy0Gg17xKlopylOhwSQIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320765; c=relaxed/simple;
	bh=jSHVmPXJHHEIldaXV1VN2SaU0KYfrsUjiOaFj0wJ18c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=un4wv802THAeC5XuCS/V+o0Zo8iiE3nvOALdl2OQ1eBMXRu8JVG6XXEPSs6PQQEMsOgtKb70heIy51lyaCy9fs6Zgbze96gNT2PtP84v/NEKrVgfdMWtPG5xFCGQrZ9Izs3ucS2zS50H7/TIWISYCj/mqyY04dSIrHR/95wEV9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5iq0nhy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5iq0nhy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200A01F000FF;
	Sun, 13 Sep 2026 17:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789320764;
	bh=Qga6023slI6fyF8kqZVXCnXzgTapdtma0NLk+l1JoBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c5iq0nhycuxZ8RHYfhmybpbHnuGAQTvRwmxmQbec9CFsD97p/PdLdgiH1xQO96UIo
	 bA70T9r0ulJ4FRqOQQUqqKzgODbOUVQ7js3uthOhf+IQHBaX0kkAA5J8zRnYypxcdX
	 JXzdOesvA0z6jDMDDixJzXGUQYvADMkQnPlcTOmMd/AAuyoSj4ig6mRDlLPZngEdeu
	 kZuc+IifQkX+CPCGKVX5PBaageLvPn9utzsoZGS2GphniHrqxsUaXdQXkZG00nVBoZ
	 tFUsR+2p6eAcsH1814hd9/BbQiAVZJtcBTy37CKKWiklFFR45W+jDm+LiP0AEZ6T8+
	 6jfd7A4Y2TW1w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/8] mm/damon/sysfs-schemes: read
 sysfs_filter->addr_range only once
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260913171706.103052-2-sj@kernel.org>
References: <20260913171706.103052-1-sj@kernel.org>
 <20260913171706.103052-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 17:32:43 +0000
Message-Id: <20260913173244.200A01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON sysfs interface reads the user-provided address range arguments
> for addr type DAMOS filter twice.  Once for validation, and once again
> for assignments to the variable that will be passed to the core
> layer. If the user updates the argument in parallel, an invalid address
> range could be passed to the core layer.  Avoid it by doing the
> assignments first, and then validating the assigned variables before
> passing those to the core layer.
>=20
> User impact of the bug should be trivial.  From the core layer's
> perspective, the invalid address range is not really invalid.  It just
> works as having a weird address range.  No critical issues such as a
> crash or a leak could happen.  And sane users ain't do such parallel
> arguments update anyway.  If they do, such racy behavior is arguably
> somewhat expected and deserved.  That said, there is no reason to keep
> such races.
>=20
> Fixes: 2f1abcfccd86 ("mm/damon/sysfs-schemes: support address range type =
DAMOS filter")
> Cc: <stable@vger.kernel.org> # 6.6.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913171706.1030=
52-1-sj@kernel.org?part=3D1

