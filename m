Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F547343897
	for <damon@lists.linux.dev>; Wed, 22 Jul 2026 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728139; cv=none; b=DKBM+JkdH6Lgdy2lKJkKnskVxGFEu96ScfCf4Umcec3+6nWSx7MlceNK4qb1PmEj2P6Cp9YB6IOx5kyrO2Sm075Xf3go05OfR7Js80uCN/CeHH2QNYotlOi2nZqRd80d4+KV0GLKTIctk+gqbMHNEKk9mYU3CeMbUzNPzvTeLfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728139; c=relaxed/simple;
	bh=JAIqzpQM3gUx7M+gDSziic1KcB43W58VAXiVvJF0/Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqVhgSwIExyLCiTjCF32KcYb52Abm6+pjuur7KvXjnSH/LdLPbh0SJTKQpqCGsXll0zKy2JHaWglK5NGBpVIIz4ohY+0iujwvi0P7JIRAOj/Ky/HjzLvayg9uPVZqwNDP0+TRta3i4rtYI0Ltrb+tcchltwVlVmP/KPb9O8Mx3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=YfOYZuNd; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="YfOYZuNd"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c16ac21acso57459381cf.0
        for <damon@lists.linux.dev>; Wed, 22 Jul 2026 06:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784728136; x=1785332936; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LI4otu0+1hHJyrtu/tBxz3iTtloCysub9k9iNgYv1gk=;
        b=YfOYZuNdcixU6KFi6hihf6NZPUYPamckxNjiSQuh3Y5LDGZmjoDNVLTDxgzMG1Yo+X
         XzZ6tvLBXsx1dQPXkSj6j/cEzn4wHJ+rOPsLcQQ+iRwfKgoIxp2JPMOX1vM89mig9szH
         NRPwcRxuOWjCP9NiB++kCyhZ3SM1uyxeVRZFZMJS+YhORFYtVrysDDD0+gswCoVUTflH
         XF8QvL2Wq+yCPt8ZtMOFrmHqM4uqelSiOhwa0uMVjir3ZP+mF+j1fraO+Y/Pq6Ju+p8S
         k4TrIKc36YZgNOb7FgVzRHan5sQq754ntuXucbdZQ3c5j/r0zWt/rQUiHvWlaOqQspP8
         mU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728136; x=1785332936;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LI4otu0+1hHJyrtu/tBxz3iTtloCysub9k9iNgYv1gk=;
        b=cDpEwdde4iG8GDcbTkJPBm+X1mjfZtFSCFQitco+Dd7dRxYllyYFz3EO1f5Wmwx0T1
         NLnk3jc5t/D2j0yXJ4ScqrsS9vK4A3ZAA0YhwcmGc0WAV0LPlkloLDFQskmCpUVngZyk
         krgrqj1n2k7VbsaYqMOW01X3PFb/v6PMnexx6R2elOso1ybPe74/n2x5qSnokHU4Y8C8
         yNGzxA5CJ4md3uv5TE7fYknnyu5QxLRwct1JN5g6G18XjweeIppMCoJM0SL2Y+IGfIS3
         zJ+DPJoe6IOmptwbPLiZyBrI9qRlX2DtZOTUWWkEhUBwl4O1FmP7LlES5ZY78mtFsD3/
         jS7Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro6l902XGrGYbWjWakS18mRWJY9gyiI+3QrhS0p9VyVD06V6Ifkmuv7YkMKRQryMqsLdA1ssQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywiv3q9tnQoZteDLajDjy8oYssWNfiozyShBIe8EVHAsgvRTDxE
	/mWpw3Z6fmmRTVvbANXzXd4Vh5ETExXHan+dYT1PDuU1idgb0QMrFgRLPIu8zceGLak=
X-Gm-Gg: AR+sD133oG1BadGchlAnYE49KNjrp3VS93Y3KgbP2RGRV2mRMIr+4IzUVMycPU1fbzu
	yRXpQoIUSjW0IfTKaBe1S5IvtIMozpim64oOw0xYGsgpFKOhFeaa+/xaGJguy77pU2tB8RO9xsV
	ZObCDO3WGpxRXdh7yFp7UaT1ht7PoG94wdr8Px3aZObCuIwmuvDwos+goc1XfAn0xTZpVeI5vXA
	Y3ORpC5eXCS0CHdL8+RJtkiUdeVe3Zfmsy3IN1aMKaXK1e6ZxNH+pJHSnu0p8wxUsKqYHxF0ZCs
	W1srxwwqXKFTTtBfChGV/IPvh0eD2rNS/89ARnFYDJeg4AdikhfdwR8LrAr7QQilyKoF1/EQNd9
	YDf41k+obmp+8vXQlR4hhXgwQXNl/y22GcIF0NjhHi5oN2AuXGvW3nyKD5BIylUjlDifEAOGIL6
	X6WF4KXIdJTHKje73s0SV7QQed6woHhpqGTfgXWjdsUxp6mldoS6zXprvmlg==
X-Received: by 2002:a05:622a:350:b0:51c:555:7dea with SMTP id d75a77b69052e-5213cbd667cmr215415981cf.30.1784728136109;
        Wed, 22 Jul 2026 06:48:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8e2581sm21393266d6.19.2026.07.22.06.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:48:55 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:48:50 -0400
From: Gregory Price <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: linux-mm@kvack.org, Zhigang.Luo@amd.com, arun.george@samsung.com, 
	balbirs@nvidia.com, brendan.jackman@linux.dev, yuzenghui@huawei.com, 
	apopple@nvidia.com, alucerop@amd.com, matthew.brost@intel.com, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	corbet@lwn.net, skhan@linuxfoundation.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, dakr@kernel.org, djbw@kernel.org, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, osandov@osandov.com, 
	jannh@google.com, pfalcato@suse.de, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, pbonzini@redhat.com, osalvador@suse.de, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
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
Subject: Re: [PATCH v5 26/36] mm: add NODE_PRIVATE_CAP_RECLAIM for opted-in
 private node reclaim
Message-ID: <amDJEbu3aQO8J8f4@gourry-fedora-PF4VCD3F>
References: <20260720193431.3841992-1-gourry@gourry.net>
 <20260720193431.3841992-27-gourry@gourry.net>
 <amDGXU94trqlXUgR@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amDGXU94trqlXUgR@MWDK4CY14F>

On Wed, Jul 22, 2026 at 09:36:14PM +0800, Richard Cheng wrote:
> On Mon, Jul 20, 2026 at 03:34:20PM +0800, Gregory Price wrote:
> > +static struct zonelist *memcg_reclaim_zonelist(int nid, gfp_t gfp_mask)
> > +{
> > +	unsigned int aflags = ALLOC_DEFAULT;
> > +
> > +	if (unlikely(!nodes_empty(node_states[N_MEMORY_PRIVATE])))
> > +		aflags = ALLOC_ZONELIST_PRIVATE;
> > +
> > +	return select_zonelist(nid, gfp_mask, aflags);
> > +}
> 
> 
> I applied this code change and notice in mem_cgroup_shrink_node(), it calls
> shrink_lruvec() directly and never passes through shrink_node().
> 
> This patch makes private nodes reachable through memcg reclaim zonelist, but
> what prevents the direct per-node memcg path from reclaiming a private node
> that has not set NODE_PRIVATE_CAP_RECLAIM ?
> 

I legitimately missed this.

Sashiko also picked it up on the filter patch:
https://sashiko.dev/#/message/20260721183528.B4B9C1F00A3A%40smtp.kernel.org

If nothing else - implementing this feature has taught me some
sub-components of mm/ have very well centralized logic, and others (like
vmscan.c) have 3 or 4 different paths in with a lot of strange quirks
carved out.

I think some of the vmscan paths can be improved to simplify this
interaction, but i will fix this particular miss in v6 and come back
around to see whether we can clean up these different paths as a general
improvement.

~Gregory
