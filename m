Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592D73803CE
	for <damon@lists.linux.dev>; Thu, 19 Mar 2026 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930603; cv=none; b=hO+bn5vawJCivZ8+a5vtaQaAz2PGuHjr5VvOrUyr8l+5pOQ1bg14SF+tZfRgWlV9wjfXCJ3+coCSW3CgAZH2WNj9INmv4MEuc9Bm1zB5UN6SQwzdmwrpvb6HgRiYlL5GPdbDP3Hn57kucJwAh/pV+YR5FQb29xPbz1c/LKe1tWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930603; c=relaxed/simple;
	bh=BArAqxuNOMZmZ3DFzVkEiSDUW/6K7+Jdphve/CIcCPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYCmg7rJcPO+C7HBjp78crU9OQG1hkekZLtHgN/uGppcWLEzmWuE5rVCRPttUNJ5qCfYqg+1aPTlbxD2W7raUfSqsbnPM1940PSi6SbGFQr9DzMNJn/kNs2LBMzapnPpBPGw1zV/9ZEcHAHhmAPFdNQHcjfkbtQ1pXsRzgxtNCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cQJOoNJU; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cQJOoNJU"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cfbbdbaf3cso88039185a.0
        for <damon@lists.linux.dev>; Thu, 19 Mar 2026 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1773930601; x=1774535401; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZ62zRGDMh84ev+ADivtxhXkIe87cWoaQL4WKudvzqg=;
        b=cQJOoNJUSVvfVL6IP6AsZ9q6WJ/fn2KkIx7gjYvkymiyHMKyGCDFLVD1l5ePkNZ554
         ZhbqoW7P+YV4BzCQnkcaqJ9bfd5kPmVGFRNuVH7SLVW1B6KOD/lIZIs/O+R0G3FrEQV1
         d/VYdlEE/DAvmSvy7fWTJnN2fBbGbFL8GZnh3VroSIOKcD85bG/QyOD9Or6CWpb3p5fN
         Vgj77U1SZ/1Uli1tmlmshDQNkoxQlEnfYFRTHgB8PL1U0ea3tTrmXWC1hTF3IQubUFYu
         q36SMhIEHGqcGYhSGP3FrnEuZ9wdmjFuItG9lrWLs5mUVxiYJKFsZpSopP3S37RF4cfP
         RulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773930601; x=1774535401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZ62zRGDMh84ev+ADivtxhXkIe87cWoaQL4WKudvzqg=;
        b=lkXT1r3913gqPIn42tiwzprCwgOAnFa3McQ6QS/oj+JP36RIvIT+LUhXI1hB1Do3PC
         H+Pv9kaRgrlaVhjQwey+ik2CHbZjmGKIloo6dhBHaSlmaahRHhsIGbbWFVXpoVarNVp1
         7KLl648PJDOHB4Q9ZXcaI13dKQKRtJT84Ah3yDp+FDHIziHxtfjzmlUlOhaUSVDXRK+d
         0VRr4woUP1//VMIa6q5y6tYxs3Xf11R2zIA2/SdG0HhbZL0ZH6li2Ms4197RDUCY60g+
         wEPjKz5pauga50J8vXYKdUG/eaxyq3bKD15OMlZmQZ0QUO0BMg7kSoVRgAOGh1pdK5mx
         SNjw==
X-Forwarded-Encrypted: i=1; AJvYcCXIL59JE1cRN5RZr+9TRMuRKUgdH0u4HHBebA9TTgFAtUQnk6m7gL91PmVGyWvwlouixxoubw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbkHfmkPy7UNbSuE1911wQHRziAmxAO9lf3zqxQlNetEekg+ih
	am5mDnuJlEaCZe1VIuTe2aRiUtLGFb6W6bzvJfiF0DZtb8i0KEBB/12gUHqufZFrE0I=
X-Gm-Gg: ATEYQzypyAANAAgK2wLPag4cXO1PeVHeq46mSfQXxJ/jUbvtr+ll5/z6onHPXx7W/4L
	TAfYTG8XZWVV8GfZhINemHqzP00XuzCvuCAGr5NmAaZH6IUvKK5+fmsu4IQ3h4uYGxal/Ml+zVA
	t1FsToF4lW+m25DFkcx4bSBb2W2sWr1KBQ+ZR/xLLNoaDiqmB13QLx0MQEAACPZCfA+i2JUujOy
	B6NjmnrYsQtgsA22pkSNJ3Bo+/zq36xeJqjjDaCgYHyOs3EiHnkm01xl4IUdKON4wD2XQwBee/4
	C0gVbDNtgrmeA4tKZ0kTGTeghu/NXRxF/SHYaXxlxRO5iFNkTXuiGNYwAW9mNs+AB8fBn4RlmOh
	kVxEb2kL3wSp9MnJGVlnRrtvTOV8t/Ne6mtKyxcM5PSG9afvXnzHFROdApT26J/BcgglvEtOMya
	/77wYk/u3ppWdGeT9sWVWN9fFznbag4UjtVr/Qa7pTDjunTzrVM4Zdi67Fg9g/1+rMWvriS9UOh
	jOXJbuFaQ==
X-Received: by 2002:a05:620a:1a21:b0:8cd:b024:114d with SMTP id af79cd13be357-8cfb9ea6bb2mr485207585a.40.1773930600903;
        Thu, 19 Mar 2026 07:30:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc25f0340sm87627185a.1.2026.03.19.07.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 07:30:00 -0700 (PDT)
Date: Thu, 19 Mar 2026 10:29:57 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
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
Message-ID: <abwIZd7FNPj5YYXQ@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <c10400db-2259-4465-a07e-19d0691101a4@kernel.org>
 <aZxqP7J1kOClQUPQ@gourry-fedora-PF4VCD3F>
 <aZx7hsVNU0XOCCiG@gourry-fedora-PF4VCD3F>
 <049d056b-844b-4480-b90e-bf4c850fc70e@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <049d056b-844b-4480-b90e-bf4c850fc70e@kernel.org>

On Tue, Mar 17, 2026 at 02:05:53PM +0100, David Hildenbrand (Arm) wrote:
> On 2/23/26 17:08, Gregory Price wrote:
> > On Mon, Feb 23, 2026 at 09:54:55AM -0500, Gregory Price wrote:
> >> On Mon, Feb 23, 2026 at 02:07:15PM +0100, David Hildenbrand (Arm) wrote:
> >>>
> >>> I'm concerned about adding more special-casing (similar to what we already
> >>> added for ZONE_DEVICE) all over the place.
> >>>
> >>> Like the whole folio_managed_() stuff in mprotect.c
> >>>
> >>> Having that said, sounds like a reasonable topic to discuss.
> >>>
> >>
> >> Another option would be to add the hook to vma_wants_writenotify()
> >> instead of the page table code - and mask MM_CP_TRY_CHANGE_WRITABLE.
> >>
> > 
> > scratch all this - existing hooks exist for exactly this purpose:
> > 
> > 	can_change_[pte|pmd]_writable()
> > 
> > Surprised I missed this.
> > 
> > I can clean this up to remove it from the page table walks.
> 
> Sorry for the late reply -- sounds like we can handle this cleaner.
> 
> But I am wondering: why is this even required?
> 
> Is it just for "Services that intercept write faults (e.g., for
> promotion tracking) need PTEs to stay read-only"
> 
> But that promotion tracking sounds like some orthogonal work to me. What
> am I missing that this is required in this patch set? (is it just for
> the special compressed RAM bits?)
> 

Yes, this was specific to the compressed ram bits - it allows for a
service to control where/when writes to the device can happen.  In this
case, I've limited writes to just the demotion step. (Although I have
since realized i need to not allow file-backed memory to be demoted).

There may be a better way to do this, but also it may very well be the
case that such a hook is just a bridge too far and isn't wanted. I think
this debate is warranted.

~Gregory
