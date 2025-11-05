Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE0C32E74A
	for <damon@lists.linux.dev>; Wed,  5 Nov 2025 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370742; cv=none; b=kL+vbEcCA3hUAaYDLYzb4LNM2rX5adeZ7wqA0SxlrMv0Tts3m+vvGTv5ObsxugH0qSu/WTa0Ayo4T/jfEPU7XchS0cpk07XY9Fmgs+uifA6uTL0xPZzgDHpmGhFcOD2z1AP8IzMJlGO7q+nrZ1uYoO//OAnHjM8Au8GjHLPbXwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370742; c=relaxed/simple;
	bh=Nu03Bte3QnL2ZmTAQ8EJFRG0YuAObGrFfyjxidVrgGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/ogsXm2+wj6zICJDo3SO5rjHW0c3ggZhUn0gQZjtw2Ptnd6ZwzA3TbS+MjP7hdZwKVeM9/YdfbTmLCf6/Laj522nPG2KLj0719G6zPBPFc8qSueQfFwYUjpSUP0KW+mNIILCjL86NV4xE73EVZaeOpWhw0UgAbxZcBUsvp3pi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=S25ogeGg; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="S25ogeGg"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-89ed2ee35bbso21978285a.3
        for <damon@lists.linux.dev>; Wed, 05 Nov 2025 11:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762370739; x=1762975539; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z3c7ISS42F3tYlBvNOZmQXpwFtE1e4tCRa3nMbV4lv0=;
        b=S25ogeGgLg5fwesyqdfP2EdcRF/gkxNnv3lqxM48xM0SgK+ZijPernGa/CvQsQ27Oj
         7DzMEUMsQqRxZZ8kerD/z/VDyxQIDg4eqqvGv5iPucxPh1uRcGt+95fbblZrNmh3AjCD
         yr3EixJckDUby10c3WAWlNMUaSMHZPReZWspztCdCrGnWWRUhs5O1bBrRK0dDYhMaxPK
         Mp1kJ5P5Q5BcLvDsWzACDqIAkZH/Z5pmvx56j7Lf2469bwUu8t/BmxCx65Q0gv2aWaHX
         hTomsTZPu+eHq2Pmjqk1S1rfGx+Y6f5iQ9xGrfidqqfNpodP1Uv+6nPAYB/Kx84yyGg+
         UOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762370739; x=1762975539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3c7ISS42F3tYlBvNOZmQXpwFtE1e4tCRa3nMbV4lv0=;
        b=g58u/tGaaose4hcRHRQHC5gTT4fptLHQ6V1B25KOZc+4+fuN015dWKHIV2HCNIibAV
         BpQtCdqX2FiCSXdW+orCiNesAOuq0O2Ey2sXP3iXP2o3xTZP2j5TwJaDmspHMLHhBZGp
         pmXsgiDnCPzziwUK+eO5OQmMX0vQ9wJSqdTdrX8a9y6l7JkEwwgDIwEMu2BhkOdn+NVl
         oIEKhgk83WJJvEUPBFP0EKHfie4Y29xoVLDe3O+wBK2Fte6GtwMrgcFkaDNwZlOTQYJf
         qaZ49jV6lz31qpPVTV9NmZHYqKupNyA+CHldqTEwziuUdEz+X5903Y6NIp95ozLz1tdC
         jFcA==
X-Forwarded-Encrypted: i=1; AJvYcCW7vcc9QvAstMkeGphCZ8NvQvsJ+yr6kWwZ2Y68LN7BwZVUUCoB36FFjIC+w1+DyykccaRG+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywdrh96T2+xIGMn4+wKOQy9R4XQP0LXjYdGlZnjKnjB7CzUs3bK
	r9g/3fFCKXR1YRjeAP/MLUxtUWV76iix4M11XED/02cFF5JQ7pgTlX8mOEW+QBKosXw=
X-Gm-Gg: ASbGncszF5OTXDsruoMO7v1kSikd7qgvlCphPxz646KoVaXOFAN0mva9tCxMU5NrqQi
	DH8X5qo64f6VoGEIIsGsvYJcpDueQtiCN/L50t/HqWf0tJix5OQUmREsoRUZLExu/rcPWrd/COL
	74TRlxANJNgglzMMqUOlN0FVetW0tIc8EL3eb1GsjCY06AqqvNk81LOIbzEK92N5qDRGEf7T/CB
	WmI3qb7JLwSbSfm17dTJubV66WvV5+WYLUGAWwooXWuVABeW/FPclaEuDkcVaDv2WwgeZksoB1R
	XHwoMRlT7vpAhtSQYPKeAvpptmUvAROtGIdOZ6Uv/9ngYfJKY9CTBJr81eIIm1Isy0OgkD33uvr
	f8/vojHIHAUvAeTc6YlBJ6n/xLtTW8JgLYqoDfSc0SCRkfxyl2kh/rpysEkgMXvlMJSbKkYkHyt
	2Xxes2PkL4JBxRBya7hkJeoMob2ucWeChtRuIIUQRt7mkHfyg26ZJi7ydRiNw=
X-Google-Smtp-Source: AGHT+IE93lZWq2OeBwVItF8pvYDXcfH6WZ0IIQ5p6JNn6wR82KcxAzEptz788KT3rDLJ0XOoUhNeCw==
X-Received: by 2002:a05:620a:4887:b0:8b1:a624:17b1 with SMTP id af79cd13be357-8b220b03a22mr560424085a.27.1762370739005;
        Wed, 05 Nov 2025 11:25:39 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2355e7208sm27162885a.18.2025.11.05.11.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:25:38 -0800 (PST)
Date: Wed, 5 Nov 2025 14:25:34 -0500
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	SeongJae Park <sj@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH 02/16] mm: introduce leaf entry type and use to simplify
 leaf entry logic
Message-ID: <aQukruJP6CyG7UNx@gourry-fedora-PF4VCD3F>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
 <aQugI-F_Jig41FR9@casper.infradead.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQugI-F_Jig41FR9@casper.infradead.org>

On Wed, Nov 05, 2025 at 07:06:11PM +0000, Matthew Wilcox wrote:
> On Mon, Nov 03, 2025 at 12:31:43PM +0000, Lorenzo Stoakes wrote:
> > The kernel maintains leaf page table entries which contain either:
> > 
> > - Nothing ('none' entries)
> > - Present entries (that is stuff the hardware can navigate without fault)
> > - Everything else that will cause a fault which the kernel handles
> 
> The problem is that we're already using 'pmd leaf entries' to mean "this
> is a pointer to a PMD entry rather than a table of PTEs".

Having not looked at the implications of this for leafent_t prototypes
...
Can't this be solved by just adding a leafent type "Pointer" which
implies there's exactly one leaf-ent type which won't cause faults?

is_present() => (table_ptr || leafent_ptr)
else():      => !leafent_ptr

if is_none()
	do the none-thing
if is_present()
	if is_leafent(ent)  (== is_leafent_ptr)
		do the pointer thing
	else
		do the table thing
else() 
	type = leafent_type(ent)
	switch(type)
		do the software things
		can't be a present entry (see above)


A leaf is a leaf :shrug:

~Gregory
