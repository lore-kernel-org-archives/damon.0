Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0F825F99F
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 01:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089689; cv=none; b=LvebD4I945PMuEG28okJCYUZKjX74iSyg/ujG+G6qVMq5I1UUM3I3NSPlonossGswYhujmPkkNFN+l0DpRSkH029y4B0J0LcXOgdly+vRtkX31aSYpxsTkEGCK3HDLmDQzN3gE4kpz94Xb9AfIxCi6BOPRQaiQjlMJ856R9V9cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089689; c=relaxed/simple;
	bh=tx10TYjo/FCp8AImh1r7QvTKSfnGC/0O9Ucx5ST1eWc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IWJU/Chf72zMZk9PAoHUg8d+ox6yKS+IYPMCR6RDFLdTyY17m71Qmd4BbeW/h69VOuHia2LUgqC5M0aLr0LzBNitkTf9tvX84wMSMRiodiCeoLbTR9TaqwJM6b6NcrlstgDaANnswehdoMsY1Bz94EIMYRdfAMRaSdsqIhNw3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfaW+LBk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfaW+LBk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D8E1F000FF;
	Fri, 11 Sep 2026 01:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089688;
	bh=77SZ7jUqCl7fgFfTbsM/bZHqek2djaWbxnNdXuvZE0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kfaW+LBkF6xg/CnPW4AX5ZcKYdZTRlKxPHPBuB9GglRztQ0XAxw3Mevq3In+9sLSB
	 sS2VeVSqIDVzHAHzfhidz7eW506WnIHg8wzow97SxqFMKcD3SDkhbB4uenJSAh5l+r
	 eqcVVSdq0D2bsdoDofxVBdVCAGW3tCHBhrt0TmCud4WjB7izw4r+4Oem2QX1idKXUV
	 z7IoI/Jk/zbUWLDfZzBD/20J+VjdVW6QTD/r3K7X14oDcQ/Toi+Yq8VvR+RfBw4O++
	 1DfUeqJ6FG8K+eK5QpYk3Ehdw2TThaRsuBUb4alPC6P9dqxvo5PX0HLxfrrVHGC2uU
	 0kLdNYaQtxK4g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 5/7] mm/damon/sysfs-schemes: support
 probe_hits_wsum damos core filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260911011330.93678-6-sj@kernel.org>
References: <20260911011330.93678-1-sj@kernel.org>
 <20260911011330.93678-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 01:21:27 +0000
Message-Id: <20260911012127.D2D8E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Extend DAMON sysfs interface to support probe_hits_wsum input.  Also
> update sysfs input based scheme build logic to setup the min/max probe
> hits weighted sum range as user provided.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911011330.9367=
8-1-sj@kernel.org?part=3D5

