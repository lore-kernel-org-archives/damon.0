Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FE8569F39;
	Tue, 22 Sep 2026 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097755; cv=none; b=omOdlfSmcpa/tbJ8iugPF6ODJ/CCK0W22nEe2DbJPeThNieBtn4e2YbC1J7z7UqoR4xMXZCkCm7HL2fbdE1ixLqKwL3tPxLHCgLXibUQmKkPYJc37H43tVUMlwOdfsecNCdCGcPie+9UwIZ7HEIYE+486uuvSEfy+B7niowVTTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097755; c=relaxed/simple;
	bh=IZ0XkrGZr4Wy3nxACdIhCjKov6p5LXKvjImWHjVN1RY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r1b3SE9eJ9EuLyc1GQeJ6Q2t3I5yYjH8ej+i2mnxOlw32qENsx7Mqo5l1U0Uz03JoaKUmwmZ0ijLPixa+uRLVGFCHXAZfLTR5s/Y1lssb7vEaCK+8jxKvO9Yx4aM5wsbZg+yNUZw4bxQtZeCGrmfyDT2b9Ja+/arUotK6DatMTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jU0iu6DB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jU0iu6DB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D431F00893;
	Tue, 22 Sep 2026 17:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790097753;
	bh=SAzGw6VksPfdRaqxO1iQ22TueSMq8Sv6o4pjdHWssx8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jU0iu6DBWgSVfEn4/GfvSym5RP6oWnhWgorOdQ7TD7XYa4F5fghW9Ok4whcbfxe1a
	 vCCxH/GnmngqzFC9PwZs3lgDOeUT1soNbq4kBmDOLAqcZDAE9XzvmnVm1VLTMhfF4B
	 ZHlFwTw3iHE/G8SMfB38gNJjc9QRR05NiA8pugzVwMzDT5hJA+9E0IM3xmlQPeruiZ
	 jP0wjy+/CN9RDuc7vusscaXbchHmlq/P76aR3quGRTRhTVuTc0o929WnrIpUniV52O
	 pZGa7r41qLXmxbSPhZ8UlLFJFrz4tZ76R82fIKTJGPqJn+iL0Z7f4De+pPJLnNXR04
	 foBfjd8ZwOKiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/9] mm: add hw_pte_val for HW PTE storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: bpf@vger.kernel.org, damon@lists.linux.dev, linux-trace-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-perf-users@vger.kernel.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20260922-pte0-v3-6-5670b8cb9059@arm.com>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
 <20260922-pte0-v3-6-5670b8cb9059@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:22:32 +0000
Message-Id: <20260922172233.38D431F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mm: hw_pte_val() yields an rvalue on x86, breaking its lvalue API p=
romise
--

commit 06b6d3a311b681bd0fa817067b39f468d3e5ca27
Author: Muhammad Usama Anjum <usama.anjum@arm.com>

mm: add hw_pte_val for HW PTE storage

This commit introduces the hw_pte_val() macro to expose the underlying
pte_val() as an lvalue for atomic PTE updates. It provides definitions
for both when hw_pte_t is distinct and when it aliases pte_t.

> diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.h
> index d6c5a7548550b..ee4eace5c3e1c 100644
> --- a/include/linux/pgtable_types.h
> +++ b/include/linux/pgtable_types.h
> @@ -9,9 +9,13 @@
>  #ifdef CONFIG_ARCH_HAS_HW_PTE_T
>  typedef struct __hw_pte_t { pte_t __pte; } hw_pte_t;
>  #define __pte_from_hw(pte)	((pte).__pte)
> +
> +#define hw_pte_val(x)  pte_val((x).__pte)

[Severity: Low]
Will this macro actually yield an lvalue on all architectures?

While pte_val(x) is a macro yielding an lvalue on some architectures like
arm64, it is implemented as a static inline function on others such as x86,
s390, and MIPS (e.g., native_pte_val(x)).

Since a function return is an rvalue in C, attempts to use hw_pte_val() as
an lvalue (such as taking its address via &hw_pte_val(pte) for cmpxchg())
will trigger a compiler error like "lvalue required as left operand" on
those architectures.

>  #else
>  #define hw_pte_t pte_t
>  #define __pte_from_hw(pte)	(pte)
> +
> +#define hw_pte_val(x)  pte_val(x)

[Severity: Low]
Does this fallback definition suffer from the same issue?

Since it relies directly on pte_val(x), it inherits the rvalue limitation
on architectures where pte_val() is an inline function, breaking the intend=
ed
lvalue abstraction.

>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-pte0-v3-0-=
5670b8cb9059@arm.com?part=3D6
