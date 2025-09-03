Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DD62E266E
	for <damon@lists.linux.dev>; Wed,  3 Sep 2025 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887975; cv=none; b=JxyqndWHGTeNCB2x5A6etUZeVAX91kJ7qe6R650wdrK/Oh+mleB4jTZiaenE9/ExmmRU3CiigAkegYos+GGuyuKEchGbq6CWldacFO9Cx6FxMxdeW6jaa7bGKpwAv3z7FaNuBkrt/S4Xvm/geUevRlADHUmu/fpon73HY3EqqO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887975; c=relaxed/simple;
	bh=pk6iffNeZHd26fThASpLl7bnLtQuEW+CYAbvR3iEnVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gydBuqtEBkNRgIJNKzqToILNhAob386fsLpI3Vvk3XMoVzv4SiLtR0h0zDZDRNTwE6jQMq3WXF/n3NMkSvkopsl+Tk/C8nfdIDEFWkgavs8GszpwcxoN+tcfr/P1Anbd1VdpVJxU6L0/6k22QeCSS3VMvaonqjMJbCjdM9DA3bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhXs/FjG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhXs/FjG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756887973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RiF4X17MAgeDzab0iosntA9Q/n0cbzxTmlw2m/AGEGE=;
	b=RhXs/FjGzCq4vQ5tiYj2Kn+D9BIk/ovbNBJRBGjQqqOLZfE+AX7HgUk/P1faeOSzhb4Y+8
	rMJB0jssbVUIYqnCUFrjtaiF6ynpWpdj4JokJpQuZv0SEfi0o1FD8aLGWbexYg7aAuDKjs
	I+n5IqeuKh3rYMgFurqESvS5/It2XZw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-GgOgRRU0Pi6v1cFeO_qFKg-1; Wed, 03 Sep 2025 04:26:11 -0400
X-MC-Unique: GgOgRRU0Pi6v1cFeO_qFKg-1
X-Mimecast-MFC-AGG-ID: GgOgRRU0Pi6v1cFeO_qFKg_1756887970
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-55f6a61e239so3008942e87.1
        for <damon@lists.linux.dev>; Wed, 03 Sep 2025 01:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756887970; x=1757492770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RiF4X17MAgeDzab0iosntA9Q/n0cbzxTmlw2m/AGEGE=;
        b=soYo+jmntc/TTgAQ0M3v9d5AmQ1/UjJdsYPNjkVV8DNQzz4KHWim1Aq68fnCssbum8
         3t5X1FQfryjEPTakrEhWsVSsugxHlLzM1PDQkI+xztIunB8Wx4kPrdjrJ3easfXddKUM
         43vHtBH51znnwnNBbN1BjFVdp8aqV4qg+LTf5ljyW6jPOt54v8HpHXWuy9GgGYep4g+A
         hV3puY1S/s6dgpZk/7MwhoXgvlbzQWjb6FMf4ub1SFpnivoN9gNgGd1HgnRgLRYan9vq
         xvQ5Qms7A7KSKmY3HYJ7C08JuQ7hfcHRhDx0ZexdvFxmOY+p66h8g1DHx/V+3OztCuum
         gk1A==
X-Gm-Message-State: AOJu0YwnRxDdELwn4hWy9VdyloOJ6cuTqzXqteh86PZU0sKnMcS1mObW
	66gTgB3VCvV2qCQDgM9GKcik6sDnbxUKgXvRBnXs4Un5dWFlcNE1vqkygoxtsD/VqGKF9Abk/ho
	7OPocbYcVEdQi2/C2V6EIQkosTkxnyg5tNr4GTxda+k88iKjW52dnzqU=
X-Gm-Gg: ASbGncty4bMEfsC/MHz+xvuJpsXRp4hjeHx15aUWcy+peKmmoNSYmzLlUCTaBXzL6SM
	Efizjgw61aPCu7eR3U5CSI46IuUvVijbjHZ16XuJxFF8s98KeJi+fVP6A0kzjz8x/GxdJURbjBS
	mA3sJFo2mkxSryo1PzXG17an/LFZ42c8pMNPvhzDzky1+2Q8jTsRYdfdJXpvEuTU40TnZMNPHUF
	u7iO+ZC1fFYY/1e4V7sfcTb0DSKP27rnTt1NhUvhHzI0EbnKyO2npDSnL8xQGkLDzwIXa9OWeB6
	KrffaGt8fprB6OXIbnUHR4BN7Hh2iui6ZPzO+VHtrdKxjx3s+/5vfY3l4aLxqWr+Xw==
X-Received: by 2002:a05:6512:6401:b0:55f:4faa:b630 with SMTP id 2adb3069b0e04-55f708b9a35mr3755414e87.24.1756887970197;
        Wed, 03 Sep 2025 01:26:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo/J8D+PycrrERqH27xh2tlYz9vfDI8vGXXWnNGFn0lTfvQ0eYEz+wc2QoktugLroVCaVR9Q==
X-Received: by 2002:a05:6512:6401:b0:55f:4faa:b630 with SMTP id 2adb3069b0e04-55f708b9a35mr3755384e87.24.1756887969707;
        Wed, 03 Sep 2025 01:26:09 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad525d1sm352909e87.139.2025.09.03.01.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 01:26:08 -0700 (PDT)
Message-ID: <ffac73b3-3c2f-402a-beb3-a98ba92c5335@redhat.com>
Date: Wed, 3 Sep 2025 11:26:08 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 05/15] mm/migrate_device: handle partially mapped folios
 during collection
To: Balbir Singh <balbirs@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: damon@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250903011900.3657435-1-balbirs@nvidia.com>
 <20250903011900.3657435-6-balbirs@nvidia.com>
 <ea6caec5-fd20-444c-b937-6cab61198c46@redhat.com>
 <6a178e78-9ccd-4845-b4ca-1e84f7d31b91@nvidia.com>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <6a178e78-9ccd-4845-b4ca-1e84f7d31b91@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G1xqagQdlY_mM2gdo1W4OzuzcvXWanBe1yqY1ExBzks_1756887970
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/3/25 09:05, Balbir Singh wrote:

> On 9/3/25 14:40, Mika Penttilä wrote:
>> Hi,
>>
>> On 9/3/25 04:18, Balbir Singh wrote:
>>
>>> Extend migrate_vma_collect_pmd() to handle partially mapped large
>>> folios that require splitting before migration can proceed.
>>>
>>> During PTE walk in the collection phase, if a large folio is only
>>> partially mapped in the migration range, it must be split to ensure
>>> the folio is correctly migrated.
>>>
> <snip>
>
>>> +
>>> +				/*
>>> +				 * The reason for finding pmd present with a
>>> +				 * large folio for the pte is partial unmaps.
>>> +				 * Split the folio now for the migration to be
>>> +				 * handled correctly
>>> +				 */
>> There are other reasons like vma splits for various reasons.
>>
> Yes, David had pointed that out as well, I meant to cleanup the comment change
> "The" to "One", I missed addressing it in the refactor, but easy to do

And of course now you split all mTHPs as well, which is different what we do today
(ignoring). Splitting might be the right thing to do, but maybe worth mentioning.

> Thanks,
> Balbir Singh
>
--Mika

