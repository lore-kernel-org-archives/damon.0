Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8132D7388
	for <damon@lists.linux.dev>; Wed,  5 Nov 2025 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372870; cv=none; b=tnzW2woWm8qfl37B0MnSAUi8yg10oONVc+s/Fhs8W9RPJwqPpxuFxoWzs1MlIocuYDWrcFUpcq5Ngr7SM6bW1q0FEkoBrFjhGigFg4GsIhRBmcP8qVWuNTuqYL/kEse+bLw5XOMdLGYCrUJ7uspeAuJYGgZf8vZ0UFZKMCrB8Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372870; c=relaxed/simple;
	bh=GsjEeX/yoeLxBaD+dnbSv8Mk07ocMdYdXojXWIK+l4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXscR7A5AldYxpYrJ4sul3TD+1nyr+m6Cn02PbLS+4IZObYhTKLrEjciW1DzA8qXEO3g+ptEq3xYHMYa3npPR8eVEe/Bcr2B5qrcrnINP/6Es/APvdtXXpF8uAUiHIlbfIlhKbKTj6wY7nNTsIjupmENEwqCQ2QDvBoQN1Bn6hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Jh+uzRit; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Jh+uzRit"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88043139c35so2225686d6.0
        for <damon@lists.linux.dev>; Wed, 05 Nov 2025 12:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762372865; x=1762977665; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldDyq3tsFgYvyoHI8nWeYS5HdbVk0rd4V1r4ezrVHxs=;
        b=Jh+uzRit1p7Q98Ap2WCBJRRdLRQbZaESgmDLja7Ktt3UMPNycujFuFZrUjUKtoD8sb
         lD1zI7jA2CPbBQilnGMjaXejRe5Q3WnBe/vYlUMJDvSKZGRJS2lIL/K8uOST35iKA5dU
         0jp6ixdFqK4jmJ6tTRGxDKraR4W1crX7jGuNJHHb4/oAVHZW+Tvr3jC8ZAJfLercScRK
         v5KBEClkjPZZYAx5l5KWK9UjYdSMHwpyozujWLlNYgAS5BlwVJn4XmaKKx6kQ5muSr2I
         rfVaDtYCjtonUZmSOYhuE84ou17vV36a4j4o4cXDaBeGM3vUX61d2KLsfgDX+pJSEYgM
         vyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762372865; x=1762977665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldDyq3tsFgYvyoHI8nWeYS5HdbVk0rd4V1r4ezrVHxs=;
        b=ZCRrTg6vHaf8PmEoq5WW3mtfT9lwlDmc3r/yo0ANDtAQd/C4uiIO5+aHvbj51NCJXZ
         mVhqm8J8ua2VRvxrPTEtNoXWAfRxyRzwd1iUHJB8vmvyR+7xzcUwGvLNibV47o3GzIwW
         tFn994kUv3lfq6omtRVfzOwKqyC3crcTyo4mJnXPE/p/Ks4r+vB5LSkd7u6TrNwP7+5h
         ogSrYQ0h6vY++5czq4ZmNSJyCDMiYD63aQxARd9iel7spFURu43eExcL2wQ8RAF6R4VR
         6y4Dz7ZFPkKh58sj3SwXBAmIi30lNyft3LUtlkw+PbnGFQD9jQPwaqlrtADVbPpUAVwo
         SZcw==
X-Forwarded-Encrypted: i=1; AJvYcCWh13r8HDfs8GV2mCHAg7d8ldH1aH+VYo9TyGGxz3qoiCUZt9A6jWVI4qhKV6oLzHVE9UOeng==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDzuDJymIQdVOf74jqHgc4SdX9eVck5pHiabE9zuUOIO4ugSMb
	llvuVF962sXS/rZZYIs6ff/OB6chzSB0tQ/PQm9k5OEQDWpykhky8yfyYRJ9sei06Ec=
X-Gm-Gg: ASbGncv9w+iA946Sxh5ZddNHPuVno0qqqV86Pyf03FECd9yCY8IGV/djX6/7xl/9Fpc
	wOc6Mnv/98TocVqxiCjYJta96BPcGX0sED62SbgTQ8gi/XrQkKq4bXlEHA4bdfWBNCAZ775QjV1
	fuadlzwc/vqY2rLYbYbheI8Ah9tFlxxZM24KjF3aNSYyCUjfrxlwvil0J3KOm5QCNGYd0QHpAnf
	dIL3oRrm5GMmnQw5HnYbnvEWWtbWdUQaDqEZALyUTrpjWuy5dWCTu1VvP+KHDier11Ajy34xbGl
	oL4nY4PHT1JZzJ7hfZewwNay8UC+n1T5U4h9XGpD7macysp8ho3fM+8b2UfKr93Ruvod+Z3mLY1
	JspalXXoca0gVyF1Q/SxNb9ikxox5dwIMiz/GmQi+mt2vKFfV5vz3aUKPMVxzTR5DmF8JhBiEJu
	L5TJcgJz8r0eNSpZ3rSbkjcw5Bqn9MQcnri+7Lqxr6YytErRfet/KGfN0qyYE=
X-Google-Smtp-Source: AGHT+IFrPbLMeE9CYwB+D7eMKoLl9vB1NdinT/slFi02CGhPHxsO1o1rCTabfaRmYf3n9WMkLz+GWg==
X-Received: by 2002:a05:6214:20ad:b0:880:4896:5d81 with SMTP id 6a1803df08f44-88071135a41mr51873106d6.3.1762372864533;
        Wed, 05 Nov 2025 12:01:04 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880828c4570sm4100556d6.10.2025.11.05.12.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:01:03 -0800 (PST)
Date: Wed, 5 Nov 2025 15:01:00 -0500
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <aQus_MNi2gFyY_pL@gourry-fedora-PF4VCD3F>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
 <aQugI-F_Jig41FR9@casper.infradead.org>
 <aQukruJP6CyG7UNx@gourry-fedora-PF4VCD3F>
 <373a0e43-c9bf-4b5b-8d39-4f71684ef883@lucifer.local>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <373a0e43-c9bf-4b5b-8d39-4f71684ef883@lucifer.local>

On Wed, Nov 05, 2025 at 07:52:36PM +0000, Lorenzo Stoakes wrote:
> On Wed, Nov 05, 2025 at 02:25:34PM -0500, Gregory Price wrote:
> > On Wed, Nov 05, 2025 at 07:06:11PM +0000, Matthew Wilcox wrote:
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
>

Reasonable - names are hard, but just about anything will be better than swp_entry.

SWE / sw_entry seems perfectly reasonable.

~Gregory
