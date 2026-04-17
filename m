Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755753A7F49
	for <damon@lists.linux.dev>; Fri, 17 Apr 2026 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776438479; cv=none; b=jOkmGydt96uu3wr99DjvPVSu6Gi3zpu8vbezRUc/gwu3H1jg9C9WsqKRPZmfZfHInw/jWHA1S993dfjuNCyViCLgo+Hm3Kvs1HlYlgI+9QdeF8a1FDSERIVWfkgWq9rt3XTnJjeu+9YEr8DgYhyesS//k7M8OlzEWJ+qfE0eJl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776438479; c=relaxed/simple;
	bh=4pOvxWvA/yj5xSsYSUbpCo6Kkeq+uF64q1hqZjlP4T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9lIOu9e/zTGFvkKY95ixFv/68d6qiW4Ju0XvZBgmQQrQD1je7JXkH/cMqm1dYTeRbK8LTMOoC/9kHGqdsyVGksml1EacYh8LZAc0PS8GIutelbS4o3/Y5cWxjEBaNehah/fQtc6QBFkWKTac1od2YKAWMk2qEl1ed+7vDTywjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cxz/SNVP; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cxz/SNVP"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-605def5b807so258039137.3
        for <damon@lists.linux.dev>; Fri, 17 Apr 2026 08:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776438477; x=1777043277; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8hmn8cP8J8LvjQAqTAHhf9pkwu4llVl8k7YZT9Lr2w=;
        b=cxz/SNVP8Reeb8dF4rjL7dpBgRh2p56x91M2swxbhdV70Wc2qkw6my7A81vpgaEX6i
         DsoTKktg2DOt/a1b4PkaJ8pOIgGfySTFQ/ujE2cKLZczHpny3kVn1K3iaKWPqGkjN7NA
         g5nm44RyC04LLRXBPY5D4a1W17SgkwuRqGB2QaQ2zfdf9p9w/NGQauo6UBhcWxz/B4A/
         jRVneAF0Ljrz2du/cokiI2ik3fa/qfuM3BlClwi3IN7s1EbKIC5Ez/AwPG0s0g7oFHck
         k1zecRKwkovSXdvEZFDAylbu9vN+/xqy7teT/KzVrl6TEyFDFaRAS7rAKk18hUWu4iZs
         QM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776438477; x=1777043277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8hmn8cP8J8LvjQAqTAHhf9pkwu4llVl8k7YZT9Lr2w=;
        b=QxzMVAMEUDMhiuvPB6tD2Orv5JdvmZjHOfe+Ona+0phi1P1weRuKNGh0tNmGzkhTMm
         Sd3uxfEAG0S5+0yfMFvGdQKgieZozcMMR8jEBKT/aw7Q1f1V2V3sltYGbtNG2WU/jG4b
         rk85eyygWmzBCRIjeZ+8/P34MYfcSOQ9ZH3m51+ZxgJOSQNSIgXK31Kq1P7QaX99pob/
         lSYIZN2hkbkw4lc4E+zWMg+K799MnnlrmQjhD6gbFJECYcl1cUwpo0mMrM0NxfteO2wE
         LUYJ4HHwQTKwDzF2IeGWugdGw/asqjXTnHe5eehXMAl0vZbdNMymCo5Bhu3nXYm67A2v
         xb0A==
X-Forwarded-Encrypted: i=1; AFNElJ+Muxxcq4YNesc5QIN2rQxTE3Z2i6mOMvIeIKM7b3LVGrGqCrrswziarv0pH8jcVO2K58r9NQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQ+WPRgKU9256JRoNbJHf6M9tl+vtBp3rURMALy8638HP7rMiT
	mLBUIyFtGwcA5/qZmv8VU4sRwPyv42Frll2uuXYaHn+1MasGGcTROU4lHqVwHqDTsH8=
X-Gm-Gg: AeBDieshI5G0knpYOkmq+mESuTalXBrmO7YQkaUNHDMPiDExqZG9QxHcMAivSVJmToQ
	cx39PzjreLzItJXIBAPCqi5HBJ0XVmxRfynEUutUUZRaMUQcFEZZEfE5MH0Eu9t7QgKNghXWXSX
	4xw9N6TbsESWBN4u7a4tBTCh/PCJiWx9FQ9Lj2FkJZL5eP1t7epXhyqFRknFD6SgQLSM+zEbpAY
	lxmHEpR20YgDcPYER3SyIAdKR0PQPF4fxgKZI3cyRyFDttIKpmezd7fcJQVm4tzU5JME7aCePWH
	a4XpRDFwyBny7fInGgd60Bh52ne+Yu5NAvDH3go/Z6WIhnKPPGQwBhPICVjjGUWOPRX0lD6oENq
	KaLbUl+tjSKDx7DVxJuwqLwwDcpdl7GlmvNeS7r6FS/cIJ0gd5V3Gaveqb2ux2pL9MHfM6yUjIY
	NjzaRcFMZ6Lpb75s1pfScSOGqSfz5srdfpbPohPxEdkCxjFmJUclgCEhBEGKOADeGYzWY8CQRf3
	ccSEZ209K8UL/p3RJNH
X-Received: by 2002:a05:6102:162a:b0:613:6b44:3fa9 with SMTP id ada2fe7eead31-616f71ff8c8mr1462957137.20.1776438477197;
        Fri, 17 Apr 2026 08:07:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-108-18-109-80.washdc.ftas.verizon.net. [108.18.109.80])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac6c3e7sm13032726d6.13.2026.04.17.08.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 08:07:56 -0700 (PDT)
Date: Fri, 17 Apr 2026 11:07:53 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Frank van der Linden <fvdl@google.com>,
	lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
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
Message-ID: <aeJMyYMQWLyiGTRb@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <3342acb5-8d34-4270-98a2-866b1ff80faf@kernel.org>
 <abwRu1FNqI3dVyqL@gourry-fedora-PF4VCD3F>
 <2608a03b-72bb-4033-8e6f-a439502b5573@kernel.org>
 <ad0iT4UWka3gMUpu@gourry-fedora-PF4VCD3F>
 <38cf52d1-32a8-462f-ac6a-8fad9d14c4f0@kernel.org>
 <ad-r7hwIdnvKsrh9@gourry-fedora-PF4VCD3F>
 <CAPTztWajm_JLpp9BjRcX=h72r25ELrXeGkOXVachybBxLJGS=g@mail.gmail.com>
 <aeA6aNDpQ-U5UJCs@gourry-fedora-PF4VCD3F>
 <6d4f702c-5ad6-4f84-a73e-c9e34965be98@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d4f702c-5ad6-4f84-a73e-c9e34965be98@kernel.org>

On Fri, Apr 17, 2026 at 11:50:58AM +0200, David Hildenbrand (Arm) wrote:
> On 4/16/26 03:24, Gregory Price wrote:
> > On Wed, Apr 15, 2026 at 12:47:50PM -0700, Frank van der Linden wrote:
> >>
> > 1GB ZONE_MOVABLE HugeTLBFS Pages is an example weird carve-out, because
> > the memory is in ZONE_MOVABLE to help make 1GB allocations more
> > reliable, but 1GB movable pages were removed from the kernel because
> > they're not easily migrated (and therefore may block hot-unplug).
> > 
> > (Thankfully they're back now, so VMs can live on this memory :P)
> 
> Heh, but longterm-pinning would fail on them (making vfio with VMs
> angry). Similar to CMA hugetlb.
> 

Yeah, depends how you configure things.  As long as you expose those
pages on a separate memfd and online it in ZONE_MOVABLE in the guest
to avoid vfio from touching it - you can have your cake and eat it too.

It's a bit of bodge but it works.

However...

> In the latter case, we should have a way to identify "this allocation is
> actually from the CMA owner, so longterm pinning is perfectly fine".
> Checking the CMA alloc state would be one approach, but that's rather
> nasty. I guess there would be ways to make that work.
> 
> I'd assume that people barely rely on 1GB ZONE_MOVABLE HugeTLBFS Pages
> (iow, mixing kernel-cmdline ZONE_MOVABLE creation with kernel-cmdline
> hugetlb reservation).
> 
> I'll note that there was long long ago a proposal of converting
> ZONE_MOVABLE to "sticky-movable" page blocks. It wouldn't really solve
> this problem, though, where the early boot code just does something
> that's rather stupid.
> 

I have been toying with hotpluggable CMA regions.

Interesting opportunity:

  Hotplug on a private node w/ (RECLAIM | DEMOTION | CMA | HUGETLBFS)

Now you have exactly two enabled consumers:
   1) HugeTLBFS
   2) vmscan.c demotion logic

In this regard, HugeTLBFS is the only one that can reach these pages in
a way that could result in the pages being pinned.

All other pages on the node are - by definition - movable, because they
can only reach the node via migration (demotion).

The system can't do fallback allocations to the node, so it operates a
bit slower as a general purpose memory pool - but if you decide you want
to optimize for that you can unplug/hotplug the memory back to a normal
node in ZONE_MOVABLE - without rebooting.

~Gregory
