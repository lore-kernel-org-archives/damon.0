Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9DB2F8E82
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 07:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787037647; cv=none; b=hz39mNz1SuDZe2LeLAnRCZ7yKNuEDnyxIN07JEbnYtaS1onjqQgk61/ihwOm7dUuqUz+GdeMm1U+Yjzg2/gtpb/BGGCYlzuZVtwVul2GEHp/VX6YRnBVWcXNzDKIsKeVGB/dukz7AzXEXFVtFsvaeaTARXXw/jbZAjTD0Mkf3+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787037647; c=relaxed/simple;
	bh=7JiYO08RYMh8T+Rabo3U/QeGx6n53kGrL7B8e62zjbM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XEpgEgx9+5xkguAkxdfX25aqT7hW54kYuGkLg1aAu4o0P5puf1+67lA8SpoB88oJO050ghONf0B1UfL33zpheTGPNT6Kj040B23jtQUFRjmuWjPITjnJ3jn2/ZCB2RLn4PCPMHfNNMiGkGonBJLRMQqiqMi2huCs6CkaVNW46Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVNayNcV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVNayNcV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5541F000E9;
	Tue, 18 Aug 2026 07:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787037645;
	bh=NV3a9LaGtE2tY56D0pcCTENFVCJc3L/dduPchmOyQjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CVNayNcViiVlkl9kfHj6XwD/oJnxQBSDjrse5vaJ21Dm72HrtaxOoJlA9j/n7BnKM
	 OLn11Mb754Bdn1pE2+MfDrxKxZfLeib90tT8c9Bz+X9DP4yL79ZURVqHBAoPBdwxnO
	 0xD6WH6pjCVBE05EuyP6mI8C31OetT2RQ9wm6NBomMkF+qc5pYBGBZGZF9V6KnyBqh
	 H0pYpB4x7f5SpWMA4g13uWMJQ7YsFWRpQHFb7n1RI3YK3W1Q+D7kjfzFr1FbZjwB17
	 Rk2JJFuG1LAKnkwtDKGCbgFYh9wxlLLnJ513Forx0Gx0PXJVjeN9jAteR3viF6nmnS
	 4JqTR37AD43ZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/7] docs/zh_CN: update DAMON index translation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Doehyun Baek" <doehyunbaek@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260818070358.455768-4-doehyunbaek@gmail.com>
References: <20260818070358.455768-1-doehyunbaek@gmail.com>
 <20260818070358.455768-4-doehyunbaek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 07:20:45 +0000
Message-Id: <20260818072045.8D5541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The Chinese documentation adds a translation and index entry for DA=
MON_STAT (`stat.rst`), but this feature and its corresponding English docum=
entation do not exist in the mainline kernel.
--

--- Patch [3]: [PATCH v8 3/7] docs/zh_CN: update DAMON index translation ---
commit 21d805a6bcb98f821e0042d118c9ffbb71686e3a
Author: Doehyun Baek <doehyunbaek@gmail.com>

docs/zh_CN: update DAMON index translation

This commit updates the Chinese translation of the DAMON documentation inde=
x.
It also updates the translation up through commit c9380cdd949d.

> diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/index.=
rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/index.rst
> index 6f8676a50b381..77bbfa7c25dcb 100644
> --- a/Documentation/translations/zh_CN/admin-guide/mm/damon/index.rst
> +++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/index.rst

[ ... ]

> @@ -23,7 +23,4 @@
>     usage
>     reclaim
>     lru_sort
> -
> -
> -
> -
> +   stat

[Severity: Low]
Does this mistakenly reference a document that doesn't exist in the mainline
kernel?

The English documentation doesn't appear to have a corresponding DAMON_STAT
feature or stat.rst file. Including it in the toctree might cause Sphinx
build warnings and mislead readers by describing an out-of-tree or
non-existent feature.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818070358.4557=
68-1-doehyunbaek@gmail.com?part=3D3
