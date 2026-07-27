Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DA2244661;
	Mon, 27 Jul 2026 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171506; cv=none; b=tCi+Lj4jsaGTXx/4PMmDgnyV6OJv/qobilScl7ZZ4l7AP7dDcvYjbDY1xQ/WWBKz08YC0TsO12ii7ldAKV4V1SA0i8pJ4nlbIzzt6wvjkWXXmChsgFR9w5AlyZlgEMow7cFH9xEfo5mWXDIfgzTjd7pXTFy8gKE3U1uahLiTSmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171506; c=relaxed/simple;
	bh=zeYfh6Ae+1xJhea6+9HT4lCqDt/7bYv2LK0Gd+dP4ds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=azhWT92MAyXtWE7wjK56F2puUFuaiMAbLfEJQc4VwMU7xVqpLHS04fyJupzOQfP+h0m9yypZ3PY2X5UzEd08EXWH1a0dUWUt4jl+eppJrsUHU/+t8vkC6B8efzkuy2wH2AYk3ZQIjDmL2IzmLcHR2+8AJk2/FtrhYfA/d7lR/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdM+l9ol; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdM+l9ol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0377C1F000E9;
	Mon, 27 Jul 2026 16:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785171504;
	bh=zeYfh6Ae+1xJhea6+9HT4lCqDt/7bYv2LK0Gd+dP4ds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XdM+l9olRW8cKalogx7n+VU3fSaNCRSPkhHZMGpLzCiNnF5n2MXamqP4NMDF773oD
	 GREnikG0Why5GUAYX0IpZTwNhzGp5bqoFZ0pTi/+O9mFL1g7myQ0E72UPFZPwN67P7
	 vLkGWiGJSKvlxkAerr6IvifRL31O/YDcEVwbm/yFVEB9K1OfnQdyXmJ4aGulx1l8TJ
	 3zdTwLFo4GTutJPOhxu+P+MyssSMxzGPfj7LOwbVamNxOjols3+UjYMG21tr7V3m8o
	 EouQobx+MZzv5jPF0GkDVCQFsaqrzLuNfbIHeCVhpRlMHCN9tR5erpTF6gxNXokLCX
	 Zd2B1b9xWPqtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 01/11] mm: introduce hw_pte_t for PTE table storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: linux-perf-users@vger.kernel.org, damon@lists.linux.dev, bpf@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260727164715.2866609-2-usama.anjum@arm.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <20260727164715.2866609-2-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 16:58:23 +0000
Message-Id: <20260727165824.0377C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The header `<linux/pgtable_types.h>` incorrectly assumes `<asm/p=
age.h>` universally defines `pte_t` and architecture opt-ins, leading to mi=
ssing types on x86 and a structural inclusion hazard for opting in.
--

--- Patch [1]: [PATCH RFC 01/11] mm: introduce hw_pte_t for PTE table stora=
ge ---
commit de503ea03294c1c9976ce045b5e820dbc0f34eba
Author: Muhammad Usama Anjum <usama.anjum@arm.com>

mm: introduce hw_pte_t for PTE table storage

This commit introduces hw_pte_t as a generic name for a PTE table element.
It defines it as an alias of pte_t by default, allowing architectures to
retain their existing representation until they opt in to a distinct type.

> diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.h
> new file mode 100644
> index 0000000000000..ed5dba42a4f8c
> --- /dev/null
> +++ b/include/linux/pgtable_types.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_PGTABLE_TYPES_H
> +#define _LINUX_PGTABLE_TYPES_H
> +
> +#include <asm/page.h>
> +
> +#ifndef __HAVE_ARCH_HW_PTE_T
> +#define hw_pte_t pte_t
> +#endif

[Severity: Medium]
Is <asm/page.h> guaranteed to define pte_t on all architectures before it is
used here?

On x86, pte_t is defined in <asm/pgtable_types.h>, which is not included by
<asm/page.h>. This means pte_t might not be defined when the default hw_pte=
_t
alias is created.

Could this also create an inclusion hazard for architectures opting in?

If x86 were to opt into hw_pte_t by defining __HAVE_ARCH_HW_PTE_T in
<asm/pgtable_types.h>, any files including <linux/pgtable_types.h> first wo=
uld
incorrectly alias hw_pte_t to pte_t. When <asm/pgtable_types.h> is
subsequently included, its explicit definition of hw_pte_t would macro-expa=
nd
to a conflicting redefinition of pte_t, breaking the build.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727164715.2866=
609-1-usama.anjum@arm.com?part=3D1
