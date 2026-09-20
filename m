Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46A2F7F13
	for <damon@lists.linux.dev>; Sun, 20 Sep 2026 01:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789867498; cv=none; b=CLUKmKXTZ7s1oq6Bo4IBzhj7nIQMTDlOhjIhbHg+Pwjb/Wnd0IsRMb1qOgorsUiX153jKARA4OR++4H3i1GSP0kv/7Dvh3VL0ctLT7UnudXDIBrB63A0OuUZmReMPx0tpGV/zQUuoeYE7gUajCPOKGc+YNGwuueFctwRR4zfZJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789867498; c=relaxed/simple;
	bh=f+wdyKYKp/H7xJfVMQ+f+mTcyXLvLCkc6M65ktGc+wM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H0WTWvyXBpN2AeCBFa4OjH04nyZvqAR0TdJFovf2vbrbPODsVtVhNSZ4A4tJSnxkCX+1aGjyBj4XXv3lXypdgK1J6bOU5f4W5RHhEGIElRtDZ4jjFA65iYyRjwoak56v9Qg2MmTbWdEB1SiwXFzm38MGbfwfBS85/GMHXGXvOdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpxjCAzc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpxjCAzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721BD1F00898;
	Sun, 20 Sep 2026 01:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789867496;
	bh=/uSrg2z2oSlb3sFmhyBw1QmMLZuGjSOw8Fdq2eNLTEQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NpxjCAzcDHkNtQlSF13xer4QgHGS1acYKeJhd1RZEIfGcAvzvrUzqwFVJPLjuugNk
	 U/9EBc4TRgFagac5POedHMC31zRMCjrOHBOV617pPRgrsmXzPaEuK90id3iuOzVcTQ
	 jw5RletPHxdz/mhZpTgqpsjpMeysc2M64jlbmgquJbvqI4VT1BZRsxJqGf2Rnh8Wmv
	 qAbTba6MVoghBYFgTtEcidKfIW5In2gIFFbzFsoaAKIYDj6ig+WHozXiyZCutnmk71
	 oBOe6u8EAompt1xaEvgfBGpGhGV9J9jIpOW2prwbMGcuKF/uSVANIGMdEyZMNw28CB
	 v0+zdajQZiNnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/api: remove unused NR_DAMOS_* enumerators
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zenghui Yu" <zenghui.yu@linux.dev>
Cc: damon@lists.linux.dev
In-Reply-To: <20260920012028.9565-1-zenghui.yu@linux.dev>
References: <20260920012028.9565-1-zenghui.yu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 01:24:55 +0000
Message-Id: <20260920012456.721BD1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
>=20
> NR_DAMOS_ACTIONS, NR_DAMOS_QUOTA_GOAL_METRICS, and NR_DAMOS_WMARK_METRICS
> are not referenced by any code.  Remove them.
>=20
> They can be reintroduced if a real user comes up.
>=20
> Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920012028.9565=
-1-zenghui.yu@linux.dev?part=3D1

