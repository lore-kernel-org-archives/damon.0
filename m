Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F58343D69
	for <damon@lists.linux.dev>; Wed,  5 Nov 2025 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372604; cv=none; b=KzoZqpfVfODPsiubApl777RCCuSdsuQ8yCTRFLNqwLR/wmk9QxlLnKPv+Xb3w8wsh/6G5F+HTw75vJvL45IgCMngPKTmsYv0x5CcMlcC8hfxO1KfYs9k2t1CJJlhSB/stvvJ6GuClEGX5id3ln1Or+AupcuEkP0LzgTgjKgUvQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372604; c=relaxed/simple;
	bh=y0djx7SaSKxrg38g7Mq/6kY7uEuPs6Y4jirNJDxy4Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ouxxj/EkiLLaFBCeq4D8nhvZft0CX/yzMoeRv1sB5Pn6qx/GhAGhRsHe+OQdnbZAWEh4+NdCjMJrf6ANZ2nvOswaxZqg06Vq3lbmK6nOeTHWvjsrBsxyNMX5rudm99h0ZDg5EFoq4cwh1XgPp+ZvYVxB/CgNlU0QaeZ9XR9EyjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f2SV8ynx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2SV8ynx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762372602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RfRdq0AOLjAvRpFgewWvnXKqu09Gq6WPLf3shQQBn6o=;
	b=f2SV8ynxT+vWq6qo+qIcTATLzYz3kByfGhT4mMHOgXgK+HSD9iCJLelPbg3km9/71uSkWF
	w+YN2FrXYCsUZOYgUwBxpt4Vv7VwvLYubeylXHnF2MnhZx9Pz0YBwDw6wlUE6fNR/6znPz
	MIuzne1EW3CgP2dSihwqzT9rxH8whT0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-tdSyXa9bOw2d0wQqF8e1Rw-1; Wed, 05 Nov 2025 14:56:39 -0500
X-MC-Unique: tdSyXa9bOw2d0wQqF8e1Rw-1
X-Mimecast-MFC-AGG-ID: tdSyXa9bOw2d0wQqF8e1Rw_1762372598
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4775e54a70aso1849865e9.0
        for <damon@lists.linux.dev>; Wed, 05 Nov 2025 11:56:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762372598; x=1762977398;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RfRdq0AOLjAvRpFgewWvnXKqu09Gq6WPLf3shQQBn6o=;
        b=C1x6zheeqI6LVN8QFABL4J9FTZ9J+YS24ns8Y0OdgA7xyxNBzfkxCndgX4L12wI/0k
         y/xo5F+ZuqWjX16914KVU1scHuohH8GWC/VOy9FD9Vji7stTOswhY4S00LlZ6rc5dKMr
         ZJukEO/FYzLju/X9IT2yfc6ARYpQNpqVjxLplHo7wyct6aWmLCDVDnBqJWYuxRzTiPym
         +8rsEgj47zAAiwSYbLEhCF+EG2KQbrrMt8izghkKTEDtPwiqimUtXgkKjWIgtYXKW4gp
         lpC4FWCHh42c+i5MUKB/n5XnJuePoChR+32HqCdOllbY0DUgesxCj9BfV9v6YVqruxsv
         Mskg==
X-Forwarded-Encrypted: i=1; AJvYcCV4g46R1zPduSVxBQqt1d0mDeSR1ppWpt3O6Qk7jTZeu68gKpTuSI47X0Xb64ZYLKmeaD0jAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpHBY5jwJIQtK8u2WZhBXFHMdUD3a1C2WiuiOPpEusV3Wgzkrf
	gLdyQMofUAaCpRRSvypKtAHISxStxiKqSoLDvAwC3NMxfcVU3oQ7PAJJmya352YDC4YuD9gu6KL
	xYZjT8kg9vr4TcEOs6cKJ6BJq/ZmNm/X9qAw6w/DjO8cANLcaz3g9gIx0
X-Gm-Gg: ASbGnct4L4d/qDNDNZuoIBqlL4enfDgZGBp0yMCHgv4hjC7qlXopRq8KYEhxddtXcvx
	Xsai68gqADatG6xdu5W2zUBjH1U5nT0hWQihTzO1yNT48WwjO37aFbMXd52Fd4lGWr9cQNR/SCw
	vXiqvLrGf0rAcZAX0G31SE+UrStGFqmGAjpfNLF4DW0DLsdRUD429WHri7YrJS8hvrJ8vF/EeqI
	5PTApsK76JpPVGLo/PRFF+S5z9q/5wvi6iCmG0mnaS4Q+gNVbUnix8eP2DMr0xJpf7zrOosSGov
	HhV46k4pQziRr9LeRb5G0JSsBt2xSZJp6LqzUa+bMrXl/HEq6EiVKTyFPYAta3Z9GpcnTQgCnNn
	TQGwnJfGg65G4KYzqI6F+jHEiSoLlVXVjmj8vsjmUr+l1yDCWvfjr5UYr7p4TOTMoavxOApY+hl
	kWUsA3Vj6vhO5t90YMSzaaZQ==
X-Received: by 2002:a05:600c:348f:b0:46f:b43a:aee1 with SMTP id 5b1f17b1804b1-4775ce2c7eemr29950535e9.38.1762372598060;
        Wed, 05 Nov 2025 11:56:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK7yLH47QUN086LZNyuRAD2Zw/GPvRFlywAZeFx22RAaEduz3ojwl4v/Mo8ax5jk1OZayf5g==
X-Received: by 2002:a05:600c:348f:b0:46f:b43a:aee1 with SMTP id 5b1f17b1804b1-4775ce2c7eemr29949845e9.38.1762372597551;
        Wed, 05 Nov 2025 11:56:37 -0800 (PST)
Received: from ?IPV6:2003:d8:2f30:b00:cea9:dee:d607:41d? (p200300d82f300b00cea90deed607041d.dip0.t-ipconnect.de. [2003:d8:2f30:b00:cea9:dee:d607:41d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdc33bdsm64219765e9.1.2025.11.05.11.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 11:56:36 -0800 (PST)
Message-ID: <c8f4e753-836d-4ca4-8a94-c54738b7db45@redhat.com>
Date: Wed, 5 Nov 2025 20:56:34 +0100
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] mm: introduce leaf entry type and use to simplify
 leaf entry logic
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Gregory Price <gourry@gourry.net>
Cc: Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
 SeongJae Park <sj@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Jann Horn <jannh@google.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Pedro Falcato <pfalcato@suse.de>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, damon@lists.linux.dev
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
 <aQugI-F_Jig41FR9@casper.infradead.org>
 <aQukruJP6CyG7UNx@gourry-fedora-PF4VCD3F>
 <373a0e43-c9bf-4b5b-8d39-4f71684ef883@lucifer.local>
From: David Hildenbrand <dhildenb@redhat.com>
In-Reply-To: <373a0e43-c9bf-4b5b-8d39-4f71684ef883@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: X1OZ3HRDQtNaDxoiPbZs57clTEAhtGHWX5M6chFMGTg_1762372598
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.11.25 20:52, Lorenzo Stoakes wrote:
> On Wed, Nov 05, 2025 at 02:25:34PM -0500, Gregory Price wrote:
>> On Wed, Nov 05, 2025 at 07:06:11PM +0000, Matthew Wilcox wrote:
>>> On Mon, Nov 03, 2025 at 12:31:43PM +0000, Lorenzo Stoakes wrote:
>>>> The kernel maintains leaf page table entries which contain either:
>>>>
>>>> - Nothing ('none' entries)
>>>> - Present entries (that is stuff the hardware can navigate without fault)
>>>> - Everything else that will cause a fault which the kernel handles
>>>
>>> The problem is that we're already using 'pmd leaf entries' to mean "this
>>> is a pointer to a PMD entry rather than a table of PTEs".
>>
>> Having not looked at the implications of this for leafent_t prototypes
>> ...
>> Can't this be solved by just adding a leafent type "Pointer" which
>> implies there's exactly one leaf-ent type which won't cause faults?
>>
>> is_present() => (table_ptr || leafent_ptr)
>> else():      => !leafent_ptr
>>
>> if is_none()
>> 	do the none-thing
>> if is_present()
>> 	if is_leafent(ent)  (== is_leafent_ptr)
>> 		do the pointer thing
>> 	else
>> 		do the table thing
>> else()
>> 	type = leafent_type(ent)
>> 	switch(type)
>> 		do the software things
>> 		can't be a present entry (see above)
>>
>>
>> A leaf is a leaf :shrug:
>>
>> ~Gregory
> 
> I thought about doing this but it doesn't really work as the type is
> _abstracted_ from the architecture-specific value, _and_ we use what is
> currently the swp_type field to identify what this is.
> 
> So we would lose the architecture-specific information that any 'hardware leaf'
> entry would require and not be able to reliably identify it without losing bits.
> 
> Trying to preserve the value _and_ correctly identify it as a present entry
> would be difficult.
> 
> And I _really_ didn't want to go on a deep dive through all the architectures to
> see if we could encode it differently to allow for this.
> 
> Rather I think it's better to differentiate between s/w + h/w leaf entries.

(Being rather silent because I'm busy with all kinds of other stuff)

I agree :)

As Willy said, something that spells out "sw leaf" would be nice.

-- 
Cheers

David

