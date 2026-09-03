Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6AB449EB8;
	Thu,  3 Sep 2026 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432530; cv=none; b=GtdM3Jjh4OeduTG4H4ub08L5n5Gm8d5zYHhoSxwty+HEyG1cttM89xSlNiV40omB3WcR9rRw6E7r5blll/sqcMJNt4KYe1pf7QoC8co7BKmI1p9ll/T/mvOeRMAGxhCAO6FbRulbG7puwvpqYA/jZKjul2uCnqSA14Y4knoFqoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432530; c=relaxed/simple;
	bh=8GGHXpoinHMF8S3XF+nIIttC4DJt7cPH2zOWSyjOLMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S922WA+54SKq3SzCdWWhhx/5BEC9gyXCwJ9hVzC2AEII1AzpiQO3qJsGQ8ATnXa+cK9cIuP0ZadTeuRo1zlXCvY70+gFvWOv02G2GdhyCoXAE8SyzBVk9kJxifX4W1Z5xMJhdPHzi3zhActj8G+TMLJOwq1UT2kQpfHEZdGwrbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0p67jG8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0p67jG8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF221F000E9;
	Thu,  3 Sep 2026 10:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788432528;
	bh=8GGHXpoinHMF8S3XF+nIIttC4DJt7cPH2zOWSyjOLMk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D0p67jG81rSHSrJG5QAe435bHXddsWghRHB0VqZPykQEYgTMVVt2g9gEF/FEmMh5n
	 o/p/SM1G8lmw0j0BoY128VNEO0viJykmsEP7VXs8saboatZHTjeVQDeuIHTgDQ+70e
	 CXewnJcVqJYbGn3hu3qxegzZyNvFqsvXQxIP6jd+dA6TsTuzGNA8Pl1A5qnSRxyyio
	 07/JJL7KkSaxhHOBtVPjxwIthxoc7useKZWfEMGtIqtYKU8Os8jeMqcq1Z1xpiKuQU
	 O1a/DCQ+MCBuHcyERt94WQT3CQlw8joj9YzEZYqOQTHD69eNcugK5XcCBvthZw1yB0
	 uDr1aROVc7I3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/8] mm: use hw_pte_t for generic PTE table storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: intel-gfx@lists.freedesktop.org, damon@lists.linux.dev, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260903103002.1091859-4-usama.anjum@arm.com>
References: <20260903103002.1091859-1-usama.anjum@arm.com>
 <20260903103002.1091859-4-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 10:48:44 +0000
Message-Id: <20260903104844.DEF221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Generic page-table interfaces use pte_t * for both pointers to PTE table
> storage and pointers to software PTE values. Convert the generic
> declarations and their MM, fs, and kernel users together so parameters,
> return types, callbacks, and local pointers that designate table storage
> use hw_pte_t *.
>=20
> Include linux/pgtable_types.h from headers that expose the converted
> interfaces. It continues to provide pgprot_t to vmalloc.h through
> asm/page.h.
>=20
> Keep software PTE values as pte_t and retain pte_t * for value interfaces.
>=20
> No architecture selects ARCH_HAS_HW_PTE_T at this point, so hw_pte_t
> remains an alias of pte_t and this changes the interface vocabulary witho=
ut
> changing representation or behavior.
>=20
> Most of this mechanical conversion was generated with the Coccinelle scri=
pt
> included in the cover letter. The script deliberately ignores pte_t *
> pointers named ptentp because they designate software PTE values. The
> result was then audited, and sites the script could not convert were
> updated by hand.
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903103002.1091=
859-1-usama.anjum@arm.com?part=3D3

