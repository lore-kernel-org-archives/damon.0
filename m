Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AC9480DDA
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396286; cv=none; b=fiqo59pxA2AVI11pwjRH2Jfft8AnQey3Lr/vkJDtBRGK666c/z3VhYfdFlt0WWh+rVI/VP2UxkYSCKb34i6o9mmDhwK99tzaACT4wsHRVziqTwRFmoxp3uyrU3MYryWHQ2mPiawfNftn0a2o2W9/yVr+tBXLbjL8O5mvDqgZ6vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396286; c=relaxed/simple;
	bh=LXsOPkAIZaFeNbB7AwH4cxQ7DiqYMYF4ZwsD1obx5gY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uqHfBQe+fWWGgLJkczNDA1Kj7xSbFFxSgMzxoKbikk+21TZDzh58KCCxHyjLIh5sVvGUs80fxdoT1aTH9Z5n3YxV5M5I7QhK5qR16ssiGbcWglmMTHqz/qZsnnK0fMg/8y2HD2qq6+wr6r+r4gH3Bia0Ie6cRed1zFscJhDXfH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHVKCsT9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHVKCsT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035671F00898;
	Mon, 14 Sep 2026 14:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396284;
	bh=Kp539rjCvV1MujwDGHy371luA/SEic8KlEcPqVUM/nM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RHVKCsT9X+R6wEKhDIaBCd40lIfI0VH7HuxuJCOBYqytcCpKZ0ps5E81LJ2Iqv3op
	 ndk1Mz67T5S4T/ipElH1WhclqrjFAuGV3S1cjSqPbcEKCsP5qWRIe8aqooLTnouYXK
	 xg4/tBQnWdkyWnGoUBqfaVd/ThoTsKjUsWq3aVQm3CXsn1T5t82JOeR5oAtOjEh+84
	 +MBrtSh3jYjt4NAN3bqShXpEc5YarfKAI5KvEcrHk82iHz+dJ6bVeg+Yv8ah60I2E1
	 ykmXDodSAGF9GR3v+sVisz+9ma+D0gb8PMqBMDH2tNucTfm07u8CBRhGJzr7Xi6D0l
	 q3BsVqSCvK5wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] selftests/damon: ignore test-generated
 damon_dump_output
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914141952.91465-3-sj@kernel.org>
References: <20260914141952.91465-1-sj@kernel.org>
 <20260914141952.91465-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:31:23 +0000
Message-Id: <20260914143124.035671F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
>=20
> sysfs.py and sysfs_no_op_commit_break.py dump the DAMON status collected
> via drgn_dump_damon_status.py into a damon_dump_output file in the working
> directory.  Ignore it so that running the tests in-tree does not pollute
> git status.
>=20
> Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914141952.9146=
5-1-sj@kernel.org?part=3D2

