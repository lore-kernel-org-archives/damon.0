Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D435A329391
	for <damon@lists.linux.dev>; Thu, 13 Aug 2026 01:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786584075; cv=none; b=roTHRpZC3+f9jX6jURcZ+EzWyOU6Tj6Z7m62QJfhT4Y3k7odgIYPmAsGKJUp28CK3X+Xc5TUPXGFgkdhh/gPnO03sLB+W0HnuaYHRp/SAm3kqtrRucPcRogYlh6aQmR8UOdoOzAVmqHv4vtM00V5YmD9NjKTlfCOnCraBc2dY3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786584075; c=relaxed/simple;
	bh=jQAWRVENXd5JGHsxo/hf6vUttuV6ujE/QtYCehIVHRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkZ/Til3b2tLuqTIuWF55sHJfsBZXOil1JIR6Ym3ev1+54+x7R6o6CbbaTp+awjn5CWXYHPzMWa7FwXweZMWXGdtjHAoCIr8u78GGDowQZY+zZXsN0ElVS7kMU3nCdnMb0qKEdg7j5uT66xbFQdOlmGoy4D/i9YcYux4cVtvVF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=d9K89YH0; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="d9K89YH0"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-9063b380982so2552266d6.0
        for <damon@lists.linux.dev>; Wed, 12 Aug 2026 18:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1786584072; x=1787188872; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZGIPGO62vUWJJtnlWOV7HnIzQD6+wbjwlpycp53S1ew=;
        b=d9K89YH0ctTT4HwDhv2Ht7dHIciuO1f7VAiT+cZxQsdDL/mqSRwwR/exBrBtR0TEgZ
         /hqfI/py/OfIPKNSfpQErjSRHP2I1yfOHe5BT7vguzGNTfsLvcY+xgAAriXhfoLjaRwJ
         8h8zQb7xHrgMJqSK/CJd56UTxSENpqhKLkuJOyTZwHTSwTXkChNiXzLUl41ruhNAW17g
         KCKmO+OaobbRo9At42SUfqCzkIVD+74SMKVUsteL++6HOeMF9FhKKhIHMTMafxgXklGb
         XN8I5M6Dy4qBizRrxAWMUnZKB5g7Z+qKm0ZdU2xShkh6sEfFfR5dAFVEx54AF5JzrGru
         fHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786584072; x=1787188872;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZGIPGO62vUWJJtnlWOV7HnIzQD6+wbjwlpycp53S1ew=;
        b=ZGqm4nRuLVp1HDg6bXqz6WcfBdLBHcd+W63jKwbSA4is6vuXgNDOW4wKeci2QKS4CJ
         ziH8hQexVeMG5uL235L6BtkbeEBQ7LBXefjs+YFHvq54DM/FegyUYryUW0tB/zyRHNrQ
         zkbgZ5sCrfFmgRqPpoms5rX+BhPHtHfPuOb5hkHnLX5cWUHvHitsckDB1yLN4uFr5wH4
         Qa8dMEEwIMWTU4Hnyn4bwuoNzHxAit0LMM8GHW65WTeg4YnCRgAt6xU1ZkX1Lzk6VhYo
         D9ONcFGd8iC3CuYQuCjZvDVXQlM/4FuPfqeTEpLix494vV2pK4/awNOvlQp/wgk8Ppka
         PWZA==
X-Forwarded-Encrypted: i=1; AHgh+RpbKrgTStUZebZFUg3neNnvJ2KWSOqwAIYD+UV1LRwRr2C640LuDsqQ9VEZpP8Ea98gf3ClIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9DvdrVqceLhzlmVfetk6BpxQ9zrGCnEra55T2ilsf1/cphgu4
	q6Zu0nJbUTRVFCO1JTd4robb46TdyHCRfvT1H0pXDwrPrM9jH5bcGm13cXbmzpINXs4=
X-Gm-Gg: AR+sD12ehmrmOr7aTcGAgTLRiA+SKyHq5sbDk5tOcbDfE+1ryo+sKg//NDqrAzp2dU+
	GjnrJ/Y1FSLSAX+XerGqJS5kvw7XBtgJS2kOnNTbHkelZ2sg9YaIFkZBhJcALt98EmBv8R0hWTo
	ljDlqwTMok9umyPqlYgc4htPJnuUQ/nWvLRVu8J5BhNJksubo6uuD88+kLV8qOk5VUTGGWYYZbx
	8fWntCzupTtj9mvnktkTpGwvXF7ytrhXQ8WhahIoydfEv/9GrDrdfg/HUs95aSnnqwQnvWUHF06
	rBfdQ3pEp18abylwgfz3U7cgoLHSiwlRyvmqxcnLfv/+qnyqI9o082Zj7dDr02ldB2b4Q7yx+SE
	+x1fv57D/Ty7xmGlLJlpYqdOZPTwxoqdGRcp/D3uPF32JwZIPzXmkq3RssbfrrKG5OOYPJdD2DY
	6RC85gu62J+A2iFwIQ6x2rKYMWD6llbF7FhrtlH2fqJODF0P4=
X-Received: by 2002:a05:6214:500b:b0:8f0:d710:26ba with SMTP id 6a1803df08f44-90a80bb0b74mr17793966d6.31.1786584071577;
        Wed, 12 Aug 2026 18:21:11 -0700 (PDT)
Received: from fedora ([2601:19e:8500:d3c0::28fe])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a8179e350sm4119856d6.6.2026.08.12.18.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 18:21:10 -0700 (PDT)
Date: Wed, 12 Aug 2026 21:21:04 -0400
From: Gregory Price <gourry@gourry.net>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: linux-mm@kvack.org, Zhigang.Luo@amd.com, arun.george@samsung.com,
	balbirs@nvidia.com, brendan.jackman@linux.dev, yuzenghui@huawei.com,
	apopple@nvidia.com, alucerop@amd.com, matthew.brost@intel.com,
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, corbet@lwn.net,
	skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, djbw@kernel.org,
	vishal.l.verma@intel.com, dave.jiang@intel.com,
	alison.schofield@intel.com, osandov@osandov.com, jannh@google.com,
	pfalcato@suse.de, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, pbonzini@redhat.com, osalvador@suse.de,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, kasong@tencent.com,
	qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, longman@redhat.com,
	ridong.chen@linux.dev, tj@kernel.org, mkoutny@suse.com,
	sj@kernel.org, jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, lance.yang@linux.dev,
	usama.arif@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-debuggers@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
	cgroups@vger.kernel.org, damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com,
	"Gupta, Pankaj" <pankaj.gupta@amd.com>
Subject: Re: [PATCH v5 00/36] Private Memory NUMA Nodes
Message-ID: <an0cAMh_m8ZhGIm2@fedora>
References: <20260720193431.3841992-1-gourry@gourry.net>
 <CAM9Jb+jpJ-Ui4qDHxsp2WiERiv8gmrQfKQ8Z0BmabefeQ6pg4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9Jb+jpJ-Ui4qDHxsp2WiERiv8gmrQfKQ8Z0BmabefeQ6pg4A@mail.gmail.com>

On Wed, Aug 12, 2026 at 02:01:12PM +0200, Pankaj Gupta wrote:
> >
> > Bonus Configuration: HBM device memory tiering
> > ==============================================
> > echo 1 > dax0.0/private       # make the node private
> > echo 0 > dax0.0/adistance     # highest tier
> > echo 1 > dax0.0/reclaim       # reclaim active
> > echo 1 > dax0.0/demotion      # may demote from the node
> > echo 1 > dax0.0/user_numa     # mbind()
> > echo online_movable > dax0.0/state
> > echo 1 > numa/demotion_enabled
> 
> I am bit confused by the HBM device example being discovered as a DAX
> device. Is it to
> only to showcase the use-case? Or we see HBM device is actually
> expected to be discovered as
> DAX device with N_MEMORY_PRIVATE?
> 

"actually expected to be" -> no.  there's no requirement HBM be
discovered and boudn to DAX, DAX is simply a convenient intermediary
to memory-hotplug.  This is at best a demonstration.

A device driver could very well just call memory-hotplug directly,
or its memory could be brought up as a private node via a boot
paremeter (which I have sculpted for v7).  The former is preferred,
but there's a bit of a chicken/egg scenario for bootstrapping.

Most of these UAPI extensions are going to be consolidated into a
debugfs interface for testing purposes only in v7.  I've been working
on aggressive Linux Test Project test expansion to ensure there is no
UAPI regressions.

~Gregory
