Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794641648;
	b=jQ49SaX+T3VVt4Aiy3erGjn0e3MrNhGomxl3S6xdLCcohmdij7uc/X8M+QpuPVYmYeQe
	 ww4jv/Slji8DDhjKYmuVDN/OJPqQrdprn8ng9Fja0KIyGNPrIiNEunbiXY3a3N6KMDQ05
	 chgQHJlInPAskxIMfExE92cP4SnoUiAgb8k6XQuXiZR/eVvK/M1e9T24oLLrz7yup+MoI
	 pBe4TVgwNnumSe6STUGB1Is06FQxm5de2iy3WbyUOIifnINnBqgo+MZlfY5Ka01PF5nEU
	 7iBi0NYupQAbhjuFwwvVhrx46oe5e/MFES5wQQJR0vF7YD6+IGDZyTo71ODPe2s8tww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794641648;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0KoqRgmGRc0qs2TY2et1mN3EuDIIdXOqtoPQ8Z8M8aU=;
	b=lfN1a326IjaYaCrtwJVb7zaWgzUS6fZtXMNsi9hPX8Y65891Ft1fftJRgb3+RrS8UCE3
	 UhfbSJ5CUYGTpF78oM72dyrdKhrXiQ2PBrHtHWIbuM6Y8kfwyj4Co3byP6IBPMdoC/Cp/
	 5+6+NN4ZzkBMbgKCTJA1rkce0124Oq/5QqVQgEwU8d8AjwmteRC0/clgNPYMZhZ6vSi97
	 zDzMZ9R/mI6jSGHJZ/Ipsqb+oCR4+VJU8BQmfTzEUyaMPAiaT+3WPwVqYBY1emWXCyjTy
	 l54Wd+pkVoR0hpSG4dDFXwXdt36MKrc7AIa9OzkMIuu51tpDYMyagoSAMSPRGYNlH2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=fail reason="signature verification failed" header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YK09FWet;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFFE606A329;
	Sat, 14 Nov 2026 07:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YK09FWet
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05241F000CB;
	Sat, 14 Nov 2026 07:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794641648;
	bh=0KoqRgmGRc0qs2TY2et1mN3EuDIIdXOqtoPQ8Z8M8aU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YK09FWetI+P5+mHhL0XQXoF2JIcNoGHXGHFtzuFx2vZYChk4b90Y2+oDMXqxA6wUH
	 bHKuL2jSUsxVX4RxjOBF5u8rjA4nDG8qldlzvqWTRSJLQLwBN6ynSTix7IXRf2Ji1z
	 HMJjLl2soPKSYj7tFcyb5xNtqG0xQpSlpeeizZ8urc6FfUOpVIFdu9NxD+SeJgtGzS
	 YNDxKYpwxrM+bh62Yj5ZFhltyppkBMxdPbybCEvox8UwtXJPKBt4a/XmqT1x7M9HGx
	 ER4P6a/ysW1ITFZnM3UYQcHCdk4AFpFJZR2giet/lesrp5XXzSqTa4Ryc5VN7DqLcc
	 rnDaiP3MbGl7A==
Message-ID: <sashiko-outbox-214264@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/22] PM: hibernate: size the image from common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>, linux-mm@kvack.org
Cc: kernel-team@meta.com, linux-serial@vger.kernel.org, damon@lists.linux.dev, linux-cxl@vger.kernel.org, akpm@linux-foundation.org, david@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, johan@kernel.org, jirislaby@kernel.org, kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk, pavel@kernel.org, lenb@kernel.org, hannes@cmpxchg.org, brendan.jackman@linux.dev, ziy@nvidia.com, sj@kernel.org, muchun.song@linux.dev, osalvador@suse.de, nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org, xu.xin@linux.dev, chengming.zhou@linux.dev, joshua.hahnjy@
 gmail.com, rakie.kim@sk.com, ying.huang@linux.alibaba.com, matthew.brost@intel.com, byungchul@sk.com, apopple@nvidia.com, rientjes@google.com
In-Reply-To: <20261114070959.3490008-21-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-21-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:34:05 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] PM: hibernate: count_free_highmem_pages() ignores
  N_MEMORY_COMMON
--

commit 7cc6e673516327174024379e9585052d08c1578f
Author: Gregory Price (Meta) <gourry@gourry.net>

PM: hibernate: size the image from common memory

This commit restricts free page accounting in hibernate_preallocate_memory()
and enough_free_mem() to zones on N_MEMORY_COMMON nodes while keeping the
metadata estimate across all populated zones.

> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index d5dba0e50b2eb..8aeb086a3fd3d 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c

[ ... ]

> @@ -2011,9 +2013,10 @@ static int enough_free_mem(unsigned int nr_pages, =
unsigned int nr_highmem)
>  	struct zone *zone;
>  	unsigned int free =3D alloc_normal;
> =20
> -	for_each_populated_zone(zone)
> +	for_each_populated_zone_state(zone, N_MEMORY_COMMON) {
>  		if (!is_highmem(zone))
>  			free +=3D zone_page_state(zone, NR_FREE_PAGES);
> +	}
> =20
>  	nr_pages +=3D count_pages_for_highmem(nr_highmem);
>  	pr_debug("Normal pages needed: %u + %u, available pages: %u\n",

[Severity: Medium]
Should count_free_highmem_pages() also iterate over N_MEMORY_COMMON zones?

On CONFIG_HIGHMEM systems, enough_free_mem() calls count_pages_for_highmem(=
),
which calls count_free_highmem_pages():

kernel/power/snapshot.c:count_free_highmem_pages() {
	struct zone *zone;
	unsigned int cnt =3D 0;

	for_each_populated_zone(zone)
		if (is_highmem(zone))
			cnt +=3D zone_page_state(zone, NR_FREE_PAGES);

	return cnt;
}

Because count_free_highmem_pages() still sums all populated zones,
enough_free_mem() continues to count free highmem pages on non-common nodes=
 as
available room for the image, undercounting the normal pages needed to back
highmem copies.

In addition, alloc_highmem_pages() and prepare_highmem_image() use
count_free_highmem_pages() to bound loops that call alloc_image_page() or
alloc_page() with __GFP_HIGHMEM and pass the returned page directly to
page_to_pfn() or swsusp_page_is_free() without a NULL check, which can
dereference NULL when highmem on N_MEMORY_COMMON nodes is exhausted while
non-common nodes still have free highmem pages.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D20
