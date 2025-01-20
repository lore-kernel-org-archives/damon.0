Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B3D1E32DB
	for <damon@lists.linux.dev>; Mon, 20 Jan 2025 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737399438; cv=none; b=kxw/q3N8NEyE4QaMYWIiFYsNuA9OzIbZ8zjiIms0MEbTD0yjrQ1DG2VNhTGv0Wr6c4qTgbs2TT22eMWGm0yUe1cAAc/PhAUZcZiajy055ATq2qHA8phKIi55QeaV+O0CAJtb1xpRnczCiPSz53VAiqkbSfjp9kQQxgDg+AzvzKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737399438; c=relaxed/simple;
	bh=DmXD2bs858f5C+hsfod+ubeoE14f+w6O/ho4M3oiDuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imFif16uAyOoH06RrKifgQgUhN4ly1R26ranGtEVbSgqCSLqKaKiX0IpZnpzQFjfOd0Ny1/Yu8uZqrUhVc2XDj+ZMqPaJGBL3Z7N/WrexoL1JAmwrsE5slwMO+sg5y3eMTrcJ/yJ9zG72FPO529SJMR1sOifBKzPpgMempA1iHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/Cql/S5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/Cql/S5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737399435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T/PRISBUXtei2V2ps4R5VHGPqzSFQpb6XowV6+9L2CQ=;
	b=D/Cql/S5PtOxG3I6sNES2eIX3BsgRJvEkkNqH3PMm6lc8zCrpRzkq/HlA49UuGT2UP6tVK
	AftSFsEsOD9USB7x0T4mP8Mn22WuZciMLeaG6FMNEg2PoTBJpeNbsbjW7V96eEegcAm6F2
	z4nO/M5a1zTfkLQRAL2XJvOLr5C1jZo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-EQQxdIM2Nuifgl5iOiW63Q-1; Mon, 20 Jan 2025 13:57:14 -0500
X-MC-Unique: EQQxdIM2Nuifgl5iOiW63Q-1
X-Mimecast-MFC-AGG-ID: EQQxdIM2Nuifgl5iOiW63Q
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3862e986d17so2022216f8f.3
        for <damon@lists.linux.dev>; Mon, 20 Jan 2025 10:57:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737399433; x=1738004233;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T/PRISBUXtei2V2ps4R5VHGPqzSFQpb6XowV6+9L2CQ=;
        b=oE7ijKJGPly/LYIPwULiEKtTECTrIe+aVWuhHV+19W4JlmAGecv86UZ71Eg3eM3tkQ
         twKwpBVF5sY2uPL2BGJSjpYi4Pvz0Z8o5jfylLY0WjCuEanCAc9g+nM7Cg2tn9K2BV6i
         ZfFFvPgNNqoE1G2bE4wMFikSFTVt0SultRmxXQ6KVUMR647cQqeX58cQTLkgHsGj8dol
         Z8jju33Ecze1aiVorr8x/73NK7YPZ680v5s8bi0t2ZS9kZeTh0tgn8n5k+9b6ZS6JqDv
         1+ARE9LJ86nm3qQWq5gJDr+lth4Fnfosp8gD61IiL9xfCJ2PY1kfJLjp4k/HPNq76Lb4
         CR+g==
X-Gm-Message-State: AOJu0YyUzD1K6dHMW4zKJQtWHoAMqQILvSgYlcfOm3NM2e3SM75gCpU4
	FiPKBeSCy8qgBHETz1JP7yn3U1OMl3NuXdA7xFEf+ek924jun4sguftogjwI6G7BCQCnaOPZZMv
	uU8am8t7tHW3boao3NpR/bqoBChsoP8/fkDBMx1DLDlSZzGCLdIxa
X-Gm-Gg: ASbGnctvvd5rDyftcSrvyTvwvfBKbSTUOgA8SX9jCfy4YdCj4oGPzzXJDe+IbgC5eoe
	2e0yZoHfn8nqdA+wkw4GD2KFxr+fcVggcQC+/tgA0yruP1D3FYzYauyODL9DtCihiEF8nE2jpGR
	zepCBEAHFZ3nrxpZavm+Q8Vk7q6ql5VNbdQjnZOpihL99JpNViulPQ71CnyRdOUVCog5HB7VmCl
	GFwR3fx6ycbsufZ+Qm0B+vhwkShOF2pN4mgA8SqnyBzwF2BagbBTiDipC7JcwDvK0H6Xph892cD
	kq5fIzriWwcs7xYFFCLIM5qX2uheQmcxEdVY8r3RffSe12BS0XvHOmvSJHJwVZIl7wgVKuza7q9
	frxTYHtQ8ygqyvWNDfwuSWw==
X-Received: by 2002:a05:6000:2ce:b0:385:e2c4:1f8d with SMTP id ffacd0b85a97d-38bf565f06bmr12171182f8f.19.1737399433374;
        Mon, 20 Jan 2025 10:57:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhabdAO/UUc3UXqLouRsw96j3NCFrRpn1wkY/ppvQQo1T81apTh02yRjUc16yBGrGAqikslg==
X-Received: by 2002:a05:6000:2ce:b0:385:e2c4:1f8d with SMTP id ffacd0b85a97d-38bf565f06bmr12171168f8f.19.1737399433031;
        Mon, 20 Jan 2025 10:57:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c72e:e400:431d:9c08:5611:693c? (p200300cbc72ee400431d9c085611693c.dip0.t-ipconnect.de. [2003:cb:c72e:e400:431d:9c08:5611:693c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74bf061sm207470795e9.17.2025.01.20.10.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 10:57:11 -0800 (PST)
Message-ID: <9257fbb9-d26d-4028-896f-fb8cfad3ddad@redhat.com>
Date: Mon, 20 Jan 2025 19:57:10 +0100
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm/damon: introduce DAMOS filter type hugepage
To: Usama Arif <usamaarif642@gmail.com>, sj@kernel.org,
 akpm@linux-foundation.org
Cc: damon@lists.linux.dev, linux-mm@kvack.org
References: <20250120181959.2564362-1-usamaarif642@gmail.com>
 <20250120181959.2564362-2-usamaarif642@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250120181959.2564362-2-usamaarif642@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TpL4bKpo13SNWtS6_bfu-b7myaSZUnMR0_sPPa7psp0_1737399433
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.01.25 19:19, Usama Arif wrote:
> This is to gather statistics to check if memory regions of specific
> access tempratures are backed by hugepages. This includes both THPs
> and hugetlbfs.
> This filter can help to observe and prove the effectivenes of
> different schemes for shrinking/collapsing hugepages.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
> v2 -> v3:
> - expose hugepage via sysfs even if the kernel is
>    built without hugepage support. DAMON will just
>    just return 0. (SJ Park)
> 
> v1 -> v2:
> - Wrap DAMOS_FILTER_TYPE_HUGEPAGE case with
>    CONFIG_PGTABLE_HAS_HUGE_LEAVES (SJ Park)
> ---
>   include/linux/damon.h    | 2 ++
>   mm/damon/paddr.c         | 5 +++++
>   mm/damon/sysfs-schemes.c | 1 +
>   3 files changed, 8 insertions(+)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index af525252b853..1d94d7d88b36 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -326,6 +326,7 @@ struct damos_stat {
>    * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
>    * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
>    * @DAMOS_FILTER_TYPE_YOUNG:	Recently accessed pages.
> + * @DAMOS_FILTER_TYPE_HUGEPAGE:	Page is part of a hugepage.
>    * @DAMOS_FILTER_TYPE_ADDR:	Address range.
>    * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
>    * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
> @@ -345,6 +346,7 @@ enum damos_filter_type {
>   	DAMOS_FILTER_TYPE_ANON,
>   	DAMOS_FILTER_TYPE_MEMCG,
>   	DAMOS_FILTER_TYPE_YOUNG,
> +	DAMOS_FILTER_TYPE_HUGEPAGE,
>   	DAMOS_FILTER_TYPE_ADDR,
>   	DAMOS_FILTER_TYPE_TARGET,
>   	NR_DAMOS_FILTER_TYPES,
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index c0ccf4fade24..224308140441 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -222,6 +222,11 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
>   		if (matched)
>   			damon_folio_mkold(folio);
>   		break;
> +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
> +		matched = folio_size(folio) == HPAGE_PMD_SIZE;


Can we directly embed in the name and the comments/docs that we are only 
talking about PMD size (both, THP and hugetlb)?

DAMOS_FILTER_TYPE_PMD_HUGEPAGE or sth. like that.


-- 
Cheers,

David / dhildenb

