Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6262248896
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789802409; cv=none; b=dIYjgdMAPHxTPmvtV+QywkkwROH22OR1v7BcxGe/Uq57JmzBZHVDMl3MNnFNyWW6MYe2IpqHFfc2ZbsDRrpCaG5MWXloHGKS66XNwL0dlCLqwWxqZKWrUcI1frE1/tk0blCa7Vf0PZfiRZ8akRwjiUxtxybCQNRwRcJCAdvLPik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789802409; c=relaxed/simple;
	bh=yghT2SXfg3F8bP6o1iIjSTgCNyXj2cMUmt4A207EPRU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TjNhofA4LboSIoOcLh5CoT6cP0FIiGpWzPgna3ZC/60ViSPzKEl8p66/Gey9OlqEKkum07vfRNk3rIJLjnH28om3pixWTPCW0gaecLvO9qZbWm2yf93tvheo+ZfooGlg+HzxWZ1PSi9zkl5o0qiTZsaptF868psNB1mMVDVwVPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyc7m7yQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyc7m7yQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409631F000FF;
	Sat, 19 Sep 2026 07:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789802408;
	bh=T628Ok19A7rWoVp7+njf6f0m7tUP1G8xYM0GZaVxlNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oyc7m7yQnvH2MY1vMBRFsFhZeGR/IRou/jaDLR8KEulsMCZlQ5pCLamtXBNnlTZ5K
	 8gLr32lkqmuEK7CBPNOUwG/pGndvR8h6k1UXLkt7+ixTIDDb1Q1R8ju5ATM/R8rZtX
	 0tDznPTpIbX+q38J6LG8HcOMNeknQNvGjR7rsqI07LjSqbZCGKwRsfdgf4N1om+xcO
	 Mektjgfjw4Z4QbJ/4mek84/gWoCkcv5bDso1ADV8mvJVjdnGSwzLUG8unCuXoSNtAi
	 UYoWq97CYIdyMXy/r2A8zCBFmgTCjKfnMrFFMmFM8UfKU8Nk5g+VfmjB8n8Kpozsln
	 N9aFgdLAOwprA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] mm/damon/tests/core-kunit: test the temporal
 tuner's size quota conversion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260919071324.1583280-3-donggeunyoo.kernel@gmail.com>
References: <20260919071324.1583280-1-donggeunyoo.kernel@gmail.com>
 <20260919071324.1583280-3-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 07:20:07 +0000
Message-Id: <20260919072008.409631F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_goal_tune_esz_bp_temporal() encodes the size quota in basis points,
> so the conversion is exact only up to ULONG_MAX / 10000.  Pin the three
> sizes around that boundary: the largest one that fits, the first one that
> does not, and ULONG_MAX.
>=20
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919071324.1583=
280-1-donggeunyoo.kernel@gmail.com?part=3D2

