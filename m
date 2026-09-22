Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191901A682F;
	Tue, 22 Sep 2026 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097622; cv=none; b=EavbjVE7fDbKR9qOnYJaQ8HDE9mEpzctj+YrZLw9A/9YzcbDxWtS5d7nN4PMDPOocLClNU9L8Z819O4VduQnsBlrWlZ4kqFor57SXh9/zffv8B+v6oeRHAenw2KileCwGBMW4GZoG6FpKacDw6D/0xVa4afuqmZdpUtq0PWSzlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097622; c=relaxed/simple;
	bh=HUuOo+GVtPQtBnmmfjEGtqIFoe6CA/D3ljd2+B9VjFM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cRXRhXMS8wbeGUQWyftPOnxvfVjq4J46zmi8BsuXOlZWW/8Wlq9hutMaxaXxGapvP78BtQ8MUB3ZiIRYFBZAiusjtzlQVl0w5QZ+bVVtWNjOv2C4UjNzqQdJsqx7YIRKS8kEoosfZcbklhJiNhgLIGLASukN2EggRuroPb8GWPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBoo0Nfj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBoo0Nfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A721F000FF;
	Tue, 22 Sep 2026 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790097620;
	bh=HUuOo+GVtPQtBnmmfjEGtqIFoe6CA/D3ljd2+B9VjFM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CBoo0Nfjp2w2p1+J6maxFpeC0S+ueii/MO/9ei3MnNAcSyGsXRYg+g7TR5Butsg3S
	 +uDejIuopir4HZLVQmasZpPpHQFTd6VE0A2/Ilk3NFQNca+tGHWGn3JnfzUawtFzeQ
	 RCy+dz/pmfc/X0IEC26Sy1nzlhu/66qjMs2slFMstGzqib8vfEPVlh33uPwTGzmEff
	 E9xJQ6/evI74zYi+k8hn3b7LfLP1X2HtgZs6Q8TFYxvFJaHrdME3JlSWEbGqcRJdyz
	 nqRo90kU5f9rLXDRjTB3mVRWWKV/GKPAK4BzInBnVIjFRCXKMJNZHQQZOJVxWoSBHF
	 YG2/wwK4ViVdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/9] mm: introduce hw_pte_t for PTE table storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: linux-perf-users@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, damon@lists.linux.dev, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260922-pte0-v3-1-5670b8cb9059@arm.com>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
 <20260922-pte0-v3-1-5670b8cb9059@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:20:19 +0000
Message-Id: <20260922172020.59A721F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> pte_t is used both for software PTE values and for entries stored in a PTE
> table, so pte_t * does not distinguish a pointer to a software PTE
> value from a pointer to table storage.
>=20
> Introduce hw_pte_t as the generic name for a PTE table element. Define it
> as a macro alias of pte_t by default. When an architecture selects
> ARCH_HAS_HW_PTE_T, define it as a structure containing a pte_t instead.
> This preserves the representation while allowing converted architectures
> to enforce the distinction at compile time.
>=20
> Name the generic wrapper structure __hw_pte_t so architectures can
> forward-declare it when pgtable_t must be defined before the generic
> hw_pte_t typedef is visible. This avoids header-order dependencies.
>=20
> Keep the C type definitions behind an __ASSEMBLY__ check because
> architecture assembly sources can include this header indirectly. Include
> asm/page.h so consumers such as linux/vmalloc.h retain the page definitio=
ns
> they previously obtained from that header.
>=20
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-pte0-v3-0-=
5670b8cb9059@arm.com?part=3D1

