Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04D53A6B89
	for <damon@lists.linux.dev>; Tue,  5 May 2026 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778019700; cv=none; b=kfSs7cVsL2+tefGfys5gTt9hotJ1t5omOdj+nGGgm5FINr2oIxp4y7QdXouBfZPKoIj+aJFbBth1fDMBSq6Yo+/xFvJA2X7/OnxQo7BkLS/8vvW3XC7U2jy9ynm/WDyiSelVcBKu5W/hgCGxUr+m/Kdo07IGDijoJb8VhJLW9/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778019700; c=relaxed/simple;
	bh=zOuCto/ei+q5X9zizDWicsGgHsnCs3KdS/blOqZ3EtY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XTf9HI5lpdHewUdnNVE1SD3yBNO3nw4X8F1TqnXnZ2RW48KtEQiI/JMgpYmY2a+mTbgmPOJpAYuvABCnxkq64OskzGjHBkU8M7StIHgzvA/P2uFJ5eG0fUsxKf2wyJshF/yAejC/dTEScFCIjCPs035EWE7pxX0ka4FoxFFNxeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJfvmQVi; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJfvmQVi"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39378db197aso40170371fa.3
        for <damon@lists.linux.dev>; Tue, 05 May 2026 15:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778019697; x=1778624497; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+bTaNE0dwTN+qN6h1nZ07Pw7t4BRJtO96DbmMB+uZo=;
        b=KJfvmQViz6qAK17ONhzkjsK/B/uRasYLDzm4uN8EdSFOh2MndJ1Lda7xXDWACunx2F
         WqnPj3odoJkeSh1BE7nIxtJM7hLuWOIeYvs2b11zqedgWBiYFYTqa8GI5XWaqcZAHk9F
         3G3XKarxGK0F9RdHwv9TQPw8FGdLnsK5es3beSnSa0+KSHkyD1DoS6AVfBzdIxxA9QvA
         RI7y7MAy2cTt2A4MH1W0VP4rrJZCLSwIVRaripSfxx3GnPEyaruZXlfBjQYZiU+bxlEf
         pbepXVZOBI9iOYQQZWidkc4b9KcMWNKNVf+Gtn36H2RNOQMCReqy40/PXIyYlBpSuxKK
         4esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778019697; x=1778624497;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e+bTaNE0dwTN+qN6h1nZ07Pw7t4BRJtO96DbmMB+uZo=;
        b=cRvF8qZ65VRZrEfuDqXo87KsVFT+kUp8lhm74RkhsBBmg6SvFAHR4PKHQ9j8QWFv6V
         J1dkQmGPuzZgyX48W2rBElawrptQVtYFUYVgdM38M5qgho3WlcSc7A8wkW+S+pLvRjWz
         /y9mPJLjsBmi6a2ar6sQg3uXoO5Nlv8vAwtBw4yFZaDjezN19BiVWEa9FFwTNnKtv3fa
         ugBhSBJE1IUXxn6OasEoO4nlc6SggzfdMLOoOXj/SDva2tkFWxEPyV3KFrMrZ90jJIKz
         r5rH7eeFJ16QLjmP3EcABVU9s/W2YefyqMVXXMEndLMhJmuiMQPoMcOg+EEGwjA7ioGc
         VsHg==
X-Forwarded-Encrypted: i=1; AFNElJ+4Rgx8OQ/0zFqDTbElHsNLXxaaXwwRN0tRRGMTqbKmS49PGmu0FvxbZtWjOT+mn8u31pG3tQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMn8uyQ9WGs4QXcl3jlVihnu6WVFAGy1bnSuV4kXckzVPVOVri
	RAJDDAedm3a6x8ggVUOVKgt5+ilRPFwggIZQvKQ+dxE5yxGpUGh94AZn
X-Gm-Gg: AeBDietqzRhI5OVsN777OY3DHTAhJBDHvd+DmM8qIb0bdZ3DI4y2WzHOpT3jhFxDcqC
	ZJjxpRLOzt3qVBCPcsFZCCHKEWjSMm0WIwdBK0zOQfnW+uEjXT5anfxBCBKWCST6UIrchT3bOvn
	Kw3YY6hS+i44PGua49mLyV9z8povhUjjwBLurvN8ymS0KzQNpVUiay4RWVE7ipE5iSBK2segkXq
	t7RKvDh/dH+wJb6MOJpoGZ0aGDBF0VTokNNDCIOiOKKlPWxgP6k6brCUYVfoMV0CxASVxPWazvh
	JdFO/o2QKsg1Ye4KaXKnrCRy2kKkQ9W0XlQ9O3VTY0zcR70xcvtm4EEDq3Fzu0eKuZjHo2nmzCr
	RRUOxi2ytjk/aTEYSSPP47QxTGeJQupRWAppk/X9c4hiMKJw38HGIzcq2+KYvOWcKDBvmUjI5ll
	Gyy3XqZ/CYSsZfWkBSUPYItzvqiyt/94JFqaroo1yenkx2bhbMQq1xiPViWbIrW4PZkF7KQ9ngA
	cd5yOE9HrwwhuCa09MWxCVxboWMs5KwcCOMqsVn
X-Received: by 2002:a05:651c:4210:b0:393:8b23:a194 with SMTP id 38308e7fff4ca-393c41cedeemr3503181fa.19.1778019696437;
        Tue, 05 May 2026 15:21:36 -0700 (PDT)
Received: from smtpclient.apple (h-155-4-132-115.NA.cust.bahnhof.se. [155.4.132.115])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3936108fb80sm46308161fa.6.2026.05.05.15.21.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2026 15:21:35 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
From: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>
Date: Wed, 6 May 2026 00:21:23 +0200
Cc: lsf-pc@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org,
 damon@lists.linux.dev,
 kernel-team@meta.com,
 gregkh@linuxfoundation.org,
 rafael@kernel.org,
 dakr@kernel.org,
 dave@stgolabs.net,
 jonathan.cameron@huawei.com,
 dave.jiang@intel.com,
 alison.schofield@intel.com,
 vishal.l.verma@intel.com,
 Ira Weiny <ira.weiny@intel.com>,
 dan.j.williams@intel.com,
 longman@redhat.com,
 akpm@linux-foundation.org,
 david@kernel.org,
 lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com,
 vbabka@suse.cz,
 rppt@kernel.org,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 osalvador@suse.de,
 ziy@nvidia.com,
 matthew.brost@intel.com,
 joshua.hahnjy@gmail.com,
 rakie.kim@sk.com,
 byungchul@sk.com,
 ying.huang@linux.alibaba.com,
 apopple@nvidia.com,
 axelrasmussen@google.com,
 yuanchu@google.com,
 weixugc@google.com,
 yury.norov@gmail.com,
 linux@rasmusvillemoes.dk,
 mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com,
 tj@kernel.org,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 jackmanb@google.com,
 sj@kernel.org,
 baolin.wang@linux.alibaba.com,
 npache@redhat.com,
 ryan.roberts@arm.com,
 dev.jain@arm.com,
 baohua@kernel.org,
 lance.yang@linux.dev,
 muchun.song@linux.dev,
 xu.xin16@zte.com.cn,
 chengming.zhou@linux.dev,
 jannh@google.com,
 linmiaohe@huawei.com,
 nao.horiguchi@gmail.com,
 pfalcato@suse.de,
 David Rientjes <rientjes@google.com>,
 shakeel.butt@linux.dev,
 riel@surriel.com,
 harry.yoo@oracle.com,
 cl@gentwo.org,
 roman.gushchin@linux.dev,
 chrisl@kernel.org,
 kasong@tencent.com,
 shikemeng@huaweicloud.com,
 nphamcs@gmail.com,
 bhe@redhat.com,
 zhengqi.arch@bytedance.com,
 terry.bowman@amd.com,
 Yiannis Nikolakopoulos <Yiannis@zptcorp.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <21B8D62E-38AB-4FA5-8942-DA4417A7E7E9@gmail.com>
References: <20260222084842.1824063-1-gourry@gourry.net>
To: Gregory Price <gourry@gourry.net>
X-Mailer: Apple Mail (2.3864.400.21)


> On 22 Feb 2026, at 09:48, Gregory Price <gourry@gourry.net> wrote:
>=20
> Topic type: MM
>=20
> Presenter: Gregory Price <gourry@gourry.net>
>=20
> This series introduces N_MEMORY_PRIVATE, a NUMA node state for memory
> managed by the buddy allocator but excluded from normal allocations.
>=20
> I present it with an end-to-end Compressed RAM service (mm/cram.c)
> that would otherwise not be possible (or would be considerably more
> difficult, be device-specific, and add to the ZONE_DEVICE boondoggle).
>=20
>=20
> TL;DR
> =3D=3D=3D
>=20
> N_MEMORY_PRIVATE is all about isolating NUMA nodes and then punching
> explicit holes in that isolation to do useful things we couldn't do
> before without re-implementing entire portions of mm/ in a driver.
>=20
>=20
> /* This is my memory. There are many like it, but this one is mine. */
> rc =3D add_private_memory_driver_managed(nid, start, size, name, =
flags,
>                                       online_type, private_context);
>=20
> page =3D alloc_pages_node(nid, __GFP_PRIVATE, 0);
>=20
> /* Ok but I want to do something useful with it */
> static const struct node_private_ops ops =3D {
>        .migrate_to     =3D my_migrate_to,
>        .folio_migrate  =3D my_folio_migrate,
>        .flags =3D NP_OPS_MIGRATION | NP_OPS_MEMPOLICY,
> };
> node_private_set_ops(nid, &ops);
>=20
> /* And now I can use mempolicy with my memory */
> buf =3D mmap(...);
> mbind(buf, len, mode, private_node, ...);
> buf[0] =3D 0xdeadbeef;  /* Faults onto private node */
>=20
> /* And to be clear, no one else gets my memory */
> buf2 =3D malloc(4096);  /* Standard allocation */
> buf2[0] =3D 0xdeadbeef; /* Can never land on private node */
>=20
> /* But i can choose to migrate it to the private node */
> move_pages(0, 1, &buf, &private_node, NULL, ...);
>=20
> /* And more fun things like this */
>=20
>=20
> Patchwork
> =3D=3D=3D
> A fully working branch based on cxl/next can be found here:
> https://github.com/gourryinverse/linux/tree/private_compression
>=20
> A QEMU device which can inject high/low interrupts can be found here:
> https://github.com/gourryinverse/qemu/tree/compressed_cxl_clean
>=20
> The additional patches on these branches are CXL and DAX driver
> housecleaning only tangentially relevant to this RFC, so i've
> omitted them for the sake of trying to keep it somewhat clean
> here.  Those patches should (hopefully) be going upstream anyway.
>=20
> Patches 1-22: Core Private Node Infrastructure
>=20
>  Patch  1:      Introduce N_MEMORY_PRIVATE scaffolding
>  Patch  2:      Introduce __GFP_PRIVATE
>  Patch  3:      Apply allocation isolation mechanisms
>  Patch  4:      Add N_MEMORY nodes to private fallback lists
>  Patches 5-9:   Filter operations not yet supported
>  Patch 10:      free_folio callback
>  Patch 11:      split_folio callback
>  Patches 12-20: mm/ service opt-ins:
>                   Migration, Mempolicy, Demotion, Write Protect,
>                   Reclaim, OOM, NUMA Balancing, Compaction,
>                   LongTerm Pinning
>  Patch 21:      memory_failure callback
>  Patch 22:      Memory hotplug plumbing for private nodes
>=20
> Patch 23: mm/cram -- Compressed RAM Management
>=20
> Patches 24-27: CXL Driver examples
>  Sysram Regions with Private node support
>  Basic Driver Example: (MIGRATION | MEMPOLICY)
>  Compression Driver Example (Generic)
>=20
Hi,

As I think this is about to be discussed in the conference, I thought
to share some high level comments.

I have tested this for some time on a device with compression (after =
some
necessary fixes for CXL RCD to work, that Greg helped me with).

Overall, the isolation property that this provides is something I deem =
necessary
for this technology. Others are better placed to judge the MM plumbing
itself, but I wanted to say that this functionality is an important =
piece of the puzzle
from the device/use-case side.

For cram itself, as it is in this RFC, I think there is still =
performance and
value left on the table (as noted in the description), but I fully =
understand Gregory=E2=80=99s=20
premise in approaching it this way.

<snip>
>=20
> Future CRAM : Loosening the read-only constraint
> =3D=3D=3D
>=20
> The read-only model is safe but conservative.  For workloads where
> compressed pages are occasionally written, the promotion fault adds
> latency.  A future optimization could allow a tunable fraction of
> compressed pages to be mapped writable, accepting some risk of
> write-driven decompression in exchange for lower overhead.
>=20
> The private node ops make this straightforward:
>=20
>  - Adjust fixup_migration_pte to selectively skip
>    write-protection.
>  - Use the backpressure system to either revoke writable mappings,
>    deny additional demotions, or evict when device pressure rises.
I have some quick hacks playing with these ideas but I haven=E2=80=99t =
had the time
to test it thoroughly and get to something robust yet. I saw in another =
thread
that there is a follow up cooking which looks interesting.

Thanks Greg for pushing this, and I=E2=80=99m happy to test more on HW =
in our lab.

Best,
/Yiannis



