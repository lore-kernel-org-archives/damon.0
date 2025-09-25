Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FA9285C89
	for <damon@lists.linux.dev>; Thu, 25 Sep 2025 10:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794787; cv=none; b=TpvHC3uZvTXS7WOnhwrpwa3i5eVvPx0IHRNrxr7rfgZ8VeQIQI/wmGTRl1IrHl2I7Q05TDsWlWo7iHDzsP5Bc8chjXtEJ4hgR7H3iYMkSOsI6bzwycnEwsxDUIo6x3Y+UrRRUSu5pxSZCMWHvJxZcpmgtlHj+csbK6HTcIUADYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794787; c=relaxed/simple;
	bh=KGbUjEpAkc4sIly8VUpEuSI3Y23L9o7q3N8FeciH2h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXzWoJXLlqY7eX30g0fFHg/tU75/dIr3x0X8guntXdzTbut26I43zzjD9LExuL1cImIyaGEHmyRbO0H3/1Ew+sl77oT7MXlXbex9diw/j9jfMqASPST13b55xkAEiKOFt/C63ocARKE/e/SAo19HsQEAoBKL8HVBHH/jpNBcd74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TuHO+6ur; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TuHO+6ur"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758794784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UQ1yIMrrwyU17r+tTnLpblX0dAaSzYGyBKLGlXcYZwI=;
	b=TuHO+6urt6hJn3ze4poCZ3CLLNwR1YxLMijTAfvSWsiDQHwihRPlaixSpw0MLijNgEm9sv
	gd76tehzjH+VnXrNbPZA3yxdkh88hIIIUC6Bc5CVXA0UOmDMhGWs32OTR/wjktKtWeHrs5
	851k1SSlBgIDK7IiYyn4rYUw07+zBc4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-6F2qKOkiOciAGv8rgR3uiw-1; Thu, 25 Sep 2025 06:06:23 -0400
X-MC-Unique: 6F2qKOkiOciAGv8rgR3uiw-1
X-Mimecast-MFC-AGG-ID: 6F2qKOkiOciAGv8rgR3uiw_1758794782
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e31191379so4948765e9.3
        for <damon@lists.linux.dev>; Thu, 25 Sep 2025 03:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758794782; x=1759399582;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQ1yIMrrwyU17r+tTnLpblX0dAaSzYGyBKLGlXcYZwI=;
        b=AVf1Y2AGBRoVkMTD9Qsp2dO28xQVTl7zRl6D8PFkmjQdonjucxYFStlg97F9jtUvsE
         0KA7AYqtDZpgxictZGcalN/X9b3GH7DAgw2chTl3MCd59cU68yTV5HrCfbp1hju8xjdQ
         5hs43eLOHY8escu0Y0X34a3d6dqlnZw9PYl9+5SeUxWGWspG3M7PG1XboPHWabP3rHQC
         8xNQ2EFRHuSfXiYrzRxFdzxbOLUtREgp6O7ymXIJ3kt53smD9qY8PqATOv9IhlPSlVyF
         E5o7JpLwhPCsPRVRRhTfQ/UGe+vwQv9yAgnxi2XQxgsrYHr0gbM6uygf5h2YqDjpVEXi
         wxuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1nY82gwJplSgp8gu+B8hf18IXGV0PqIeu8e8a42cUaBr+hrvaqPU4AP0aj0JqP3qt+YIyTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTz8ukcpq4h3erap7kbMFME2+ChFhjFH+iNRavE+Lh8NjRsmz5
	oTOL9Bni4fNb2yyrjStjO1/Q6MOPP036C6oHBOKJJ/astKW9y4S2k5HG4xUpPfTeOQM+VBETNOg
	2PcutCOdPBF+SZ22RJ2cRkU7SrkoqX4dQ0XLsrVhY/PAODIOOczYN+65E
X-Gm-Gg: ASbGnctrhKfT/c9VWTTQsu+vnBiTSGeLRCKNnj6MN9KgiK04oCx7H8YJ70nLVuuI4Ow
	rgqefbfqrRx8qWuZmsrWkquK4cH2o1N8MTVMPMTbvsaXB8TKhRdYSg/5diL+8U0KKOOeTtwmouK
	HURMnQJI1vdpjQCEVqb8LZaH2NdbYPUB8TzEaDE9zG4rPQ7r5Hx2cub+Ttx5L+Hw3jwj9Gw4dZE
	bBDLp8tqTsVeofJuAK79fztMpUIMZZCKI0rzD9hOw/rN5sdqRBUmSsXi2vkwwm7P8zoffLsZ++x
	VALqTHMl+k212S9c5/CxKkFL0Tx6LUKjiv0NO2V0hl53RugfvOd5ZwHVkclRvheHzvLNHLMYvAm
	j+yGkEbhz3FpEICNXeYIJYDCxukADRxQT2uiBn/8j6pvplMFCZh87EpQkI4goKCyEG0CO
X-Received: by 2002:a05:600c:1e87:b0:46e:27f7:80ce with SMTP id 5b1f17b1804b1-46e329e51c2mr23724835e9.23.1758794781989;
        Thu, 25 Sep 2025 03:06:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXJl4bhmMZAV2Ov8ckXqohzCkRtHDu295sdMoIicohDcdpvJzXAjcv+ktFKrVhD9D0sp0u6g==
X-Received: by 2002:a05:600c:1e87:b0:46e:27f7:80ce with SMTP id 5b1f17b1804b1-46e329e51c2mr23724515e9.23.1758794781570;
        Thu, 25 Sep 2025 03:06:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08? (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31f1dsm70034495e9.13.2025.09.25.03.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:06:20 -0700 (PDT)
Message-ID: <c9a0f531-bba6-48a1-bb50-639fb4f2dfb6@redhat.com>
Date: Thu, 25 Sep 2025 12:06:18 +0200
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 04/15] mm/huge_memory: implement device-private THP splitting
To: Zi Yan <ziy@nvidia.com>, Balbir Singh <balbirs@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, damon@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250916122128.2098535-1-balbirs@nvidia.com>
 <20250916122128.2098535-5-balbirs@nvidia.com>
 <7987AB89-4E80-4A0D-8736-E95F998698DA@nvidia.com>
 <a77b03b8-508b-4bad-8913-fb825ecd8a0d@nvidia.com>
 <F6F6DB2E-C08B-417A-A8CB-3E759FE2C3A7@nvidia.com>
 <901c82e7-0442-4791-b249-b035f8ee428d@nvidia.com>
 <B24E4F6A-F61B-4E9B-A2FE-4004C62A3DD2@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <B24E4F6A-F61B-4E9B-A2FE-4004C62A3DD2@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fpkpCyk8xBz0zpbLfMvpHzRi9NT8l6R4sWJ0RtVYQGw_1758794782
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> Even if this is the only call site, there is no guarantee that
>>> there will be none in the future. I am not sure why we want caller
>>> to handle this special case. Who is going to tell the next user
>>> of RMP_USE_SHARED_ZEROPAGE or caller to try_to_map_unused_to_zeropage()
>>> that device private is incompatible with them?
>>>
>>
>> I don't disagree, but the question was why are device private pages even making
>> it to try_to_map_unused_to_zeropage()>>
> 
> Then, it could be done in remove_migration_pte():
> 
> if (rmap_walk_arg->map_unused_to_zeropage &&
> 	!folio_is_device_private(folio) &&
> 	try_to_map_unused_to_zeropage(&pvmw, folio, idx))
> 	continue;
> 
> Maybe I am too hung up on this and someone else could pat on my back and
> tell me it is OK to just do this at the only caller instead. :)

I think we shouldn't set a flag for a folio that does not make any 
sense. Just like we don't set the flag for non-anon folios?

In addition, we could add a 
VM_WARN_ON_ONCE(folio_is_device_private(folio)) in 
try_to_map_unused_to_zeropage(), to catch any future abuse.

-- 
Cheers

David / dhildenb

