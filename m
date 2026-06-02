Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2864533A9CB
	for <damon@lists.linux.dev>; Tue,  2 Jun 2026 02:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780368426; cv=none; b=aHA8hyfA1mkHXHj0ASdmHR1dg83rts1voU8mSml/ppXDeX3X3ZOowX7LbolgpF7OI1/A5Wpl6XxzNZ2oP2AS3XuMbY3kvWsqCD+rMxRK08pGG6h/SF7v/pLiy8jfznEseYyid3qLxKtiyrnISdC00pV2eOLqiY+262QrtJ/PrVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780368426; c=relaxed/simple;
	bh=jGmf/himYOssnxkiYCGhSl5qC3ScSmdh3I8Xl9A39JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nAtw0zq3yO3kfK4ZWCGcFNQwi13h7cSZLc0Q4Bh1gEb8LBnGjLRSBD1G/CjQsY2UBozMoPHW6FNh2R6YLna0orYLDSxR17CAwmNKyYH/TLsvbmMh2SI5C8meS1MjNpR9c4CjqvyfhccuU7eSef1Qh5vwkoHI06Ej/dmRCxKYr94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LkPFv9Yx; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LkPFv9Yx"
Message-ID: <2e9175ab-f9be-44c6-bf1a-a82aeed18f98@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780368422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DzEYFBO0HPhxlPtDd2N2r80uc2UpuMcmthR9XLKa9lY=;
	b=LkPFv9YxAbgRgjzFP5BMJD5UzFP+Pyiqo/D36+oL993VEh6AhN+ezGxDUcCS9s1mF8idFo
	bKX0IsY3IN9aHJ9n2qaT7GDgfkgtCEo4nxE73t6M0xRyIHtFkbgoKVcmNlAMsIba1f1TGR
	1etFxbBwPJy0kyfvqYoI+XbTR08elbs=
Date: Tue, 2 Jun 2026 10:46:35 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
Content-Language: en-US
To: Barry Song <baohua@kernel.org>, wangtao <tao.wangtao@honor.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "david@kernel.org" <david@kernel.org>,
 "willy@infradead.org" <willy@infradead.org>, "sj@kernel.org"
 <sj@kernel.org>, "kees@kernel.org" <kees@kernel.org>,
 "luizcap@redhat.com" <luizcap@redhat.com>,
 "zhangjiao2@cmss.chinamobile.com" <zhangjiao2@cmss.chinamobile.com>,
 "kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "liam@infradead.org" <liam@infradead.org>,
 "vbabka@kernel.org" <vbabka@kernel.org>, "rppt@kernel.org"
 <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>,
 "mhocko@suse.com" <mhocko@suse.com>, "jack@suse.cz" <jack@suse.cz>,
 "riel@surriel.com" <riel@surriel.com>, "harry@kernel.org"
 <harry@kernel.org>, "jannh@google.com" <jannh@google.com>,
 "jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ziy@nvidia.com" <ziy@nvidia.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 "npache@redhat.com" <npache@redhat.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "dev.jain@arm.com" <dev.jain@arm.com>,
 "xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>,
 "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
 "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
 "matthew.brost@intel.com" <matthew.brost@intel.com>,
 "joshua.hahnjy@gmail.com" <joshua.hahnjy@gmail.com>,
 "rakie.kim@sk.com" <rakie.kim@sk.com>, "byungchul@sk.com"
 <byungchul@sk.com>, "gourry@gourry.net" <gourry@gourry.net>,
 "ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>,
 "apopple@nvidia.com" <apopple@nvidia.com>,
 "pfalcato@suse.de" <pfalcato@suse.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "damon@lists.linux.dev" <damon@lists.linux.dev>,
 "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
 "ryncsn@gmail.com" <ryncsn@gmail.com>,
 "jparsana@google.com" <jparsana@google.com>,
 "dvander@google.com" <dvander@google.com>, zhangji <zhangji1@honor.com>,
 wangzicheng <wangzicheng@honor.com>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <ahcANgFDFwfC0v1q@lucifer> <b24b4a8198ba412f8b8b42c43dccd058@honor.com>
 <ahf2mJg9OOWvu0jA@lucifer>
 <CAGsJ_4zy=-m5wjm0BC-vQXMHGRkHymC-5S_L9Oi708v339vvPw@mail.gmail.com>
 <99dfc4a50f3643a6bef6deaeccfcf115@honor.com> <ahlzj--3Gm5pD9ge@lucifer>
 <a90bcb0fa3a044588350e92a78258a09@honor.com>
 <CAGsJ_4wFr89M2i8pth79swv3==i8SGSMWrbr+Yp2umwFTuCShg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <CAGsJ_4wFr89M2i8pth79swv3==i8SGSMWrbr+Yp2umwFTuCShg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/6/2 10:15, Barry Song wrote:
> On Mon, Jun 1, 2026 at 9:46 AM wangtao <tao.wangtao@honor.com> wrote:
> [...]
>>
>> You said discussion was welcome, yet when someone offered even a
>> small comment, you refused to continue the discussion.
>>
>> If I had known you would be this inconsistent, I would not have
>> replied to you in the first place.
>>
>> This will be my last reply to you. I will not respond again.
>>
> 
> Hi Tao,
> 
> Please don't walk away from the linux-mm community. I read your
> patchset and found it quite valuable. It not only reduces memory
> overhead, but also eliminates rmap costs for exclusive folios.
> 
> Since I'm not very confident discussing technical topics in English,
> I wrote a blog post in Chinese about your patchset:
> 
> https://mp.weixin.qq.com/s/k00tzhTl8HbL3k4G6ev4SA
> 
> I have to admit that I found the implementation quite complex and
> in need of significant improvement. However, I think the underlying
> idea is very interesting and worth exploring further.
> 
> I'm looking forward to seeing a v2 RFC with a cleaner and simpler
> implementation while preserving the core concept.
> 
> Regardless of whether it ultimately gets merged, I hope the discussion
> can continue.

Same here :)

Tao, please don't let this thread get you down. No first RFC is
perfect, and the idea still looks worth discussing :)

Thanks for working on this!

Cheers, Lance

