Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB27F3090D9
	for <damon@lists.linux.dev>; Wed, 15 Apr 2026 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776282485; cv=pass; b=P1R6oWNOhfjFZ5ItV/uzCyka8eTfhKhzAmxS+cRMc2DexsJCy10O8c/8YUnsiSDTAl0nRGa8xjuAPJZlvyrHL3RiWXjcmsVwWjtYJiQfcgA5g59q2uzCzk1rT5ckugLPL+p/z8tfxDqYrrHnB5qFz6qhieKktFn2fULfo8N9cFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776282485; c=relaxed/simple;
	bh=bTKITcODyC33aRzhtGD6NO5LshHbAyzyPqYrtdm77LE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6IFJnnsQ/AUs4TUpbP92IhnusCVxLTEu2GhM9q+ZHcfGzavAdFuyKHwq9TLqijAYN7ugz4GzrXAaCiMKbj0NuWxkqeTT9WXkcZ8Rq/Oui2xMiFiAzK9lEP5lZGyB/DtUHdonMDOAa72bWV1Ksj4pseTQzQSFzm6KgoWGwAtkMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RMHz6Axo; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RMHz6Axo"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488879dcbc3so50385e9.0
        for <damon@lists.linux.dev>; Wed, 15 Apr 2026 12:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776282482; cv=none;
        d=google.com; s=arc-20240605;
        b=jSd179iZUOUhQZuoY2dUfIpUZCH4Fg7p4VyPSF/qXx2Drkqj26DBPMdtZdqksSPXTS
         IA9BqiOjZmSZCfyU4gwF/drpIpnHl4PpjhSVlz2wHw2dZ9RmzkFSnXslmXDrJagBm9Za
         zaz3S6YXmMw/5rvyAPk32hpU5M+J7hbihkeIu4KT9yzP/w+vAOO7OVDroQauOwQoRH56
         cvnnhYw80XdH6j1iQPz640KCMSr5crM5UGJASbLn3xIM4auyFPYdiUCsFLWLxBp5Gqqx
         pvywyoGgrSshdMffl0ZqPYmPOkWTlLFqC+oiVF9Rpqg0w3J8ltB8yLFZpn6Q+KpuFxGi
         iaIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+7EyRQT4jMuTzXDYdte1riRfSEGUZuTfSDGM7Pop5YI=;
        fh=8pjtotvUiwbAwASAmcGqavZqFdMQJ5CfgK4L6WwKqzM=;
        b=jvsq9Q0HsiifD8cZoflN5TJrxMbIzK0phSuFpXWOwfEVkVJ0fIky6V9iMahv6oFDdh
         aXshx3Ejkayiq6C+WAuGVgRqb/ifNMIFtjgBZUszWelz4XBjlTp8VOLiMiTZIfCnFTSJ
         alQLDDmYbYknEm5wCI8oHxPUs9SkIVnzs1BoaE8+Rr8SCE366HauxEfSMfkOXxM0ihQz
         aBhXY6Jgp6/mbw9jfZZNWllcMAKWj7CNUV0056oB2FbxQyqq0XqWFefofgUlOvAOjp97
         2yfP3ZnraHUpn7JMr9WCTMgKt/3iOGGsAm2UbgElIZQCypOh1l5kVaMffIgVcIV/ybz8
         alFQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776282482; x=1776887282; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7EyRQT4jMuTzXDYdte1riRfSEGUZuTfSDGM7Pop5YI=;
        b=RMHz6AxoeTapDLg/meYJ0ug1Lb4UqdlRNhUnb+zyUZYP7oYGkubfgaP17HGAikvqYs
         I4mwXbk2DrI9tQPG8cOvVLYhMEeG/6ssAc+s8VBnmryF4HOkoan/SDJJzXgbk7d2Q0uF
         lZL6D1/vlp+Pe3mtq6LfgnlOVJS5h2RFay11JjjsujSFkxcc4kjnam1D19MC9ke1F2rl
         CM6bulCZpq485q47zlI44Q0Qu9GSkFAkME4NB1ZvLFfsWrhHA6wEU6uI9BMJk5LnVep5
         jmSv40ZW+YBL7JS5384ugNDrC4qn5FR8lA5bR0iBk73L25+vF4xPBxPKbLWRimulW7ZK
         ekFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776282482; x=1776887282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+7EyRQT4jMuTzXDYdte1riRfSEGUZuTfSDGM7Pop5YI=;
        b=nDf3MpdV1zPCOOsNIko+GuvSBcXdPbRwVt5wsEUDevpOjqZZs40kM0HAX/0zOJqWgx
         G+yysOFPawXnAdkNEyIYweLat3zi3EnSlcRYu2Gi+uQZj0sJAi7Wg2Z5exmC6vSI44WP
         YYecVO1GKpKmpqlnsl2I21bDoInNpWlN8wSEEUbFeTiSsKN8jN4c36uhw0aMYJqv7ZYH
         qAgRAoUzKn8OMcaki31Js+DqASndF0mJWZuIxrBAA6CzUUn5o/t2RP9Ah+qWOo6Hn30I
         iSFxM0GETrKdTEXOGj4+y8LMF6pFcln81ocmvbMxR4kNE4vuDVp5/HudGcy74uqj68Sr
         kFdg==
X-Forwarded-Encrypted: i=1; AFNElJ8MUE5mrZuKi5zFHEGJHzaZXBerw44rkP64Nmpv2ZCvNoAGAsdHKV78nocGYdTnXg9HHOkRxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YykOqfXUUp6C6whZT4ccAycguX1LqImkYfFUT73bhIrr7U4O/86
	x3yT20fGJTz5GCX8Clushg/P0cUmnfMnTOK+Bi2BGeJ5njiPs/Xgn1XLyIQ2X9dmM5nR0UCC/53
	7TWd9UO99j4f9Lnmrf3appEoYny/BTNPih0DXa5Cq
X-Gm-Gg: AeBDievwA+YfA2nzKR82BnDWwweKELjNK5wsNeeWhg+sXJlDEzZmawpiy71nh9jHjzC
	QEemM2QRRzwrKEo6DqZflATR3spzx3emnS0oak2WYwMTJBDD7pIiuY4cENwb2m7n20B9x2SZZ+i
	18F6EjRtsS9Mw3fyUAg12G9KszFNbdqREiZiVSo2m1XZzltMnJ6kuARk8LugU/+8dbf3m6Jw/EE
	59JUtfauUCaN4JbaPIaNCDzPFvGGXA9FsZ2evtpgt81RwKBnt5l5Q8SKcLek4WqoInJL8L8hHXH
	xupRB6pr6xrT/fBcYDFDPqaLxaLI
X-Received: by 2002:a05:600c:529a:b0:485:1a54:9407 with SMTP id
 5b1f17b1804b1-488f49f7b15mr240485e9.0.1776282481776; Wed, 15 Apr 2026
 12:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260222084842.1824063-1-gourry@gourry.net> <3342acb5-8d34-4270-98a2-866b1ff80faf@kernel.org>
 <abwRu1FNqI3dVyqL@gourry-fedora-PF4VCD3F> <2608a03b-72bb-4033-8e6f-a439502b5573@kernel.org>
 <ad0iT4UWka3gMUpu@gourry-fedora-PF4VCD3F> <38cf52d1-32a8-462f-ac6a-8fad9d14c4f0@kernel.org>
 <ad-r7hwIdnvKsrh9@gourry-fedora-PF4VCD3F>
In-Reply-To: <ad-r7hwIdnvKsrh9@gourry-fedora-PF4VCD3F>
From: Frank van der Linden <fvdl@google.com>
Date: Wed, 15 Apr 2026 12:47:50 -0700
X-Gm-Features: AQROBzCIVwgyF1A8foGoMoeg1wgH05cQMGevG1TSqfVdQKYctSN8Xrxoo27rHlc
Message-ID: <CAPTztWajm_JLpp9BjRcX=h72r25ELrXeGkOXVachybBxLJGS=g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
To: Gregory Price <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev, 
	kernel-team@meta.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com, 
	ira.weiny@intel.com, dan.j.williams@intel.com, longman@redhat.com, 
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com, 
	linux@rasmusvillemoes.dk, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, jackmanb@google.com, 
	sj@kernel.org, baolin.wang@linux.alibaba.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com, 
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com, 
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com, cl@gentwo.org, 
	roman.gushchin@linux.dev, chrisl@kernel.org, kasong@tencent.com, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, 
	zhengqi.arch@bytedance.com, terry.bowman@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 8:18=E2=80=AFAM Gregory Price <gourry@gourry.net> w=
rote:
>
> On Wed, Apr 15, 2026 at 11:49:59AM +0200, David Hildenbrand (Arm) wrote:
> > On 4/13/26 19:05, Gregory Price wrote:
>
> As a preface - the current RFC was informed by ZONE_DEVICE patterns.
>
> I think that was useful as a way to find existing friction points - but
> ultimately wrong for this new interface.
>
> I don't thinks an ops struct here is the right design, and I think there
> are only a few patterns that actually make sense for device memory using
> nodes this way.
>
> So there's going to be a *major* contraction in the complexity of this
> patch series (hopefully I'll have something next week), and much of what
> you point out below is already in-flight.
>
> > > On Mon, Apr 13, 2026 at 03:11:12PM +0200, David Hildenbrand (Arm) wro=
te:
> > >
> > > This is because the virtio-net device / network stack does GFP_KERNEL
> > > allocations and then pins them on the host to allow zero-copy - so al=
l
> > > of ZONE_NORMAL is a valid target.
> > >
> > > (At least that's my best understanding of the entire setup).
> >
> ... snip ...
> >
> > A related series proposed some  MEM_READ/WRITE backend requests [1]
> >
> > [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-09/msg02693.h=
tml
> >
>
> Oh interesting, thank you for the reference here.
>
> >
> > Something else people were discussing in the past was to physically
> > limit the area where virtio queues could be placed.
> >
>
> That is functionally what I did - the idea was pretty simple, just have
> a separate memfd/node dedicated for the queues:
>
> guest_memory =3D memfd(MAP_PRIVATE)
> net_memory =3D memfd(MAP_SHARED)
>
> And boom, you get what you want.
>
> So yeah "It works" - but there's likely other ways to do this too, and
> as you note re: compatibility, i'm not sure virtio actually wants this,
> but it's a nice proof-of-concept for a network device on the host that
> carries its own memory.
>
> I'll try post my hack as an example with the next RFC version, as I
> think it's informative.
>
> > >
> > > This partially answers your question about slub fallback allocations,
> > > there are slab allocations like this that depend on fallbacks (more
> > > below on this explicitly).
> >
> > But that's a different "fallback" problem, no?
> >
> > You want allocations that target the "special node" to fallback to
> > *other* nodes, but not other allocations to fallback to *this special* =
node.
> >
> ... snip - slight reordering to put thoughts together ...
> > >
> > > __GFP_PRIVATE vs GFP_PRIVATE then is just a matter of use case.
> > >
> > > For mbind() it probably makes sense we'd use GFP_PRIVATE - either it
> > > succeeds or it OOMs.
> >
> > Needs a second thought regarding fallback logic I raised above.
> >
> > What I think would have to be audited is the usage of __GFP_THISNODE by
> > kernel allocations, where we would not actually want to allocate from
> > this private node.
> >
>
> This is fair, and I a re-visit is absolutely warranted.
>
> Re-examining the quick audit from my last response suggests - I should
> never have seen leakage in those cases, but the fallbacks are needed.
>
> So yes, this all requires a second look (and a third, and a ninth).
>
> I'm not married to __GFP_PRIVATE, but it has been reliable for me.
>
> > Maybe we could just outright refuse *any* non-user (movable) allocation=
s
> > that target the node, even with __GFP_THISNODE.
> >
> > Because, why would we want kernel allocations to even end up on a
> > private node that is supposed to only be consumed by user space? Or
> > which use cases are there where we would want to place kernel
> > allocations on there?
> >
>
> As a start, maybe? But as a permanent invariant?  I would wonder whether
> the decision here would lock us into a design.
>
> But then - this is all kernel internal, so i think it would be feasible
> to change this out from under users without backward compatibility pain.
>
> So far I have done my best to avoid changing any userland interfaces in
> a way that would fundamentally change the contracts.  If anything
> private-node other than just the node's `has_memory_private` attribute
> leaks into userland, someone messed up.
>
> So... I think that's reasonable.
>
> >
> > I assume you will be as LSF/MM? Would be good to discuss some of that i=
n
> > person.
> >
>
> Yes, looking forward to it :]
>
>
> > > One note here though - OOM conditions and allocation failures are not
> > > intuitive, especially when THP/non-order-0 allocations are involved.
> > >
> > > But that might just mean this minimal setup should only allow order-0
> > > allocations - which is fiiiiiiiiiiiiiine :P.
> >
> >
> > Again, I am not sure about compaction and khugepaged. All we want to
> > guarantee is that our memory does not leave the private node.
> >
> > That doesn't require any __GFP_PRIVATE magic, just en-lighting these
> > subsystems that private nodes must use __GFP_THISNODE and must not leak
> > to other nodes.
>
> This is where specific use-cases matter.
>
> In the compressed memory example - the device doesn't care about memory
> leaving - but it cares about memory arriving and *and being modified*.
> (more on this in your next question)
>
> So i'm not convinced *all possible devices* would always want to support
> move_pages(), mbind(), and set_mempolicy().
>
> But, I do want to give this serious thought, and I agree the absolute
> minimal patch set could just be the fallback control mechanism and
> mm/ component filters/audit on __GFP_*.
>
>
> > > If you want the mbind contract to stay intact:
> > >
> > >    NP_OPS_MIGRATION (mbind can generate migrations)
> > >    NP_OPS_MEMPOLICY (this just tells mempolicy.c to allow the node)
> >
> > I'm missing why these are even opt-in. What's the problem with allowing
> > mbind and mempolicy to use these nodes in some of your drivers?
> >
>
> First:
>
> In my latest working branch these two flags have been folded into just
> _OPS_MEMPOLICY and any other migration interaction is just handled by
> filtering with the GFP flag.
>
>
> on always allowing mbind and mempolicy vs opt-in
> ---
>
> A proper compressed memory solution should not allow mbind/mempolicy.
>
> Compressed memory is different from normal memory - as the kernel can
> percieves free memory (many unused struct page in the buddy) when the
> device knows there's none left (the physical capacity is actually full).
>
> Any form of write to a compressed memory device is essentially a
> dangerous condition (OOMs =3D poison, not oom_kill()).
>
> So you need two controls:  Allocation and (userland) Write protection
> I implemented via:
>     - Demotion-only (allocations only happen in reclaim path)
>     - Write-protecting the entire node
>
> (I fully accept that a write-protection extension here might be a bridge
>  to far, but please stick with me for the sake of exploration).
>
>
> There's a serious argument to limit these devices to using an mbind
> pattern, but I wanted to make a full-on attempt to integrate this device
> into the demotion path as a transparent tier (kinda like zswap).
>
> I could not square write-protection with mempolicy, so i had to make
> them both optional and mutually exclusive.
>
> If you limit the device to mbind interactions, you do limit what can
> crash - but this forces userland software to be less portable by design:
>
>   - am i running on a system where this device is present?
>   - is that device exposing its memory on a node?
>   - which node?
>   - what memory can i put on that node? (can you prevent a process from
>     putting libc on that node?)
>   - how much compression ratio is left on the device?
>   - can i safety write to this virtual address?
>   - should i write-protect compressed VMAs? Can i handle those faults?
>   - many more
>
> That sounds a lot like re-implementing a bunch of mm/ in userland, and
> that's exactly where we were at with DAX.  We know this pattern failed.
>
> I'm trying to very much avoid repeating these mistakes, and so I'm very
> much trying to find a good path forward here that results in transparent
> usage of this memory.
>
>
> > I also have some questions about longterm pinnings, but that's better
> > discussed in person :)
> >
>
> The longterm pin extention came from auditing existing zone_device
> filters.
>
> tl;dr: informative mechanism - but it probably should be dropped,
> it makes no sense (it's device memory, pinnings mean nothing?).
>
>
> > >
> > > The task dies and frees the pages back to the buddy - the question is
> > > whether the 4-5 free_folio paths (put_folio, put_unref_folios, etc) c=
an
> > > all eat an ops.free_folio() callback to inform the driver the memory =
has
> > > been freed.
> >
> > Right, that's rather invasive.
> >
>
> Yeah i'm trying to avoid it, and the answer may actually just exist in
> the task-death and VMA cleanup path rather than the folio-free path.
>
> From what i've seen of accelerator drivers that implement this, when you
> inform the driver of a memory region with a task, the driver should have
> a mechanism to take references on that VMA (or something like this) - so
> that when the task dies the driver has a way to be notified of the VMA
> being cleaned up.
>
> This probably exists - I just haven't gotten there yet.
>
> ~Gregory

This has been a really great discussion. I just wanted to add a few
points that I think I have mentioned in other forums, but not here.

In essence, this is a discussion about memory properties and the level
at which they should be dealt with. Right now there are basically 3
levels: pageblocks, zones and nodes. While these levels exist for good
reasons, they also sometimes lead to issues. There's duplication of
functionality. MIGRATE_CMA and ZONE_MOVABLE both implement the same
basic property, but at different levels (attempts have been made to
merge them, but it didn't work out). There's also memory with clashing
properties inhabiting the same data structure: LRUs. Having strictly
movable memory on the same LRU as unmovable memory is a mismatch. It
leads to the well known problem of reclaim done in the name of an
unmovable allocation attempt can be entirely pointless in the face of
large amounts of ZONE_MOVABLE or MIGRATE_CMA memory: the anon LRU will
be chock full of movable-only pages. Reclaiming them is useless for
your allocation, and skipping them leads to locking up the system
because you're holding on to the LRU lock a long time.

So, looking at having some properties set at the node level makes
sense to me even in the non-device case. But perhaps that is out of
scope for the initial discussion.

One use case that seems like a good match for private nodes is guest
memory. Guest memory is special enough to want to allocate / maintain
it separately, which is acknowledged by the introduction of
guest_memfd.

I'm interested in enabling guest_memfd allocation from private nodes.
I've been playing around with setting aside memory at boot, and
assigning it to private nodes (one private node per physical NUMA
node), and making it available to guest_memfd only. There are issues
to be solved there, but the private node abstraction seems to fit
well, and provides for useful hooks to manage guest memory.

Some properties that I'm interested in for this use case:

1) is the memory in the direct map or not? Should that be configurable
for a private node? I know there are patches right now to remove
memory from the direct map for guest_memfd, but what if there was a
private node whose memory is not in the direct map by default?
2) Default page size. devdax, a ZONE_DEVICE user, allows for memory
setup on hotplug that initializes things with HVO-ed large pages.
Could the page size be a property of the node? That would make it easy
to hand out larger pages to guests.  Of course, if you use anything
but 4k, the argument of 'we can use the general buddy allocator' goes
out the window, unless it's made to deal with a per-node base page
size.

- Frank
