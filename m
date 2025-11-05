Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C2431DDBD
	for <damon@lists.linux.dev>; Wed,  5 Nov 2025 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363279; cv=none; b=UgQPxEPGNyLjOIfHMdzYTpY+XASslkQtHMmxnODBkaQbknvhRzE+K+lQqJr3oiAEVp23FilTmQWu4bl6Tbh1RlpsBWAryzxKoqtwcrddsK0HfRyk92lkhxyJDBjglUdqaVJRxgf2hIY7oiWMTItYGZubX7qc8YRPLjIr2fIe4zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363279; c=relaxed/simple;
	bh=R+scxNFIJ7A2QKHZGih1Ehc3wdUpOLgJ/krGtFdCacU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dn0nKN0yTvwbVZqco0P35lnzOigeaA1tZpcq8sGD5cP1QJNJW3m889pBNgn394rbuUCpEXY3DcGwig5SU0OPpNMLdtNoK+k32SjJtkpF3zFqiuwg4HY8nHMGEQHI0/7bOI+U2jkZ/Cm2D+BAnmk8PAuemOVgbfA+0FTdrrXqWLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GkAJTfsB; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GkAJTfsB"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88059c28da1so1393166d6.2
        for <damon@lists.linux.dev>; Wed, 05 Nov 2025 09:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762363276; x=1762968076; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2cq2mS+yWhZev0zm4YEm/j+lSP0FbcQSTW4gUm6tSNU=;
        b=GkAJTfsBxdqpe6nYztNxI2kRIrCyTnZ5M1Q/o0IbF2cgbfpc6PZpqx7K2i3ENKRLXG
         LQeY8U1pd1Tuu0Li/rTNMOVA2pcgXpfKJd2jtBjs6jEUM2blDCbj/a5ZunxAzwn5/ogh
         jD/6iKk0BxNpHl4hnNYYhfeiZJysLeMvwXOIl0/WndbwXq3oTLPTtfb2DmjRNfNXH8m4
         SZ60ex9tHWCezp/ohGOek5R1eK30ZOe32P1XdL7X3X6lUkbRVE+h3EktE7Wnq9lHCeTa
         Mss0pK7eN9i0PWHM0U6S8yankCvi6tJjTSuR54guT0Xp/Q0ch7lyL9oo7oMBpiTWoNgG
         6IZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762363276; x=1762968076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cq2mS+yWhZev0zm4YEm/j+lSP0FbcQSTW4gUm6tSNU=;
        b=L5jcyUBediPmkroOy11zBlKCmp5d7nh81vE764UQVEUjDJos/0FXBL5IyQWbfyndcR
         nmY9KM+hv9ytJElGucELkQSvUTEPc1OmUvHAjEl9dhQWBucn1hMszhxqKgGUB9wLlUnF
         IiMvXfOlGMSljeA/lHCThUUdEkCNK6RwXyzQC6JIDwck/V9R9OJ124By+yyrCHOsea+6
         pa+uPA8+jBaMDzD/fxtMB3L/YZOm9ahuES6aDJvZD+MZ+V5ZyLIEDTNeIiQL4fkm5fu6
         H6CeXcS3RIZ2+aXLgaeEtcFhYNbvA8DkPPrutWsYbnmzTu4BWc42yMo/W8BPeAU5OnmL
         X7Sg==
X-Forwarded-Encrypted: i=1; AJvYcCX48NoRGvhp6jWrh9vM+Vyp/gUMKtQEflgxXC+SAzk219mISMXElum84U0FFR1AOvvCQVcm/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YycBBurC+yDPPjN9FyrTdp4L9XPVqvxCNOFJa7f0k6d7uwB4kzk
	XgHKdxydoNBM2ZNOj1ZfsV4E1/GlaIFVsHCbJhgguKKVeHiLubIfjBxCIK13r4apE6c=
X-Gm-Gg: ASbGncskqyGM/nfdI/2DTlTTWblxrGOlaWpzOR7A+vbkK9PsCV6d3DoDFGVZgBuzMoS
	3CmfNz5occGB+uGgyscuA2IAel95Ldxu7PXQf1nCwGC3myOE+uCmN95jjGaA0pD+Glx/vdk6P6W
	Rl2SdXcRb4So/cACahDwXNjFnq4E9l6mto1e5QAbsUv8fwm18/12+YAqlpYxR2CLWSqm+6cc7ym
	t6J0dB9Yfe61fM6mCDEvmv03qtTuGvXgVx8BCGb8KH4FwwTixnGOIO7m0uac63I2nNZtyiEPi/l
	FAtDV0dS1DdDfXgUez7L2THMt6AuuGPtdbmfrE90EqLbZnA9kE9PaRCGOZcHJvqygrCidnRwgl3
	oLWngcOV/ThmvZPGuhYwFdE4j+q9eSQE1/OWycvR8Pe3gHEsETLeZLqUjKBHTzV3eH8GKtiCOKd
	OLsNG86f9gbWdKLyWNZwAlz1hGuMYIw7w1s/W+bD3sNvmufQ==
X-Google-Smtp-Source: AGHT+IGCK5Ht7P6eoqM7YgVZ6ef4jlofMTj5LlbxF9x0JfdkYp0y/H774e8UOGf7CmqXFow5BgQdlA==
X-Received: by 2002:ad4:576e:0:b0:880:5779:d489 with SMTP id 6a1803df08f44-88071095623mr52524556d6.3.1762363276490;
        Wed, 05 Nov 2025 09:21:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880828c457bsm996916d6.5.2025.11.05.09.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:21:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vGhC7-00000007Bv7-1e20;
	Wed, 05 Nov 2025 13:21:15 -0400
Date: Wed, 5 Nov 2025 13:21:15 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Gregory Price <gourry@gourry.net>
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
	SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <20251105172115.GQ1204670@ziepe.ca>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
 <aQtiUPwhY5brDrna@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQtiUPwhY5brDrna@gourry-fedora-PF4VCD3F>

On Wed, Nov 05, 2025 at 09:42:24AM -0500, Gregory Price wrote:
> On Mon, Nov 03, 2025 at 12:31:43PM +0000, Lorenzo Stoakes wrote:
> > +typedef swp_entry_t leaf_entry_t;
> > +
> > +#ifdef CONFIG_MMU
> > +
> > +/* Temporary until swp_entry_t eliminated. */
> > +#define LEAF_TYPE_SHIFT SWP_TYPE_SHIFT
> > +
> > +enum leaf_entry_type {
> > +	/* Fundamental types. */
> > +	LEAFENT_NONE,
> > +	LEAFENT_SWAP,
> > +	/* Migration types. */
> > +	LEAFENT_MIGRATION_READ,
> > +	LEAFENT_MIGRATION_READ_EXCLUSIVE,
> > +	LEAFENT_MIGRATION_WRITE,
> > +	/* Device types. */
> > +	LEAFENT_DEVICE_PRIVATE_READ,
> > +	LEAFENT_DEVICE_PRIVATE_WRITE,
> > +	LEAFENT_DEVICE_EXCLUSIVE,
> > +	/* H/W posion types. */
> > +	LEAFENT_HWPOISON,
> > +	/* Marker types. */
> > +	LEAFENT_MARKER,
> > +};
> > +
> 
> Have been browsing the patch set again, will get around a deeper review,
> but just wanted to say this is a thing of beauty :]

+1 I thought the same thing. So much clearer what is going on here,
and I didn't realize we had so many types already..

Jason
