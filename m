Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E278B478E56
	for <damon@lists.linux.dev>; Mon, 21 Sep 2026 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003852; cv=none; b=XGiIuvP38HH4092+CykoPFfH5ho09ALtgiEVaKFSD/SmGZFHqkB43FDbVUa076mopjaFDyB4r4rUpxjJqbqWOWM8Yyw/yHyEqPsMckZOP05qHA29bApXu/83RU1zhumtoqsAjts2viG4d5MKx915s/mioUrDA/Lpvq3A+oxH4/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003852; c=relaxed/simple;
	bh=57ef5MJkugfIYn1Foat3ubqIgbpAXCAscu2XeayenA0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LxjjzlmmPrwNqBa2RInbTe7I/1BfBwlXkJoVOp/2WrtXy9aCk0/FblOsccE6G0CTB58g92dU2k9S+42ft+JN6kahkqxPcTu+bH3MT/Mq+K+S8EmhCiDLUKiChOK/gcIN3JLxbXvPv0I1doXBeR0sQgpAbDTfErNoJZBMyJ29X0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmTmri3y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmTmri3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980B31F000FF;
	Mon, 21 Sep 2026 15:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003850;
	bh=57ef5MJkugfIYn1Foat3ubqIgbpAXCAscu2XeayenA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KmTmri3yNcoqJKapzZE73xRHjUjvaACbDha3T9gHqzfPO67K6xrSD0pa4voi/5jDZ
	 w6FtdymkLNZbPA5UbpshT0TKsoMgbE/Zjqc2EZO3H+TzeDNDGJ7/OcouiCon3Z1VXd
	 KAH2+ldq+FzoDA+WN8xEF947HhFYxQceUg1pYEJ1GLNA2kkL3VJGRrUi/KJqZhLk17
	 i/PedJqAsQeQdYo1TdLTL9TVdeuMXVAE7IUeLAkdQJyoTXi2d3bCeb5EiVI1+Jo/bX
	 09G9UfPKIgsekdoqVTc2aBehiM4RMJsjO+Z1SKveOtOlfNqc0b3mpOYaeYYg+4IJF6
	 rkVe+d6jJoTZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] mm/damon: fix typos in comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260921151547.78472-4-sj@kernel.org>
References: <20260921151547.78472-1-sj@kernel.org>
 <20260921151547.78472-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 15:17:30 +0000
Message-Id: <20260921151730.980B31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
>=20
> Correct spelling mistakes. No functional changes.
>=20
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
> Reviewed-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921151547.7847=
2-1-sj@kernel.org?part=3D3

