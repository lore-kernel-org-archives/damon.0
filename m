Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8910937EFEE
	for <damon@lists.linux.dev>; Mon, 20 Apr 2026 02:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776653787; cv=none; b=aSLRQdTdlsvrAUBKZycP1VDcUN6FK/ADpP8zqiOYHWAcNl3GtFRtSRCfANPSHdsy+KimOEDzfxe9u1/NSKO88gBJPc4jco47PndMz7aTOT3ZzGI0kChbkwbTRRPTf2yKfbgcEK//V7O07rWlPW9Q7Dd5M4tMbeCGuCU/KE0MOCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776653787; c=relaxed/simple;
	bh=Gy7C5LgAy0+dNJVh3a/spG3LUsjag46Tvhe61CPzqjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrZVNCpOw4JvkAjPQOBFD/QhH88CZo4BWg5lo7AtjbTsWRZsUixD6p0NncfOtL5LagRt6Y8IiDkbpuHC0tvb3/FZM+O+sohQz1Np5sqtDYPAqnORfhSUms6uVGmtqrSsRrDFhW5w+tKhAJtml59pQKLwJNZrdTN/vyMr49M+g30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Oa4G3Rm/; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Oa4G3Rm/"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cbb6d5f780so238487185a.1
        for <damon@lists.linux.dev>; Sun, 19 Apr 2026 19:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776653784; x=1777258584; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tugQt2aIOJgoqj0Ob37lQ1a1TrVKhZ7jSIgjv7qjxfc=;
        b=Oa4G3Rm/XIA4erZ4YPfaXpf1i7DAhv5+SoY6b9+D7sQMquUy+K4+2FtsZ044pUiHeQ
         cLrRGNSeuN/d5visTD0WoEORRfhhoeLIjYMwRPFkWUYnbsbOj5iEjbqdCzDIs1sXNVaw
         cItZGhFUjTUhgBxJcbXOeGQNuV8PzLV3QazQK4ud3Y0qpGVmepsXDrudXfc09IDdGhKz
         9kXSHBEWflz6lYkPd9D/MsVdljJYiqydBZi+Ybg5J5QvB+1E8mdiBfEfYt6puRnSCUOq
         D4poDtjO0FRpCKrAvXPdBKNrOCr65LCCtqk2i4TS3ZWWQIeUWYF8ws4WEDTTrnPXPr58
         KbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776653784; x=1777258584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tugQt2aIOJgoqj0Ob37lQ1a1TrVKhZ7jSIgjv7qjxfc=;
        b=OyFcJRmNEzm/XjBn++xCXE4SWe67Sd8hz1oFdG5h/5sNt2fdz2f+ZEteypqo40q27w
         thWJVVRbCX8cB5vFAtChSyNe6pB+56EHSZhP0TWcFgvzfxwzlKjqk+3t3aCZYZO+jKLd
         cinqb7HkJtwskm1tRjY4usl47ra7FaRdgTLlIhhn0UNdE4zIiSvmjRLIM6xcquZFGidL
         zhYMUzRnLILQK6YVq/08b5mPzVf2U285IzNTQ2LRtf5u78ATB465sNowp/4wwPAz1g+6
         KUHW5a/qHaycoczKdJl3PKCFURMzQCB2Ntk8L2T7K/03UqC0u27pQ4+VfTEQRCfKJ0+E
         /KSg==
X-Forwarded-Encrypted: i=1; AFNElJ9RDd/uwBXwMkUgNWxo8U5ZM5RB9r7P1uRhttmMmLu3v/WRdNq0yuqHExTrv8Orxt9cjuhHIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz594v24WtpeisyNIc3g2f5+z+GSiAw2AxJTuFtJUYk+4ZqlGh1
	HNX2DYnXAL1Bge037WNNcTw4Bsgo0UyzlpoKpoaCqsldnexCeqS2ciC9vnwTVRitfsc=
X-Gm-Gg: AeBDieuAdNc2Bra+wtIuGQemlABlTNqCVqhqdgD1ZiODGTAwtHNQXfHC2d10Y4O7aec
	+XyTVNh181qDBfXVS/wQ0rF2UmaxRsQNuCwZgXRUJueY0Uge90pllSuiGQlnco9h8HfewVetH5L
	muTYZns4Y4+cnt/FDOSj6/KaYiYYS4zlXvQoWZESIjYv68m0HDAme1Q0hZy6frYi683+wFQ8ofi
	S2/JQKN2xDG2UPq8Sw9I9ZPz1GZ5sBurP8wt9KeK5fflN8A4bwLq7Ii/MEZZdl7ar2JdJum7GXa
	2yaQ1c3kLyf00igTTbBD9JbhBkC3/LxNEldDwuybkJEZOMmUsUQViT86pO62pArWKaCinjn1/th
	+IKWNzfXGaQzM9y5rr/bDkrNWik1ke1GOgBzT7OMEyTJK5XtRY8e3sHUSfVwXDITPcvBFvigesr
	eU1oZo6u+G7EZV57AWxRycZt8kMvzrCJ8tqL/2ydB28DpP8e0B7tFztNOt+rHEpg3LKRECjjtjs
	W5/HvSMUSk2NFTmvvb0Qh8=
X-Received: by 2002:a05:620a:a2c3:10b0:8e8:bedd:14b2 with SMTP id af79cd13be357-8e8bedd1701mr799144185a.43.1776653784400;
        Sun, 19 Apr 2026 19:56:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-108-28-184-223.washdc.fios.verizon.net. [108.28.184.223])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe9638sm706089185a.1.2026.04.19.19.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 19:56:23 -0700 (PDT)
Date: Sun, 19 Apr 2026 22:56:20 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
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
Message-ID: <aeWV1CvP9ImZ3eEG@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <3342acb5-8d34-4270-98a2-866b1ff80faf@kernel.org>
 <abwRu1FNqI3dVyqL@gourry-fedora-PF4VCD3F>
 <2608a03b-72bb-4033-8e6f-a439502b5573@kernel.org>
 <ad0iT4UWka3gMUpu@gourry-fedora-PF4VCD3F>
 <38cf52d1-32a8-462f-ac6a-8fad9d14c4f0@kernel.org>
 <ad-r7hwIdnvKsrh9@gourry-fedora-PF4VCD3F>
 <46837cea-5d90-49d8-be67-7306e0e89aa3@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46837cea-5d90-49d8-be67-7306e0e89aa3@kernel.org>

On Fri, Apr 17, 2026 at 11:37:36AM +0200, David Hildenbrand (Arm) wrote:
> On 4/15/26 17:17, Gregory Price wrote:
> 
> >> Needs a second thought regarding fallback logic I raised above.
> >>
> >> What I think would have to be audited is the usage of __GFP_THISNODE by
> >> kernel allocations, where we would not actually want to allocate from
> >> this private node.
> >>
> > 
> > This is fair, and I a re-visit is absolutely warranted.
> > 
> > Re-examining the quick audit from my last response suggests - I should
> > never have seen leakage in those cases, but the fallbacks are needed.
> > 
> > So yes, this all requires a second look (and a third, and a ninth).
> > 
> > I'm not married to __GFP_PRIVATE, but it has been reliable for me.
> 
> Yes, we should carefully describe which semantics we want to achieve, to
> then figure out how we could achieve them.
> 

Ah, I finally dug up my notes on this.

If we overload __GFP_THISNODE - then we have to audit all gfp_mask's
with THISNODE against the use of any of the following *forever*:

#define node_online_map         node_states[N_ONLINE]
#define node_possible_map       node_states[N_POSSIBLE]
#define for_each_node(node)        for_each_node_state(node, N_POSSIBLE)
#define for_each_online_node(node) for_each_node_state(node, N_ONLINE)

  or

cgroup.cpuset.mems_allowed / mems_effective


Anyone that attempts to do:

    for_each_online_node(node):
        buf = alloc_pages_node(node, __GFP_THISNODE, NULL)

*will* get incidental access to private node memory, and it won't be
obvious to existing tooling that this should be considered a bug.


rate of occurance in the current code:
-----------------
node_online_map       -  21 instances
node_possible_map     -  25 instances
for_each_node         -  346 instances
for_each_online_node  -  67 instances
GFP_THISNODE          -  58 instances
(notes don't have mems_allowed/mems_effective instances)


But it's not always going to be obvious - since nodemasks and gfp_masks
get passed around as variables all throughout the kernel.

I ultimately determined that auditing this in-tree is already a fools
errand - and suggesting we try to validate this never occurs for all
future code moving forward is just not realistic in any sense.

I could not come up with a way to remove private nodes from
node_online/possible_map - and private nodes must be added to
cpuset.mems_allowed to allow cpuset control (otherwise all userland
access is blanket denied).

So I moved back to __GFP_PRIVATE.

=== TL;DR:

The core premise of private nodes is isolation first.

So we want this code:

   for node in cpuset.mems_allowed / online_map
       buf = alloc_pages_node(node, __GFP_THISNODE, NULL)

To explicitly fail - so that the caller knows they can't use these
masks this way anymore (it was already potentially a bug, but could
have been masked if all online nodes had memory).

~Gregory
