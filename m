Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40323EC4
	for <damon@lists.linux.dev>; Thu,  2 Mar 2023 03:26:56 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id n6so14823853plf.5
        for <damon@lists.linux.dev>; Wed, 01 Mar 2023 19:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2g8UviE1kEkFqq9eAKhynAgig45tdIeMwbCgGYlxa20=;
        b=I3aW2wiBG01Yzon1TKAIHv9x2nch3BVxByOC6NaL6FQgs3kL1V7QXsKoFMqCL9ia1x
         Gv9OwqnIubVb9HvyqfPYa3wU2LEbj0omk/TEOHySWA0jS0cir/0d5cYVY2HicG4UbzbQ
         hi0mo7RiHv/YToly6/xnN/OjKSl7IZz6etQVPj/bVMCCSy8Vco1gXwEZpxYFvjpvypwQ
         HTylwqi3hTSPlvX7fVcPr72xmurulp9PKyXD22Y5u8B0O+X90uqRUyhwvoKwqHfknQvG
         TzT6CFWd9ADVvDhew+6/V4HHYOHd7d2ZCvYpLCUxUFzCW/+GFj5+YPXDkfaY+V2LlLqS
         7X+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2g8UviE1kEkFqq9eAKhynAgig45tdIeMwbCgGYlxa20=;
        b=ZNUKDOM/jeLXXTsL6sNEayf4Z1nWgWE6pby5HHaB1TsN1mKiccWNgCIjcYLRsqwoBc
         +yuwtmEvlr5rx+DjY23NIwamwNyyYTtE+Vi+vA5q+dzSQKqrrwhu1V0hf7p4w86p3MTX
         aw0fWQTOJohQfjo85OfecngFmmozTzG3RtfTIao42Zcm+tUSfpptu1YEOotdHMKLPd8W
         Q8DrTtSxU2SHld27hkJDW15nQg0RT0UKo38WzNCnthUv1J2nV3yXl/NEVT/9PdkfqZKv
         V26S5ugDABBJRtrm0/s8nMqa2JrEyC/uBe/eD6cLAzYvsjogFZEeQEGNZ2Ee/dY1/b+j
         +XiQ==
X-Gm-Message-State: AO0yUKXU8YTdltP0+ArhuUmEVU4QW3kCwcwiGNHEMkMLJStI4x8R3mNU
	2LfDXt9lLREflIgKBHQtlo2Lo8f/kXl4+R7nTPI=
X-Google-Smtp-Source: AK7set+mFSclLWu5PamoIAn7F8ypQviYjDCGxIJe7RbJwAAUC/ngPIfBegjRkstrSzQWQPbExb+n6w==
X-Received: by 2002:a17:903:704:b0:19a:5a9d:3c with SMTP id kk4-20020a170903070400b0019a5a9d003cmr79895plb.16.1677727615410;
        Wed, 01 Mar 2023 19:26:55 -0800 (PST)
Received: from [2620:15c:29:203:5530:853:8d92:ba58] ([2620:15c:29:203:5530:853:8d92:ba58])
        by smtp.gmail.com with ESMTPSA id x26-20020aa784da000000b005a8f1187112sm8569832pfn.58.2023.03.01.19.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 19:26:54 -0800 (PST)
Date: Wed, 1 Mar 2023 19:26:53 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: David Hildenbrand <david@redhat.com>
cc: SeongJae Park <sj@kernel.org>, "T.J. Alumbaugh" <talumbau@google.com>, 
    lsf-pc@lists.linux-foundation.org, 
    "Sudarshan Rajagopalan (QUIC)" <quic_sudaraja@quicinc.com>, hch@lst.de, 
    kai.huang@intel.com, jon@nutanix.com, Yuanchu Xie <yuanchu@google.com>, 
    linux-mm <linux-mm@kvack.org>, damon@lists.linux.dev
Subject: Re: [LSF/MM/BPF TOPIC] VM Memory Overcommit
In-Reply-To: <5751ca20-9848-af42-bd1d-c7671b5796db@redhat.com>
Message-ID: <c57f3f06-5079-6e28-5238-c5731ee02a6e@google.com>
References: <20230228223859.114846-1-sj@kernel.org> <5751ca20-9848-af42-bd1d-c7671b5796db@redhat.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 28 Feb 2023, David Hildenbrand wrote:

> On 28.02.23 23:38, SeongJae Park wrote:
> > On Tue, 28 Feb 2023 10:20:57 +0100 David Hildenbrand <david@redhat.com>
> > wrote:
> > 
> > > On 23.02.23 00:59, T.J. Alumbaugh wrote:
> > > > Hi,
> > > > 
> > > > This topic proposal would be to present and discuss multiple MM
> > > > features to improve host memory overcommit while running VMs. There
> > > > are two general cases:
> > > > 
> > > > 1. The host and its guests operate independently,
> > > > 
> > > > 2. The host and its guests cooperate by techniques like ballooning.
> > > > 
> > > > In the first case, we would discuss some new techniques, e.g., fast
> > > > access bit harvesting in the KVM MMU, and some difficulties, e.g.,
> > > > double zswapping.
> > > > 
> > > > In the second case, we would like to discuss a novel working set size
> > > > (WSS) notifier framework and some improvements to the ballooning
> > > > policy. The WSS notifier, when available, can report WSS to its
> > > > listeners. VM Memory Overcommit is one of its use cases: the
> > > > virtio-balloon driver can register for WSS notifications and relay WSS
> > > > to the host. The host can leverage the WSS notifications and improve
> > > > the ballooning policy.
> > > > 
> > > > This topic would be of interest to a wide range of audience, e.g.,
> > > > phones, laptops and servers.
> > > > Co-presented with Yuanchu Xie.
> > > 
> > > In general, having the WSS available to the hypervisor might be
> > > beneficial. I recall, that there was an idea to leverage MGLRU and to
> > > communicate MGLRU statistics to the hypervisor, such that the hypervisor
> > > can make decisions using these statistics.
> > > 
> > > But note that I don't think that the future will be traditional memory
> > > balloon inflation/deflation. I think it might be useful in related
> > > context, though.
> > > 
> > > What we actually might want is a way to tell the OS ruining inside the
> > > VM to "please try not using more than XXX MiB of physical memory" but
> > > treat it as a soft limit. So in case we mess up, or there is a sudden
> > > peak in memory consumption due to a workload, we won't harm the guest
> > > OS/workload, and don't have to act immediately to avoid trouble. One can
> > > think of it like an evolution of memory ballooning: instead of creating
> > > artificial memory pressure by inflating the balloon that is fairly event
> > > driven and requires explicit memory deflation, we teach the OS to do it
> > > natively and pair it with free page reporting.
> > > 
> > > All free physical memory inside the VM can be reported using free page
> > > reporting to the hypervisor, and the OS will try sticking to the
> > > requested "logical" VM size, unless there is real demand for more memory.
> > 
> > I think use of DAMON_RECLAIM[1] inside VM together with free pages reporting
> > could be an option.  Some users tried that in a manual way and reported some
> > positive results.  I'm trying to find a good way to provide some control of
> > the
> > in-VM DAMON_RECLAIM utilization to hypervisor.
> > 
> 
> I think we might want to go one step further and not only reclaim
> (pro)actively, but also limit e.g., the growth of caches, such as the
> pagecache, to make them also aware of a soft-limit. Having that said, I still
> have to learn more about DAMON reclaim :)
> 

I'm curious, is this limitation possible to impose with memcg today or are 
specifically looking to provide a cap on page cache, dentries, inodes, 
etc, without specifically requiring memcg?
