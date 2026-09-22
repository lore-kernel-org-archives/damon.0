Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD0C572698;
	Tue, 22 Sep 2026 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098036; cv=none; b=aDwQJpoeJNJTWAGOTmXzm2XooxW/efOW+lXku2E8rEndNja3IFbKdPrdECf5IVZ5vq6MnaR0UpE+a13CE+V9g5W/bcHZOCGdMoiIhbI9lG+e8jhnQfhfNXvUg883gqN8aU4Ota22L9LjZUS+WUw1o0m2brpUv/4D1PJn7R0sueE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098036; c=relaxed/simple;
	bh=JfrULAjAYTN79xyC19YGhCr1rxdcFCCfrSjIGCo/tkw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BLLaic3JptjeJGIPmKTK2qM7DFgA1gGMXJXtcXC42LyMaKOWc41sp7+2lCeNB499Bds1iIiX485SAUA23ufmoooNb2SaZeiShi2RwZu3GvgBON+3ZF6vH6v1nRXOaszJMZwqScwiGtBNMv0DklO9835nyVeARWZfl9T4C9iHULM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XftxNA+L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XftxNA+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9401F00893;
	Tue, 22 Sep 2026 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790098033;
	bh=JfrULAjAYTN79xyC19YGhCr1rxdcFCCfrSjIGCo/tkw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XftxNA+LTBLkWQxw1kEjRiShug4MURxMfQ4eZynKtivgcS37l35AheQ4qlLtnb0w9
	 6hXfjqPJM2AruNtPphAPfwWfwVKntrDqAMQJ9Fa9uBPUq3v9tKJBdRRgDzmqPDpciO
	 VnaJLkLZvXo1/kFVexlruPNm8ETnkBRJ/HMAB/03cXE6BMioul0DHbT9urywfCAX4c
	 RUH4GyHmAaWqqqpjsQEWR2Fp24aRF6V3JPKt1FBYWu99DfTYkFuG1tiPy/p1lCwQ6M
	 DRRc8JEt/xtB3bnXX0ioL0VJJx5Xx4eqJiLBkeeOFzviEssH1jUkd6cWRdop1cGc9P
	 GV3Oqi6Jj+6jQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/9] mm: use hw_pte_t for generic PTE table storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: linux-perf-users@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, damon@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260922-pte0-v3-3-5670b8cb9059@arm.com>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
 <20260922-pte0-v3-3-5670b8cb9059@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:27:12 +0000
Message-Id: <20260922172712.AD9401F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-pte0-v3-0-=
5670b8cb9059@arm.com?part=3D3

