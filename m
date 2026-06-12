Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F1F349CD0
	for <damon@lists.linux.dev>; Fri, 12 Jun 2026 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781278185; cv=none; b=fw2Nh8/bKgkfwcTeDh4sAeLnjlH8a1kfdLXoS35dkuej9tk52bKbt0CKY/FbUsYi6c6ZVulpJTSvLiHkM3XLXGuHaDded/0S976nfu1W3FUDsicrFcRkeyehxt86HQmgmOtZg6psqMbtTf7QTXpKIXzVSrkdxloMd5C9uFgyBDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781278185; c=relaxed/simple;
	bh=mVnLEdPsEZ4bwU/Ei3LWYtLLBe2x/ajf/pLUxSqCLVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IffscQIzDT6vXBQ+effGVsNDnRhtE3vdo3/2i/L5ewCPk5gUgklGb5DsSBvPB/8TPztY88/rlyzZnweTmz3kvoYcVDqVsinRF2KCYZbgs//itidI/AC9KEaGGPYI7Rn0v36Rz4p5mbqpEHEFY8XoX5Xoj3PvKQ1lOoOauOALC40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BKBL8mhE; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BKBL8mhE"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5176096116fso12000741cf.0
        for <damon@lists.linux.dev>; Fri, 12 Jun 2026 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781278183; x=1781882983; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dGTIoUK/OWYjJAAY1+ZmAOAhqsOqMD1OUbmAHjFef1Y=;
        b=BKBL8mhEgWsCgZVvI55RFr75/Rz/LpUnP5arOHWm2uTyaylbSAe6p6qD8B/jkR9d0B
         Or5aZuV3iT4LwMukXkjnbDzjRE3Og9pdUNGmjz7Eosm8R7DeYpoOSFW3vLrFQWbnrzNP
         1KvDsz0+Iv85AsEEkXVsXu3dhkrE9FnAxXMz0QfDzmxkioEht8HDUbjs6JP0fxy/DVof
         J+7tHzqVUo2jXEPp83zyPsXVZlaJ1iC1R640GmRvn8wusd8J0VcJvOzn3SgbGt6WjB2C
         VO2p5s3Plj+Ua/MmsmvQxYSzk6UWi2LdMggOPHdnExkhW2j+kqo9YmHqSXzmiBVIBlDj
         c2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781278183; x=1781882983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGTIoUK/OWYjJAAY1+ZmAOAhqsOqMD1OUbmAHjFef1Y=;
        b=MxxM/XQvCrfMN7F6FbcuaydGvo1O1AGAi64/Q0PwT/WTXsQk6MTx1guWraxrt6K7rK
         BJy805gU0ASjcnhK8pK6KQmYu+UTKUCz4m6ibwPZOmNrw3cypGe9c9KDqtuAo7/4ZR1o
         v/z/E6Zd2q4AFv1b0skTurzqHPOXhPciq688oToa+E07vdFp5FyG8VGnD9c/V2zLq4Dy
         4O+y3uypVZyAFok7SssO4fkSfay+FgsZBF3q5jAdRS+mXPhd+qNXxC5XJw7zhxMHwt8J
         L4e1Wdmdgp0M2XO5yiRGxywI05TqnBpuVXtzpxHNYa5N+4hLkRA0nkSBOmIuPJj2LkzT
         cFcg==
X-Forwarded-Encrypted: i=1; AFNElJ/Y3awflkZ5Qo4L4nv7CicsrOiiJN3N5cGZoiaBdJF9gO7NG0rxiTK8+zqbR0lSbaPzlBFivg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHtwai8ww1CFmoLNPB7CrPBg4vozZdwIwWxwGLnLk15jf8fh2y
	q1k5DEcnMMZiKDIh7L3uo8roLg719dusve72Eoj90YmLc3pguzu+ChqOK1rNvexjv3I=
X-Gm-Gg: Acq92OEe49l/Pcv7aLoZrIdlWKd8TPCqZbrU9ttsubcy/OMJEDWPdF56ZCGslf9OMd+
	a9mqh7Q779Z+NwGiulF4JkElVWNzjKHVaPfbF9VX7YlJHQArfCfgZnypREycAGCPFvr2fxRscqN
	i/AiSeL86U+PDAPL2W2O7hBb4xEK60OWr8AAsdnlE/9k4xpWflfUoKCU0TShIHLeAFEsJGWAEfg
	fzqbGLNixg5DiM6Rd88srR8YYdUMKUeBKemdD5srE5rmAbXd1wLVoLWydfMPmj3IBOLdDZG1doO
	tlHyiv164WTnSUlk4PamTngV938SQ8sjUKdEyFsJZjhIhcLoInISjb/wXNXzso+JSJEnfW6FIBF
	GWhzgw9zuajMqzSDC/QXW2Cc/8pHz01vCtklWC1J4jmd3Xa6XknZYrIfkJ5A8S0xGuqhACa8r9Q
	JVG7iLWHTtkGBnmZEenBtJoXViG+wirmbe1WX3lwo2EdRSgqAbHlvGRsjYTG+VYH/ybRcJP88w+
	mThCT0=
X-Received: by 2002:a05:622a:1445:b0:516:ce43:f4ee with SMTP id d75a77b69052e-51953395db3mr1534991cf.20.1781278182636;
        Fri, 12 Jun 2026 08:29:42 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7ec47asm23782211cf.24.2026.06.12.08.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 08:29:42 -0700 (PDT)
Date: Fri, 12 Jun 2026 11:29:38 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>, lsf-pc@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	kernel-team@meta.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, osalvador@suse.de,
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
	apopple@nvidia.com, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, jackmanb@google.com,
	sj@kernel.org, baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aiwl4kCG814dpX7L@gourry-fedora-PF4VCD3F>
References: <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
 <ah47NNhuiClgGCdn@parvat>
 <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
 <aik_ddHymus2DJ6D@gourry-fedora-PF4VCD3F>
 <c1b66e7a-bb95-4295-8193-55ceadaaa578@kernel.org>
 <aimSzvoJDrpeQsmM@gourry-fedora-PF4VCD3F>
 <d01fb1ed-2418-42ee-aea2-37f9a5c5729c@kernel.org>
 <ainFROZ3WrGioyuY@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ainFROZ3WrGioyuY@gourry-fedora-PF4VCD3F>

On Wed, Jun 10, 2026 at 04:12:52PM -0400, Gregory Price wrote:
> On Wed, Jun 10, 2026 at 08:59:59PM +0200, David Hildenbrand (Arm) wrote:
> > > 
> > > I understand this question in two ways:
> > > 
> > >   1) Can we disallow PAGE allocation and limit this to FOLIO allocation
> > 
> > Yes. Can we only allow folios to be allocated from private memory nodes. So let
> > me reply to that one below.
> > 
> ... snip ...
> > 
> > At LSF/MM we talked about how GFP flags are bad and how deriving stuff from the
> > context might be better. I think there was also talk about how the memalloc_*
> > interface might be a better way forward. Maybe we would start giving the
> > allocator more context ("we are allocating a folio").
> > 
> > The following is incomplete (esp. hugetlb stuff I assume), just as some idea:
> >
> 
> I will still probably send the next RFC version tomorrow or friday,
> as I want to get some eyes on the __GFP_PRIVATE-less pattern.
> 
> Also, I made a new `anondax` driver which enables userland testing
> of this functionality without any specialty hardware.
> 

(apologies for the length of this email: this will all be covered in
the coming cover letter, but I just wanted to share a bit of a preview)

===

Just another small update - I am planning to post the RFC today once i
get some mild cleanup done.  It will be based on the dax atomic hotplug

https://lore.kernel.org/linux-mm/20260605211911.2160954-1-gourry@gourry.net/

But a couple specific details regarding the memalloc pieces that i've
learned the past couple of days playing with it.

1) memalloc_folio is required to ensure non-folio allocations don't land
   on the private node, even if it happens within a memalloc_private
   context.  Since memalloc_folio may be useful in contexts outside of
   private nodes, I kept this as a separate flag.

   If we think there will *never* be additional users of memalloc_folio,
   then we could fold _folio into _private to save the flag for now and
   add it back when we actually need it.

2) memalloc_private is needed to unlock private nodes, but in the
   original NOFALLBACK-only design, you also needed __GFP_THISNODE.

   This is *highly* restrictive.  I found when playing with mbind that
   MPOL_BIND + __GFP_THISNODE generates a WARN (valid WARN, it normally
   implies a bug). 

   That leads me to #3

3) If a private node is opted into something like Demotion (the node is
   a demotion target) or mbind(), such that normal kernel operation can
   place memory there - it's *pseudo-private*, and should actually land
   in it's own FALLBACK list (reachable without __GFP_THISNODE, but not
   reachable as a normal fallback allocation target).

I'm still playing with this, but I think we can even omit the
__GFP_THISNODE requirement (my initial feeling that __GFP_THISNODE
didn't buy us anything in particular seems to have panned out).

At the end of the day, this makes the whole memalloc_private_save()
pattern a heck of a lot cleaner than trying fiddle with GFP.

I think you will all enjoy how clean the code ends up, and how easily
testable it is.

As a testbed I've implement an anondax (we can discuss naming) that
adds some sample NODE_PRIVATE_OPT_* flags so you can do the following.

I'm including this in the next RFC - but we can hack the entire thing
off (including the OPT flags) if we prefer to just get the base set in
without a new driver as a start.

echo 1 > dax0.0/reclaim   # kswapd and reclaim run normally on this node
echo 1 > dax0.0/demotion  # it is a demotion target
echo 1 > dax0.0/mbind     # mbind() can target this node for anon-vma's
echo 1 > dax0.0/madvise   # allow madvise() to operate on its folios
echo 1 > dax0.0/numa_balance  # allow numa balancing for this node
echo 1 > dax0.0/ltpin     # allow GUP longterm pin to operate normally
echo * > dax0.0/adistance # set the adistance for hotplug time
echo * > dax0.0/hotplug   # same as kmem/hotplug

This also means *existing hardware* can leverage private nodes if
they're capable of generating a dax device.

I've even gotten it such that you can put a private node above dram in
the adistance heirarchy - which means demotion flows downward from
device to CPU, but allocations don't default or fallback there.

This seems *immediately* useful for a variety of use cases.

~Gregory
