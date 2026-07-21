Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1818415F3F
	for <damon@lists.linux.dev>; Tue, 21 Jul 2026 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657790; cv=none; b=tuRvHnQfBcCYSxjxz4Hapb35Bw6ByFENkYTExijfT2n3VXSNezijkXPoKGFl+gNl/gccs9u1EJrlOOGXl4D1MfHL3z3NCcP9ekjUtoIST+yD+vl70axZKl9SkNkTtn2hfj1+vrPN0KubdnTT3x1qEYwSh3FCQ653cHReQt2klCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657790; c=relaxed/simple;
	bh=oFlvw3giOtGQsSkXQn6VVdx6osu4tro2T3RPW7SBhU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQCtezcZ/SOWCOq3rg05b7r80aRDbuJoTY/k4CY2PFHherfWHbvo/nDbEbzQi8zRjnFlT3Hgi5oFhj114l48bmBpNy9Z8RZEnLG7KrQoVO2HWMeyMmdpEftvwv/d7GeDYoi2GvFc98Mi6kHVT8cD6wJSnNn2ZScGmh7tZI8ssmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Y9ROWYwt; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Y9ROWYwt"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c15bf5000so79310521cf.3
        for <damon@lists.linux.dev>; Tue, 21 Jul 2026 11:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784657788; x=1785262588; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tK6CpaworNApxpcs4ZRJbHY7w08bgOkmP8ipHWd1tq8=;
        b=Y9ROWYwtMNHw9dpr9ETmAJJLCDvgcQUO7o5EX6NlnqHqvAfxG5AKlQ3mRMO2/QxeVq
         ZXiYSHh/Zjm0GpHvCHQk1SbIdR85N4TzIZ0IHIX6o7Tg7HfxoEwWztTIeMtehJCWEGoS
         BsFsqta7MA+aG81sS0mtuswwr2Z4Wn24Lhvk/cTf97YdD1CtD9NBgK3+BG6zo4PuCG2a
         1xLiFGTZLZmlcOhYo+zTeTES215teGUIdJQ4YLHn27y25oBawPpjtFMkQKu9zugpieVK
         lSLmVGzCvqugG5Wb0jm0shrSdKodGpjJ+Lqmd5h0XBnYs1XLcxXdW/zy9UeqFupfshT2
         +ZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784657788; x=1785262588;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tK6CpaworNApxpcs4ZRJbHY7w08bgOkmP8ipHWd1tq8=;
        b=Kj3zHLZPgwspkJGt9cOLzt8rVb3uLYckueY7NBNyfaF4EcuSwLJaz8xN+ugOl6xop3
         cBILuaEHDfKtPQ0wMEry2S6J+k75wCfGTxB8a7LIEy9YFZsZH3anHlXV/3kaa49Cs36i
         OillifRapwuQyq/D70Q69ues5WaVa0cGPxzMZMtnQI9P8NXmPw5FJlcqalak7/UR9eaW
         Xm3iLxrk5nJ1m6U9u1+lA8ANWr7wpUgx4ZEEDeMBKf4VQ54VtXSfrwoXuYgcfzEJdeeP
         Q88iNmUS42xEKrRmc9JBsZKAb8WOXeksHFC4bByqLsRXj9WPHpYiy/lSkNI29/GPpjuh
         nrRw==
X-Forwarded-Encrypted: i=1; AHgh+RpjehfS6F/gO5Px0bpSN9KTAy9Dy7SBHMtxkdlaK2U2Jww+t4MGmIzx0luL35t2jPhOJS8T9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEFPhjw4R2jDJW2WE85YB2KcwCjMQd6vjOqegToXJY+urBK7UE
	uw2jqFAQXjLZxUV71/q26U5mQuPLtgVX/acEdzn/E4lTUfLmd+iDksRndOPM4FEV++Q=
X-Gm-Gg: AfdE7cn/AlKgwxoT4pCngdsGTHAgACTGAvIxktbSs1sEqUOo0YB/YUmLizqq1Z0OjOs
	OTjlmrq0DSfWcoxPSldSP1odUXQw5RIfTrft1Rc4ym5pft9Vjie1TYadKw982PB1Gs+kbgK0mt/
	YevcrSUVtrDbx5AUsOQzUnVweJUCMlokx3JuN3JVpApjG2YwqjEZZtgzm19eRbdkGsskUg8+Bfm
	UJ6nmSbiqKFIpXWpl2gNi5fIF1Ut7wdQJL9NTpN6JUYYW3vyPvse7VDavOJJq/NVLsm5HV/9B5X
	icBxBOs9ZA7s+BWLwGW19JyYGguXmjPlCYjoTkPY73jA1ukYlLBo4reqWVNpPt7fmryhed2D8gf
	fTg3btTmwuBGcYdAtsEca7cgl1glndfvmDX7JD4ZgSq5WL0AO7vFwomT9r+fxNWxj5MC2Xoo2N/
	NCjay0KTdzAgp83tNnvqpkytBqaOzymOsDwtZkPT7jTpz/yeZysJJ3GC6PJOWbEk5d+RA/
X-Received: by 2002:ac8:5845:0:b0:51c:7b12:600a with SMTP id d75a77b69052e-5213e881e44mr171868611cf.86.1784657787636;
        Tue, 21 Jul 2026 11:16:27 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d066fa6asm463921cf.6.2026.07.21.11.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 11:16:27 -0700 (PDT)
Date: Tue, 21 Jul 2026 14:16:21 -0400
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
Cc: linux-mm@kvack.org, Zhigang.Luo@amd.com, arun.george@samsung.com, 
	brendan.jackman@linux.dev, yuzenghui@huawei.com, apopple@nvidia.com, alucerop@amd.com, 
	matthew.brost@intel.com, akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, djbw@kernel.org, 
	vishal.l.verma@intel.com, dave.jiang@intel.com, alison.schofield@intel.com, 
	osandov@osandov.com, jannh@google.com, pfalcato@suse.de, jackmanb@google.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, pbonzini@redhat.com, osalvador@suse.de, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com, 
	linux@rasmusvillemoes.dk, longman@redhat.com, ridong.chen@linux.dev, tj@kernel.org, 
	mkoutny@suse.com, sj@kernel.org, jgg@ziepe.ca, jhubbard@nvidia.com, 
	peterx@redhat.com, baolin.wang@linux.alibaba.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, lance.yang@linux.dev, usama.arif@linux.dev, 
	xu.xin16@zte.com.cn, chengming.zhou@linux.dev, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	driver-core@lists.linux.dev, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, 
	cgroups@vger.kernel.org, damon@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v5 00/36] Private Memory NUMA Nodes
Message-ID: <al-2D_7NcwMxqmsM@gourry-fedora-PF4VCD3F>
References: <20260720193431.3841992-1-gourry@gourry.net>
 <6a7aaac3-e70d-4063-9c84-e643db1488e0@nvidia.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a7aaac3-e70d-4063-9c84-e643db1488e0@nvidia.com>

On Tue, Jul 21, 2026 at 01:46:01PM +1000, Balbir Singh wrote:
> On 7/21/26 5:33 AM, Gregory Price wrote:
> > 
> > Patch Layout
> > ============
> > The series is broken into two sections:
> > 
> > 1) N_MEMORY_PRIVATE Introduction.
> >    Introduce the node state.
> >    Opt those nodes out of mm/ services.
> > 
> > 2) NODE_PRIVATE_CAP_* features
> >    A set of mm/ service opt-in flags that augment private
> >    nodes to make them more useful (i.e. reclaim = overcommit).
> > 
> >    NODE_PRIVATE_CAP_LTPIN for private node folio pinning
> >    NODE_PRIVATE_CAP_NUMA_BALANCING for private-node NUMA balancing
> >    NODE_PRIVATE_CAP_DEMOTION for private-node tiering demotion
> >    NODE_PRIVATE_CAP_HOTUNPLUG for opted-in private nodes
> >    NODE_PRIVATE_CAP_USER_NUMA for userland numa controls
> >    NODE_PRIVATE_CAP_RECLAIM for opted-in private node reclaim
> > 
> 
> Looks reasonable, I wonder why USER_NUMA/HOTUNPUG is an opt-in?
> 

Ideologically: Private nodes default to fully isolated, why should any
given feature be special?

Concretely: 

User-numa

   Some devices don't want the user to have control over placement.
   I have been working on compressed memory, for example, which only
   ever wants to be used as a reclaim-demotion target.
   
   (The reasoning for this is another thread, i plan on publishing
    my research on this this year)

Hot-unplug:

   Some devices can't necessarily handle unexpected migration, and
   hot-unplug is fundamentally a migration.  So the HOTUNPLUG cap
   actually means "hot-unplug can execute migrations".

   If the entire device has pre-drained the memory (all memory is free)
   then unplug works - it's just not very hot (no migrations) :]

   Maybe a naming issue?

~Gregory

