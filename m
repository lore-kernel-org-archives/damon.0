Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB313CCFD2
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120442; cv=none; b=gPqSmYiloxCJubsaDCeIZcOptW8nN0NwEA7GJ4mKiGf3R22q6aKUK8gM0qBzr4wexIbdME39X+lQdAU2U18XDpYfC2J9cYNZkYJMQ3cCfn7V42Ie0My8ygenbjyrRNocbDG2iChdomNDeBY/dsFTn5lEqdNvJ6Dq8uNYVhphUjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120442; c=relaxed/simple;
	bh=P93zf/if6O8xkhJq7rQ6DePmlWDuaeDRsy/JRlLbXcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDZ4JtqrhTuC3rWsHEJPlo0xYiSHnsUDsyqEDgTVr6yIavy+YogDv0+sPFU6Vly+AyBHmFALqBCluTixdn6Q1gqZDUDunE/Tj0o3XWaud/2a0oIbQZb6Rcv9LgDKvkb+kQtTIeuQL0zF5n/6OMG98JRXXIE2RU5/zbFsgCMVfuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOGyUqh5; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOGyUqh5"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso605165a12.3
        for <damon@lists.linux.dev>; Fri, 11 Sep 2026 02:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789120440; x=1789725240; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R5M95WIaFsi2d1eZZAa7AEXfbZ9VQBY7mOxP3ywQF0g=;
        b=EOGyUqh5PSR0XTKXEM1z7buDWU7HVBpcpah4P7OvtRcqwKc9cYe1x7SruVAcyh/YhX
         JVZjE9Pfhmv/LbPC6yyUs45Mey4fqk/BRJflJHOd6yV4eZqA0dJITPPJToVeXiZ6SIZy
         czR6dCY9XQr2dLatweSry7sy2BQ3HgkYuTN4IQQHoRyc1hndMOlTKoy8+2vBLRshGAnv
         S5tX2hiLrWTfym7xWNhUPF8EjIQGTfPuDvbL/mruEbXwUAYmmWb6T/hp7yq7hSpqgj2A
         UVyni0+SBbdfEfNQdpDfMKYXHONmoFHoJZDzz6c9oeCEtU8HI4Ym1zuxXGbEzDFY7hdK
         AfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789120440; x=1789725240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R5M95WIaFsi2d1eZZAa7AEXfbZ9VQBY7mOxP3ywQF0g=;
        b=qtGV9HvXAFjgEmg7czCWpIxIILa36y52B5urMJrzLFNOnAC4fsDDpUMEcjlJwYkurB
         NTv4VaebuO/wWlW3mY9o3dr8a4et2rqwy/YZX6AUeZ1L9368GN4j5DQkxtEY7A25E3Fc
         8spYjXnloRVD3guHJS+veeJ92e+h6x7Gqem9sAqy6tYM3WVL3ZJOX/3ruoWVXnVzv923
         UjwECqCpFwK+XwYdp0nHxJ2F1NXzPFWHGYcWF39ZiOx4cNiw4SHh3eBkocRcnGkY/8sH
         UKKLIYOVX5z19EscOBFBzEmrRcRXDooDiPZ3Mfw8CMBbfn4+4JLNWaXWWtPU38Mmpfj0
         WUCQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0/JHL5Q9opaZzS6uchK+jxOLav1uPxxc+bt+TpxaYSIMDOIO/+fNwxd3/OBWCXkHrNHx0RQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nEmGETHI6XXenS29aHlM3Zo233Cj2M+DEJEjeu/NXljGl8XTwl
	4d6CnzI4Mbzh+STXfVc6hbAtJs8WkEYL+lQ4OAMhJX1NBn4+j8om5ec6
X-Gm-Gg: AYBFou21JSyijk9nk7PW+D7T3t4lm5bTigmgCGI/vEYaR4sYjj8Z0TKRHgA9XorJK3C
	ac+NhzizUJ+UqbIQGHrKN33fyNHpqcgQltm5kvf3FR8YoY8DP8FPYThGS+PByxsxQIwkZzIfR7g
	HZhukbLu1BKMbqQfkVmrg3Sm6/THqyPv/6aRkQiYOIBr4vkW9/1ueMaBEVZGfTNVq+qkBw8+dgp
	P5Cd8qSRot7uCdMFOG5JjDBzSnO52A9vx++UM5ZZBmmX9lGPp8Edfnt5i/io5W30XXumU+D3niT
	jhyYD4dcJ7TgE0GEf3ee5zIgokezZjlPgtfWbTrhE318+7Emf/EFBLeDnFFWeyAO5fYhC75mbMS
	1QCn4n+xPy4TcMg/Pq4Bn46twdU+MTyCJfeZQAUm8DHz5GGOdvU7pZ7gp7/3OzJEHrEdq7t1ZcK
	k8P6c3q/01varrmoDLN5h+2KC5Q1LSK1lZAC8GIzmkE6cc6Ar/hH1ddVhFrg1EikRqM15r9A==
X-Received: by 2002:a05:6a20:7f96:b0:3cd:9dea:2be1 with SMTP id adf61e73a8af0-3daecb20df1mr6246360637.0.1789120439682;
        Fri, 11 Sep 2026 02:53:59 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6550df9sm868437a12.16.2026.09.11.02.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 02:53:59 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH REPOST 4/5] mm/damon/vaddr: extend apply_probes() for hugetlb
Date: Fri, 11 Sep 2026 17:53:51 +0800
Message-ID: <20260911095352.2803549-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909140408.104699-5-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  9 Sep 2026 07:04:06 -0700 SJ Park <sj@kernel.org> wrote:

> DAMON virtual address space operation set(vaddr) does not support
> hugetlb pages in apply_probes.  Extend it for hugetlb pages.
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/vaddr.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 7c548ec0cf6b5..45239f05e113b 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -598,6 +598,34 @@ static int damon_va_probe_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	return 0;
>  }
>  
> +#ifdef CONFIG_HUGETLB_PAGE
> +static int damon_va_probe_hugetlb_entry(pte_t *pte, unsigned long hmask,
> +		unsigned long addr, unsigned long end, struct mm_walk *walk)
> +{
> +	struct damon_va_probe_walk_private *priv = walk->private;
> +	struct hstate *h = hstate_vma(walk->vma);
> +	struct folio *folio;
> +	spinlock_t *ptl;
> +	pte_t entry;
> +
> +	ptl = huge_pte_lock(h, walk->mm, pte);
> +	entry = huge_ptep_get(walk->mm, addr, pte);
> +	if (!pte_present(entry))
> +		goto out;
> +
> +	folio = pfn_folio(pte_pfn(entry));
> +	folio_get(folio);
> +	damon_va_probe_folio(priv->ctx, priv->r, folio);
> +	folio_put(folio);
> +
> +out:
> +	spin_unlock(ptl);
> +	return 0;
> +}
> +#else
> +#define damon_va_probe_hugetlb_entry NULL
> +#endif /* CONFIG_HUGETLB_PAGE */
> +
>  static void __damon_va_apply_probes(struct damon_ctx *ctx,
>  		struct mm_struct *mm,  struct damon_region *r)
>  {
> @@ -607,7 +635,7 @@ static void __damon_va_apply_probes(struct damon_ctx *ctx,
>  	};
>  	struct mm_walk_ops damon_probe_walk_ops = {
>  		.pmd_entry = damon_va_probe_pmd_entry,
> -		.hugetlb_entry = NULL,
> +		.hugetlb_entry = damon_va_probe_hugetlb_entry,
>  	};
>  	unsigned long addr = r->sampling_addr;
>  
> -- 
> 2.47.3
> 

Hi SJ,

Reviewed patches 1-4, with particular attention to the vaddr prep/apply flow, 
the filter handling shared with paddr, and the hugetlb page-walk path. 
The changes look consistent with the existing DAMON interfaces 
and page-walk semantics. 

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com> 

Thanks,
Kunwu

Sent using hkml (https://github.com/sjp38/hackermail)
