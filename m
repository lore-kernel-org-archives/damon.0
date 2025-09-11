Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73F42D24BD
	for <damon@lists.linux.dev>; Thu, 11 Sep 2025 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577849; cv=none; b=buGyr1CX/QrFRZ0QRSdSATFQN6J7b26xXgrrnRm3vcd/VCSmkHK2omjE7T3txZ+fXaj0LbydYtyWNuoTli/MCMKLDilwQ725U8DNTt1Z3GmoP77b+Q4G+IL12NE8BRhrLpbA73MMLOPZOIu/ECAA12FPeLfvsShZZmE0qsY1xU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577849; c=relaxed/simple;
	bh=D1dXUKDliy4JjAhsX2oUcRHMuirhDjdc0xD6es9VOAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6og1d8JAGCH2o9WE5GPJ2vD3fWtzKV0GxiUZ/pupKQDvCB455s7Pi5b20dHfEz2aGwSF4722txLPB8OaZdDhNiTqYPOWgLbDnPtW9P941YmyHvmNunDBqBDaPY+pWlk/r8JaTgDtV27wqutDCV7MhhasTfiXpW6w8vO9ipGA2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XN4Bpzwv; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XN4Bpzwv"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b046f6fb230so80132966b.1
        for <damon@lists.linux.dev>; Thu, 11 Sep 2025 01:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757577846; x=1758182646; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCXGwUwpyKq6QC0HqHvB+PlNFDZF/zHlcXjRKnHG9yI=;
        b=XN4BpzwvHUsuNy/VyWQa5o0fFX7dmrcYsje73kmfFhSEdfuYGpoX4yeSTKYSTtHhaK
         u6QYSSIx+6plrw1iuMrzUvlaUhLBRvwKffnjnetHfT8aQQhp9MxEE/mkOfHaR0RBfWuQ
         GrdIMnziAHEZAIufr+3m4TVX9D+fYBAJP3AvVPtdCeLY8qRp0b4YieyfhSTELYDUBYwo
         IU335ynyF7ctt2GI6ljIIPrYGEv3HVJNxdqfMsx0SGCSY6cEvQlFUk8B8UvuPPNaMShb
         ErIUnglRfbo0B14IsYrDBin3pu3LSDCh2mZXQLJAMAr3e6j9diRrh+1e7Xvq9DfYFapF
         TPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757577846; x=1758182646;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UCXGwUwpyKq6QC0HqHvB+PlNFDZF/zHlcXjRKnHG9yI=;
        b=r74Tvf7gk+UsywTo5KnhKIUkstWZmf8JADWaaTOVmv3oDbWO3MNa3gvPSdFg3DIZJe
         8tZMGGGjfppKRc08m6Kwk6jS5izBzGXjBc/1aAACwkVsxSBl6bH4k8w40xWdlcbVjH/N
         x2VLnE+LCH7R793SbAXBQQqdte8GNzapixA/dchxVGW84cuf/DNTjeAieQXvpyduy92+
         wNLR9SlMQ3FL3J2a6jJRRdABGJdi4R3otMtcHqw5Zt9wC9i1FZOz1+7Z84CTps9LBfs7
         sqWelsoxqH/x9AJRQr+hps1OMBsqSSjOz686OOj9GPBCUKMP39XpE9ZG7EHrQirCoPe5
         qRMg==
X-Forwarded-Encrypted: i=1; AJvYcCUFGrYqj12e5hCnre9jvocqmVwEjamj7e4fOy9TKSZcEy1RiJvIeYf5UBm/dMfsvAopNTwRaw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyl4lRJwRA/yf6x6pA88Ut53MLCDv5qNiTPZqPiR1cO0o8tMncg
	pPiTFYVfNkFS5+XM9qpX/jsT66kf3hIA+gIDO8M3hntr94BCoOgv0TbI
X-Gm-Gg: ASbGncs2qA8fqyTjewKtdRnTHPhNyHIwg7yCM4OGL5ZUmNimc8FoN1cq+v0G0yg09yK
	5zfHME5r98uZnUNgneMNmW4tnkEJ1OvJm7EVOO/7nbrbAWHCt19kQfw9acuRn1M+u7vHP32PMC9
	7p7CgVNXY8HfLr1e+PCZXA7KfhgKRx/5M4DoIh7om5h0OTxeuybpzibu03GdFiqOwpBbhE8098r
	coSabLgHjsk8EJMSLxvrV/aqGx5HDev4UKtHMIWtMiKjb4R9JkwgUet3Oa6egpiTOoaArT00xLi
	A/nZua5HCunctrClC7WcyddVlIl01Lqq36lWiz6I9EOaFkPeKVw7YRYfFrb1SEc1t21Tb9qhWlw
	5WXWv45OfwwRApXR1ao1PWugUuw==
X-Google-Smtp-Source: AGHT+IEcMSgKo4+sU99486bq3+Fvkta2bK3Nuc0JJPNS1zet5974H/X47nBk+8+kC1RGRur6L5MELw==
X-Received: by 2002:a17:907:8691:b0:afd:eb4f:d5d2 with SMTP id a640c23a62f3a-b07a640873dmr285777066b.31.1757577845911;
        Thu, 11 Sep 2025 01:04:05 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f2122sm75915966b.85.2025.09.11.01.04.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Sep 2025 01:04:05 -0700 (PDT)
Date: Thu, 11 Sep 2025 08:04:04 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Balbir Singh <balbirs@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, damon@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Mika =?iso-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Francois Dugast <francois.dugast@intel.com>
Subject: Re: [v4 06/15] mm/migrate_device: implement THP migration of zone
 device pages
Message-ID: <20250911080404.r6vqlhyi7qyjutij@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250903011900.3657435-1-balbirs@nvidia.com>
 <20250903011900.3657435-7-balbirs@nvidia.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903011900.3657435-7-balbirs@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Sep 03, 2025 at 11:18:51AM +1000, Balbir Singh wrote:
[...]
>@@ -836,15 +1107,47 @@ static void __migrate_device_pages(unsigned long *src_pfns,
> 					migrate->pgmap_owner);
> 				mmu_notifier_invalidate_range_start(&range);
> 			}
>-			migrate_vma_insert_page(migrate, addr, newpage,
>+
>+			if ((src_pfns[i] & MIGRATE_PFN_COMPOUND) &&
>+				(!(dst_pfns[i] & MIGRATE_PFN_COMPOUND))) {
>+				nr = HPAGE_PMD_NR;

This one trigger BUILD_BUG() if !PGTABLE_HAS_HUGE_LEAVES.

>+				src_pfns[i] &= ~MIGRATE_PFN_COMPOUND;
>+				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>+				goto next;
>+			}
>+
>+			migrate_vma_insert_page(migrate, addr, &dst_pfns[i],
> 						&src_pfns[i]);
>-			continue;
>+			goto next;

-- 
Wei Yang
Help you, Help me
