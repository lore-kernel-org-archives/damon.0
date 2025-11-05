Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8704132E140
	for <damon@lists.linux.dev>; Wed,  5 Nov 2025 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353751; cv=none; b=k4R7xNA5iWD1Nopp83k2reh2xqMMNBOqwR09XGnZ5Rt/4l0/Hy3UshX5dbYfsPzKZ7LevPtmHz8t6kt5TcVEDmanXCu/Z3WmTdLPxd82wE0kkvcPB1L/v+G7m8ZOMBotqnumpib9+SPtbu+T38C1cLySerTDkoINJ0hhCS34nPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353751; c=relaxed/simple;
	bh=ij2iHrslX/5yNAV81WvwyiP5ZRrrhcDqQSgtHEa9ZoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrobb3pDFGpIjxtRmqqUZrYscLHFGtr5w2XuNgpA42b8PtJXhnxaDgSUJD5NMVvhh67YysERw1FEUpWgDtubLdCKVF6hxZEaEkNyf1udN8cPoAzx8hxeTyJ4deGmS4ovHMt8zoc8TSaLCfxHE/Pg+XQKUMpic2Z73f6j/CX65HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=g+Xl2xYS; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="g+Xl2xYS"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b220ddc189so162589985a.0
        for <damon@lists.linux.dev>; Wed, 05 Nov 2025 06:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762353748; x=1762958548; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCP0hsq/q40gFxNmjoVFcp0QbOx89aTWebuusBQgCaY=;
        b=g+Xl2xYSv3Z1WBrgaYV97hQsZ4/cz89wxjIyFDVgqDCRule5XVoC8g8ohHBEtYTEJ+
         G4V2hcVS1tQ0gHrpUsEtLFouOVqtSC0zJQOPS4At1VffS7vl8keyigHx2b2KqzsolSyG
         TQPeI/0Snwrqw/cv0QgI8nUY/uOioeBy+cTFc3esTGpBBEjr1JgyLFNPevn9qaMvzc4e
         eMoqzxRgQEA/bqVZpR4+XpcnnDftIJYnsPmtF2YDfp2rVEJxPnw+Ve3/1kYgM1kziTz1
         RMAc+cV5OT4BtPWCBPT90f+W5aBR9CFJ5Bog1rUDyINGaw0IuUdyiMULR57e9wDDaB2Y
         7ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353748; x=1762958548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCP0hsq/q40gFxNmjoVFcp0QbOx89aTWebuusBQgCaY=;
        b=SdXvyoarNjUQM/oXe1GA4NTSbZqcxEo0Kj2ChHa44VAB70oi4rgkcEaNHpuuo+WPUF
         qNSjlWGub2lA8BF5earSBfq7EgqBgv7d80mfIkvThxn8T2NOg4B49QIXCZBxWkhwKcj8
         I0PDXVXYD9IzTafFCVk+Mdlh4pA8nwUiNW8tRKUbSAafH8ZWBqjwQ4vnuQDr+mPMQ6M1
         l3JjOUuBKoBdyoUNJSGRZd4P9uy7enmlgks2P/B+lvHWxGSuUdzfBOrgnpAd7nbJCVQ0
         BSAycfpI8LXyBIQMBn77O7Fpl/wViY2eBULcmsvvsI3ONdJH38s2W0i4WNO3aEP5v2U9
         N+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdRAU/eSSuv39A2rCvwLwHUHbFDNZjWbABvXFzXTDV19o4XTy1bnuGrbTbgVo46+6Dmh4OBg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyqbr/tQNa3NTZPDUESPdu9EaoDszqQ3z7vJ+9q0N9Rtsy+hIxV
	zQfzeSLZ/dsfJ70AvdKwG+wP7jewDF6i+8euWy81xdwNuwGCaEa0kDJ/0jUAqpqLqxM=
X-Gm-Gg: ASbGncsMFRIxPJ2N9fZxFA6NxYEF6Q5bV2KUEnVrgWh/c/g8jXm5QVb73gAaWk5aEQ5
	wCeqOIVI56Thc0X2fByIhj9+hrnwi4adpjnTCWH0MrBASWj70/nFMxD79EOE2VXspy1PUtVEyv1
	4VsMX4DpYqI+wUroVeV71o0UB/ka2Wg2oTtr0fI7ylmaggOvcSlH6EQlf5s5HPDxixCKPhCTLAz
	XBTXxc2Kc4Y4ffwaD4rcah0Wkd99KIH51U8EGtpUybfgF9E518xl5RFMJuAlx+ymmbs7KZNjcdQ
	J/hptzX3II6R9mHgBsWWbE4NBTcGX1DzMPhqkFF7u6YB1YD/zIoXtag2cPXArjvDjiGPEkfqDPa
	yeZG0JHuNkbW9GAJok6a7qpXQMJuLAh8VFFtBgX3uzDxgIilXy8A+PM8nGBs0ccl26dzwY2Wp6j
	3pUKuHJ4uZG9cl8CWk5LTYN5gqQn8DfzYaOp9dOg/HALfymqVo3P8oJKRtmmM+Ugv3cVe59Q==
X-Google-Smtp-Source: AGHT+IFOPmymxkVWTStAmI1fSxsEHrX8n+cH3NR2hrKHNMeSwi6zTbwFsDY5mjtR5/Zbzi6pU1fUXg==
X-Received: by 2002:a05:620a:4416:b0:8ab:4ada:9b2f with SMTP id af79cd13be357-8b220b7f441mr375892585a.56.1762353748298;
        Wed, 05 Nov 2025 06:42:28 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b21fc36dbasm239867985a.19.2025.11.05.06.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:42:27 -0800 (PST)
Date: Wed, 5 Nov 2025 09:42:24 -0500
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
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
Message-ID: <aQtiUPwhY5brDrna@gourry-fedora-PF4VCD3F>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>

On Mon, Nov 03, 2025 at 12:31:43PM +0000, Lorenzo Stoakes wrote:
> +typedef swp_entry_t leaf_entry_t;
> +
> +#ifdef CONFIG_MMU
> +
> +/* Temporary until swp_entry_t eliminated. */
> +#define LEAF_TYPE_SHIFT SWP_TYPE_SHIFT
> +
> +enum leaf_entry_type {
> +	/* Fundamental types. */
> +	LEAFENT_NONE,
> +	LEAFENT_SWAP,
> +	/* Migration types. */
> +	LEAFENT_MIGRATION_READ,
> +	LEAFENT_MIGRATION_READ_EXCLUSIVE,
> +	LEAFENT_MIGRATION_WRITE,
> +	/* Device types. */
> +	LEAFENT_DEVICE_PRIVATE_READ,
> +	LEAFENT_DEVICE_PRIVATE_WRITE,
> +	LEAFENT_DEVICE_EXCLUSIVE,
> +	/* H/W posion types. */
> +	LEAFENT_HWPOISON,
> +	/* Marker types. */
> +	LEAFENT_MARKER,
> +};
> +

Have been browsing the patch set again, will get around a deeper review,
but just wanted to say this is a thing of beauty :]

~Gregory
