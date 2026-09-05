Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AD936F8F1
	for <damon@lists.linux.dev>; Sat,  5 Sep 2026 20:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788640490; cv=none; b=knE7Rnmh1i+R2qPTAIXe2twevwU2UsPXZ97dmdlFspwQYVydUw8cU63izZ/h99Q3ATBMDMjtmjp2SvTlykoMvSDV7FmDLRT9snoL6Zob25w4vxdY8SLY3yLgYd2X5NNs9gRuATyiykL27y6HFfJ1m88/QQymqABnvEpjPv7T6pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788640490; c=relaxed/simple;
	bh=VP6fRBp8HAz+0q0kXm1iAkHTiel4726FzTzmw+O+jfo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FXxeAHKtlVGXeg+5kWky2tXgmTF7XsWFJCmwf7X3FXieGZFsZduk5xTrH7lETG0wJBPx2M8vHCiglSit+ftho/5PWu+dOq3HA8lXcYayTC2SvRJNKpUQdTtl9ydwmU+fWn+i+TuZPJWThUZ5MvyRphX91/18zXU9In3H4VzCqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnDqhq6h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnDqhq6h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99D71F00A3A;
	Sat,  5 Sep 2026 20:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788640488;
	bh=hwRz5Tf2NSKj+I9XPkQamFRf+4aMI/bjOviCAzijsS8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LnDqhq6hm9nA9hziveFVGKNRYR6npShrjeTFGNn7Gt6LP1hAvBzPAyzIN7nILc43N
	 ZasXwrATL6n6oVnV6FDVGuhdvoBpl/J6bw102Ke5RRVipYSIF9YsUZioTXsOjoi/uk
	 YAK4ditCy7e8/ZTjYTlYMf1c89cnqhxw7rkC9XB1FGukMd9P994LC4/lLC8D4E0zoX
	 xosaUkED7FjN/4Q9+ghh+3a+BRIOKoe1QR9ExnwCtID80BeQikLIS9wu90Los6/YaY
	 pVzHHK1+cAOgQ7svrpY70IIv1TnY0NP6VRSNy6V4PkEBvihmt+ctiIwzFZuBdVwpgf
	 J0jZXUS7UKubQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/5] mm/damon/vaddr: extend apply_probes() for
 hugetlb
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260905202634.88102-5-sj@kernel.org>
References: <20260905202634.88102-1-sj@kernel.org>
 <20260905202634.88102-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 20:34:48 +0000
Message-Id: <20260905203448.A99D71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON virtual address space operation set(vaddr) does not support
> hugetlb pages in apply_probes.  Extend it for hugetlb pages.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905202634.8810=
2-1-sj@kernel.org?part=3D4

