Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFCF48D880;
	Thu,  3 Sep 2026 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431776; cv=none; b=M5i3dAj5l/ud8dJVEH0CCJR3DcXt8RpLf1chweVIyZIAiYl2EX01Iym+vlTVguhrOn/sU1YSS2B8S5n1dmdCBlUbecgErETcu3hOatPKS1oKKnFzLteEPcZpPUQ1qbPK0bgty5wm7y+gXkWV4s2MjZxKJl9M6nTr7YegB5rjCv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431776; c=relaxed/simple;
	bh=J6ZdMZLfluCT5KJ0ipdvS/MsvXXZY/glu2moxZOBezc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q1tvRcH+pBGq1BJv5CajvOLGTTGpdj+9A+Uw+wDuUZ6U24F9N7rakNl5f85HLqtM0AsQ75Gc440GI+VaMLdVxO3XyRqHIxK7WNVhHIEqObaomzwuZmZXDHM7+2+At2PJwxVzNqLLlglX2Yw2pATzboxN/kiq9kgl780AAHPgjFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0SdEkPB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0SdEkPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9ACF1F000E9;
	Thu,  3 Sep 2026 10:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788431768;
	bh=J6ZdMZLfluCT5KJ0ipdvS/MsvXXZY/glu2moxZOBezc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X0SdEkPB3Ogr+utm3DPQ5sDyLRh+hJrtZRq/Qsa7DQg2mJgclnfQjq3amSgCogFom
	 I1kcf+JeklQ89DFh4+vqS9R/3+B56N71KQvrAsCHc15Tb+XHrihyYGfApJbuQcwTZ2
	 XTu9iSDC+SPe0Z1QuWTi1qRTkmgwRPuBrM/uUahP2hhVj4eOkTndbiRXhZEoppk15P
	 Y+rPapCIzT2GmH+4c/SvPnskIGpl6WSxAgHI+F6mLM/9GbLXUGpymdenWbg0eszCui
	 5E/pminoFs6GMizDqD08xwc9DBpHlVomcxvpbjSWgUZ+qqXmjbkzwZ50PgKBQAkUAY
	 MXYy9gZFoPmWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/8] mm: introduce hw_pte_t for PTE table storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: damon@lists.linux.dev, linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20260903103002.1091859-2-usama.anjum@arm.com>
References: <20260903103002.1091859-1-usama.anjum@arm.com>
 <20260903103002.1091859-2-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 10:36:07 +0000
Message-Id: <20260903103607.B9ACF1F000E9@smtp.kernel.org>
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
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903103002.1091=
859-1-usama.anjum@arm.com?part=3D1

