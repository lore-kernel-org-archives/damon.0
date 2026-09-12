Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D938C3ACA5C
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789243856; cv=none; b=hh5kZhuXhGwO6pMbB4c2CIqP8dlEgKMXtj1Rf9ISOoyBy8t4qm/1sNvh6u0W9IXXpMDkQMdz7piybHYO0WLBAVJh/5CBqnv7WlYu7PrbFNyNoeT8rdt7ZGF6EVP2Ohm/oBjDM6QMGBryRbhHC2v913/nln/Vqv3ipUQziLXCCXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789243856; c=relaxed/simple;
	bh=iEWedQoe/wemxEjmgDIjohMrxf4Utm0vyhBjgbwEQsg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DMlYLk8mRqc+0xNfIsonU4q4236veJpwf43LJ+4OHFDRr0+rqlYeuPNsI6bqo12+o+baaNlGdB+GCZNS/gY94YQM0OAgCvycKkbV2VA5OZ0HaIWIMYpF+7lAkHv6ytw7iepSQUwXu0pCtFCzdt4oP928EnUEnGW9qTpsDndBibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAmWUN8F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAmWUN8F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF3B1F00893;
	Sat, 12 Sep 2026 20:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789243854;
	bh=PRMq9I7/FVEtP6h7SEI8lDdX4fjHony4uCufRNNdfBs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QAmWUN8FN57JAV/A8NpRPBMXPWTZ+1pjgBRdvQMeKZl09X9892q5XMKJOSZJV6S7Z
	 mYREOku1HoYyFrw9ZKI2HWQkQxnn3IZEZFl32wQDkHL8amP8ta5VB1oqf61c/7YfBx
	 5UojOqqEtMBhnP/zBqUWA50qjipFsFMCbfeS+brbrv4TU6/mvdFgSrUW1d7jRgCUJR
	 Ppgr+YXlr+pDaGRWQd2cCzOfqZKadexUMG9VsCJ3Wqbma+lJLyjfBQV8CBDl62WQFQ
	 ER8vUeygWjx9cjRGIoRJUGJL4sOo3/ZHtEHAW/4nvCpjFk/4PzVOMqIvtYEF2zLtxO
	 0ns+To0VmdyyA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 8/9] mm/damon/tests/core-kunit: test eligible_mem_bp
 commitment
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260912200814.145612-9-sj@kernel.org>
References: <20260912200814.145612-1-sj@kernel.org>
 <20260912200814.145612-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 20:10:54 +0000
Message-Id: <20260912201054.8FF3B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> There was a DAMOS quota goal commit bug [1] that doesn't update the nid
> field for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP metric goal.  Add a kunit
> test case for confirming nid commitment.
>=20
> [1] https://lore.kkernel.org/20260827045035.94611-1-sj@kernel.org
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912200814.1456=
12-1-sj@kernel.org?part=3D8

