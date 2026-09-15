Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3775391E50
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 02:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438379; cv=none; b=mii3ov0fnnT2VI0oTgRR6GcpDldxEPRjoNpk8BIalxfyZ3kpf0sme0bj8yTi72Z9cc+4tztGmkgpvWHVQOK20Vc8Jtonc78IHsYcxVb8eSlpozgCuYV9BqK7L3e+UR44yjfUHOp6ioA78O81uMzMeHBG0ycAmn9FkAdWRAmxmYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438379; c=relaxed/simple;
	bh=3m8CE+4R/1HIyfkqQUsMm5ml7XutZJEh8cUCxFNQxvU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KuAH+CZlzR/JdEQ7aZ2443WjZD8MduSgPHiLGThb+Lg7lGRX+YD1x0eUt/a1hYPtff7svbiZZWWqfQ/J8yO1sVQJF+3JuB+pxg5v0i521YY8LSAKawOR/srg59DB7bVf5yv31nqKj0HbFg5LdsF1ImDmM8NGebPm4Gdbtd2XsVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uo4N9azN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uo4N9azN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6741F000FF;
	Tue, 15 Sep 2026 02:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789438378;
	bh=3m8CE+4R/1HIyfkqQUsMm5ml7XutZJEh8cUCxFNQxvU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uo4N9azNbaM1pGc4dOwXtVbP6oMWiokqBj7gbW30hLkIOpT/9X8+P7z53BbkJUhSo
	 6emMfW4aACmZy3gNlvU7EYe1wmBlYHpkahsRa0geASOgD2PBiYLoGDxK7yFxVIuoKe
	 r4u5IH2wio+YqnpG+LVIueSy3vlkbLr4D0duGhG/1CZOsDsfk7vIn642Ltc4y4WqD/
	 rjdgxRL0FfzcfS4EbZyHTywLmsY41aQtpdx9hnBW2BYF1DolzOF+hNBsnQov6+7Xhr
	 +MtqwalKHdRiwsphsxaS1tAly1IG1Zv90J7zGwsLYj8eynpl6K+qwVSKTMSoxqM6Eo
	 Zvr3dcL400oVQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 7/8] Docs/admin-guide/mm/damon/usage: update for
 hugepage_size
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260915020929.102953-8-sj@kernel.org>
References: <20260915020929.102953-1-sj@kernel.org>
 <20260915020929.102953-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 02:12:58 +0000
Message-Id: <20260915021258.7E6741F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON usage document for the newly added hugepage_size data
> attribute filter type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915020929.1029=
53-1-sj@kernel.org?part=3D7

